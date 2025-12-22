#drinc:exec/miscellaneous.g
#drinc:exec/nodes.g
#drinc:exec/memory.g
#drinc:exec/ports.g
#drinc:exec/tasks.g
#drinc:graphics/gfx.g
#drinc:graphics/gfxBase.g
#drinc:graphics/view.g
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
 * $Id: Empire.d,v 1.6 90/06/23 00:38:17 DaveWT Exp $
 * $Log:	Empire.d,v $
Revision 1.6  90/06/23  00:38:17  DaveWT
Added the version number display to the startup and shutdown log
messages.

Revision 1.5  90/06/02  19:27:18  DaveWT
Changed version numbers
/

Revision 1.4  90/05/08  14:42:13  DaveWT
Added CG's -t feature to use "Empire test port" instead of "Empire port"
to allow testing while the main Empire server is still running.

Revision 1.3  90/04/11  10:24:26  DaveWT
Added the console type to the title bar, and print what the -a option
is.

 */

ulong STACK_NEEDED = 25000;

uint LOG_SIZE = 512 * 10;

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
Handle_t StdOut, StdIn, LogFd;
*EmpireState_t ES;
bool NonShell, DoDebug;

[LOG_SIZE] char LogBuffer;
unsigned LOG_SIZE LogPos;

/*
 * mess - simple routine to write a string to the user.
 */

proc mess(*char m)void:
    register *char p;

    p := m;
    while p* ~= '\e' do
        p := p + sizeof(char);
    od;
    ignore Write(StdOut, m, p - m);
corp;

/*
 * num - simple routine to write a number to the user.
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
 * logFlush - flush the user log data.
 */

proc logFlush()void:

    if LogPos ~= 0 then
        ignore Write(LogFd, &LogBuffer[0], LogPos);
        LogPos := 0;
    fi;
corp;

/*
 * serverAbort - something has gone wrong in our communications with the
 *      Empire server. We issue a message and then shut down.
 */

proc serverAbort()void:
    register *Request_t rq;

    if LogFd ~= 0 then
        logFlush();
        Close(LogFd);
    fi;
    rq := &ES*.es_request;
    rq*.rq_type := rt_stopClient;
    PutMsg(EmpirePort, &rq*.rq_message);
    ignore WaitPort(MyPort);
    ignore GetMsg(MyPort);
    FreeMem(ES, sizeof(EmpireState_t));
    CloseEmpireLibrary();
    DeletePort(MyPort);
    Exit(RETURN_FAIL);
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
 * writeLog - write some stuff to the user log file.
 */

proc writeLog(register *char p; register uint i)void:

    while i ~= 0 do
        i := i - 1;
        LogBuffer[LogPos] := p*;
        p := p + sizeof(char);
        LogPos := LogPos + 1;
        if LogPos = LOG_SIZE then
            logFlush();
        fi;
    od;
corp;

/*
 * writeUser - routine to allow the Empire library to write to the user.
 */

proc writeUser()void:

    ignore Write(StdOut, &ES*.es_textOut[0], ES*.es_textOutPos);
    if LogFd ~= 0 then
        writeLog(&ES*.es_textOut[0], ES*.es_textOutPos);
    fi;
corp;

/*
 * readUser - routine to allow the Empire library to read from the user.
 */

proc readUser()bool:
    register *EmpireState_t es;
    register *char p;
    register long len;

    es := ES;
    es*.es_textInPos := &es*.es_textIn[0];
    len := Read(StdIn, &es*.es_textIn[0], INPUT_BUFFER_SIZE - 1);
    if len < 0 then
        es*.es_textIn[0] := '\e';
        false
    else
        if LogFd ~= 0 then
            writeLog(&es*.es_textIn[0], len);
        fi;
        p := &es*.es_textIn[0];
        while p* ~= '\n' and len ~= 0 do
            len := len - 1;
            p := p + sizeof(char);
        od;
        p* := '\e';
        true
    fi
corp;

/*
 * echoOff - disable echo on the user input.
 */

