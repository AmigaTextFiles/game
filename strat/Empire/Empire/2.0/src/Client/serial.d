#drinc:exec/nodes.g
#drinc:exec/lists.g
#drinc:exec/tasks.g
#drinc:exec/io.g
#drinc:exec/ports.g
#drinc:devices/serial.g
#drinc:devices/timer.g
#drinc:libraries/dos.g
#drinc:hardware/cia.g

#drinc:util.g

/*
 * Amiga Empire
 *
 * Copyright (c) 1990 by Chris Gray
 *
 * Feel free to modify and use these sources however you wish, so long
 * as you preserve this copyright notice.
 */

bool VERBOSE = false;

uint
    INPUT_BUFFER_SIZE = 512,
    OUTPUT_BUFFER_SIZE = 512,
    HISTORY_BUFFER_SIZE = 1024;

extern
    mess(*char message)void,
    num(ulong number)void;

ulong LineSpeed, TimeOut;
bool EchoOn, SerialDropped, AutoBaud, IgnoreCD;

*MsgPort_t SerPort, SerPort2;
*IOExtSer_t SerReq, SerReq2;
IOExtSer_t SaveParams;
*MsgPort_t TimerPort;
*timerequest_t TimerReq;
*Task_t MyTask;
ushort SerFlags, SerBits;

[INPUT_BUFFER_SIZE] char InputBuffer;
uint InputBufferMax, InputBufferPos;
[OUTPUT_BUFFER_SIZE] char OutputBuffer;
uint OutputBufferPos;
[HISTORY_BUFFER_SIZE] char HistoryBuffer;
uint HistoryAddPoint;

[12] char SpeedBuffer;

/*
 * checkDoIO - do and check a DoIO write call for the serial device.
 */

proc checkDoIO(register *IOExtSer_t req; uint command; *char message)void:
    uint errnum;

    req*.ios_IOSer.io_io.io_Command := command;
    req*.ios_IOSer.io_io.io_Flags := 0;
    if command ~= CMD_READ then
        /* apparantly this is needed by the Supra 'modem0.device' */
        req*.ios_IOSer.io_Length := 0;
    fi;
    req*.ios_IOSer.io_Actual := 0;
    if VERBOSE then
        errnum := DoIO(&req*.ios_IOSer.io_io);
        if errnum ~= 0 then
            mess(message);
            mess(" error on serial port: ");
            num(errnum);
            mess("\n");
        fi;
    else
        ignore DoIO(&req*.ios_IOSer.io_io);
    fi;
corp;

/*
 * setParams - issue an SCMD_SETPARAMS to serial device.
 */

proc setParams(register *IOExtSer_t req)void:

    checkDoIO(req, CMD_CLEAR, "setParams first clear");
    req*.ios_CtlChar := 0x11130000;
    req*.ios_Baud := LineSpeed;
    req*.ios_TermArray.TermArray0 := 0xff7f1c04;
    req*.ios_TermArray.TermArray1 := 0x03000000;
    req*.ios_StopBits := 1;
    req*.ios_SerFlags := SerFlags;
    req*.ios_ReadLen := SerBits;
    req*.ios_WriteLen := SerBits;
    checkDoIO(req, SDCMD_SETPARAMS, "setParams");
    checkDoIO(req, CMD_CLEAR, "setParams second clear");

    InputBufferPos := 0;
    InputBufferMax := 0;
    OutputBufferPos := 0;
corp;

/* some little utility routines to make things more readable */

proc createSerIO(*MsgPort_t port)*IOExtSer_t:

    pretend(CreateExtIO(port, sizeof(IOExtSer_t)), *IOExtSer_t)
corp;

proc deleteSerIO(*IOExtSer_t req)void:

    DeleteExtIO(&req*.ios_IOSer.io_io, sizeof(IOExtSer_t));
corp;

proc createTimerIO(*MsgPort_t port)*timerequest_t:

    pretend(CreateExtIO(port, sizeof(timerequest_t)), *timerequest_t)
