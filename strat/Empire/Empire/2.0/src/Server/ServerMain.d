#drinc:exec/miscellaneous.g
#drinc:exec/memory.g
#drinc:exec/ports.g
#drinc:exec/tasks.g
#drinc:libraries/dos.g
#drinc:libraries/dosextens.g
#drinc:workbench/workbench.g
#drinc:workbench/icon.g
#drinc:workbench/startup.g
#drinc:util.g
#/Include/Empire.g
#/Include/Request.g
#Server.g

/*
 * Amiga Empire
 *
 * Copyright (c) 1990 by Chris Gray
 *
 * Feel free to modify and use these sources however you wish, so long
 * as you preserve this copyright notice.
 */

/*
 * serverMain.d - main program for Empire server.
 */

bool DEBUG = false;

*char DEFAULT_PATH = "";                /* default to current directory */

type
    ResourceKind_t = enum {
        rk_world,
        rk_weather,
        rk_country,
        rk_sector,
        rk_ship,
        rk_fleet,
        rk_loan,
        rk_offer,
        rk_sectorPair,
        rk_shipPair,
        rk_sectorShipPair
    },

    MessageList_t = struct {
        *MessageList_t ml_next;
        uint ml_length;
        *char ml_data;
    },

    Client_t = struct {
        *Client_t cl_next;              /* next in any list of clients */
        *Client_t cl_prev;              /* prev in any list of clients */
        *Client_t cl_waitQueue;         /* queue waiting for what I have */
        *Client_t cl_masterNext;        /* next in master list */
        *Client_t cl_masterPrev;        /* prev in master list */
        *Request_t cl_request;          /* the request that is waiting */
        *MessageList_t cl_messages;     /* messages waiting to go to him */
        ulong cl_identifier;            /* client counter */
        ResourceKind_t cl_lockKind;     /* kind of thing I have locked */
        uint cl_resource;               /* identifier of what I have locked */
        uint cl_resource2;              /* identifier of other */
        uint cl_countryNumber;          /* which country this client is */
        Handle_t cl_fd;                 /* fd for various things */
        bool cl_newWorld;               /* needs to see new world */
        bool cl_newCountry;             /* needs to see new country */
        bool cl_chatting;               /* chat is enabled for this client */
    },

    FileType_t = enum {
        ft_normal,
        ft_help,
        ft_doc
    };

World_t World;                          /* keep it right here */

[COUNTRY_MAX] Country_t Country;        /* keep them all here */

*MsgPort_t EmpirePort;

*Client_t Clients;                      /* master list of clients */
*Client_t IdleClients;                  /* nothing locked, not waiting */
*Client_t BusyClients;                  /* holding something locked */
ulong ClientCounter;                    /* count the clients */
[150] char Path;                        /* path to access files */
[150] char HelpDir;                     /* directory to find help files in */
[150] char DocDir;                      /* directory to find doc files in */

bool Aborting;

/*
 * setAborting - called from any FileIO routine when they want to abort.
 */

proc setAborting()void:

    Aborting := true;
corp;

/*
 * copyData - supply appropriate data to the request.
 */

proc copyData(*Request_t rq; ResourceKind_t rk)void:

    case rk
    incase rk_world:
        rq*.rq_u.ru_world := World;
    incase rk_weather:
        rq*.rq_u.ru_weather := World.w_weather;
    incase rk_country:
        rq*.rq_u.ru_country := Country[rq*.rq_whichUnit];
    incase rk_sector:
        readSector(rq*.rq_whichUnit, &rq*.rq_u.ru_sector);
    incase rk_ship:
        readShip(rq*.rq_whichUnit, &rq*.rq_u.ru_ship);
    incase rk_fleet:
        readFleet(rq*.rq_whichUnit, &rq*.rq_u.ru_fleet);
    incase rk_loan:
        readLoan(rq*.rq_whichUnit, &rq*.rq_u.ru_loan);
    incase rk_offer:
        readOffer(rq*.rq_whichUnit, &rq*.rq_u.ru_offer);
    incase rk_sectorPair:
        readSector(rq*.rq_whichUnit, &rq*.rq_u.ru_sectorPair[0]);
        readSector(rq*.rq_otherUnit, &rq*.rq_u.ru_sectorPair[1]);
    incase rk_shipPair:
        readShip(rq*.rq_whichUnit, &rq*.rq_u.ru_shipPair[0]);
        readShip(rq*.rq_otherUnit, &rq*.rq_u.ru_shipPair[1]);
    incase rk_sectorShipPair:
        readSector(rq*.rq_whichUnit, &rq*.rq_u.ru_sectorShipPair.p_s);
        readShip(rq*.rq_otherUnit, &rq*.rq_u.ru_sectorShipPair.p_sh);
    esac;
corp;

/*
 * startClient - a new client is starting up.
 */

proc startClient(register *Request_t rq)void:
    register *Client_t cl;

    cl := AllocMem(sizeof(Client_t), 0);
    if cl = nil then
        rq*.rq_type := rt_stopClient;
        log("*** can't allocate record for new client");
    else
        /* general initialization of client structure */
        cl*.cl_messages := nil;
        cl*.cl_identifier := ClientCounter;
        cl*.cl_countryNumber := 0;
        cl*.cl_fd := 0;
        cl*.cl_newWorld := false;
        cl*.cl_newCountry := false;
        cl*.cl_chatting := false;
        rq*.rq_clientId := ClientCounter;
        /* put new client on chain of idle clients */
        cl*.cl_next := IdleClients;
        cl*.cl_prev := nil;
        if IdleClients ~= nil then
            IdleClients*.cl_prev := cl;
        fi;
        IdleClients := cl;
        /* put new client on master client chain */
        cl*.cl_masterNext := Clients;
        cl*.cl_masterPrev := nil;
        if Clients ~= nil then
            Clients*.cl_masterPrev := cl;
        fi;
        Clients := cl;
        ClientCounter := ClientCounter + 1;
    fi;
corp;

/*
 * clearClient - clear out a client.
 */

proc clearClient(register *Client_t cl)void:
    register *MessageList_t ml, mlt;

    /* delete any messages */
    ml := cl*.cl_messages;
    while ml ~= nil do
        FreeMem(ml*.ml_data, ml*.ml_length);
        mlt := ml;
        ml := ml*.ml_next;
        FreeMem(mlt, sizeof(MessageList_t));
    od;
    if cl*.cl_fd ~= 0 then
        Close(cl*.cl_fd);
        cl*.cl_fd := 0;
    fi;
corp;

/*
 * stopClient - a client is shutting down.
 */

