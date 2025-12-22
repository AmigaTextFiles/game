#drinc:exec/miscellaneous.g
#drinc:exec/nodes.g
#drinc:exec/memory.g
#drinc:exec/ports.g
#drinc:exec/tasks.g
#drinc:libraries/dos.g
#drinc:libraries/dosextens.g
#drinc:workbench/workbench.g
#drinc:workbench/icon.g
#drinc:workbench/startup.g
#drinc:util.g
#/Include/EmpLib.g

/*
 * Amiga Empire
 *
 * Copyright (c) 1990 by Chris Gray
 *
 * Feel free to modify and use these sources however you wish, so long
 * as you preserve this copyright notice.
 */

ulong
    /* these are all stored as seconds */
    DEFAULT_RETRY_DELAY = 60,
    DEFAULT_PROBE_DELAY = 1,
    DEFAULT_DISCONNECT_DELAY = 3,
    DEFAULT_TIMEOUT = 15 * 60;

extern
    openSerialHandler(*char device; ulong unit, baud, timeout;
                      bool shared, XXEnabled, sevenWire, ignoreCD;
                      ushort parity)bool,
    closeSerialHandler()void,
    serialGetLine(*char buffer; uint bufferLen)bool,
    serialPutLine(*char buffer; uint length)void,
    serialEcho(bool enabled)void,
    serialActive()uint,
    serialSpeed()*char,
    serialHungup()bool,
    serialGotControlC()bool;

ulong STACK_SIZE_NEEDED = 25000;

uint
    R_D0 = 0,
    R_A0 = 0,
    R_FP = 6,
    OP_MOVEL = 0x2000,
    OP_MOVEW = 0x3000,
    M_DDIR = 0,
    M_ADIR = 1,
    M_DISP = 5;

*MsgPort_t EmpirePort, MyPort;
Handle_t OutputFd;
*EmpireState_t ES;
ulong SerialUnit, SerialBaud, RetryDelay, ProbeDelay, DisconnectDelay, TimeOut;
bool SerialShared, SerialXXEnabled, Serial7Wire, SerialReady, IgnoreCD;
ushort SerialParity;

[100] char SerialDevice;

bool FromWorkBench;
*WBStartup_t StartupMessage;

/*
 * mess - simple routine to write a string to the console.
 */

proc mess(*char m)void:
    register *char p;

    if OutputFd = 0 then
        OutputFd := Open("CON:0/20/640/30/SEREmp", MODE_NEWFILE);
    fi;
    if OutputFd ~= 0 then
        p := m;
        while p* ~= '\e' do
            p := p + sizeof(char);
        od;
        ignore Write(OutputFd, m, p - m);
    fi;
corp;

/*
 * num - simple routine to write a number to the console.
 */

proc num(register ulong n)void:
    [11] char buffer;
    register *char p;

    p := &buffer[10];
    p* := '\e';
    while
        p := p - sizeof(char);
        p* := n % 10 + '0';
        n := n / 10;
        n ~= 0
    do
    od;
    mess(p);
corp;

/*
 * serverAbort - something has gone wrong in our communications with the
 *      Empire server. We issue a message and then shut down.
 */

proc serverAbort()void:
    register *Request_t rq;

    rq := &ES*.es_request;
    rq*.rq_type := rt_stopClient;
    PutMsg(EmpirePort, &rq*.rq_message);
    ignore WaitPort(MyPort);
    ignore GetMsg(MyPort);
    FreeMem(ES, sizeof(EmpireState_t));
    CloseEmpireLibrary();
    DeletePort(MyPort);
    if FromWorkBench then
        if OutputFd ~= 0 then
            Delay(10 * 10);
            Close(OutputFd);
        fi;
        CloseIconLibrary();
        Forbid();
        ReplyMsg(&StartupMessage*.sm_Message);
    else
        Exit(RETURN_FAIL);
    fi;
corp;

/*
 * serverRequest - routine to allow library to send a request to the Empire
 *      server, and wait for a reply.
 */