corp;

proc deleteTimerIO(*timerequest_t req)void:

    DeleteExtIO(&req*.tr_node, sizeof(timerequest_t));
corp;

/*
 * openSerialHandler - initial open of serial device. Return 'true' if worked.
 */

proc openSerialHandler(*char device; ulong unit, baud, timeOut;
                       bool shared, xxEnabled, sevenWire, ignoreCD;
                       ushort parity)bool:
    register ushort flags;

    AutoBaud := false;
    if baud = 0 then
        AutoBaud := true;
        baud := 2400;
    fi;
    EchoOn := true;
    LineSpeed := baud;
    SerialDropped := false;
    TimeOut := timeOut;
    HistoryBuffer[0] := ' ';
    HistoryBuffer[1] := '\e';
    HistoryAddPoint := 2;
    flags := SERF_EOFMODE;
    if shared then
        flags := flags | SERF_SHARED;
    fi;
    if not xxEnabled then
        flags := flags | SERF_XDISABLED;
    fi;
    if sevenWire then
        flags := flags | SERF_7WIRE;
    fi;
    case parity
    incase 0:
        /* no parity */
        SerBits := 8;
    incase 1:
        /* even parity */
        SerBits := 7;
        flags := flags | SERF_PARTY_ON;
    incase 2:
        /* odd parity */
        SerBits := 7;
        flags := flags | (SERF_PARTY_ON | SERF_PARTY_ODD);
    esac;
    SerFlags := flags;
    IgnoreCD := ignoreCD;
    SerPort := CreatePort(nil, 0);
    if SerPort ~= nil then
        SerPort2 := CreatePort(nil, 0);
        if SerPort2 ~= nil then
            TimerPort := CreatePort(nil, 0);
            if TimerPort ~= nil then
                SerReq := createSerIO(SerPort);
                if SerReq ~= nil then
                    SerReq2 := createSerIO(SerPort2);
                    if SerReq2 ~= nil then
                        TimerReq := createTimerIO(TimerPort);
                        if TimerReq ~= nil then
                            SerReq*.ios_SerFlags := SerFlags;
                            if OpenDevice(device, unit,
                                          &SerReq*.ios_IOSer.io_io, 0) = 0
                            then
                                if OpenDevice(TIMERNAME, UNIT_VBLANK,
                                              &TimerReq*.tr_node, 0) = 0
                                then
                                    MyTask := FindTask(nil);
                                    SaveParams := SerReq*;
                                    SerReq2* := SerReq*;
                                    SerReq2*.ios_IOSer.io_io.io_Message.
                                        mn_ReplyPort := SerPort2;
                                    return(true);
                                fi;
                                CloseDevice(&SerReq*.ios_IOSer.io_io);
                            fi;
                            deleteTimerIO(TimerReq);
                        fi;
                        deleteSerIO(SerReq2);
                    fi;
                    deleteSerIO(SerReq);
                fi;
                DeletePort(TimerPort);
            fi;
            DeletePort(SerPort2);
        fi;
        DeletePort(SerPort);
    fi;
    false
corp;

/*
 * closeSerialHandler - final close of serial device.
 */

proc closeSerialHandler()void:

    SaveParams.ios_IOSer := SerReq*.ios_IOSer;
    SerReq* := SaveParams;
    checkDoIO(SerReq, SDCMD_SETPARAMS, "close reset params");
    CloseDevice(&TimerReq*.tr_node);
    CloseDevice(&SerReq*.ios_IOSer.io_io);
    deleteTimerIO(TimerReq);
    deleteSerIO(SerReq2);
    deleteSerIO(SerReq);
    DeletePort(TimerPort);
    DeletePort(SerPort2);
    DeletePort(SerPort);
corp;

/*
 * timedRequest - do a serial port request, but put a timer on it so that
 *      we can abort it if it takes too long.
 */