proc stopClient(register *Client_t cl; register *Request_t rq)void:

    /* delete client from chain of idle clients */
    if cl*.cl_next ~= nil then
        cl*.cl_next*.cl_prev := cl*.cl_prev;
    fi;
    if cl*.cl_prev ~= nil then
        cl*.cl_prev*.cl_next := cl*.cl_next;
    else
        IdleClients := cl*.cl_next;
    fi;
    /* delete client from master client chain */
    if cl*.cl_masterNext ~= nil then
        cl*.cl_masterNext*.cl_masterPrev := cl*.cl_masterPrev;
    fi;
    if cl*.cl_masterPrev ~= nil then
        cl*.cl_masterPrev*.cl_masterNext := cl*.cl_masterNext;
    else
        Clients := cl*.cl_masterNext;
    fi;
    clearClient(cl);
    if cl*.cl_countryNumber ~= 0 then
        Country[cl*.cl_countryNumber].c_loggedOn := false;
    fi;
    FreeMem(cl, sizeof(Client_t));
    writeWorld(&World, &Country);
    closeFiles();
    openFiles(&Path[0], &HelpDir, &DocDir);
corp;

/*
 * readFile - starting a normal, help or doc file.
 */

proc readFile(register *Client_t cl; register *Request_t rq;
              FileType_t ft)void:
    [150] char fileName;
    register long len;

    CharsCopy(&fileName[0],
        case ft
        incase ft_normal:
            &Path[0]
        incase ft_help:
            &HelpDir[0]
        incase ft_doc:
            &DocDir[0]
        esac);
    CharsConcat(&fileName[0], &rq*.rq_u.ru_text[0]);
    cl*.cl_fd := Open(&fileName[0], MODE_OLDFILE);
    if cl*.cl_fd = 0 then
        rq*.rq_whichUnit := 0;
    else
        len := Read(cl*.cl_fd, &rq*.rq_u.ru_text[0], TEXT_LENGTH);
        if len ~= TEXT_LENGTH then
            Close(cl*.cl_fd);
            cl*.cl_fd := 0;
            if len < 0 then
                len := 0;
            fi;
        fi;
        rq*.rq_whichUnit := len;
    fi;
corp;

/*
 * moreFile - continue reading a file.
 */

proc moreFile(register *Client_t cl; register *Request_t rq)void:
    register long len;

    if cl*.cl_fd = 0 then
        rq*.rq_whichUnit := 0;
    else
        len := Read(cl*.cl_fd, &rq*.rq_u.ru_text[0], TEXT_LENGTH);
        if len ~= TEXT_LENGTH then
            Close(cl*.cl_fd);
            cl*.cl_fd := 0;
            if len < 0 then
                len := 0;
            fi;
        fi;
        rq*.rq_whichUnit := len;
    fi;
corp;

/*
 * readLocal - read a file from the main directory into a telegram.
 */

proc readLocal(register *Client_t cl; register *Request_t rq)void:
    [150] char fileName;
    register *char p;
    register long len;
    register Handle_t fd;

    p := &rq*.rq_u.ru_text[0];
    while p* ~= '\e' and p* ~= '/' and p* ~= ':' do
        p := p + sizeof(char);
    od;
    if p* = '\e' then
        CharsCopy(&fileName[0], &Path[0]);
        CharsConcat(&fileName[0], &rq*.rq_u.ru_text[0]);
        fd := Open(&fileName[0], MODE_OLDFILE);
        if fd = 0 then
            rq*.rq_whichUnit := 0;
        else
            len :=
                Read(fd, &rq*.rq_u.ru_telegram.te_data[0], TELEGRAM_MAX - 1);
            Close(fd);
            if len < 0 then
                len := 0;
            fi;
            if len ~= 0 then
                rq*.rq_u.ru_telegram.te_data[len - 1] := '\n';
            fi;
            rq*.rq_u.ru_telegram.te_data[len] := '\e';
            rq*.rq_whichUnit := len;
        fi;
    else
        /* don't allow a file name containing '/' or ':' */
        rq*.rq_whichUnit := 0;
    fi;
corp;

/*
 * edit - edit a file in the main directory via a telegram.
 */

proc edit(register *Client_t cl; register *Request_t rq)void:
    [150] char fileName;
    register long len;

    CharsCopy(&fileName[0], &Path[0]);
    CharsConcat(&fileName[0],
                case rq*.rq_whichUnit
                incase 0:
                    "empire.conMess"
                incase 1:
                    "empire.logMess"
                incase 2:
                    "empire.hangMess"
                incase 3:
                    "empire.bulletin"
                default:
                    "empire.temp"
                esac);
    if cl*.cl_fd = 0 then
        /* first call of pair - read the file */
        cl*.cl_fd := Open(&fileName[0], MODE_OLDFILE);
        if cl*.cl_fd = 0 then
            cl*.cl_fd := Open(&fileName[0], MODE_NEWFILE);
            if cl*.cl_fd = 0 then
                rq*.rq_whichUnit := TELEGRAM_MAX;
            else
                rq*.rq_whichUnit := 0;
            fi;
        else
            len := Read(cl*.cl_fd, &rq*.rq_u.ru_telegram.te_data[0],
                        TELEGRAM_MAX - 1);
            if len < 0 then
                len := 0;
            fi;
            if len ~= 0 then
                rq*.rq_u.ru_telegram.te_data[len - 1] := '\n';
            fi;
            rq*.rq_whichUnit := len;
        fi;
    else
        /* second call - write out the new data. */
        Close(cl*.cl_fd);
        if rq*.rq_u.ru_telegram.te_length ~= TELEGRAM_MAX then
            ignore DeleteFile(&fileName[0]);
            cl*.cl_fd := Open(&fileName[0], MODE_NEWFILE);
            if cl*.cl_fd ~= 0 then
                ignore Write(cl*.cl_fd, &rq*.rq_u.ru_telegram.te_data[0],
                             rq*.rq_u.ru_telegram.te_length);
                Close(cl*.cl_fd);
            fi;
        fi;
        cl*.cl_fd := 0;
    fi;
corp;

/*
 * appendMessage - add a message from the request to the end of the
 *      client's message queue.
 */

proc appendMessage(register *Client_t cl; register *Request_t rq)void:
    *char NOBODY_HEADER = "******:\n";
    uint NOBODY_LENGTH = 8;
    register **MessageList_t mlp;
    register *MessageList_t ml @ cl;

    mlp := &cl*.cl_messages;
    while mlp* ~= nil do
        mlp := &mlp**.ml_next;
    od;
    ml := AllocMem(sizeof(MessageList_t), 0);
    if ml ~= nil then
        ml*.ml_next := nil;
        if rq*.rq_u.ru_telegram.te_from = NOBODY then
            ml*.ml_length := rq*.rq_u.ru_telegram.te_length + NOBODY_LENGTH;
        else
            ml*.ml_length := rq*.rq_u.ru_telegram.te_length;
        fi;
        ml*.ml_data := AllocMem(ml*.ml_length, 0);
        if ml*.ml_data ~= nil then
            if rq*.rq_u.ru_telegram.te_from = NOBODY then
                BlockCopy(ml*.ml_data, NOBODY_HEADER, NOBODY_LENGTH);
                BlockCopy(ml*.ml_data + NOBODY_LENGTH * sizeof(char),
                          &rq*.rq_u.ru_telegram.te_data[0],
                          rq*.rq_u.ru_telegram.te_length);
            else
                BlockCopy(ml*.ml_data, &rq*.rq_u.ru_telegram.te_data[0],
                          ml*.ml_length);
            fi;
            mlp* := ml;
            rq*.rq_whichUnit := MESSAGE_SENT;
            if DEBUG then
                log("message appended to queue");
            fi;
        else
            FreeMem(ml, sizeof(MessageList_t));
            rq*.rq_whichUnit := MESSAGE_FAIL;
            if DEBUG then
                log("message append failed - no mem");
            fi;
        fi;
    else
        rq*.rq_whichUnit := MESSAGE_FAIL;
        if DEBUG then
            log("message append failed - no mem for messageList");
        fi;
    fi;
