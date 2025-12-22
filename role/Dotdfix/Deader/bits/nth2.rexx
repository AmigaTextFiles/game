/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'
echo 'Stop being silly will you? you are in mortal danger!...'
echo '[PUSH RETURN]'
 pull answer
echo ' No Way! you shout... you have a couple of options although this does seem like death...'
echo 'Will you say sorry and plead for your life, or will you hurl abuse at him, or will you rattle the cage and try to escape...?'
 pull answer
   Select
    When answer = Say sorry and plead for my life then cmd = 'plead.rexx'
    When answer = Hurl abuse at him then cmd = 'abuse.rexx'
    When answer = Rattle cage and try to escape then cmd = 'rattle.rexx'
    When answer = Say sorry and plead for life then cmd = 'plead.rexx'
    When answer = Hurl abuse then cmd = 'abuse.rexx'
    When answer = Rattle cage then cmd = 'rattle.rexx'
    When answer = Say sorry plead for life then cmd = 'plead.rexx'
    When answer = Hurl abuse him then cmd = 'abuse.rexx'
    When answer = Rattle cage and escape then cmd = 'rattle.rexx'
    When answer = sorry and plead for life then cmd = 'plead.rexx'
    When answer = abuse him then cmd = 'abuse.rexx'
    When answer = Rattle cage escape then cmd = 'rattle.rexx'
    When answer = plead then cmd = 'plead.rexx'
    When answer = abuse then cmd = 'abuse.rexx'
    When answer = Rattle then cmd = 'rattle.rexx'
    When answer = sorry then cmd = 'plead.rexx'
    When answer = abuse him then cmd = 'abuse.rexx'
    When answer = cage then cmd = 'rattle.rexx'
    When answer = Say sorry and plead for life then cmd = 'plead.rexx'
    When answer = Hurl abuse then cmd = 'abuse.rexx'
    When answer = Rattle cage and escape then cmd = 'rattle.rexx'
    When answer = sorry plead then cmd = 'plead.rexx'
    When answer = insult then cmd = 'abuse.rexx'
    When answer = Rattle cage then cmd = 'rattle.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    When answer = Say sorry and plead for my life then cmd = 'plead.rexx'
    When answer = Hurl abuse at him then cmd = 'abuse.rexx'
    When answer = Rattle cage and try to escape then cmd = 'rattle.rexx'
    When answer = Say sorry and plead for life then cmd = 'plead.rexx'
    When answer = Hurl abuse then cmd = 'abuse.rexx'
    When answer = Rattle cage then cmd = 'rattle.rexx'
    When answer = Say sorry plead for life then cmd = 'plead.rexx'
    When answer = Hurl abuse him then cmd = 'abuse.rexx'
    When answer = Rattle cage and escape then cmd = 'rattle.rexx'
    When answer = sorry and plead for life then cmd = 'plead.rexx'
    When answer = abuse him then cmd = 'abuse.rexx'
    When answer = Rattle cage escape then cmd = 'rattle.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'nth2.rexx'
   End
   Address command 'rx Dawn:bits/'cmd