proc timedRequest(register *IOExtSer_t serReq)bool:
    register ulong serBit, timBit, mask;
    register *MsgPort_t serPort;
    bool ok;

    serReq*.ios_IOSer.io_io.io_Flags := 0;
    serReq*.ios_IOSer.io_Actual := 0;   /* in case device needs it */
    serPort := serReq*.ios_IOSer.io_io.io_Message.mn_ReplyPort;

    TimerReq*.tr_time.tv_secs := TimeOut;
    TimerReq*.tr_time.tv_micro := 0;
    TimerReq*.tr_node.io_Command := TR_ADDREQUEST;
    SendIO(&TimerReq*.tr_node);

    SendIO(&serReq*.ios_IOSer.io_io);

    timBit := 1 << TimerPort*.mp_SigBit;
    serBit := 1 << serPort*.mp_SigBit;
    mask := Wait(timBit | serBit | SIGBREAKF_CTRL_F);

    ok := false;
    if mask & serBit ~= 0 then
        /* serial request has completed, and signal bit is clear */
        ignore GetMsg(serPort);
        ok := true;
    else
        ignore AbortIO(&serReq*.ios_IOSer.io_io);
        ignore WaitIO(&serReq*.ios_IOSer.io_io);
    fi;
    if mask & timBit ~= 0 then
        /* timer done and signal bit cleared */
        ignore GetMsg(TimerPort);
        SerialDropped := true;
    else
        ignore AbortIO(&TimerReq*.tr_node);
        ignore WaitIO(&TimerReq*.tr_node);
        MyTask*.tc_SigRecvd := MyTask*.tc_SigRecvd & ~timBit;
    fi;
    if mask & SIGBREAKF_CTRL_F ~= 0 then
        /* system owner has sent a signal - force a hang up soon */
        SerialDropped := true;
    fi;
    ok
corp;

/*
 * readSerial - low-level routine to read a single raw character.
 */

proc readSerial()char:
    ulong readLength;
    uint errnum;

    if SerialDropped then
        '\r'
    elif InputBufferPos ~= InputBufferMax then
        InputBufferPos := InputBufferPos + 1;
        InputBuffer[InputBufferPos - 1]
    else
        checkDoIO(SerReq, SDCMD_QUERY, "Read check");
        /* if connection is dropped, return CR */
        if not IgnoreCD and SerReq*.ios_Status & CIAF_COMCD ~= 0 then
            SerialDropped := true;
            '\r'
        elif SerReq*.ios_Status & (make(IOSTF_READBREAK,uint) << 8) ~= 0 then
            '\r'
        elif SerReq*.ios_Status & (make(IOSTF_OVERRUN, uint) << 8) ~= 0 then
            ' '
        else

            /* build the request in SerReq2 based on the query that was
               done using SerReq */
            readLength :=
                if SerReq*.ios_IOSer.io_Actual = 0 then
                    1
                elif SerReq*.ios_IOSer.io_Actual <= INPUT_BUFFER_SIZE then
                    SerReq*.ios_IOSer.io_Actual
                else
                    INPUT_BUFFER_SIZE
                fi;
            InputBufferMax := 0;

            while
                /* re-set in case device needs it */
                SerReq2*.ios_IOSer.io_Length := readLength;
                SerReq2*.ios_IOSer.io_io.io_Command := CMD_READ;
                SerReq2*.ios_IOSer.io_Data := pretend(&InputBuffer[0], *byte);
                if timedRequest(SerReq2) then
                    /* serial request completed */
                    InputBufferMax := SerReq2*.ios_IOSer.io_Actual;
                    if VERBOSE then
                        errnum := SerReq2*.ios_IOSer.io_io.io_Error;
                        if errnum ~= 0 then
                            mess("read error on serial port: ");
                            num(errnum);
                            mess("\n");
                        fi;
                    fi;
                    InputBufferMax = 0
                else
                    false
                fi
            do
                SerReq2*.ios_IOSer.io_Length := 1;
            od;

            InputBufferPos := 1;
            InputBuffer[0]
        fi
    fi
