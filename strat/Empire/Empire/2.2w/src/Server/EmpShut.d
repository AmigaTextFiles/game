#drinc:exec/miscellaneous.g
#drinc:exec/nodes.g
#drinc:exec/memory.g
#drinc:exec/ports.g
#drinc:exec/tasks.g
#drinc:libraries/dos.g
#drinc:libraries/dosextens.g
#/Include/Empire.g
#/Include/Request.g

/*
 * Amiga Empire
 *
 * Copyright (c) 1990 by Chris Gray
 *
 * Feel free to modify and use these sources however you wish, so long
 * as you preserve this copyright notice.
 * $Id: EmpShut.d,v 1.1 90/03/25 18:36:19 DaveWT Rel $
 */

/*
 * EmpShut - simple program to request a shutdown of the Empire server.
 */

/*
 * doShut - all setup, try to shut the server and clients down.
 */

proc doShut()void:
    register *MsgPort_t empirePort, myPort;
    register *Request_t rq;

    empirePort := FindPort(EMPIRE_PORT_NAME);
    if empirePort ~= nil then
        myPort := CreatePort(nil, 0);
        if myPort ~= nil then
            rq := AllocMem(sizeof(Request_t), MEMF_PUBLIC);
            if rq ~= nil then
                rq*.rq_message.mn_Node.ln_Type := NT_MESSAGE;
                rq*.rq_message.mn_ReplyPort := myPort;
                rq*.rq_message.mn_Length :=
                    sizeof(Request_t) - sizeof(Message_t);
                rq*.rq_type := rt_shutDown;
                rq*.rq_clientId := 0;
                PutMsg(empirePort, &rq*.rq_message);
                ignore WaitPort(myPort);
                ignore GetMsg(myPort);
                FreeMem(rq, sizeof(Request_t));
            fi;
            DeletePort(myPort);
        fi;
    fi;
corp;

/*
 * main - open libraries, check WorkBench v.s. CLI.
 */

proc main()void:
    *Process_t thisProcess;
    *Message_t sm;

    if OpenExecLibrary(0) ~= nil then
        if OpenDosLibrary(0) ~= nil then
            thisProcess := pretend(FindTask(nil), *Process_t);
            if thisProcess*.pr_CLI = 0 then
                /* running from WorkBench */
                ignore WaitPort(&thisProcess*.pr_MsgPort);
                sm := GetMsg(&thisProcess*.pr_MsgPort);
                doShut();
                Forbid();
                ReplyMsg(sm);
            else
                /* running from CLI */
                doShut();
            fi;
            CloseDosLibrary();
        fi;
        CloseExecLibrary();
    fi;
corp;