corp;

/*
 * message - send a message (in telegram structure) to other user.
 */

proc message(register *Request_t rq)void:
    register *Client_t cl;

    cl := Clients;
    while cl ~= nil and cl*.cl_countryNumber ~= rq*.rq_whichUnit do
        cl := cl*.cl_masterNext;
    od;
    if cl ~= nil then
        appendMessage(cl, rq);
    else
        rq*.rq_whichUnit := MESSAGE_NO_COUNTRY;
    fi;
corp;

/*
 * getMessage - retrieve the next message destined for this client.
 */

proc getMessage(register *Client_t cl; register *Request_t rq)void:
    register *MessageList_t ml;

    ml := cl*.cl_messages;
    if ml ~= nil then
        rq*.rq_u.ru_telegram.te_length := ml*.ml_length;
        BlockCopy(&rq*.rq_u.ru_telegram.te_data[0], ml*.ml_data,ml*.ml_length);
        FreeMem(ml*.ml_data, ml*.ml_length);
        cl*.cl_messages := ml*.ml_next;
        FreeMem(ml, sizeof(MessageList_t));
    else
        rq*.rq_u.ru_telegram.te_length := 0;
    fi;
corp;

/*
 * startChat - send the new chatter a list of the current chatters.
 */

proc startChat(register *Client_t clNew)void:
    register *Client_t cl;
    register *MessageList_t ml;
    register uint len;

    cl := Clients;
    while cl ~= nil do
        if cl ~= clNew and cl*.cl_chatting and cl*.cl_countryNumber ~= 0 then
            ml := AllocMem(sizeof(MessageList_t), 0);
            if ml ~= nil then
                len := CharsLen(&Country[cl*.cl_countryNumber].c_name[0]);
                ml*.ml_data := AllocMem(len + 12, 0);
                if ml*.ml_data ~= nil then
                    BlockCopy(ml*.ml_data, "Chatting: ", 10);
                    BlockCopy(ml*.ml_data + 10 * sizeof(char),
                              &Country[cl*.cl_countryNumber].c_name[0], len);
                    (ml*.ml_data + (len + 10) * sizeof(char))* := '\n';
                    (ml*.ml_data + (len + 11) * sizeof(char))* := '\e';
                    ml*.ml_length := len + 12;
                    ml*.ml_next := clNew*.cl_messages;
                    clNew*.cl_messages := ml;
                else
                    FreeMem(ml, sizeof(MessageList_t));
                fi;
            fi;
        fi;
        cl := cl*.cl_masterNext;
    od;
corp;

/*
 * sendChat - this client has sent a new chat line.
 *      Copy it to the end of all other chatting client's message queues.
 */

proc sendChat(register *Client_t sender; register *Request_t rq)void:
    register *Client_t cl;

    cl := Clients;
    while cl ~= nil do
        if cl ~= sender and cl*.cl_chatting then
            appendMessage(cl, rq);
        fi;
        cl := cl*.cl_masterNext;
    od;
corp;

/*
 * setFileName - fill in a file name for something for the given time's day.
 */

proc setFileName(register *char buffer; register ulong time; *char what)void:
    register *char p;
    [12] char buf;

    CharsCopy(buffer, &Path[0]);
    CharsConcat(buffer, what);
    CharsConcat(buffer, ".");
    time := time / (World.w_secondsPerETU * (2 * 24));
    p := &buf[11];
    p* := '\e';
    while
        p := p - sizeof(char);
        p* := time % 10 + '0';
        time := time / 10;
        time ~= 0
    do
    od;
    CharsConcat(buffer, p);
corp;

/*
 * news - add a news item to today's news file.
 */

proc news(register *Request_t rq)void:
    ulong now;
    Handle_t fd;
    [150] char fileName;

    now := GetCurrentTime();
    rq*.rq_u.ru_news.n_time := now;
    setFileName(&fileName[0], now, "news");
    fd := Open(&fileName[0], MODE_READWRITE);
    if fd = 0 then
        fd := Open(&fileName[0], MODE_NEWFILE);
    fi;
    if fd ~= 0 then
        if Seek(fd, 0, OFFSET_END) ~= -1 then
            ignore Write(fd, &rq*.rq_u.ru_news, sizeof(News_t));
        fi;
        Close(fd);
    fi;
corp;

/*
 * readNews - get the indicated news item. Lots of file open/close!
 */

proc readNews(register *Request_t rq)void:
    Handle_t fd;
    [150] char fileName;
    long len;

    setFileName(&fileName[0], rq*.rq_u.ru_news.n_time, "news");
    fd := Open(&fileName[0], MODE_OLDFILE);
    if fd = 0 then
        rq*.rq_whichUnit := 0;
    else
        if Seek(fd, make(rq*.rq_whichUnit, ulong) * sizeof(News_t),
                OFFSET_BEGINNING) = -1
        then
            rq*.rq_whichUnit := 0;
        else
            len := Read(fd, &rq*.rq_u.ru_news, sizeof(News_t));
            if len ~= sizeof(News_t) then
                rq*.rq_whichUnit := 0;
            else
                rq*.rq_whichUnit := rq*.rq_whichUnit + 1;
            fi;
        fi;
        Close(fd);
    fi;
corp;

/*
 * propaganda - enter a piece of propaganda.
 */

proc propaganda(register *Request_t rq)void:
    Handle_t fd;
    [150] char fileName;
    long len;

    setFileName(&fileName[0], rq*.rq_u.ru_telegram.te_time, "prop");
    fd := Open(&fileName[0], MODE_READWRITE);
    if fd = 0 then
        fd := Open(&fileName[0], MODE_NEWFILE);
    fi;
    if fd ~= 0 then
        if Seek(fd, 0, OFFSET_END) ~= -1 then
            len := rq*.rq_u.ru_telegram.te_length + 3 * sizeof(uint) +
                    sizeof(ulong);
            if Write(fd, &rq*.rq_u.ru_telegram, len) ~= len then
                log("*** write to propaganda file failed");
            fi;
        else
            log("*** seek to write propaganda file failed");
        fi;
        Close(fd);
    else
        log("*** write open of propaganda file failed");
    fi;
