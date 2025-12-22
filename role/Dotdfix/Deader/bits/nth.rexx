/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'
echo 'You walk into a room which looks like a sort of torture chamber....a half breed of zombie and human approaches you...'
echo '[PUSH RETURN]'
 pull answer
 address command 'rx dawn:bits/quit.rexx'
    Address command 'run >nil: dawn:bits/zombieplayer dir=dawn:bits/ play=zombietune2 nowindow'
echo 'He speaks.....hey human, get out of my home...I converted this place myself you know......he turns around and pushes a switch...'
echo '[PUSH RETURN]'
 pull answer
echo ' The Door Slams shut behind you and the horrific hybrid walks up to you.....his bulging eyes and nose make your stomach churn.....You shouldnt have come into my sector bud....he says...'
echo '[PUSH RETURN]'
 pull answer
echo 'Now youre going to pay...hahahah..cough cough.....he pushes another button and a glass cage is lowered down...he holds a gun to you and says get in...'
echo '[PUSH RETURN]'
 pull answer
echo ' You climb into the glass cage and he uses a series of pulleys and levers to manouver you over a pit which is filled with zombies...'
echo '[PUSH RETURN]'
 pull answer
echo ' he begins to lower you into the pit..this is sure death....'
echo '[PUSH RETURN]'
 pull answer
echo 'you gonna plead with me bud.....get on your knees and beg scum...he orders'
echo '[PUSH RETURN]'
 pull answer
echo ' You look down at your knees.....'
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
    Otherwise cmd = 'nth2.rexx'
   End
   Address command 'rx Dawn:bits/'cmd