corp;

/*
 * writeFlush - low-level routine to flush all queued output characters.
 */

proc writeFlush()void:

    if not SerialDropped then
        SerReq*.ios_IOSer.io_io.io_Command := CMD_WRITE;
        SerReq*.ios_IOSer.io_Data := pretend(&OutputBuffer[0], *byte);
        SerReq*.ios_IOSer.io_Length := OutputBufferPos;
        ignore timedRequest(SerReq);
    fi;
    OutputBufferPos := 0;
corp;

/*
 * writeSerial - low-level routine to write a single raw character.
 */

proc writeSerial(char ch)void:

    if OutputBufferPos = OUTPUT_BUFFER_SIZE then
        writeFlush();
    fi;
    OutputBuffer[OutputBufferPos] := ch;
    OutputBufferPos := OutputBufferPos + 1;
    if ch = '\n' then
        writeFlush();
    fi;
corp;

/*
 * appendToHistory - append the given line to the history buffer.
 */

proc appendToHistory(register *char buffer)void:
    register *char p;
    register ulong n;

    while buffer* = ' ' do
        buffer := buffer + sizeof(char);
    od;
    if buffer* ~= '\e' then
        while
            if HistoryAddPoint = HISTORY_BUFFER_SIZE - 1 then
                p := &HistoryBuffer[2];
                n := 1;
                while p* ~= '\e' do
                    p := p + sizeof(char);
                    n := n + 1;
                od;
                p := p + sizeof(char);
                BlockCopy(&HistoryBuffer[2], p, HISTORY_BUFFER_SIZE - n - 2);
                HistoryAddPoint := HistoryAddPoint - n;
            fi;
            HistoryBuffer[HistoryAddPoint] := buffer*;
            HistoryAddPoint := HistoryAddPoint + 1;
            buffer* ~= '\e'
        do
            buffer := buffer + sizeof(char);
        od;
    fi;
corp;

/*
 * serialBackup - handle destructive backspace for line editing.
 */

proc serialBackup()void:

    if EchoOn then
        writeSerial('\b');
        writeSerial(' ');
        writeSerial('\b');
    fi;
corp;

/*
 * serialGetLine - upper level routine to get a line from the serial port.
 *      Echoing is done, as is line editing (backspace, CNTL-X).
 */

