/* MapDataBackup.rexx V1.5 (german version, build 14.06.2002)		*/
/* Author: Dieter Zenteck						*/
/*         email: zenti@livingarts.de					*/
/*         www:   http://www.livingarts.de				*/
/*									*/
/* Arexx-Script zum automatischen Backup von ToT Map und Data Files	*/
/* vor dem Starten oder/und nach dem Beenden von Tales of Tamar		*/
/*									*/ 
/* Das Script legt, falls nicht vorhanden im Assign tot: ein		*/
/* Verzeichnis BACKUP an. Darin werden dann sortiert nach Datum und	*/
/* Uhrzeit weitere Verzeinisse wie z.B. 20020612_13_45_13 angelegt in	*/
/* die dann wiederum das aktuelle Map und Data Verzeichnis kopiert	*/
/* werden.								*/
/*									*/
/* Argument 1: 	auto	= ohne Requester Backup machen			*/
/*		req	= mit Requester Backup machen			*/
/* Argument 2:	before	= vor dem Start von ToT Backup machen		*/
/*		after	= nach dem Beenden von ToT Backup machen	*/
/*		all	= vor und nach ToT Backup machen		*/
/* Argument 3:	beiliebiges assign auf das TalesOfTamar-Verzeichnis	*/
/*		falls mehere Spiele gleichzeitig getestet werden	*/
/* Argument 4:	debug	= optional um ToT-Client-Debug statt ToT-Client	*/
/*			  zu starten					*/
/*									*/
/* Voreistellung: req all tot:						*/
/*									*/
/* 	NUR ZUR INTERNEN VERWENDUNG FÜR TALES OF TAMAR-TESTER !!!	*/
/* 	ONLY FOR INTERNAL USE FOR TALES OF TAMAR-TESTERS !!!		*/

norexxsup=0
if ~show('L',"rexxsupport.library") then
do
	if ~addlib('rexxsupport.library',0,-30,0) then say "REXXSupport.library konnte nicht geöffnet werden!"
	norexxsup=1
end

parse arg arg1 arg2 arg3 arg4
if strip(arg1,'B')~="" then arg1=strip(arg1,'B')
else arg1="req"
if strip(arg2,'B')~="" then arg2=strip(arg2,'B')
else arg2="all"
if strip(arg3,'B')~="" then arg3=strip(arg3,'B')
else arg3="tot:"
if strip(arg4,'B')~="" then arg4=strip(arg4,'B')
else arg4="nodebug"

if arg1~="auto"&arg1~="req" then arg1="req"
if arg2~="before"&arg2~="after"&arg2~="all" then arg2="all"
if norexxsup==0 then
do
	aktassigns=showlist('A')
	checkarg3=substr(arg3,1,length(arg3)-1)
	if find(aktassigns,upper(checkarg3))==0 then
	do
		say 'Tales of Tamar kann nicht gestartet werden.'
		say
		say 'Das als 3. Argument angegebene Assign: "'||arg3||'" existiert nicht !' 
		say '--> "... MapDataBackup.rexx '||arg1 arg2 arg3||'"'
		say
		say 'Bitte überprüfen Sie die angegebenen Parameter.'
		say "<return>"
		pull
		exit
	end
end
if arg4~="debug"&arg4~="nodebug" then arg4="nodebug"

if arg2=="before"|arg2=="all" then
do
	if arg1=="req" then
	do
		didbak=vorstartout(pre)
		if didbak=="backup" then call vorstartout(post)
	end
	else call dobackup()
end
else dirname=makeoutputdir()
if arg4=="nodebug" then
	address command arg3'tot-client.exe >'||dirname||'/tot-output_'||substr(time(),1,2)||'_'||substr(time(),4,2)||'_'||substr(time(),7,2)||'.txt'
if arg4=="debug" then
	address command arg3'tot-client-debug >'||dirname||'/tot-debug_'||substr(time(),1,2)||'_'||substr(time(),4,2)||'_'||substr(time(),7,2)||'.txt'