proc serverRequest()void:
    register *Request_t rq;
    RequestType_t rt;

    rq := &ES*.es_request;
    rt := rq*.rq_type;
    PutMsg(EmpirePort, &rq*.rq_message);
    ignore WaitPort(MyPort);
    if pretend(GetMsg(MyPort), *Request_t) ~= rq then
        mess("*** serverRequest: didn't get MY message back ***\n");
        serverAbort();
    else
        if rq*.rq_type ~= rt then
            mess("*** serverRequest: got type ");
            num(rq*.rq_type - rt_nop);
            mess(" back instead of ");
            num(rt - rt_nop);
            mess(" ***\n");
            serverAbort();
        fi;
    fi;
corp;

/*
 * writeUser - routine to allow the Empire library to write to the user.
 */

proc writeUser()void:

    serialPutLine(&ES*.es_textOut[0], ES*.es_textOutPos);
corp;

/*
 * readUser - routine to allow the Empire library to read from the user.
 */

proc readUser()bool:

    ES*.es_textInPos := &ES*.es_textIn[0];
    serialGetLine(&ES*.es_textIn[0], INPUT_BUFFER_SIZE)
corp;

/*
 * echoOff - disable echo on the user input.
 */

proc echoOff()void:

    serialEcho(false);
corp;

/*
 * echoOn - re-enable echo on the user input.
 */

proc echoOn()void:

    serialEcho(true);
corp;

/*
 * gotControlC - return true if user has typed a CNTL-C.
 */

proc gotControlC()bool:

    if serialGotControlC() then
        serialPutLine("Interrupt!!!\n", 13);
        true
    else
        false
    fi
corp;

/*
 * sleep - sleep for the given number of tenths of a second.
 */

proc sleep()void:
    uint n;

    code(OP_MOVEW | R_FP << 9 | M_DISP << 6 | M_DDIR << 3 | R_D0, n);
    Delay(n * 5);
corp;

/*
 * userLog - routine to allow the user to do logging.
 */

proc userLog(/* *char fileName */)bool:

    /* logging not allowed for people connecting over the serial port */
    false
corp;

/*
 * oneRun - do one run of Empire.
 */

proc oneRun(register *EmpireState_t es)void:
    register *char p;
    [2] char buff;

    p := &es*.es_request.rq_private[0];
    if SerialReady then
        CharsCopy(p, "Getty");
    else
        CharsCopy(p, serialSpeed());
        CharsConcat(p, " baud");
    fi;
    CharsConcat(p, " connection on ");
    CharsConcat(p, &SerialDevice[0]);
    CharsConcat(p, " port ");
    buff[0] := SerialUnit + '0';
    buff[1] := '\e';
    CharsConcat(p, &buff[0]);
    CharsConcat(p, ".");
    es*.es_request.rq_type := rt_log;
    serverRequest();

    Empire(es);

    CharsCopy(p, "Connection terminated on ");
    CharsConcat(p, &SerialDevice[0]);
    CharsConcat(p, " port ");
    CharsConcat(p, &buff[0]);
    CharsConcat(p, ".");
    es*.es_request.rq_type := rt_log;
    serverRequest();
    es*.es_request.rq_type := rt_flush;
    serverRequest();
corp;

/*
 * startRuns - setup the serial port and do some connects.
 */

proc startRuns(register *EmpireState_t es)void:
    register bool serialOpen, done;

    serialOpen := false;
    done := false;
    while not done do
        if not serialOpen then
            if openSerialHandler(&SerialDevice[0], SerialUnit, SerialBaud,
                                 TimeOut, SerialShared, SerialXXEnabled,
                                 Serial7Wire, IgnoreCD, SerialParity)
            then
                serialOpen := true;
            else
                Delay(RetryDelay * 50);
            fi;
        fi;
        if serialOpen then
            if SerialReady then
                /* Getty has the line all set - just play one game */
                oneRun(es);
                done := true;
            else
                case serialActive()
                incase 0:
                    /* no activity on port */
                    Delay(ProbeDelay * 50);
                incase 1:
                    /* activity on port, but no connect - force disconnect */
                    closeSerialHandler();
                    serialOpen := false;
                    Delay(DisconnectDelay * 50);
                incase 2:
                    /* got a connection - start up the game */
                    oneRun(es);
                    closeSerialHandler();
                    serialOpen := false;
                    Delay(DisconnectDelay * 50);
                esac;
            fi;
        fi;
        if SetSignal(0, SIGBREAKF_CTRL_C) & SIGBREAKF_CTRL_C ~= 0 then
            done := true;
        fi;
        es*.es_request.rq_type := rt_poll;
        serverRequest();
        if es*.es_request.rq_whichUnit ~= 0 then
            /* server is asking us to go away */
            done := true;
        fi;
    od;
    if serialOpen then
        closeSerialHandler();
    fi;
