{ ex: ts=2 ai
}
program DSA_Wetter;
	{ Generiert Wetter-Tabelle nach DSA-Regeln }
	{ Quelle: "Das Handbuch für den Reisenden" }
	{ © copyright 1995-97 by Henning Peters }
	{ eMail: faroul@beyond.hb.north.de }
	{ Public-Domain - darf zwecks Systemanpassung }
	{ modifiziert werden; dann bitte Source an mich senden. }

{$I "include:utils/StringLib.i"}
{$I "include:utils/Random.i"}

const
	Version="2.1";
	c_Wind:array[0..8]of string=
				("windstill\\\\","leichter Windzug\\\\","leichte Brise\\\\",
				 "frische Brise\\\\","steife Brise\\\\","starker Wind\\\\","Sturm\\\\",
				 "schwerer Sturm\\\\","Orkan\\\\");
	c_Temp:array[0..8]of string=
				(" & empfindlich kalt & "," & kalt & "," & k\\\"uhl & ",
				 " & der Jahreszeit entsprechend & "," & der Jahreszeit entsprechend & ",
				 " & der Jahreszeit entsprechend & "," & warm & ",
				 " & sehr warm & "," & f\\\"ur die Jahreszeit unnat\\\"urlich warm & ");
	c_vWetter:array[1..4,1..20]of short=
				((0,0,0,0,0,0,-3,-3,-1,-1,-1,-1,-2,-2,-2,-2,-2,-4,-4,2),
				 (-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-1,-1,-1,-1,-1,-4,-3,1,5,5),
				 (0,0,0,0,0,0,-3,-3,-1,-1,-1,-1,-2,-2,-2,-2,-2,-4,-4,2),
				 (-1,-1,-1,-1,-1,-1,-2,-2,-2,-2,-2,-2,-3,-3,-4,-4,-2,-2,-2,-2));
	c_vWind:array[1..4,1..20]of short=
				((0,0,0,0,0,0,1,1,-1,-1,-1,-1,-3,-3,-3,-1,-1,2,2,4),
				 (-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-2,-2,-2,-2,-2,1,1,2,4,4),
				 (0,0,0,0,0,0,1,1,-1,-1,-1,-1,-3,-3,-3,-1,-1,2,2,4),
				 (0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,2,2,2,2));
	c_vTemp:array[1..4,1..20]of short=
				((0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-2,-2,-3),
				 (1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,0,0,-1,-2,-2),
				 (0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-2,-2,-3),
				 (-2,-2,-2,-2,-2,-2,-1,-1,-1,-1,-1,-1,1,1,2,2,0,0,0,0));

var
	Breite,Zeit,Tage,Wetter,Wind,Temp:short;
	Ausfile:text;
	c:char;
	Tag:integer;
	Jz,str:string;
	Unwetter:boolean;


{ Strings sind wie in C, also Pointer! }
function int_str(i:integer):string;	{ i=0..999 }
var str:string;
begin str:=AllocString(5);
	if i<10 then begin
		str[0]:=chr(i+48); str[1]:='\0'
	end else if i<100 then begin
		str[0]:=chr(i div 10+48); str[1]:=chr(i mod 10+48); str[2]:='\0'
		end else begin
				str[0]:=chr(i div 100+48); str[1]:=chr((i mod 100)div 10+48);
				str[2]:=chr(i mod 10+48); str[3]:='\0'
		end;
	int_str:=str
end;

function str_int(str:string):short;
var i,j:integer;
		l,n:short;
begin
	i:=0; l:=pred(strlen(str));
	for j:=0 to l do begin
		n:=ord(str[j])-48;
		if (n<0) or (n>9) then str_int:=0;
		i:=i*10+n
	end;
	str_int:=i
end;

function Wurf(w:byte):short;
begin
	Wurf:=succ(RangeRandom(pred(w)))
end;	{ RangeRandom(n) liefert 0..n; für 1..6 also (0..(6-1))+1 }

function Range(a:short):short;
begin
	if a<0 then Range:=0 else if a>8 then Range:=8;
	Range:=a;	{ Bei mir: Func:=Wert -> Exit Func }
end;

function Near(a:short):short;
var b,c:short;
begin
	b:=Wurf(6); c:=Wurf(6);
	if abs(a-b)>abs(a-c) then Near:=c else Near:=b
end;

procedure Ausgabe;
var s,aus:string;
	p:short;
	l,j:integer;