proc echoOff()void:
    char CSI = '\(0x9b)';

    if not NonShell then
        ignore Write(StdOut, "\(CSI)30;40m", 7);
    fi;
corp;

/*
 * echoOn - re-enable echo on the user input.
 */

proc echoOn()void:
    char CSI = '\(0x9b)';

    if not NonShell then
        ignore Write(StdOut, "\(CSI)31;40m", 7);
    fi;
corp;

/*
 * gotControlC - return true if user has typed a CNTL-C.
 */

proc gotControlC()bool:

    if SetSignal(0, SIGBREAKF_CTRL_C) & SIGBREAKF_CTRL_C ~= 0 then
        ignore Write(StdOut, "Interrupt!!!\n", 13);
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
    *char fileName;

    code(OP_MOVEL | R_FP << 9 | M_DISP << 6 | M_ADIR << 3 | R_A0, fileName);
    if LogFd ~= 0 then
        logFlush();
        Close(LogFd);
        LogFd := 0;
    fi;
    if fileName = nil then
        true
    else
        LogFd := Open(fileName, MODE_OLDFILE);
        if LogFd = 0 then
            LogFd := Open(fileName, MODE_NEWFILE);
        fi;
        if LogFd ~= 0 then
            if Seek(LogFd, 0, OFFSET_END) = 0 then
                true
            else
                Close(LogFd);
                LogFd := 0;
                false
            fi
        else
            false
        fi
    fi
corp;

/*
 * runEmpire - start up the Empire-specific stuff.
 */

proc runEmpire()bool:
    register *EmpireState_t es;
    bool ok;

    ok := false;
    EmpirePort := FindPort(if DoDebug then "Empire test port" else
                               EMPIRE_PORT_NAME fi);
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
                    LogFd := 0;

                    es*.es_request.rq_message.mn_Node.ln_Type := NT_MESSAGE;
                    es*.es_request.rq_message.mn_ReplyPort := MyPort;
                    es*.es_request.rq_message.mn_Length :=
                        sizeof(Request_t) - sizeof(Message_t);

                    es*.es_request.rq_type := rt_startClient;
                    serverRequest();
                    CharsCopy(&es*.es_request.rq_private[0],
                              "Local client 2.2w started.");
                    es*.es_request.rq_type := rt_log;
                    serverRequest();

                    Empire(es);

                    if LogFd ~= 0 then
                        logFlush();
                        Close(LogFd);
                    fi;
                    CharsCopy(&es*.es_request.rq_private[0],
                              "Local client 2.2w terminated.");
                    es*.es_request.rq_type := rt_log;
                    serverRequest();
                    es*.es_request.rq_type := rt_stopClient;
                    serverRequest();

                    FreeMem(es, sizeof(EmpireState_t));
                    ok := true;
                else
                    mess(
                        "*** can't allocate Empire state structure.\n"
                    );
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
    ok
corp;

/*
 * fmtNum - little utility for 'openWindow'.
 */

proc fmtNum(*char desc; register uint n)void:
    register *char p;
    [6] char buffer;

    p := &buffer[5];
    p* := '\e';
    while
        p := p - sizeof(char);
        p* := n % 10 + '0';
        n := n / 10;
        n ~= 0
    do
    od;
    CharsConcat(desc, p);
corp;

/*
 * openWindow - open an appropriate window for WorkBench startup.
 */

