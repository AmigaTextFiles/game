;Quick Gun 4
;Ziemowit Kordecki ul. B. Prusa 43/4  
;Wroclaw 1992
;VI klasa SP nr 59

start   MOV <linia  <dal 
        DJN start   #12  
start2  MOV #1      504 
        MOV #500    501 
        MOV #12     498 
        SPL 491        
        JMP 0
start3  CMP <kompas 0
dal     JMP start3  500
        DJN start3  499
kompas  JMP start3  501     
linia   DAT 1                 