corp;

/*
 * runEmpire - start up the Empire-specific stuff.
 */

proc runEmpire()void:
    register *EmpireState_t es;

    EmpirePort := FindPort(EMPIRE_PORT_NAME);
    if EmpirePort ~= nil then
        MyPort := CreatePort(nil, 0);
        if MyPort ~= nil then
            if OpenEmpireLibrary(0) ~= nil then
                es := AllocMem(sizeof(EmpireState_t), MEMF_PUBLIC);
                if es ~= nil then
                    ES := es;
                    es*.es_serverRequest := serverRequest;
                    es*.es_writeUser := writeUser;
                    es*.es_readUser := readUser;
                    es*.es_echoOff := echoOff;
                    es*.es_echoOn := echoOn;
                    es*.es_gotControlC := gotControlC;
                    es*.es_sleep := sleep;
                    es*.es_log := userLog;

                    es*.es_request.rq_message.mn_Node.ln_Type := NT_MESSAGE;
                    es*.es_request.rq_message.mn_ReplyPort := MyPort;
                    es*.es_request.rq_message.mn_Length :=
                        sizeof(Request_t) - sizeof(Message_t);

                    es*.es_request.rq_type := rt_startClient;
                    serverRequest();
                    startRuns(es);
                    es*.es_request.rq_type := rt_stopClient;
                    serverRequest();

                    FreeMem(es, sizeof(EmpireState_t));
                else
                    mess("*** can't allocate Empire state structure.\n");
                fi;
                CloseEmpireLibrary();
            else
                mess("*** can't open Empire.library.\n");
                mess("*** Is it in your LIBS: directory?\n");
            fi;
            DeletePort(MyPort);
        else
            mess("*** can't create client reply port\n");
        fi;
    else
        mess("*** can't find Empire port. Is server running?\n");
    fi;
corp;

/*
 * getNumber - parse a number from the passed string. No error checking.
 */

proc getNumber(register *char str)ulong:
    register ulong n;

    n := 0;
    while str* >= '0' and str* <= '9' do
        n := n * 10 + (str* - '0');
        str := str + sizeof(char);
    od;
    n
corp;

/*
 * getBool - interpret a YES/NO or ON/OFF from a string.
 */

proc getBool(*char st)bool:

    CharsEqual(st, "YES") or CharsEqual(st, "ON") or CharsEqual(st, "TRUE")
corp;

/*
 * scanToolTypes - extract overriding parameters from the given
 *      toolType array.
 */

