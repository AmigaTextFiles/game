program printgame;		{ Version 3.0 · © Copyright 1993-98 by Henning Peters }

{$I "include:utils/stringlib.i"}
{$I "include:utils/break.i" }
{$I "include:Libraries/DOS.i" }

type t_spieler=record
	realname,name,strasse,ort:string;
	geld:real;
    end;

var spieler:array[1..16]of t_spieler;
    spiel,anzahl:byte;
    datei,drucker:text;
    UserName:string;

function int_str(i:integer):string;	{ i=0..999 }
var str:string;
begin str:=AllocString(4); strcpy(str,"\0\0\0\0");
  if i<10 then str[0]:=chr(i+48)
  else if i<100 then begin
    str[0]:=chr(i div 10+48); str[1]:=chr(i mod 10+48)
  end else begin
    str[0]:=chr(i div 100+48); str[1]:=chr((i mod 100)div 10+48);
    str[2]:=chr(i mod 10+48)
  end;
  int_str:=strdup(str)
end;

function str_real(s:string):real;
var a,b,c:byte;
    l,i:integer;
begin
  a:=0; b:=0; c:=1; i:=0; l:=strlen(s);
  while (s[i]<>'.') and (i<l) do begin a:=a*10+ord(s[i])-48; inc(i) end;
  if i=l then str_real:=a*1.0;
  inc(i);
  while i<l do begin c:=c*10; b:=b*10+ord(s[i])-48; inc(i) end;
  str_real:=a+b/c
end;

procedure load_data;
var i:integer;
    datei:text;
    str,txt:string;
begin
  str:=allocstring(40); strcpy(str,"Inselreich:Spieler/Print_");
	strcat(str,int_str(spiel));
  txt:=allocstring(60);
  if reopen(str,datei) then begin
    readln(datei,anzahl);
    for i:=1 to anzahl do with spieler[i] do begin
      readln(datei,txt); realname:=strdup(txt);
      readln(datei,txt); name:=strdup(txt);
      readln(datei,txt); strasse:=strdup(txt);
      readln(datei,txt); ort:=strdup(txt);
      readln(datei,geld)
    end; close(datei)
  end else begin
    writeln("\aKonnte Kundendatei für Spiel ",spiel," nicht lesen!");
    exit(20)
  end
end;

function sgn(n:real):integer;
begin
  if n<0 then sgn:=-1;
  if n>0 then sgn:=1;
  sgn:=0;
end;

procedure verwaltung;
var i:integer;
    j,k:real;
    str:string;
    datei:text;
begin
  str:=allocstring(40);
  for i:=1 to anzahl do with spieler[i] do begin
    write("\nSpieler ",i,": `",name,"' (",realname,")    Kontostand: DM ",geld,
	"\nWieviel DM Porto wurde letztes mal bezahlt? ");
    readln(str); j:=str_real(str);
    k:=geld-j; geld:=(k*sgn(k)*100+0.5)/100*sgn(k);	{ Rundungsfehler %-I }
  end;
  strcpy(str,"Inselreich:Spieler/Print_"); strcat(str,int_str(spiel));
	strcat(str,".neu");
  if open(str,datei) then begin
    writeln(datei,anzahl);
    for i:=1 to anzahl do with spieler[i] do
      writeln(datei,realname,'\n',name,'\n',strasse,'\n',ort,'\n',geld);
    close(datei)
  end else begin
    writeln("\aKonnte Kundendatei für Spiel ",spiel," nicht schreiben!");
    exit(20)
  end
end;

procedure DoBreak;
begin
  if CheckBreak then begin
    close(datei); write(drucker,'\eE'); close(drucker);
    writeln("\n *** Break ***"); exit(10)
  end
end;

procedure FormatData;
var sp,i,j,pc,line,seite:integer;
    datum,version,txt,str:string;
    max_score:short;
    zei:array[1..64]of string;
    c:char;
    botsch:boolean;

  procedure newpage(nonprop:boolean);
  var i:integer;
  begin
    for i:=2 to line do writeln(drucker); inc(seite); { readln(datei,txt); }
    if nonprop then write(drucker,"\e(s1p4101T");
    write(drucker,"- ":85,seite," -\f"); 
    line:=63; write('.'); close(drucker);
    strcpy(str,"RAM:Seite_"); strcat(str,int_str(succ(seite)));
    if not open(str,drucker,2048) then begin
      writeln("\n\a *** Abbruch! Konnte `",str,
		"' nicht zum schreiben öffnen!\n");
      exit(10)
    end;
    write(drucker,"\e(s4101t1p10v1Q\e&a10L\e&k2G");
    if botsch then write(drucker,"\e(s12h6t0P"); {else write(drucker,"\e(s4101t1P")}
  end;

