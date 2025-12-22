/**/
Call Open(TCP,"TCP:localhost/998","W")
Call WriteLn(TCP,"EOF")
Call Close(TCP)
Exit
