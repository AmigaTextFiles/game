
OPT OSVERSION=37

PROC main()
  DEF r
  r:=request('ramlib\nProgram failed (error #8000000B).\nWait for disk activity to finish.','Suspend|Reboot',NIL)
  request('Not this time...','Thanks God',[r])
ENDPROC

PROC request(body,gadgets,args)
ENDPROC EasyRequestArgs(0,[20,0,0,body,gadgets],0,args)