if arg2=="after"|arg2=="all" then
do
	if arg1=="req" then
	do
		didbak=nachstartout(pre)
		if didbak=="backup" then call nachstartout(post)
	end
	else call dobackup()
end
exit

dobackup:
if ~exists(arg3||"BACKUP") then
	address command "makedir "||arg3||"BACKUP"
dirname=date("s",date("i")) substr(time(),1,2) substr(time(),4,2) substr(time(),7,2)
dirname=arg3||"BACKUP/"space(dirname,1,"_")
if ~exists(dirname) then
	address command "makedir" dirname
address command "copy >NIL: "||arg3||"data" dirname"/data ALL"
address command "copy >NIL: "||arg3||"map" dirname"/map ALL"
return
makeoutputdir:
if ~exists(arg3||"BACKUP") then
	address command "makedir "||arg3||"BACKUP"
dirname=arg3||"BACKUP/"||date("s",date("i"))||"_output"
if ~exists(dirname) then
	address command "makedir" dirname
return(dirname)
vorstartout:
parse arg cmdline
if cmdline==pre then
do
	bakstat="nobackup"
	if exists("c:requestchoice") then
		do
			address command 'c:requestchoice >RAM:T/000BAK.tmp "Backup-Nachricht" "Backup von Map und Data erstellen ?" "Ja|Nein"'
			open(goon,"RAM:T/000BAK.tmp",R)
			todo=readch(goon,1)
			close(goon)
			address command 'delete >NIL: RAM:T/000BAK.tmp'
			if todo=1 then
			do
				bakstat="backup"
				call dobackup()
			end
			else call makeoutputdir()
		end
		else do
			say "Backup von Map und Data erstellen ?"
			say "<j> Backup erstellen, <n> kein Backup erstellen"
			do until noreqturn==1
				pull decision
				if decision=="N"|decision=="J" then
					do
						noreqturn=1
						if decision=="J" then
						do
							call dobackup()
							bakstat="backup"
						end
						else call makeoutputdir()
					end
					else say "M M"
			end
		end
return(bakstat)
end
if cmdline==post
then do
	if exists("c:requestchoice") then
		address command 'c:requestchoice >NIL: "Backup-Nachricht" "Backup von Map und Data beendet. Starte Tales of Tamar" "Ok"'
		else do
			say "Backup von Map und Data beendet. Starte Tales of Tamar"
			say "<RETURN> zum weitermachen"
			pull dummy
		end
return
end
nachstartout:
parse arg cmdline
if cmdline==pre then
do
	backstat="nobackup"
	if exists("c:requestchoice") then
		do
			address command 'c:requestchoice >RAM:T/000BAK.tmp "Backup-Nachricht" "Tales of Tamar beendet. Backup von Map und Data erstellen ?" "Ja|Nein"'
			open(goon,"RAM:T/000BAK.tmp",R)
			todo=readch(goon,1)
			close(goon)
			address command 'delete >NIL: RAM:T/000BAK.tmp'
			if todo=0 then
				exit
				else do
				bakstat="backup"
				call dobackup
				end
		end
		else do
			noreqreturn=0
			say "Tales of tamar beendet."
			say "Backup von Map und Data erstellen ?"
			say "<j> Backup erstellen, <n> kein Backup erstellen"
			do until noreqturn==1
				pull decision
				if decision=="N"|decision=="J" then
					do
						noreqturn=1
						if decision=="N" then exit
						else do
						bakstat="backup"
						call dobackup
						end
					end
					else say "M M"
			end
		end
return(bakstat)
end
if cmdline==post then
do
	if exists("c:requestchoice") then
		address command 'c:requestchoice >NIL: "Backup-Nachricht" "Backup von Map und Data beendet." "Ok"'
		else do
			say "Backup von Map und Data beendet."
			say "<RETURN> zum schließen"
			pull dummy
		end
return
end