corp;

/*
 * readPropaganda - read an item of propaganda.
 */

proc readPropaganda(register *Client_t cl; register *Request_t rq)void:
    [150] char fileName;
    long len;

    if cl*.cl_fd = 0 then
        setFileName(&fileName[0], rq*.rq_u.ru_telegram.te_time, "prop");
        cl*.cl_fd := Open(&fileName[0], MODE_OLDFILE);
        if cl*.cl_fd = 0 then
            rq*.rq_u.ru_telegram.te_length := 0;
        fi;
    fi;
    if cl*.cl_fd ~= 0 then
        len := sizeof(Telegram_t) - TELEGRAM_MAX * sizeof(char);
        if Read(cl*.cl_fd, &rq*.rq_u.ru_telegram, len) ~= len then
            rq*.rq_u.ru_telegram.te_length := 0;
            Close(cl*.cl_fd);
            cl*.cl_fd := 0;
        else
            len := rq*.rq_u.ru_telegram.te_length;
            if Read(cl*.cl_fd, &rq*.rq_u.ru_telegram.te_data[0],len) ~= len
            then
                rq*.rq_u.ru_telegram.te_length := 0;
                Close(cl*.cl_fd);
                cl*.cl_fd := 0;
                log("*** read of propaganda file failed");
            fi;
        fi;
    fi;
corp;

/*
 * sendTelegram - send the telegram from the request.
 */

proc sendTelegram(register *Request_t rq)void:
    register *Country_t cou;
    register Handle_t fd;
    [150] char fileName;
    register ulong len;

    CharsCopy(&fileName[0], &Path[0]);
    CharsConcat(&fileName[0], "telegrams.");
    len := CharsLen(&fileName[0]);
    fileName[len] := rq*.rq_u.ru_telegram.te_to / 10 + '0';
    len := len + 1;
    fileName[len] := rq*.rq_u.ru_telegram.te_to % 10 + '0';
    len := len + 1;
    fileName[len] := '\e';
    fd := Open(&fileName[0], MODE_READWRITE);
    if fd ~= 0 then
        cou := &Country[rq*.rq_u.ru_telegram.te_to];
        if Seek(fd, cou*.c_telegramsTail, OFFSET_BEGINNING) ~= -1 then
            len := rq*.rq_u.ru_telegram.te_length + 3 * sizeof(uint) +
                    sizeof(ulong);
            if Write(fd, &rq*.rq_u.ru_telegram, len) = len then
                cou*.c_telegramsTail := cou*.c_telegramsTail + len;
            else
                log("*** write to telegram file failed");
            fi;
        else
            log("*** seek to write telegram file failed");
        fi;
        Close(fd);
    else
        log("*** write open of telegram file failed");
    fi;
corp;

/*
 * checkMessages - tell about various things waiting for the client.
 */

proc checkMessages(register *Client_t cl; register *Request_t rq)void:
    register *Country_t cou;

    cou := &Country[rq*.rq_whichUnit];
    if cl*.cl_newWorld then
        rq*.rq_u.ru_messageCheck.mc_newWorld := true;
        cl*.cl_newWorld := false;
    else
        rq*.rq_u.ru_messageCheck.mc_newWorld := false;
    fi;
    if cl*.cl_newCountry then
        rq*.rq_u.ru_messageCheck.mc_newCountry := true;
        cl*.cl_newCountry := false;
    else
        rq*.rq_u.ru_messageCheck.mc_newCountry := false;
    fi;
    rq*.rq_u.ru_messageCheck.mc_hasMessages := cl*.cl_messages ~= nil;
    rq*.rq_u.ru_messageCheck.mc_hasOldTelegrams := cou*.c_telegramsNew ~= 0;
    if cou*.c_telegramsTail ~= cou*.c_telegramsNew then
        rq*.rq_u.ru_messageCheck.mc_hasNewTelegrams := true;
        cou*.c_telegramsNew := cou*.c_telegramsTail;
    else
        rq*.rq_u.ru_messageCheck.mc_hasNewTelegrams := false;
    fi;
corp;

/*
 * readTelegram - read a telegram from the user.
 */

proc readTelegram(register *Client_t cl; register *Request_t rq)void:
    register *Country_t cou;
    [150] char fileName;
    register long len;

    cou := &Country[cl*.cl_countryNumber];
    rq*.rq_u.ru_telegram.te_length := 0;
    if cl*.cl_fd = 0 and cou*.c_telegramsTail ~= 0 then
        case rq*.rq_whichUnit
        incase TELE_DELETE:
            cou*.c_telegramsTail := 0;
            cou*.c_telegramsNew := 0;
        incase TELE_KEEP:
            cou*.c_telegramsNew := cou*.c_telegramsTail;
        default:
            /* first read of telegrams */
            CharsCopy(&fileName[0], &Path[0]);
            CharsConcat(&fileName[0], "telegrams.");
            len := CharsLen(&fileName[0]);
            fileName[len] := cl*.cl_countryNumber / 10 + '0';
            len := len + 1;
            fileName[len] := cl*.cl_countryNumber % 10 + '0';
            len := len + 1;
            fileName[len] := '\e';
            cl*.cl_fd := Open(&fileName[0], MODE_OLDFILE);
            if cl*.cl_fd = 0 then
                rq*.rq_u.ru_telegram.te_length := 0;
                log("*** read open of telegram file failed");
            fi;
        esac;
    fi;
    if cl*.cl_fd ~= 0 then
        if Seek(cl*.cl_fd,0,OFFSET_CURRENT) >= make(cou*.c_telegramsTail, long)
        then
            Close(cl*.cl_fd);
            cl*.cl_fd := 0;
        else
            len := sizeof(Telegram_t) - TELEGRAM_MAX * sizeof(char);
            if Read(cl*.cl_fd, &rq*.rq_u.ru_telegram, len) ~= len then
                rq*.rq_u.ru_telegram.te_length := 0;
                Close(cl*.cl_fd);
                cl*.cl_fd := 0;
            else
                len := rq*.rq_u.ru_telegram.te_length;
                if len > TELEGRAM_MAX then
                    /* something is mucked up! */
                    cou*.c_telegramsTail := 0;
                    cou*.c_telegramsNew := 0;
                    Close(cl*.cl_fd);
                    cl*.cl_fd := 0;
                    rq*.rq_u.ru_telegram.te_length := 0;
                elif Read(cl*.cl_fd,&rq*.rq_u.ru_telegram.te_data[0],len) ~=len
                then
                    rq*.rq_u.ru_telegram.te_length := 0;
                    Close(cl*.cl_fd);
                    cl*.cl_fd := 0;
                    log("*** read of telegram file failed");
                fi;
            fi;
        fi;
    fi;
corp;

/*
 * writePower - write a new power file.
 */

