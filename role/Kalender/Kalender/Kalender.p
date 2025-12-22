program Kalender;	{ berechnet Kalender für DSA }
			{ Hilfe: Das Lexikon des Schwarzen Auges", FanPro }
			{ © copyright 1999 by Henning Peters }
			{ faroul@gmx.de }

{$I "include:utils/StringLib.i" }

const DSA_Monat:array[1..13]of string=
			("Praios","Rondra","Efferd","Travia","Boron","Hesinde","Firun","Tsa",
			 "Phex","Peraine","Ingerimm","Rahja","Namenlos");
		DSA_Region:array[1..6]of string=
			("Mittelreich","Liebliches Feld","Neetha, Weiden und Amazonien",
			 "Thorwal","Bornland","Al'Anfa, Mengbilla und Trahelien");
		{ In einigen Regionen heißen einige Tage anders }
		DSA_Tag:array[1..6,0..6]of string=
			(("Wasser","Winds","Erds","Markt","Praios","Rohals","Feuer"),
			 ("Wasser","Winds","Erds","Markt","Horas","Rohals","Feuer"),
			 ("Wasser","Winds","Erds","Markt","Rondra","Rohals","Feuer"),
			 ("Swafnir","Winds","Erds","Markt","Praios","Rohals","Feuer"),
			 ("Wasser","Schnee","Erds","Zins","Praios","Rohals","Feuer"),
			 ("Boron","Winds","Erds","Markt","Praios","Rohals","Feuer")); 
		KB="ABCDEFG";
		KB_Mon:array[1..13]of string=
			("DCBAGFE","BAGFEDC","GFEDCBA","EDCBAGF","CBAGFED","AGFEDCB","FEDCBAG",
			 "DCBAGFE","BAGFEDC","GFEDCBA","EDCBAGF","CBAGFED","AGFEDCB");
		Header="\f\n		\e[1mDas Schwarze Auge - Kalenderberechnung\e[0m\n";
		Copyright="\n		\e[33m© copyright 1999 by Henning Peters\e[0m\n";

var Datei:text;
		Region:byte;
		s:string;
		c:char;
		i:integer;

function str_int(str:string; start,ende:byte):integer;
var i,j:integer;
		n:short;
begin
	i:=0;
	for j:=start to ende do begin
		n:=ord(str[j])-48;
		if (n<0) or (n>9) then str_int:=0;
		i:=i*10+n
	end;
	str_int:=i
end;

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

function strpart(s:string; a,b:short):string;
var str:string;
		i:integer;
begin
	str:=AllocString(b-a+2);
	for i:=a to b do str[i-a]:=s[i];
	str[succ(b-a)]:='\0'; strpart:=strdup(str)
end;

function Calc_Wotag(t,m,j:integer):byte;
var c:char;
		a:byte;
begin
	c:=KB[pred(j)mod 7]; a:=strpos(KB_Mon[m],c); Calc_WoTag:=(7+pred(t)-a)mod 7;
end;							{+7 damit's immer >0 ist}

procedure Wochentag;
var wt,t,m,j:byte;
		a,b,i:integer;
		s,Datum:string;
		ok:boolean;
begin
	writeln(Header,"\n			Region: \e[4m",DSA_Region[Region],"\e[0m\n\n	\e[1mWochentagsberechnung\e[0m\n\n	1: Praios,	 2: Rondra,	 3: Efferd,	 4: Travia,\n	5: Boron,	 6: Hesinde,	 7: Firun,	 8: Tsa,\n	9: Phex,	10: Peraine,	11: Ingerimm,	12: Rahja");
	Datum:=AllocString(25);
	repeat
		write("\nBitte Datum eingeben (Tag.Monat.Jahr): "); readln(Datum);
		if strlen(Datum)=0 then return;
		a:=strpos(Datum,'.'); b:=strrpos(Datum,'.');
		if (a>0) and (b>a) then begin
			t:=str_int(Datum,0,pred(a));
			if (t>0) and (t<31) then begin
				m:=str_int(Datum,succ(a),pred(b));
				if m<1 then begin
					s:=strpart(Datum,succ(a),pred(b)); m:=0;
					repeat
						ok:=strieq(s,DSA_Monat[m]); inc(m)
					until ok or (m>12);
					if ok then dec(m)
				end;
				if (m>0) and (m<13) then j:=str_int(Datum,succ(b),pred(strlen(Datum)));
			end
		end;
		ok:=((t>0) and (t<31)) and ((m>0) and (m<13)) and (j>0);
		if not ok then writeln("Ungültige Eingabe!")
	until ok;
	wt:=Calc_WoTag(t,m,j);
	writeln("\nDer ",t,". ",DSA_Monat[m],' ',j," war ein ",DSA_Tag[Region,wt],"tag.")
end;

procedure JahresKalender;
var s:string;
		Datei:text;
		zl,sl,sr,tr,tl,wtl,wtr,Format:byte;
		i,Monat,Jahr:integer;
		c:char;
		LaTeX:boolean;
begin
	write(Header,"\n			Region: \e[4m",DSA_Region[Region],"\e[0m\n\n	\e[1mJahreskalender\e[0m\n\nFür welches Jahr soll der Kalender erstellt werden? ");
	s:=AllocString(50); readln(s); Jahr:=str_int(s,0,pred(strlen(s)));
	if Jahr<1 then return;
	write("\n	1) LaTeX (Roman-Fonts)\n	2) LaTeX (Fraktur-Fonts)\n	3) Ascii-Vollblatt\n\nWelches Format? ");
	readln(s); Format:=ord(s[0])-48;
	if (Format<1) or (Format>3) then return;
	write("\nName der Ausgabedatei: "); readln(s);
	LaTeX:=Format<3;
	if LaTeX then
		if strpos(s,'.')<0 then
			strcat(s,".tex");
	if reopen(s,Datei) then begin
		write("\n\a	Achtung, Datei `",s,"' existiert und würde überschrieben!\n	Fortfahren (j/n)? ");
		close(Datei); readln(c); if c<>'j' then return
	end;
	if open(s,Datei,4096) then begin
		case Format of
			1:writeln(Datei,"\\documentstyle[a4,german]{article}\n\\pagestyle{empty}\\parindent 0mm\n\\def\\luecke{\\hspace{30mm}} \\def\\gl{\\,\\raisebox{1pt}{\\footnotesize=}\\,}");
			2:writeln(Datei,"\\documentstyle[a4]{article}\n\\newfont{\\goth}{ygoth scaled 2074} \\newfont{\\Goth}{ygoth scaled 2400}\n\\pagestyle{empty}\\parindent 0mm \\tabcolsep 3pt\n\\def\\luecke{\\hspace{30mm}} \\def\\gl{\\,\\raisebox{3pt}{\\small=}\\,}");
		end;
		if LaTeX then begin
			if Format=2 then
				writeln(Datei,"\\oddsidemargin 0mm \\advance\\textwidth 20mm");
			writeln(Datei,"\\begin{document}");
			if Format=2 then write(Datei,"\\goth\n");
			write(Datei,"\\begin{tabular}{ccccccc@{\\luecke}ccccccc}")
		end;
		write("\nErstelle Kalender");
		for Monat:=1 to 6 do begin write('.');
			if LaTeX then begin
				write(Datei,"\\multicolumn{7}{c@{\\luecke}}{");
				if Format=2 then write(Datei,"\\Goth ") else write(Datei,"\\bf\\large ");
				write(Datei,DSA_Monat[Monat]);
				if (Format=2) and (Monat=1) then write(Datei,':');
				write(Datei,"}\n	& \\multicolumn{7}{c}{");
				if Format=2 then write(Datei,"\\Goth ") else write(Datei,"\\bf\\large ");
				write(Datei,DSA_Monat[Monat+6],"}\\\\[1mm]\n ");
				for i:=0 to 13 do begin
					write(Datei,strpart(DSA_Tag[Region,i],0,1));
					if i<13 then write(Datei," & ")
				end; write(Datei,"\\\\\n")
			end else begin
				writeln(Datei,DSA_Monat[Monat]:20,DSA_Monat[Monat+6]:50); sl:=0;
				for i:=0 to 6 do begin
					write(Datei,strpart(DSA_Tag[Region,i],0,1):3+sl); sl:=1
				end;
				write(Datei,' ':23);
				for i:=0 to 6 do begin
					write(Datei,strpart(DSA_Tag[Region,i],0,1):3+sl); sl:=1
				end; writeln(Datei)
			end;
			wtl:=Calc_WoTag(1,Monat,Jahr); sl:=0; tl:=1;
			wtr:=Calc_WoTag(1,Monat+6,Jahr); sr:=0; tr:=1;
			if LateX then while sl<wtl do begin write(Datei,'&':5); inc(sl) end
			else if wtl>0 then write(Datei,' ':4*wtl);
			sl:=wtl; zl:=0;
			repeat
				if sl<7 then begin
					if tl<31 then write(Datei,tl:3) else write(Datei,"   "); inc(tl); inc(sl);
					if (zl=0) and (sl=7) then begin
						if LaTeX then begin
							while sr<wtr do begin write(Datei,'&':5); inc(sr) end
						end else write(Datei,' ':23+wtr*4);
						sr:=wtr
					end;
					if not LaTeX and (sl=7) and (zl>0) then write(Datei,' ':23);
				end else begin
					if tr<31 then write(Datei,tr:3) else write(Datei,"   "); inc(tr); inc(sr)
				end;
				if LaTeX then begin
					if sr<7 then write(Datei," &")
					else begin
						write(Datei," \\\\"); if (tl<31) or (tr<31) then writeln(Datei);
						inc(zl); sl:=0; sr:=0;
					end
				end else begin
					if sr<7 then write(Datei,' ')
					else begin writeln(Datei); inc(zl); sl:=0; sr:=0 end
				end
			until (tr>30) and (tl>30);
			if LaTeX then begin
				if ((sl>0) and (sr=0)) or (sr>0) then write(Datei,"\\\\");
				if Monat=3 then begin
					if Format=2 then writeln(Datei,"\n\\end{tabular}\n\\newpage\n\\begin{tabular}{ccccccc@{\\luecke}ccccccc}")
					else write(Datei,"[2mm]\n")
				end else write(Datei,"[2mm]\n")
			end else if sr<7 then writeln(Datei,'\n');
			if (Monat=3) and not LaTeX then
				writeln(Datei,"\n\n\n\n\n\n\n\n\n\n")
		end;
		if LaTeX then begin
			write(Datei," & & & & & & & \\multicolumn{7}{c}{");
			if Format=2 then write(Datei,"\\Goth ") else write(Datei,"\\bf\\large ");
			write(Datei,"Namenlos");
			if Format=2 then write(Datei,':');
			write(Datei,"}\\\\[1mm]\n  & & & & & & & ");
		end else begin
			writeln(Datei,"Namenlos":68); sl:=0;
			write(Datei,' ':51);
		end;
		wtl:=Calc_WoTag(1,13,Jahr); sl:=0; tl:=1;
		if LateX then while sl<wtl do begin write(Datei,'&':5); inc(sl) end
		else if wtl>0 then write(Datei,' ':4*wtl);
		sl:=wtl; tl:=1;
		repeat
			write(Datei,tl:3); inc(tl); inc(sl);
			if tl<6 then begin
				if LaTeX then begin
					if sl<7 then write(Datei," &")
					else begin write(Datei," \\\\\n & & & & & & & "); sl:=0 end
				end else begin
					if sl<7 then write(Datei,' ')
					else begin write(Datei,'\n',' ':51); sl:=0 end
				end
			end
		until tl>5;
		if LaTeX then write(Datei,"\n\\end{tabular}\n\\bigskip\n\n\\centerline{")
		else writeln(Datei,'\n');
		for i:=0 to 6 do begin
			if (i>0) and (i<>4) then write(Datei,"; ");
			write(Datei,strpart(DSA_Tag[Region,i],0,1),"\\gl{}",
						DSA_Tag[Region,i]);
			if Format=2 then begin
				tl:=strlen(DSA_Tag[Region,i])-1;
				if streq(strpart(DSA_Tag[Region,i],tl,tl),"s") then write(Datei,":{}");
			end;
			write(Datei,"tag");
			if i=3 then begin
				if LaTeX then write(Datei,"}\n\n\\centerline{")
				else writeln(Datei,'\n')
			end
		end;
		if LaTeX then writeln(Datei,"}\n\\end{document}");
		close(Datei); writeln("Ok.")
	end else writeln("\a\n	Kann Datei `",s,"' nicht zum Schreiben öffnen!\n")
end;


begin	{ Main }
	writeln(Header,Copyright);
	s:=AllocString(40);
	for i:=1 to 6 do writeln('	',i,": ",DSA_Region[i]);
	write("\nFür welche Region soll der Kalender benutzt werden (1-6)? ");
	readln(s); Region:=ord(s[0])-48;
	if (Region<1) or (Region>6) then begin
		writeln("\n\aDiese Region wird aber nicht unterstützt...\n"); exit(5) end;
	repeat
		write(Header,"\n			Region: \e[4m",DSA_Region[Region],"\e[0m\n\n	1) Ausgabe eines Jahreskalenders\n	2) Berechnung eines Wochentages\n	0) Programmende\n\nIhre Wahl: ");
		readln(c);
		case c of
			'1':JahresKalender;
			'2':Wochentag;
		end;
		if (c>'0') and (c<'3') then begin
			write("\nWeiter mit <RETURN>"); readln
		end;
	until c='0'; writeln;
end.