proc scanToolTypes(register **char toolTypeArray)void:
    register *char value;

    value := FindToolType(toolTypeArray, "DEVICE");
    if value ~= nil then
        CharsCopy(&SerialDevice[0], value);
    fi;
    value := FindToolType(toolTypeArray, "UNIT");
    if value ~= nil then
        SerialUnit := getNumber(value);
    fi;
    value := FindToolType(toolTypeArray, "BAUD");
    if value ~= nil then
        SerialBaud := getNumber(value);
    fi;
    value := FindToolType(toolTypeArray, "SHARED");
    if value ~= nil then
        SerialShared := getBool(value);
    fi;
    value := FindToolType(toolTypeArray, "XONXOFF");
    if value ~= nil then
        SerialXXEnabled := getBool(value);
    fi;
    value := FindToolType(toolTypeArray, "IGNORECD");
    if value ~= nil then
        IgnoreCD := getBool(value);
    fi;
    value := FindToolType(toolTypeArray, "7WIRE");
    if value ~= nil then
        Serial7Wire := getBool(value);
    fi;
    value := FindToolType(toolTypeArray, "PARITY");
    if value ~= nil then
        if CharsEqual(value, "NONE") then
            SerialParity := 0;
        elif CharsEqual(value, "EVEN") then
            SerialParity := 1;
        elif CharsEqual(value, "ODD") then
            SerialParity := 2;
        fi;
    fi;
    value := FindToolType(toolTypeArray, "RETRY");
    if value ~= nil then
        RetryDelay := getNumber(value);
    fi;
    value := FindToolType(toolTypeArray, "PROBE");
    if value ~= nil then
        ProbeDelay := getNumber(value);
    fi;
    value := FindToolType(toolTypeArray, "DISCONNECT");
    if value ~= nil then
        DisconnectDelay := getNumber(value);
    fi;
    value := FindToolType(toolTypeArray, "TIMEOUT");
    if value ~= nil then
        TimeOut := getNumber(value);
    fi;
corp;

/*
 * useage - issue a CLI useage error line.
 */

proc useage()void:

    mess(
       "Use: SEREmp [d<device> u<unit> b<baud> sxi7 p[neo] t[rpdt]<delay>]\n");
corp;

/*
 * main - start everything up.
 */

