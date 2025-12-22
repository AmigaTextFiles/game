;Szperacz2
;Ziemowit Kordecki, Wroclaw, Poland 1992
;ul. B. Prusa 43/4
;VI klasa SP 59

ttart   JMN ttak    @tal
        SUB #4      tal
towrot  DJN ttart   #100  ;l. rund szukania
ttstp   JMZ taty    <tinia 
ticznik DJN ttstp   #32   ;l. lini programu
        MOV #0      tinia
        MOV #100    towrot
        MOV #32     ticznik 
        DJN ttart   #20   ;w. areny/r. szuka.

        JMP -10
ttak    ADD #3      tal
tasakra MOV tinia   <tal
tzas    DJN tasakra #9
        SUB #2      towrot
        MOV #9      tzas
        JMN tasakra <tal
        JMP ttart        
taty    ADD tinia   topia
        JMZ tlarm   @topia  
        MOV @topia  @tinia
        SUB tinia   topia
tal     JMP ttstp   -61       
tinia   DAT 0           
topia   DAT -39 
tlarm   MOV -26   @tinia
        SPL tucha  
        JMP ttstp  
tmiec   DAT 1               
tucha   ADD #50     tmiec
        MOV tuszka  @tmiec
        SPL @tmiec
        JMP tucha   
tuszka  MOV 0       1
        DAT 0
        DAT 0
        DAT 0
        DAT 0
        DAT 0        
renta   JMP 0
start   JMN atak    @dal
        SUB #4      dal
powrot  DJN start   #100  
testp   JMZ laty    @linia
licznik DJN testp   #32   
        MOV #0      linia
        MOV #100    powrot
        MOV #12     licznik
rundy   DJN start   #20   
        JMP renta
atak    ADD #3      dal
masakra MOV linia   <dal
czas    DJN masakra #9
        SUB #2      powrot
        MOV #9      czas
        JMN masakra <dal
        JMP start
laty    ADD linia   kopia
testm   JMZ alarm   @kopia  
        MOV @kopia  @linia
        SUB linia   kopia
dal     JMP testp   -61       
linia   DAT 0           
kopia   DAT -39 
alarm   MOV renta   @linia
        SPL mucha  
        JMP testp  
smiec   DAT 1               
mucha   ADD #50     smiec
        MOV muszka  @smiec
        SPL @smiec
        JMP mucha
muszka  MOV 0       1