begin
  str:=allocstring(50); datum:=AllocString(50); version:=AllocString(5);
  for i:=1 to 64 do zei[i]:=Allocstring(150); txt:=allocstring(150);
  for sp:=1 to anzahl do with spieler[sp] do begin
    write('\n',name,": \e[33mD\e[0mrucken (einfach so), D\e[33mo\e[0mppelseitig drucken, \e[33mÜ\e[0mberspringen oder \e[33mA\e[0mbbrechen? ");
    repeat readln(c) until (c='d') or (c='ü') or (c='a') or (c='o');
    if c='a' then exit(5); botsch:=false;
    if (c='d') or (c='o') then begin
     strcpy(str,"Inselreich:Ausgabe/"); strcat(str,int_str(spiel)); strcat(str,"/");
     strcat(str,name); write("Ausgabe für `",name,"'");
     if reopen(str,datei,20480) then begin line:=55;
      seite:=0; strcpy(str,"RAM:Seite_"); strcat(str,int_str(succ(seite)));
      if open(str,drucker,2048) then begin
	readln(datei,version); readln(datei,datum);
	if streq(datum,"ENDE") then readln(datei,max_score);
	writeln(drucker,"\e(s4101t1p14v3b2Q		\e&d3D ·  Inselreich  V",version,"  ·       ©Copyright 1992-97 by Henning Peters\e&d@\n\n	",UserName,"\n\n\e&a10L\e(s0b1Q",
		realname,"			Kontostand: DM ",geld,
		" (abzüglich Porto dieser Runde)\n");
	if streq(datum,"ENDE") then writeln(drucker,"		Das Spiel ist zu Ende! Maximal-Score war ",max_score,".\n")
	else writeln(drucker,"		Die Züge müssen bis zum ",datum," angekommen sein!\n");
	if geld<2.00 then begin dec(line,2); writeln(drucker,"	\e&d4D ACHTUNG! \e&d3D Kontostand reicht nicht mehr für nächste Runde! \e&d@\n") end;
	readln(datei,txt); writeln(drucker,txt);
	if not strieq(strasse,"str") then begin
	  writeln(drucker,"\n\n	",realname,'\n\n	',strasse,'\n\n	',ort,"\n\n");
	  dec(line,12)
	end; readln(datei,txt);
	repeat
	  writeln(drucker,txt); readln(datei,txt); dec(line);
	  if line=1 then newpage(false)
	until streq(txt,"STOP");
	readln(datei,txt);
	while not streq(txt,"ENDE") do begin
	  pc:=1; strcpy(zei[1],txt); DoBreak;
	  repeat
	    inc(pc); readln(datei,zei[pc])
	  until streq(zei[pc],"STOP");
	  if line>succ(pc) then begin writeln(drucker,'\n'); dec(line,2) end
	  else newpage(false);
	  for i:=1 to pred(pc) do writeln(drucker,zei[i]); dec(line,pred(pc));
	  readln(datei,txt);
	end;
	readln(datei,txt);
	if line<6 then newpage(false)
	else begin writeln(drucker,'\n'); dec(line,2) end;
	if not streq(txt,"WELT") then repeat
	  writeln(drucker,txt); readln(datei,txt); dec(line);
	  if streq(txt,"MELD") then begin
	    readln(datei,txt);
	    if line<6 then newpage(false)
	  end else if line=2 then newpage(false)
	until eof(datei) or streq(txt,"BOT") or streq(txt,"WELT") or
	      streq(txt,"RANG");
	if streq(txt,"BOT") then readln(datei,txt);
	while (not eof(datei)) and (not streq(txt,"WELT")) and
		(not streq(txt,"RANG")) do begin
	  pc:=1; strcpy(zei[1],txt); DoBreak;
	  repeat inc(pc); readln(datei,zei[pc])
	  until streq(zei[pc],"^^^") or (pc>60);
	  if line<5 then newpage(false); i:=1;
	  if not botsch then begin
	    inc(i); dec(line); writeln(drucker,zei[1]); botsch:=true end;
	  write(drucker,"\e(s0p12h6T");
	  while i<pc do begin
	    repeat
	      writeln(drucker,zei[i]); inc(i); dec(line)
	    until (i=pc) or (line=3);
	    if line<5 then newpage(true)
	  end;
	  readln(datei,txt); write(drucker,"\e(s1p4101T")
	end;
	if line<8 then newpage(false)
	else begin writeln(drucker); dec(line) end;
	if streq(txt,"WELT") then begin
	  readln(datei,txt); writeln(drucker,txt,"\e(s0p12h6T"); dec(line);
	  readln(datei,txt); botsch:=true
	end;
	while not eof(datei) do begin DoBreak;
	  writeln(drucker,txt); readln(datei,txt); dec(line);
	  if line=2 then newpage(true);
	  if streq(txt,"RANG") then begin
	    write(drucker,"\e(s1p4101T"); botsch:=false;
	    if line<8 then newpage(false)
	    else begin writeln(drucker,'\n'); dec(line,2) end;
	    readln(datei,txt)
	  end;
	  if streq(txt,"SPIELENDE") then begin readln(datei,txt);
	    while not streq(txt,"LISTENENDE") do begin
	      pc:=1; strcpy(zei[1],txt); DoBreak;
	      repeat
		inc(pc); readln(datei,zei[pc]);
	      until streq(zei[pc],"STOP");
	      if line>succ(pc) then begin writeln(drucker); dec(line) end
	      else newpage(false);
	      for i:=1 to pred(pc) do writeln(drucker,zei[i]); dec(line,pred(pc));
	      readln(datei,txt)
	    end;
	    readln(datei,txt);
	  end
	end;
	write(drucker,txt);
	for i:=2 to line do writeln(drucker); inc(seite);
	write(drucker,"\e(s1p4101T","- ":85,seite," -\f");
	close(drucker); close(datei); writeln(". ",seite," Seiten Ok.")
      end else write("\a Kann Ausgabe nicht lesen!")
     end else begin
      writeln("\n\a *** Abbruch! Konnte `",str,"' nicht zum schreiben öffnen!\n");
      exit(20)
     end;
     if open("par:",drucker) then begin
	{ kein Puffer, weil sonst nicht alles zu PAR: geschickt wird
	  => Drucker wartet mit halber Seite... }
      write(drucker,"\eE\e&k1w2G\e(0N");
      if c='d' then begin
        write("Drucke Seiten");
	for i:=seite downto 1 do begin
	  strcpy(str,"RAM:Seite_"); strcat(str,int_str(i)); write('.');
	  if reopen(str,datei,2048) then begin
	    while not eof(datei) do begin
	      readln(datei,txt); writeln(drucker,txt);
	    end;
	    close(datei)
	  end else begin
	    writeln("\n\a *** Abbruch! Konnte `",str,"' nicht zum lesen öffnen!\n");
	    exit(20)
	  end
	end
      end else begin
        i:=2; write("\nDrucke gerade Seiten");
	while i<=seite do begin write('.');
	  strcpy(str,"RAM:Seite_"); strcat(str,int_str(i));
	  if reopen(str,datei,2048) then begin
	    while not eof(datei) do begin
	      readln(datei,txt); writeln(drucker,txt);
	    end;
	    close(datei)
	  end else begin
	    writeln("\n\a *** Abbruch! Konnte `",str,"' nicht zum lesen öffnen!\n");
	    exit(20)
	  end;
	  inc(i,2)
	end; write("Ok.\n");
	write("\nSeiten neu einlegen und <RETURN> drücken! "); i:=seite;
	if odd(seite) then write("	Ein Blatt oben drauf legen! ") else dec(i);
	readln; write("Drucke restliche Seiten");
	while i>0 do begin write('.');
	  strcpy(str,"RAM:Seite_"); strcat(str,int_str(i));
	  if reopen(str,datei,2048) then begin
	    while not eof(datei) do begin
	      readln(datei,txt); writeln(drucker,txt);
	    end;
	    close(datei)
	  end else begin
	    writeln("\n\a *** Abbruch! Konnte `",str,"' nicht zum lesen öffnen!\n");
	    exit(20)
	  end;
	  dec(i,2)
	end
      end;
      write(drucker,"\eE"); close(drucker); writeln(" Ok.")
     end else writeln("\n\a Konnte Drucker `par:' nicht ansprechen!\n");
    end
  end
end;


begin	{ Main }
  write("\f			\e[33m\e[4m\e[1mInselreich \e[0m\e[33m\e[4m\e[3mPrintgame\e[0m\e[33m\e[4m  Version 3.0\e[0m\n\n		\e[2m   © Copyright 1993-98 by Henning Peters\e[31m\n\nSpiel Nummer? "); readln(spiel);
  Load_Data; Verwaltung; FormatData
end.