proc serialGetLine(register *char buffer; register uint bufferLen)bool:
    register *char historyPoint, p;
    *char bufferStart;
    register uint pos;
    register char ch;
    bool gotEof, lastWasNext, lastWasHistory;

    gotEof := SerialDropped;
    bufferStart := buffer;
    historyPoint := &HistoryBuffer[HistoryAddPoint - 2];
    lastWasNext := false;
    lastWasHistory := false;
    pos := 0;
    bufferLen := bufferLen - 1;         /* leave space for the '\e' */
    while
        ch := readSerial();
        ch := (ch - '\e') & 0x7f + '\e';
        if ch = '\r' or ch = '\n' then
            buffer* := '\e';
            if not lastWasHistory and EchoOn then
                appendToHistory(bufferStart);
            fi;
            if not SerialDropped then
                writeSerial('\r');
                writeSerial('\n');
                writeFlush();
            fi;
            false
        elif ch = '\b' then
            if pos ~= 0 then
                pos := pos - 1;
                buffer := buffer - sizeof(char);
                serialBackup();
                writeFlush();
            fi;
            lastWasHistory := false;
            true
        elif ch = '\(0x18)' or ch = '\(0x15)' or ch = '\(0x03)' then
            /* control-X, control-U, control-C - empty the input line */
            while pos ~= 0 do
                pos := pos - 1;
                buffer := buffer - sizeof(char);
                serialBackup();
            od;
            writeFlush();
            lastWasHistory := false;
            true
        elif ch = '\(0x1c)' or ch = '\(0x04)' then
            /* control-backslash or control-D - end of input */
            buffer* := '\e';
            gotEof := true;
            false
        elif ch = '\(0x10)' then
            /* ^P - previous line in history */
            while pos ~= 0 do
                pos := pos - 1;
                buffer := buffer - sizeof(char);
                serialBackup();
            od;
            if lastWasNext and historyPoint ~= &HistoryBuffer[0] and
                historyPoint ~= &HistoryBuffer[HistoryAddPoint - 2]
            then
                while historyPoint* ~= '\e' do
                    historyPoint := historyPoint - sizeof(char);
                od;
                historyPoint := historyPoint - sizeof(char);
            fi;
            lastWasNext := false;
            if historyPoint = &HistoryBuffer[0] then
                writeSerial('\(0x07)');
            else
                while historyPoint* ~= '\e' do
                    historyPoint := historyPoint - sizeof(char);
                od;
                p := historyPoint;
                p := p + sizeof(char);
                while p* ~= '\e' do
                    pos := pos + 1;
                    writeSerial(p*);
                    buffer* := p*;
                    buffer := buffer + sizeof(char);
                    p := p + sizeof(char);
                od;
                historyPoint := historyPoint - sizeof(char);
                lastWasHistory := true;
            fi;
            writeFlush();
            true
        elif ch = '\(0x0e)' then
            /* ^N - next line in history */
            while pos ~= 0 do
                pos := pos - 1;
                buffer := buffer - sizeof(char);
                serialBackup();
            od;
            if not lastWasNext and historyPoint ~= &HistoryBuffer[0] and
                historyPoint ~= &HistoryBuffer[HistoryAddPoint - 2]
            then
                historyPoint := historyPoint + 2 * sizeof(char);
                while historyPoint* ~= '\e' do
                    historyPoint := historyPoint + sizeof(char);
                od;
                historyPoint := historyPoint - sizeof(char);
            fi;
            lastWasNext := true;
            if historyPoint = &HistoryBuffer[HistoryAddPoint - 2] then
                writeSerial('\(0x07)');
            else
                historyPoint := historyPoint + 2 * sizeof(char);
                while historyPoint* ~= '\e' do
                    pos := pos + 1;
                    writeSerial(historyPoint*);
                    buffer* := historyPoint*;
                    buffer := buffer + sizeof(char);
                    historyPoint := historyPoint + sizeof(char);
                od;
                historyPoint := historyPoint - sizeof(char);
                lastWasHistory := true;
            fi;
            writeFlush();
            true
        elif ch >= ' ' and ch <= '~' then
            historyPoint := &HistoryBuffer[HistoryAddPoint - 2];
            if pos < bufferLen then
                pos := pos + 1;
                buffer* := ch;
                buffer := buffer + sizeof(char);
                if EchoOn then
                    writeSerial(ch);
                fi;
            fi;
            if InputBufferPos = InputBufferMax then
                writeFlush();
            fi;
            lastWasHistory := false;
            true
        else
            true
        fi
    do
    od;
    not gotEof
corp;

/*
 * serialPutLine - upper level routine to write a line to the serial port.
 *      This one just turns '\n' into CR-LF.
 */

proc serialPutLine(register *char buffer; register uint length)void:

    while length ~= 0 do
        length := length - 1;
        if buffer* = '\n' then
            writeSerial('\r');
        fi;
        writeSerial(buffer*);
        buffer := buffer + sizeof(char);
    od;
    if OutputBufferPos ~= 0 then
        writeFlush();
    fi;
corp;

/*
 * serialEcho - set/clear the echoing flag. (Used for passwords)
 */

proc serialEcho(bool enabled)void:

    EchoOn := enabled;
corp;

