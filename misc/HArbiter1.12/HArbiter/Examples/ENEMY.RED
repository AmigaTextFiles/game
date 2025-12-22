; enemy2.red (c) 1997 tim
; Incredible how can I destroy you, hmmm ?

start          mov        bomb2+3,1011
               mov        bomb2+2,<-1
               mov        bomb2+1,<-2
               mov        bomb2+0,<-3
               spl        @-4
start2         mov        bomb2+3,511
               mov        bomb2+2,<-1
               mov        bomb2+1,<-2
               mov        bomb2+0,<-3
               spl        @-4
               add        #730,start
               add        #730,start2
               jmp        start
bomb2          mov        $3,<2
               mov        $2,<1
               jmp        $-2,$-2
               dat        $0,$0