proc openWindow(*Process_t thisProcess)bool:
    register *GfxBase_t gfxBase;
    register *View_t v;
    *Window_t saveWindow;
    uint rows, cols;
    [100] char windowDesc;

    rows := 200;
    cols := 640;
    gfxBase := OpenGraphicsLibrary(0);
    if gfxBase ~= nil then
        rows := gfxBase*.gb_NormalDisplayRows;
        cols := gfxBase*.gb_NormalDisplayColumns;
        v := gfxBase*.gb_ActiView;
        if v ~= nil and v*.v_Modes & LACE ~= 0 then
            rows := rows * 2;
        fi;
        CloseGraphicsLibrary();
    fi;
    CharsCopy(&windowDesc[0], "NEWCON:0/0/");
    fmtNum(&windowDesc[0], cols);
    CharsConcat(&windowDesc[0], "/");
    fmtNum(&windowDesc[0], rows);
    CharsConcat(&windowDesc[0],
        "/Amiga Empire 2.2w by Chris Gray & David Wright {newcon:}");
    saveWindow := thisProcess*.pr_WindowPtr;
    thisProcess*.pr_WindowPtr := pretend(-1, *Window_t);
    StdOut := Open(&windowDesc[0], MODE_NEWFILE);
    thisProcess*.pr_WindowPtr := saveWindow;
    if StdOut = 0 then
        CharsCopy(&windowDesc[0], "CON:0/0/");
        fmtNum(&windowDesc[0], cols);
        CharsConcat(&windowDesc[0], "/");
        fmtNum(&windowDesc[0], rows);
        CharsConcat(&windowDesc[0],
            "/Amiga Empire 2.2w by Chris Gray & David Wright {con:}");
        StdOut := Open(&windowDesc[0], MODE_NEWFILE);
    fi;
    StdOut ~= 0
corp;

/*
 * useage - print a simple CLI useage message.
 */

proc useage()void:

    mess("Useage is: Empire [-a] [-t]\n");
    mess("    -a = non-ANSI terminal\n");
    mess("    -t = use test port\n");
corp;

/*
 * main - start everything up.
 */

proc main()void:
    extern _d_pars_initialize()void;
    *char par;
    *Process_t thisProcess;
    *WBStartup_t sm;
    register *WBArg_t wa;
    register Lock_t oldDir;
    register *DiskObject_t dob;
    register ulong stackSize;
    bool hadError;

    if OpenExecLibrary(0) ~= nil then
        if OpenDosLibrary(0) ~= nil then
            NonShell := false;
            DoDebug := false;
            thisProcess := pretend(FindTask(nil), *Process_t);
            if thisProcess*.pr_CLI = 0 then
                /* running from WorkBench */
                if OpenIconLibrary(0) ~= nil then
                    stackSize := 4000;
                    ignore WaitPort(&thisProcess*.pr_MsgPort);
                    sm := pretend(GetMsg(&thisProcess*.pr_MsgPort),
                                  *WBStartup_t);
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
                                        stackSize := dob*.do_StackSize;
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
                                        stackSize := dob*.do_StackSize;
                                        FreeDiskObject(dob);
                                    fi;
                                fi;
                                ignore CurrentDir(oldDir);
                            fi;
                        fi;
                    fi;
                    if openWindow(thisProcess) then
                        if stackSize < STACK_NEEDED then
                            mess("Stack size (");
                            num(stackSize);
                            mess(") too small - use at least ");
                            num(STACK_NEEDED);
                            mess("\n");
                            Delay(5 * 50);
                        else
                            StdIn := StdOut;
                            if not runEmpire() then
                                Delay(5 * 50);
                            fi;
                        fi;
                        Close(StdOut);
                    fi;
                    Forbid();
                    ReplyMsg(&sm*.sm_Message);
                    CloseIconLibrary();
                fi;
            else
                /* running from CLI */
                StdOut := Output();
                _d_pars_initialize();
                hadError := false;
                while
                    par := GetPar();
                    par ~= nil
                do
                    if par* = '-' then
                        par := par + sizeof(char);
                    fi;
                    while par* ~= '\e' do
                        case par*
                        incase 'a':
                            NonShell := true;
                        incase 't':
                            DoDebug := true;
                        default:
                            hadError := true;
                        esac;
                        par := par + sizeof(char);
                    od;
                od;
                if hadError then
                    useage();
                fi;
                stackSize := pretend(thisProcess*.pr_ReturnAddr, *ulong)*;
                if stackSize < STACK_NEEDED then
                    mess("Stack size (");
                    num(stackSize);
                    mess(") too small - use at least ");
                    num(STACK_NEEDED);
                    mess("\n");
                    hadError := true;
                fi;
                if not hadError then
                    StdIn := Input();
                    ignore runEmpire();
                fi;
            fi;
            CloseDosLibrary();
        fi;
        CloseExecLibrary();
    fi;
corp;