proc writePower(register *Client_t cl; register *Request_t rq)void:
    [150] char fileName;

    if cl*.cl_fd = 0 then
        /* try to open the power file and write the header */
        CharsCopy(&fileName[0], &Path[0]);
        CharsConcat(&fileName[0], POWER_FILE);
        cl*.cl_fd := Open(&fileName[0], MODE_NEWFILE);
        if cl*.cl_fd = 0 then
            /* can't create it! */
            log("*** can't create power file");
            rq*.rq_whichUnit := 0;
        else
            if Write(cl*.cl_fd, &rq*.rq_u.ru_powerHead, sizeof(PowerHead_t)) ~=
                sizeof(PowerHead_t)
            then
                log("*** bad header write on power file");
                /* can't write it! */
                Close(cl*.cl_fd);
                cl*.cl_fd := 0;
                rq*.rq_whichUnit := 0;
            else
                /* all OK */
                rq*.rq_whichUnit := 1;
            fi;
        fi;
    else
        /* file already open, just write the next chunk, or close it */
        if rq*.rq_whichUnit = 0 then
            Close(cl*.cl_fd);
            cl*.cl_fd := 0;
        else
            if Write(cl*.cl_fd, &rq*.rq_u.ru_powerData, sizeof(PowerData_t)) ~=
                sizeof(PowerData_t)
            then
                log("*** bad write of data on power file");
                Close(cl*.cl_fd);
                cl*.cl_fd := 0;
                rq*.rq_whichUnit := 0;
            fi;
        fi;
    fi;
corp;

/*
 * readPower - read the current power file.
 */

proc readPower(register *Client_t cl; register *Request_t rq)void:
    [150] char fileName;

    if cl*.cl_fd = 0 then
        CharsCopy(&fileName[0], &Path[0]);
        CharsConcat(&fileName[0], POWER_FILE);
        cl*.cl_fd := Open(&fileName[0], MODE_OLDFILE);
        if cl*.cl_fd = 0 then
            rq*.rq_whichUnit := 0;
        else
            if Read(cl*.cl_fd, &rq*.rq_u.ru_powerHead, sizeof(PowerHead_t)) ~=
                sizeof(PowerHead_t)
            then
                log("*** bad header read on power file");
                Close(cl*.cl_fd);
                cl*.cl_fd := 0;
                rq*.rq_whichUnit := 0;
            else
                rq*.rq_whichUnit := 1;
            fi;
        fi;
    else
        if Read(cl*.cl_fd, &rq*.rq_u.ru_powerData, sizeof(PowerData_t)) ~=
            sizeof(PowerData_t)
        then
            Close(cl*.cl_fd);
            cl*.cl_fd := 0;
            rq*.rq_whichUnit := 0;
        else
            rq*.rq_whichUnit := 1;
        fi;
    fi;
corp;

/*
 * noLockConflict - return true if cl2 has nothing locked that prevents
 *      cl1 from going ahead.
 */

proc noLockConflict(register *Client_t cl, cl2)bool:
    register uint ra1, ra2, rb1, rb2;
    bool ok;

    ok := true;
    ra1 := cl*.cl_resource;
    rb1 := cl2*.cl_resource;
    if cl*.cl_lockKind = cl2*.cl_lockKind and ra1 = rb1 then
        ok := false;
    else
        ra2 := cl*.cl_resource2;
        rb2 := cl2*.cl_resource2;
        case cl*.cl_lockKind
        incase rk_world:
            if cl2*.cl_lockKind = rk_weather then
                ok := false;
            fi;
        incase rk_weather:
            if cl2*.cl_lockKind = rk_world then
                ok := false;
            fi;
        incase rk_sector:
            if cl2*.cl_lockKind = rk_sectorPair then
                if ra1 = rb1 or ra1 = rb2 then
                    ok := false;
                fi;
            elif cl2*.cl_lockKind = rk_sectorShipPair then
                if ra1 = rb1 then
                    ok := false;
                fi;
            fi;
        incase rk_sectorPair:
            if cl2*.cl_lockKind = rk_sector or
                cl2*.cl_lockKind = rk_sectorShipPair
            then
                if ra1 = rb1 or ra2 = rb1 then
                    ok := false;
                fi;
            elif cl2*.cl_lockKind = rk_sectorPair then
                if ra1 = rb1 or ra2 = rb1 or ra1 = rb2 or ra2 = rb2 then
                    ok := false;
                fi;
            fi;
        incase rk_ship:
            if cl2*.cl_lockKind = rk_shipPair then
                if ra1 = rb1 or ra1 = rb2 then
                    ok := false;
                fi;
            elif cl2*.cl_lockKind = rk_sectorShipPair then
                if ra1 = rb2 then
                    ok := false;
                fi;
            fi;
        incase rk_shipPair:
            if cl2*.cl_lockKind = rk_ship then
                if ra1 = rb1 or ra2 = rb1 then
                    ok := false;
                fi;
            elif cl2*.cl_lockKind = rk_shipPair then
                if ra1 = rb1 or ra2 = rb1 or ra1 = rb2 or ra2 = rb2 then
                    ok := false;
                fi;
            elif cl2*.cl_lockKind = rk_sectorShipPair then
                if ra1 = rb2 or ra2 = rb2 then
                    ok := false;
                fi;
            fi;
        incase rk_sectorShipPair:
            case cl2*.cl_lockKind
            incase rk_sector:
                if ra1 = rb1 then
                    ok := false;
                fi;
            incase rk_ship:
                if ra2 = rb1 then
                    ok := false;
                fi;
            incase rk_sectorPair:
                if ra1 = rb1 or ra1 = rb2 then
                    ok := false;
                fi;
            incase rk_shipPair:
                if ra2 = rb1 or ra2 = rb2 then
                    ok := false;
                fi;
            incase rk_sectorShipPair:
                if ra1 = rb1 or ra2 = rb2 then
                    ok := false;
                fi;
            esac;
        esac;
    fi;
    ok
corp;

/*
 * handleLockRequest - try to handle a lock request, either arriving as a
 *      new request or as a result of an unlock.
 */

proc handleLockRequest(register *Client_t cl)void:
    register *Client_t cl2;
    register **Client_t pcl @ cl2;

    cl2 := BusyClients;
    while cl2 ~= nil and noLockConflict(cl, cl2) do
        cl2 := cl2*.cl_next;
    od;
    if cl2 = nil then
        /* nobody has it locked - go ahead and lock it */
        cl*.cl_next := BusyClients;
        cl*.cl_prev := nil;
        cl*.cl_waitQueue := nil;
        if BusyClients ~= nil then
            BusyClients*.cl_prev := cl;
        fi;
        BusyClients := cl;
        copyData(cl*.cl_request, cl*.cl_lockKind);
        ReplyMsg(&cl*.cl_request*.rq_message);
    else
        /* it is locked - we have to wait for it by putting
           ourselves on the back of the queue waiting for it */
        pcl := &cl2*.cl_waitQueue;
        while pcl* ~= nil do
            pcl := &pcl**.cl_next;
        od;
        pcl* := cl;
        cl*.cl_next := nil;
    fi;
