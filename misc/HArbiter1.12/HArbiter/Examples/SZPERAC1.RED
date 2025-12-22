;Szperacz
;Ziemowit Kordecki, Wroclaw, Poland 1992
;ul. B. Prusa 43/4
;VI klasa SP 59
ttart   JMN ttak    @tal
        SUB #4      tal
towrot  DJN ttart   #100  
ttstp   JMZ taty    <tinia 
ticznik DJN ttstp   #12   
        MOV #0      tinia
        MOV #100    towrot
tundy   DJN ttart   #20   
ttak    MOV @tinia  @tal    
taty    ADD tinia   topia
ttstm   JMZ tlarm   @topia  
        MOV @topia  @tinia
        SUB tinia   topia
tal     JMP ttstp   -46       
tinia   DAT 0           
topia   DAT -31 
tlarm   MOV -17     @tinia
        SPL tucha  
        JMP ttstp                  
tmiec   DAT 1
tucha   ADD #100    tmiec
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
testp   JMZ laty    <linia 
licznik DJN testp   #12   
        MOV #0      linia
        MOV #100    powrot
rundy   DJN start   #20   
atak    MOV @linia  @dal    
laty    ADD linia   kopia
testm   JMZ alarm   @kopia  
        MOV @kopia  @linia
        SUB linia   kopia
dal     JMP testp   -46       
linia   DAT 0           
kopia   DAT -31 
alarm   MOV renta   @linia
        SPL mucha  
        JMP testp                  
smiec   DAT 1
mucha   ADD #100    smiec
        MOV muszka  @smiec
        SPL @smiec
        JMP mucha
muszka  MOV 0       1
        DAT 0