proc main()void:
    extern _d_pars_initialize()void;
    *Process_t thisProcess;
    *WBStartup_t sm;
    register *WBArg_t wa;
    register Lock_t oldDir;
    register *DiskObject_t dob;
    register *char par;
    register ulong stackSize;
    register char ch;
    [2] char buff;
    bool hadError;

    if OpenExecLibrary(0) ~= nil then
        if OpenDosLibrary(0) ~= nil then
            CharsCopy(&SerialDevice[0], "serial.device");
            SerialUnit := 0;
            RetryDelay := DEFAULT_RETRY_DELAY;
            ProbeDelay := DEFAULT_PROBE_DELAY;
            DisconnectDelay := DEFAULT_DISCONNECT_DELAY;
            TimeOut := DEFAULT_TIMEOUT;
            SerialBaud := 0;
            SerialShared := false;
            SerialXXEnabled := false;
            Serial7Wire := false;
            IgnoreCD := false;
            SerialReady := false;
            SerialParity := 0;
            hadError := false;
            thisProcess := pretend(FindTask(nil), *Process_t);
            if thisProcess*.pr_CLI = 0 then
                /* running from WorkBench */
                FromWorkBench := true;
                if OpenIconLibrary(0) ~= nil then
                    stackSize := 4000;
                    OutputFd := 0;
                    ignore WaitPort(&thisProcess*.pr_MsgPort);
                    sm := pretend(GetMsg(&thisProcess*.pr_MsgPort),
                                  *WBStartup_t);
                    StartupMessage := sm;
                    wa := sm*.sm_ArgList;
                    if wa ~= nil then
                        if sm*.sm_NumArgs <= 1 then
                            if wa*.wa_Lock ~= 0 then
                                oldDir := CurrentDir(wa*.wa_Lock);
                                if wa*.wa_Name ~= nil and
                                    wa*.wa_Name* ~= '\e' and
                                    wa*.wa_Name* ~= ' '
                                then
                                    dob := GetDiskObject(wa*.wa_Name);
                                    if dob ~= nil then
                                        if dob*.do_StackSize > stackSize then
                                            stackSize := dob*.do_StackSize;
                                        fi;
                                        scanToolTypes(dob*.do_ToolTypes);
                                        FreeDiskObject(dob);
                                    fi;
                                fi;
                                ignore CurrentDir(oldDir);
                            fi;
                        else
                            wa := wa + sizeof(WBArg_t);
                            if wa*.wa_Lock ~= 0 then
                                oldDir := CurrentDir(wa*.wa_Lock);
                                if wa*.wa_Name ~= nil and
                                    wa*.wa_Name* ~= '\e' and
                                    wa*.wa_Name* ~= ' '
                                then
                                    dob := GetDiskObject(wa*.wa_Name);
                                    if dob ~= nil then
                                        if dob*.do_StackSize > stackSize then
                                            stackSize := dob*.do_StackSize;
                                        fi;
                                        scanToolTypes(dob*.do_ToolTypes);
                                        FreeDiskObject(dob);
                                    fi;
                                fi;
                                ignore CurrentDir(oldDir);
                            fi;
                        fi;
                    fi;
                    if stackSize < STACK_SIZE_NEEDED then
                        mess("Stack size (");
                        num(stackSize);
                        mess(") too small - use at least ");
                        num(STACK_SIZE_NEEDED);
                        mess("\n");
                    else
                        runEmpire();
                    fi;
                    if OutputFd ~= 0 then
                        Delay(10 * 10);
                        Close(OutputFd);
                    fi;
                    CloseIconLibrary();
                    Forbid();
                    ReplyMsg(&sm*.sm_Message);
                fi;
            else
                /* running from CLI */
                FromWorkBench := false;
                OutputFd := Output();
                _d_pars_initialize();
                while
                    par := GetPar();
                    par ~= nil
                do
                    if par* = '-' then
                        par := par + sizeof(char);
                    fi;
                    if CharsEqual(par, "Getty") then
                        SerialReady := true;
                        SerialShared := true;
                    elif CharsEqual(par, "DEVICE") then
                        par := GetPar();
                        if par ~= nil then
                            CharsCopy(&SerialDevice[0], par);
                        fi;
                    elif CharsEqual(par, "UNIT") then
                        par := GetPar();
                        if par ~= nil then
                            SerialUnit := getNumber(par);
                        fi;
                    else
                        while
                            ch := par*;
                            par := par + sizeof(char);
                            ch ~= '\e'
                        do
                            case ch
                            incase 'd':
                                CharsCopy(&SerialDevice[0], par);
                                par := "";
                            incase 'u':
                                SerialUnit := getNumber(par);
                                par := "";
                            incase 'b':
                                SerialBaud := getNumber(par);
                                par := "";
                            incase 's':
                                SerialShared := true;
                            incase 'x':
                                SerialXXEnabled := true;
                            incase 'i':
                                IgnoreCD := true;
                            incase '7':
                                Serial7Wire := true;
                            incase 'p':
                                ch := par*;
                                par := par + sizeof(char);
                                case ch
                                incase 'n':
                                    SerialParity := 0;
                                incase 'e':
                                    SerialParity := 1;
                                incase 'o':
                                    SerialParity := 2;
                                default:
                                    mess("Unknown 'p' option: ");
                                    buff[0] := ch;
                                    buff[1] := '\e';
                                    mess(&buff[0]);
                                    mess("\n");
                                    hadError := true;
                                esac;
                                par := "";
                            incase 't':
                                ch := par*;
                                par := par + sizeof(char);
                                case ch
                                incase 'r':
                                    RetryDelay := getNumber(par);
                                incase 'p':
                                    ProbeDelay := getNumber(par);
                                incase 'd':
                                    DisconnectDelay := getNumber(par);
                                incase 't':
                                    TimeOut := getNumber(par);
                                default:
                                    mess("Unknown 't' option: ");
                                    buff[0] := ch;
                                    buff[1] := '\e';
                                    mess(&buff[0]);
                                    mess("\n");
                                    hadError := true;
                                esac;
                                par := "";
                            default:
                                mess("Unknown option: ");
                                buff[0] := ch;
                                buff[1] := '\e';
                                mess(&buff[0]);
                                mess("\n");
                                hadError := true;
                            esac;
                        od;
                    fi;
                od;
                if hadError then
                    useage();
                fi;
                stackSize := pretend(thisProcess*.pr_ReturnAddr, *ulong)*;
                if stackSize < STACK_SIZE_NEEDED then
                    mess("Stack size (");
                    num(stackSize);
                    mess(") too small - use at least ");
                    num(STACK_SIZE_NEEDED);
                    mess("\n");
                    hadError := true;
                fi;
                if not hadError then
                    runEmpire();
                fi;
            fi;
            CloseDosLibrary();
        fi;
        CloseExecLibrary();
    fi;
corp;