corp;

/*
 * handleRequests - wait for and handle requests from clients.
 */

proc handleRequests()void:
    register *Request_t rq;
    register *Client_t cl, cl2;
    register *Country_t cou @ cl2;
    ulong waitBits;
    bool quitRequested;

    ClientCounter := 1;
    quitRequested := false;
    waitBits := (1 << EmpirePort*.mp_SigBit) | SIGBREAKF_CTRL_C;
    while IdleClients ~= nil or BusyClients ~= nil or not quitRequested do
        if Wait(waitBits) & SIGBREAKF_CTRL_C ~= 0 then
            quitRequested := true;
        fi;
        while
            rq := pretend(GetMsg(EmpirePort), *Request_t);
            rq ~= nil
        do
            rq*.rq_time := GetCurrentTime();
            case rq*.rq_type
            incase rt_stopClient:
            incase rt_setCountry:
            incase rt_readFile:
            incase rt_moreFile:
            incase rt_readHelp:
            incase rt_readDoc:
            incase rt_readLocal:
            incase rt_edit:
            incase rt_getMessage:
            incase rt_setChat:
            incase rt_sendChat:
            incase rt_readPropaganda:
            incase rt_checkMessages:
            incase rt_readTelegram:
            incase rt_writePower:
            incase rt_readPower:
            incase rt_lockWorld:
            incase rt_lockWeather:
            incase rt_lockCountry:
            incase rt_lockSector:
            incase rt_lockShip:
            incase rt_lockFleet:
            incase rt_lockLoan:
            incase rt_lockOffer:
            incase rt_lockSectorPair:
            incase rt_lockShipPair:
            incase rt_lockSectorShipPair:
            incase rt_createShip:
            incase rt_createFleet:
            incase rt_createLoan:
            incase rt_createOffer:
                if Aborting then
                    /* this should cause the client to go away */
                    if rq*.rq_type ~= rt_stopClient then
                        rq*.rq_type := rt_nop;
                    fi;
                    quitRequested := true;
                fi;
                cl := IdleClients;
                while cl ~= nil and cl*.cl_identifier ~= rq*.rq_clientId do
                    cl := cl*.cl_next;
                od;
                if cl = nil then
                    logN("*** no idle client ", rq*.rq_clientId, " found");
                    rq*.rq_type := rt_nop;
                fi;
            incase rt_unlockWorld:
            incase rt_unlockWeather:
            incase rt_unlockCountry:
            incase rt_unlockSector:
            incase rt_unlockShip:
            incase rt_unlockFleet:
            incase rt_unlockLoan:
            incase rt_unlockOffer:
            incase rt_unlockSectorPair:
            incase rt_unlockShipPair:
            incase rt_unlockSectorShipPair:
                cl := BusyClients;
                while cl ~= nil and cl*.cl_identifier ~= rq*.rq_clientId do
                    cl := cl*.cl_next;
                od;
                if cl = nil then
                    logN("*** no busy client ", rq*.rq_clientId, " found");
                    rq*.rq_type := rt_nop;
                fi;
            esac;
            case rq*.rq_type
            incase rt_nop:
                if DEBUG then
                    log("nop");
                fi;
            incase rt_log:
                log(&rq*.rq_u.ru_text[0]);
            incase rt_startClient:
                if DEBUG then
                    log("start client");
                fi;
                startClient(rq);
            incase rt_stopClient:
                if DEBUG then
                    log("stop client");
                fi;
                stopClient(cl, rq);
            incase rt_shutDown:
                if DEBUG then
                    log("shutDown");
                fi;
                logN("Shut-down requested by client ", rq*.rq_clientId, ".");
                quitRequested := true;
            incase rt_poll:
                if quitRequested then
                    rq*.rq_whichUnit := 1;
                    logN("Shut-down request sent to client ",
                         rq*.rq_clientId, ".");
                else
                    rq*.rq_whichUnit := 0;
                fi;
            incase rt_flush:
                writeWorld(&World, &Country);
                closeFiles();
                openFiles(&Path[0], &HelpDir, &DocDir);
            incase rt_setCountry:
                cl*.cl_countryNumber := rq*.rq_whichUnit;
            incase rt_readFile:
                if DEBUG then
                    log("readFile");
                fi;
                readFile(cl, rq, ft_normal);
            incase rt_moreFile:
                if DEBUG then
                    log("moreFile");
                fi;
                moreFile(cl, rq);
            incase rt_readHelp:
                if DEBUG then
                    log("readHelp");
                fi;
                readFile(cl, rq, ft_help);
            incase rt_readDoc:
                if DEBUG then
                    log("readDoc");
                fi;
                readFile(cl, rq, ft_doc);
            incase rt_readLocal:
                if DEBUG then
                    log("readLocal");
                fi;
                readLocal(cl, rq);
            incase rt_edit:
                if DEBUG then
                    log("edit");
                fi;
                edit(cl, rq);
            incase rt_message:
                if DEBUG then
                    log("message");
                fi;
                message(rq);
            incase rt_getMessage:
                if DEBUG then
                    log("getMessage");
                fi;
                getMessage(cl, rq);
            incase rt_setChat:
                if DEBUG then
                    if rq*.rq_whichUnit = 0 then
                        log("set chat off");
                    else
                        log("set chat on");
                    fi;
                fi;
                if rq*.rq_whichUnit ~= 0 then
                    cl*.cl_chatting := true;
                    startChat(cl);
                else
                    cl*.cl_chatting := false;
                fi;
            incase rt_sendChat:
                if DEBUG then
                    log("sendChat");
                fi;
                sendChat(cl, rq);
            incase rt_news:
                if DEBUG then
                    log("news");
                fi;
                news(rq);
            incase rt_readNews:
                if DEBUG then
                    log("readNews");
                fi;
                readNews(rq);
            incase rt_propaganda:
                if DEBUG then
                    log("propaganda");
                fi;
                propaganda(rq);
            incase rt_readPropaganda:
                if DEBUG then
                    log("readPropaganda");
                fi;
                readPropaganda(cl, rq);
            incase rt_sendTelegram:
                cou := &Country[rq*.rq_whichUnit];
                if rq*.rq_u.ru_telegram.te_from = NOBODY then
                    if cou*.c_notify ~= nt_message or not cou*.c_loggedOn then
                        if DEBUG then
                            log("notify sendTelegram");
                        fi;
                        sendTelegram(rq);
                    fi;
                    if cou*.c_notify ~= nt_telegram and cou*.c_loggedOn then
                        if DEBUG then
                            log("notify message");
                        fi;
                        message(rq);
                    fi;
                else
                    if DEBUG then
                        log("sendTelegram");
                    fi;
                    sendTelegram(rq);
                fi;
            incase rt_checkMessages:
                if DEBUG then
                    log("checkMessages");
                fi;
                checkMessages(cl, rq);
            incase rt_readTelegram:
                if DEBUG then
                    log("readTelegram");
                fi;
                readTelegram(cl, rq);
            incase rt_writePower:
                if DEBUG then
                    log("writePower");
                fi;
                writePower(cl, rq);
            incase rt_readPower:
                if DEBUG then
                    log("readPower");
                fi;
                readPower(cl, rq);
            incase rt_readWorld:
            incase rt_readWeather:
            incase rt_readCountry:
            incase rt_readSector:
            incase rt_readShip:
            incase rt_readFleet:
            incase rt_readLoan:
            incase rt_readOffer:
            incase rt_readSectorPair:
            incase rt_readShipPair:
            incase rt_readSectorShipPair:
                if DEBUG then
                    case rq*.rq_type
                    incase rt_readWorld:
                        log("readWorld");
                    incase rt_readWeather:
                        log("readWeather");
                    incase rt_readCountry:
                        logN("readCountry ", rq*.rq_whichUnit, "");
                    incase rt_readSector:
                        logN("readSector ", rq*.rq_whichUnit, "" );
                    incase rt_readShip:
                        logN("readShip ", rq*.rq_whichUnit, "");
                    incase rt_readFleet:
                        logN("readFleet ", rq*.rq_whichUnit, "");
                    incase rt_readLoan:
                        logN("readLoan ", rq*.rq_whichUnit, "");
                    incase rt_readOffer:
                        logN("readOffer ", rq*.rq_whichUnit, "");
                    incase rt_readSectorPair:
                        logN("readSectorPair ", rq*.rq_whichUnit, "");
                    incase rt_readShipPair:
                        logN("readShipPair ", rq*.rq_whichUnit, "");
                    incase rt_readSectorShipPair:
                        logN("readSectorShipPair ", rq*.rq_whichUnit, "");
                    esac;
                fi;
                copyData(rq, (rq*.rq_type - rt_readWorld) / 3 + rk_world);
            incase rt_lockWorld:
            incase rt_lockWeather:
            incase rt_lockCountry:
            incase rt_lockSector:
            incase rt_lockShip:
            incase rt_lockFleet:
            incase rt_lockLoan:
            incase rt_lockOffer:
            incase rt_lockSectorPair:
            incase rt_lockShipPair:
            incase rt_lockSectorShipPair:
                if DEBUG then
                    case rq*.rq_type
                    incase rt_lockWorld:
                        log("lockWorld");
                    incase rt_lockWeather:
                        log("lockWeather");
                    incase rt_lockCountry:
                        logN("lockCountry ", rq*.rq_whichUnit, "");
                    incase rt_lockSector:
                        logN("lockSector ", rq*.rq_whichUnit, "" );
                    incase rt_lockShip:
                        logN("lockShip ", rq*.rq_whichUnit, "");
                    incase rt_lockFleet:
                        logN("lockFleet ", rq*.rq_whichUnit, "");
                    incase rt_lockLoan:
                        logN("lockLoan ", rq*.rq_whichUnit, "");
                    incase rt_lockOffer:
                        logN("lockOffer ", rq*.rq_whichUnit, "");
                    incase rt_lockSectorPair:
                        logN("lockSectorPair ", rq*.rq_whichUnit, "");
                    incase rt_lockShipPair:
                        logN("lockShipPair ", rq*.rq_whichUnit, "");
                    incase rt_lockSectorShipPair:
                        logN("lockSectorShipPair ", rq*.rq_whichUnit, "");
                    esac;
                fi;
                cl*.cl_lockKind := (rq*.rq_type - rt_lockWorld) / 3 + rk_world;
                cl*.cl_resource := rq*.rq_whichUnit;
                cl*.cl_resource2 := rq*.rq_otherUnit;
                /* remove client from list of idle clients */
                if cl*.cl_next ~= nil then
                    cl*.cl_next*.cl_prev := cl*.cl_prev;
                fi;
                if cl*.cl_prev ~= nil then
                    cl*.cl_prev*.cl_next := cl*.cl_next;
                else
                    IdleClients := cl*.cl_next;
                fi;
                /* see if anyone has that resource locked */
                cl*.cl_request := rq;
                rq := nil;
                handleLockRequest(cl);
            incase rt_unlockWorld:
            incase rt_unlockWeather:
            incase rt_unlockCountry:
            incase rt_unlockSector:
            incase rt_unlockShip:
            incase rt_unlockFleet:
            incase rt_unlockLoan:
            incase rt_unlockOffer:
            incase rt_unlockSectorPair:
            incase rt_unlockShipPair:
            incase rt_unlockSectorShipPair:
                if DEBUG then
                    case rq*.rq_type
                    incase rt_unlockWorld:
                        log("unlockWorld");
                    incase rt_unlockWeather:
                        log("unlockWeather");
                    incase rt_unlockCountry:
                        logN("unlockCountry ", rq*.rq_whichUnit, "");
                    incase rt_unlockSector:
                        logN("unlockSector ", rq*.rq_whichUnit, "" );
                    incase rt_unlockShip:
                        logN("unlockShip ", rq*.rq_whichUnit, "");
                    incase rt_unlockFleet:
                        logN("unlockFleet ", rq*.rq_whichUnit, "");
                    incase rt_unlockLoan:
                        logN("unlockLoan ", rq*.rq_whichUnit, "");
                    incase rt_unlockOffer:
                        logN("unlockOffer ", rq*.rq_whichUnit, "");
                    incase rt_unlockSectorPair:
                        logN("unlockSectorPair ", rq*.rq_whichUnit, "");
                    incase rt_unlockShipPair:
                        logN("unlockShipPair ", rq*.rq_whichUnit, "");
                    incase rt_unlockSectorShipPair:
                        logN("unlockSectorShipPair ", rq*.rq_whichUnit, "");
                    esac;
                fi;
                /* copy out the updated data */
                case rq*.rq_type
                incase rt_unlockWorld:
                    World := rq*.rq_u.ru_world;
                    cl2 := Clients;
                    while cl2 ~= nil do
                        if cl2 ~= cl then
                            cl2*.cl_newWorld := true;
                        fi;
                        cl2 := cl2*.cl_masterNext;
                    od;
                incase rt_unlockWeather:
                    World.w_weather := rq*.rq_u.ru_weather;
                incase rt_unlockCountry:
                    Country[rq*.rq_whichUnit] := rq*.rq_u.ru_country;
                    cl2 := Clients;
                    while cl2 ~= nil do
                        if cl2*.cl_countryNumber = rq*.rq_whichUnit then
                            cl2*.cl_newCountry := true;
                        fi;
                        cl2 := cl2*.cl_masterNext;
                    od;
                incase rt_unlockSector:
                    writeSector(rq*.rq_whichUnit, &rq*.rq_u.ru_sector);
                incase rt_unlockShip:
                    writeShip(rq*.rq_whichUnit, &rq*.rq_u.ru_ship);
                incase rt_unlockFleet:
                    writeFleet(rq*.rq_whichUnit, &rq*.rq_u.ru_fleet);
                incase rt_unlockLoan:
                    writeLoan(rq*.rq_whichUnit, &rq*.rq_u.ru_loan);
                incase rt_unlockOffer:
                    writeOffer(rq*.rq_whichUnit, &rq*.rq_u.ru_offer);
                incase rt_unlockSectorPair:
                    writeSector(rq*.rq_whichUnit, &rq*.rq_u.ru_sectorPair[0]);
                    writeSector(rq*.rq_otherUnit, &rq*.rq_u.ru_sectorPair[1]);
                incase rt_unlockShipPair:
                    writeShip(rq*.rq_whichUnit, &rq*.rq_u.ru_shipPair[0]);
                    writeShip(rq*.rq_otherUnit, &rq*.rq_u.ru_shipPair[1]);
                incase rt_unlockSectorShipPair:
                    writeSector(rq*.rq_whichUnit,
                                &rq*.rq_u.ru_sectorShipPair.p_s);
                    writeShip(rq*.rq_otherUnit,
                              &rq*.rq_u.ru_sectorShipPair.p_sh);
                esac;
                /* remove this client from the busy list */
                if cl*.cl_next ~= nil then
                    cl*.cl_next*.cl_prev := cl*.cl_prev;
                fi;
                if cl*.cl_prev ~= nil then
                    cl*.cl_prev*.cl_next := cl*.cl_next;
                else
                    BusyClients := cl*.cl_next;
                fi;
                /* put it onto the list of idle clients */
                cl*.cl_next := IdleClients;
                cl*.cl_prev := nil;
                if IdleClients ~= nil then
                    IdleClients*.cl_prev := cl;
                fi;
                IdleClients := cl;
                /* reply to this request */
                ReplyMsg(&rq*.rq_message);
                rq := nil;
                /* go through the wait queue of the now finished lock. A
                   request that is still waiting is put on another wait
                   queue. Any that can run are released. */
                cl := cl*.cl_waitQueue;
                while cl ~= nil do
                    cl2 := cl;
                    cl := cl*.cl_next;
                    handleLockRequest(cl2);
                od;
            incase rt_createShip:
                if DEBUG then
                    logN("createShip ", rq*.rq_whichUnit, "");
                fi;
                writeShip(rq*.rq_whichUnit, &rq*.rq_u.ru_ship);
            incase rt_createFleet:
                if DEBUG then
                    logN("createFleet ", rq*.rq_whichUnit, "");
                fi;
                writeFleet(rq*.rq_whichUnit, &rq*.rq_u.ru_fleet);
            incase rt_createLoan:
                if DEBUG then
                    logN("createLoan ", rq*.rq_whichUnit, "");
                fi;
                writeLoan(rq*.rq_whichUnit, &rq*.rq_u.ru_loan);
            incase rt_createOffer:
                if DEBUG then
                    logN("createOffer ", rq*.rq_whichUnit, "");
                fi;
                writeOffer(rq*.rq_whichUnit, &rq*.rq_u.ru_offer);
            default:
                logN("*** bad request type ", rq*.rq_type - rt_nop,
                     " received");
            esac;
            /* only reply if we have not already done so, or made it wait */
            if rq ~= nil then
                ReplyMsg(&rq*.rq_message);
            fi;
        od;
        if Aborting then
            quitRequested := true;
        fi;
    od;
    logN("Shutting down, ", ClientCounter - 1, " clients serviced.");