begin
	case Zeit of
		1,3: case Wetter of
			1..6:	s:="Klar";
			7,8:	 s:="Bew\\\"olkt, gelegentlich Schauer";
			9..12: s:="Leichter Morgennebel, dann aufklarend";
			13..15:s:="Nebel";
			16,17: s:="Nieselregen";
			18,19: s:="Dauerregen";
			20:		s:="Gewitter, Wolkenbruch (";
		end;
		2: case Wetter of
			1..10: s:="Sonnig und klar";
			11..15:s:="Schw\\\"ulwarm, dunstig";
			16:		s:="Kurze Schauer";
			17:		s:="Nieselregen";
			18:		s:="Gewitter, heftige Schauer";
			19,20: s:="Gewitter, Wolkenbruch (";
		end;
		4: case Wetter of
			1..6:	s:="Frostklar";
			7..12: s:="Klar";
			13,14: s:="einzelne Flocken";
			15,16: s:="Schneeschauer";
			17..20:s:="Starker Schneefall"
		end
	end;
	aus:=AllocString(200);
	if Unwetter then begin
		strcpy(aus," & Anschlie\\ss end: "); Unwetter:=false
	end else begin
		strcpy(aus,int_str(Tag)); strcat(aus," & ");
	end;
	strcat(aus,s);
	if ((Zeit=2) and (Wetter>18)) or (((Zeit=1) or (Zeit=3)) and (Wetter=20)) then begin
		p:=Wurf(3); strcat(aus,int_str(p));
		if p>1 then strcat(aus," Stunden)") else strcat(aus," Stunde)");
		Unwetter:=true; dec(Tag);
	end;
	strcat(aus,c_Temp[Temp]); strcat(aus,c_Wind[Wind]);
	if not Unwetter then strcat(aus,"\\hline\n");
	write(Ausfile,aus)
end;


begin				{ Main }
	write("\f\n		\e[1mDSA Wettergenerator\e[0m V",Version,"\n\n    © copyright 1995-97 by Henning Peters\n  eMail: faroul@beyond.hb.no\/rth.d\n\nFür wieviel Tage soll das Wetter berechnet werden (45 pro Seite)? ");
	{ \e=Esc=chr(27); \f=chr(12)=ClearScreen; \e[1m=BoldOn, \e[0m=BoldOff }
	str:=AllocString(60);
	readln(str); Tage:=str_int(str); if Tage<1 then exit(5);
	repeat
		write("\nWelche Jahreszeit soll genommen werden:\n	\e[4mF\e[0mrühjahr, \e[4mS\e[0mommer, \e[4mH\e[0merbst oder \e[4mW\e[0minter? ");
		readln(c);
		case tolower(c) of
			'f':begin Zeit:=1; Jz:="Fr\\\"uhjahr" end;
			's':begin Zeit:=2; Jz:="Sommer" end;
			'h':begin Zeit:=3; Jz:="Herbst" end;
			'w':begin Zeit:=4; Jz:="Winter" end
			else begin Zeit:=0; write("Das geht nicht!\eM\eM\eM") end
		end;
	until Zeit>0;	{ \e=Esc=chr(27); \eM=Cursor up }
	selfseed;	{ Zufallsgenerator starten }
	Wetter:=wurf(20); Wind:=Range(Wurf(6)+c_vWind[Zeit,Wetter]);
	Temp:=Range(Wurf(6)+c_vTemp[Zeit,Wetter]);
	repeat
		write("\nName der Ausgabedatei (ohne Endung `.tex'): "); readln(str);
		strcat(str,".tex"); c:='j';
		if reopen(str,Ausfile) then begin
			write("\n\aAchtung! Datei `",str,"' existiert bereits! Überschreiben (j/n)? ");
			readln(c); close(Ausfile)
		end
	until tolower(c)='j';
	if open(str,Ausfile,1024) then begin
		write("\nGeneriere Wetterdaten");
		write(Ausfile,"\\documentstyle{article}\n\\topmargin 0pt \\voffset -2cm \\hoffset -1cm \\textwidth 512pt \\textheight 25cm\n\\oddsidemargin 0mm \\evensidemargin 0mm \\marginparwidth 0mm \\marginparsep 0mm\n\\begin{document}\n\\begin{center}\n{\\Large\\bf ",Jz,"}\\\\[2mm]\n\\begin{tabular}{|r|l|l|l|}\n\\hline\n\\bf Tag & \\bf Wetter \\bf & \\bf Temperatur & \\bf Wind\\\\ \\hline\n");
		for Tag:=1 to Tage do begin
			Ausgabe; if Tag mod 10=0 then write('.');
			Wetter:=Wetter+Wurf(6)+c_vWetter[Zeit,Wetter];
			if Wetter<1 then inc(Wetter,20)
			else if Wetter>20 then dec(Wetter,20);
			Wind:=Range(Near(Wind)+c_vWind[Zeit,Wetter]);
			Temp:=Range(Near(Temp)+c_vTemp[Zeit,Wetter]);
			if (Tag mod 45=0) and (Tag<Tage) then
				write(Ausfile,"\\end{tabular}\n\\end{center}\n\\vfill{\\small\\sf DSA-Wettergenerator V",Version," -- \\copyright\ copyright 1995/96 by Henning Peters \\hfill E-Mail: faroul@beyond.hb.north.de}\n\\newpage\n\\begin{center}\n{\\Large\\bf ",Jz,"}\\\\[2mm]\n\\begin{tabular}{|r|l|l|l|}\n\\hline\n\\bf Tag & \\bf Wetter \\bf & \\bf Temperatur & \\bf Wind\\\\ \\hline\n");
		end;
		write(Ausfile,"\\end{tabular}\n\\end{center}\n\\vfill{\\small\\sf DSA-Wettergenerator V",Version," -- \\copyright\ copyright 1995--97 by Henning Peters \\hfill eMail: faroul@beyond.hb.north.de}\n\\end{document}\n");
		close(Ausfile); write("Ok.\n\n")
	end else write("\aKonnte `",str,"' nicht zum Schreiben öffnen!\n")
end.	{ \a=Attention=chr(7) }