/*
 * serialActive - check for a connection. If there is one, set up the baud
 *      rate and parity (none or even) and return 'true', else return
 *      'false'. If AutoBaud is set, we handle 2400, 1200 and 300 baud.
 *      NOTE: when we are called by Getty, we do not call 'serialActive' in
 *      the serial client. Since 'serialActive' contains ALL calls to
 *      'setParams', we will then use the serial port in whatever state
 *      Getty has put it for us.
 */

proc serialActive()uint:
    ulong saveTimeOut;
    char ch;

    if AutoBaud then
        LineSpeed := 2400;
        SerFlags := SerFlags & ~SERF_PARTY_ON;
        SerBits := 8;
        SerialDropped := false;
        while
            setParams(SerReq);
            checkDoIO(SerReq, SDCMD_QUERY, "serialActive first query");
            if SerReq*.ios_Status & CIAF_COMCD ~= 0 then
                return(0);
            fi;
            saveTimeOut := TimeOut;
            TimeOut := 30;
            ch := readSerial();
            TimeOut := saveTimeOut;
            if SerialDropped then
                return(1);
            fi;
            Delay(5);
            checkDoIO(SerReq, SDCMD_QUERY, "serialActive second query");
            if SerReq*.ios_Status & CIAF_COMCD ~= 0 then
                return(1);
            fi;
            ch ~= '\r' and (ch ~= '\r' + 0x80 or not AutoBaud)
        do
            if AutoBaud then
                LineSpeed :=
                    if LineSpeed = 2400 then
                        1200
                    elif LineSpeed = 1200 then
                        300
                    else
                        2400
                    fi;
            fi;
        od;
        if ch = '\r' + 0x80 then
            SerFlags := SerFlags | SERF_PARTY_ON;
            SerBits := 7;
            setParams(SerReq);
        fi;
    else
        setParams(SerReq);
        if IgnoreCD then
            return(2);
        fi;
        checkDoIO(SerReq, SDCMD_QUERY, "serialActive first query");
        if SerReq*.ios_Status & CIAF_COMCD ~= 0 then
            return(0);
        fi;
        Delay(1 * 50);
        checkDoIO(SerReq, SDCMD_QUERY, "serialActive second query");
        if SerReq*.ios_Status & CIAF_COMCD ~= 0 then
            return(1);
        fi;
    fi;
    2
corp;

/*
 * serialSpeed - return a string giving the serial connection speed.
 */

proc serialSpeed()*char:
    register *char p;
    register ulong n;

    n := LineSpeed;
    p := &SpeedBuffer[11];
    p* := '\e';
    while
        p := p - sizeof(char);
        p* := n % 10 + '0';
        n := n / 10;
        n ~= 0
    do
    od;
    p
corp;

/*
 * serialGotControlC - return 'true' if someone typed a control-C.
 */

proc serialGotControlC()bool:
    char ch;
    bool gotOne;

    if SerialDropped then
        true
    else
        gotOne := false;
        while
            checkDoIO(SerReq, SDCMD_QUERY, "^C check");
            if not IgnoreCD and SerReq*.ios_Status & CIAF_COMCD ~= 0 then
                SerialDropped := true;
                InputBufferPos := 0;
                InputBufferMax := 0;
                gotOne := true;
            elif SerReq*.ios_Status & (make(IOSTF_READBREAK, uint) << 8) ~= 0
            then
                gotOne := true;
            fi;
            not gotOne and SerReq*.ios_IOSer.io_Actual ~= 0
        do
            SerReq*.ios_IOSer.io_Data := pretend(&ch, *byte);
            SerReq*.ios_IOSer.io_Length := 1;
            checkDoIO(SerReq, CMD_READ, "^C read");
            if ch = '\(0x03)' or ch = '\(0xff)' or ch = '\(0x7f)' then
                gotOne := true;
            fi;
        od;
        if gotOne then
            checkDoIO(SerReq, CMD_START, "^C start");
            checkDoIO(SerReq, CMD_CLEAR, "^C clear");
            true
        else
            false
        fi
    fi
corp;