corp;

/*
 * startServing - start the Empire-specific stuff.
 */

proc startServing(bool test)void:
    *char portName;

    openFiles(&Path[0], &HelpDir, &DocDir);
    if not Aborting then
        portName := if test then TEST_PORT_NAME else EMPIRE_PORT_NAME fi;
        EmpirePort := FindPort(portName);
        if EmpirePort = nil then
            EmpirePort := CreatePort(portName, 0);
            if EmpirePort ~= nil then
                if readWorld(&World, &Country) then
                    IdleClients := nil;
                    BusyClients := nil;
                    log("Empire server started up.");
                    handleRequests();
                    writeWorld(&World, &Country);
                    log("Empire server shut down.");
                else
                    abort("can't read world/countries");
                fi;
                DeletePort(EmpirePort);
            else
                abort("can't create Empire port");
            fi;
        else
            abort("Empire port already exists");
        fi;
    fi;
    closeFiles();
corp;

/*
 * main - entry point for Empire server.
 */

proc main()void:
    extern _d_pars_initialize()void;
    *char par;
    *Process_t thisProcess;
    *WBStartup_t sm;
    register *WBArg_t wa;
    register Lock_t oldDir;
    register *DiskObject_t dob;
    register *char value;
    bool hadError, test;

    if OpenExecLibrary(0) ~= nil then
        if OpenDosLibrary(0) ~= nil then
            Aborting := false;
            CharsCopy(&Path[0], DEFAULT_PATH);
            thisProcess := pretend(FindTask(nil), *Process_t);
            if thisProcess*.pr_CLI = 0 then
                /* running from WorkBench */
                if OpenIconLibrary(0) ~= nil then
                    ignore WaitPort(&thisProcess*.pr_MsgPort);
                    sm := pretend(GetMsg(&thisProcess*.pr_MsgPort),
                                  *WBStartup_t);
                    wa := sm*.sm_ArgList;
                    if wa ~= nil and wa*.wa_Lock ~= 0 then
                        oldDir := CurrentDir(wa*.wa_Lock);
                        if wa*.wa_Name ~= nil and wa*.wa_Name* ~= '\e' and
                            wa*.wa_Name* ~= ' '
                        then
                            dob := GetDiskObject(wa*.wa_Name);
                            if dob ~= nil then
                                value :=
                                    FindToolType(dob*.do_ToolTypes, "PATH");
                                if value ~= nil then
                                    CharsCopy(&Path[0], value);
                                fi;
                                FreeDiskObject(dob);
                            fi;
                        fi;
                        startServing(false);
                        ignore CurrentDir(oldDir);
                    fi;
                    CloseIconLibrary();
                    Forbid();
                    ReplyMsg(&sm*.sm_Message);
                fi;
            else
                /* running from CLI */
                _d_pars_initialize();
                hadError := false;
                test := false;
                while
                    par := GetPar();
                    par ~= nil
                do
                    if par* = '-' then
                        par := par + sizeof(char);
                        while par* ~= '\e' do
                            case par*
                            incase 't':
                                test := true;
                            default:
                                hadError := true;
                            esac;
                            par := par + sizeof(char);
                        od;
                    else
                        CharsCopy(&Path[0], par);
                    fi;
                od;
                if hadError then
                    ignore Write(Output(), "Use is: run EmpServ [-t]\n", 25);
                else
                    startServing(test);
                fi;
            fi;
            CloseDosLibrary();
        fi;
        CloseExecLibrary();
    fi;
corp;
