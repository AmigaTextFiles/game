{ ex: ts=2 ai
 }
program DSA_Dorf;	{ Version 2.2 · 1.`96 }

{$R+}

	{ Generiert ein Dorf (nach DSA-Regeln)
		Quelle f\"ur die Texte: "Das Handbuch f\"ur den Reisenden"
				(© copyright Schmidt Spiel & Freizeit GmbH)
		© copyright 1995/96 by Henning Peters
			E-Mail: faroul@beyond.hb.north.de
			Fido-Mail: 2:2426/3020.28
		Public-Domain - darf zwecks Systemanpassung modifiziert werden;
		dann bitte Source an mich senden.
	}

{$I-}
{$I "include:utils/StringLib.i"}
{$I "include:utils/Random.i"}

const
	Version="2.2";
	c_Groesse=30;
	c_Tempel:array[1..12]of string=
		("Peraine","Travia","Efferd","Rahja","Phex","Rondra","Ingerimm","Praios",
			"Hesinde","Tsa","Boron","Firun");
	c_HandwI:array[1..7] of string=
		("Grobschmied","Hufschmied","Sattler","Schuster","Grobschneider","Tischler",
			"Zimmermann");
	c_HandwII:array[1..23]of string=
		("Fleischer","Bootsbauer","Schnapsbrenner","Brotb\"acker","Netzkn\"upfer",
			"Kunstschmied","Waffenschmied","Bogenbauer","Armbruster","Bronzegie\"ser",
			"K\"urschner","Gerber","F\"arber","K\"ufer","Kerzenzieher","T\"opfer","Zinngie\"ser",
			"Tuchmacher","Seiler","Wagner","Drechsler","M\"uller","N\"aherin");
	c_HandwIII:array[1..12]of string=
		("Dachdecker","Konditor","Baumeister","K\"unstler","Gelehrter","Graveur",
			"Hofschneider","Glasbl\"aser","Instrumentenbauer","Kammerj\"ager",
			"Prothesenmacher","Alchimist");
	c_Gross:array[1..12]of string=
		("Brauerei","Spinnerei","Weinkellerei","Weberei","Drahtzieherei",
			"Stellmacherei","Werft","Druckerei/Buchbinderei","Papierm\"uhle","Gie\"serei",
			"Mine","K\"aserei");
	c_HaendlI:array[1..3]of string=
		("Ausr\"ustung","Lebensmittel","Kr\"amerwaren");
	c_HaendlII:array[1..8]of string=
		("spezielle Lebensmittel","Gew\"urze","Schmuck","Waffen","Vieh","Tuche",
			"Kleidung","Kr\"auter");
	c_HaendlIII:array[1..10]of string=
		("Feinkost","hei\"se Waren (Hehler)","Edelsteine","Andenken","Wein","Apotheke",
			"Teppiche","G\"uldenlandwaren","Zauberwerk","Spezialgesch\"aft");
	c_DienstI:array[1..4]of string=
		("Badehaus","Bordell","Barbier","Schreiber");
	c_DienstII:array[1..14]of string=
		("Kurier-/Botendienst","Reederei","Pfandhaus","Droschkenverleih","Wahrsager",
			"Seelenheiler","S\"oldner und Besch\"utzer","Schule","Geldwechsler",
			"Fremdenf\"uhrer","Traumdeuter","Geisteraustreiber","Rechtsgelehrter","Zauberer");
	c_Heilk:array[1..4]of string=
		("Medikus","Heiler","Hebamme","Quacksalber");
	c_Durch:array[1..10]of string=
		("Korbmacher","Scherenschleifer","Kesselflicker","Gaukler","Musikanten",
			"Quacksalber","Zahnbrecher","Kuriosit\"atenkr\"amer","Geschichtenerz\"ahler",
			"Wahrsager");
	c_QuaPreis:array[1..20]of short=
		(4,4,2,2,2,2,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-3,-3);
	c_Siehe="siehe St\"adtebeschreibung in \"Das Land des Schwarzen Auges\".";

type
	t_Feld=(f_Haus1,f_Haus2,f_Haus3,f_Haus4,f_Haus5,f_Tempel1,f_Tempel2,f_Hotel1,
					f_Hotel2,f_Hotel3,f_Kneipe1,f_Kneipe2,f_HandwI,f_HandwII,f_HandwIII,
					f_Gross,f_HaendlI,f_HaendlII,f_HaendlIII,f_DienstI,f_DienstII,f_Heilk,
					f_Durch,f_Markt,f_Teich,f_Baum1,f_Baum2,f_Baum3,f_Leer);
	t_Dorf=record
		Feld:t_Feld;
		num:byte
	end;
	t_Richtung=(runter,rechts);
	t_Weg=record
		x,y,l:short;
		r:t_Richtung;
		next:^t_Weg;
	end;
  p_Weg=^t_Weg;

var
	Einw,xy,Dorf_Num,Tempel,Hotels,Kneipen,HandwI,HandwII,HandwIII,Gross,HaendlI,
	HaendlII,HaendlIII,DienstI,DienstII,Heilk,Durch,Markt,Qual,PreisHa,PreisHw:short;
	Ausfile:text;
	Aus_Leer,ok:boolean;
	str,Name:string;
	Dorf:array[1..c_Groesse,1..c_Groesse]of t_Dorf;
	Weg:p_Weg;
	Bau:array[f_Haus1..f_Leer]of string;
	Vorh:array[f_Haus1..f_Durch]of integer;


function PreisText(p:byte):string;
begin
	case p of
		0..2: 	PreisText:="sehr billig";
		3,4:		PreisText:="billig";
		5..12:	PreisText:="durchschnittlich";
		13..18:	PreisText:="teuer";
		19:			PreisText:="sehr teuer";
		20:			PreisText:="Wucher"
	end
end;

function QualText(q:byte):string;
begin
	case q of
		1..2:		QualText:="sehr gut";
		3..6:		QualText:="gut";
		7..14:	QualText:="durchschnittlich";
		15,16:	QualText:="m\"a\"sig";
		17,18:	QualText:="schlecht";
		19,20:	QualText:="miserabel"
	end
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

function str_int(str:string):short;
var i,j:integer;
		s,l,n:short;
begin
	i:=0; l:=pred(strlen(str)); if str[0]='-' then s:=1 else s:=0;
	for j:=s to l do begin
		n:=ord(str[j])-48;
		if (n<0) or (n>9) then str_int:=0;
		i:=i*10+n
	end;
	if str[0]='-' then str_int:=-i else str_int:=i
end;

function Wurf(w:short):short;
begin
	if w<2 then Wurf:=1;	{ Bei mir: Func:=Wert -> Exit Func }
	Wurf:=succ(RangeRandom(pred(w)))
end;	{ RangeRandom(n) liefert 0..n; f\"ur 1..6 also (0..(6-1))+1 }

function Zero(a:short):short;
begin
	if a<0 then Zero:=0;
	Zero:=a;
end;

function Range(a,b:short):short;
begin
	if a<0 then Range:=0 else if a>b then Range:=b;
	Range:=a;
end;

procedure Eingabe;
var s:string;
		c:char;
begin
	s:=AllocString(20);
	repeat
		write("\n\nEingabe der Dorfdaten\n  (keine Kontrolle der Zahlenwerte, Falscheingaben werden als 0 gezählt!)\n\n  Anzahl der Einwohner:              ");
		readln(s); Einw:=str_int(s);
		write("  Anzahl der Tempel:                 "); readln(s); Tempel:=str_int(s);
		write("             Hotels:                 "); readln(s); Hotels:=str_int(s);
		write("             Kneipen:                "); readln(s); Kneipen:=str_int(s);
		write("             Handwerker I:           "); readln(s); HandwI:=str_int(s);
		write("             Handwerker II:          "); readln(s); HandwII:=str_int(s);
		write("             Handwerker III:         "); readln(s); HandwIII:=str_int(s);
		write("             Großbetriebe:           "); readln(s); Gross:=str_int(s);
		write("             Händler I:              "); readln(s); HaendlI:=str_int(s);
		write("             Händler II:             "); readln(s); HaendlII:=str_int(s);
		write("             Händler III:            "); readln(s); HaendlIII:=str_int(s);
		write("             Dienstleistungen I:     "); readln(s); DienstI:=str_int(s);
		write("             Dienstleistungen II:    "); readln(s); DienstII:=str_int(s);
		write("             Heilkundigen:           "); readln(s); Heilk:=str_int(s);
		write("             Durchfahrenden:         "); readln(s); Durch:=str_int(s);
		write("             Markttage (-1=ständig): "); readln(s); Markt:=str_int(s);
		write("  Qualitätsniveau (-2 bis 3):        "); readln(s); Qual:=str_int(s);
		write("  Preisniveau Händler (0 bis 3):     "); readln(s); PreisHa:=str_int(s);
		write("  Preisniveau Handwerker (-5 bis 3): "); readln(s); PreisHw:=str_int(s);
		write("\nAlle Eingaben richtig (j/n)? "); readln(s);
	until tolower(s[0])='j';
	write("\nErstelle Dorf")
end;

procedure Generate_Bild;
var i,j:integer;
		nr,zz,Baeume:byte;
		q,x,y,ay,Teiche,Haeuser:short;
		wt,wp:p_Weg;

	procedure Generate_Gebaeude;
	begin
		repeat inc(zz); if zz>12 then begin write('.'); zz:=0 end;
			x:=Wurf(xy); y:=Wurf(xy); ay:=y;
			while (Dorf[x,y].Feld<>f_Leer) and (ay<xy) do begin inc(x);
				if x>xy then begin
					inc(y); x:=1; if y>xy then y:=1 else if y=ay then ay:=99
				end
			end;
			if ay>xy then begin
				write("Konnte nicht alle Gebäude etc. verteilen!"); return
			end;
			if Markt>0 then begin
				while (y=xy) or (x=xy) or ((Dorf[x,y].Feld<>f_Leer) and
							 (Dorf[x,succ(y)].Feld<>f_Leer) and (Dorf[succ(x),y].Feld<>f_Leer) and
							 (Dorf[succ(x),succ(y)].Feld<>f_Leer))
				do begin inc(x);
					if x>=xy then begin
						inc(y); x:=1; if y>=xy then y:=1
					end
				end;
				Dorf[x,y].Feld:=f_Markt; Dorf[succ(x),y].Feld:=f_Markt;
				Dorf[x,succ(y)].Feld:=f_Markt; Dorf[succ(x),succ(y)].Feld:=f_Markt; 
				dec(Markt)
			end else if Tempel>0 then begin
				if Wurf(2)=1 then Dorf[x,y].Feld:=f_Tempel1 else Dorf[x,y].Feld:=f_Tempel2;
				dec(Tempel); Dorf[x,y].num:=nr; inc(nr)
			end else if Haeuser>0 then begin
				case Wurf(5) of
					1:Dorf[x,y].Feld:=f_Haus1;
					2:Dorf[x,y].Feld:=f_Haus2;
					3:Dorf[x,y].Feld:=f_Haus3;
					4:Dorf[x,y].Feld:=f_Haus4;
					5:Dorf[x,y].Feld:=f_Haus5
				end;
				dec(Haeuser)
			end else if Hotels>0 then begin
				case Wurf(3) of
					1:Dorf[x,y].Feld:=f_Hotel1;
					2:Dorf[x,y].Feld:=f_Hotel2;
					3:Dorf[x,y].Feld:=f_Hotel3
				end;
				dec(Hotels); Dorf[x,y].num:=nr; inc(nr)
			end else if Kneipen>0 then begin
				if Wurf(2)=1 then Dorf[x,y].Feld:=f_Kneipe1 else Dorf[x,y].Feld:=f_Kneipe2;
				dec(Kneipen); Dorf[x,y].num:=nr; inc(nr)
			end else if HandwI>0 then begin
				Dorf[x,y].Feld:=f_HandwI; dec(HandwI); Dorf[x,y].num:=nr; inc(nr)
			end else if HandwII>0 then begin
				Dorf[x,y].Feld:=f_HandwII; dec(HandwII); Dorf[x,y].num:=nr; inc(nr)
			end else if HandwIII>0 then begin
				Dorf[x,y].Feld:=f_HandwIII; dec(HandwIII); Dorf[x,y].num:=nr; inc(nr)
			end else if Gross>0 then begin
				Dorf[x,y].Feld:=f_Gross; dec(Gross); Dorf[x,y].num:=nr; inc(nr)
			end else if HaendlI>0 then begin
				Dorf[x,y].Feld:=f_HaendlI; dec(HaendlI); Dorf[x,y].num:=nr; inc(nr)
			end else if HaendlII>0 then begin
				Dorf[x,y].Feld:=f_HaendlII; dec(HaendlII); Dorf[x,y].num:=nr; inc(nr)
			end else if HaendlIII>0 then begin
				Dorf[x,y].Feld:=f_HaendlIII; dec(HaendlIII); Dorf[x,y].num:=nr; inc(nr)
			end else if DienstI>0 then begin
				Dorf[x,y].Feld:=f_DienstI; dec(DienstI); Dorf[x,y].num:=nr; inc(nr)
			end else if DienstII>0 then begin
				Dorf[x,y].Feld:=f_DienstII; dec(DienstII); Dorf[x,y].num:=nr; inc(nr)
			end else if Heilk>0 then begin
				Dorf[x,y].Feld:=f_Heilk; dec(Heilk); Dorf[x,y].num:=nr; inc(nr)
			end else if Teiche>0 then begin
				Dorf[x,y].Feld:=f_Teich; dec(Teiche)
			end else if Baeume>0 then begin
				case Wurf(3) of
					1:Dorf[x,y].Feld:=f_Baum1;
					2:Dorf[x,y].Feld:=f_Baum2;
					3:Dorf[x,y].Feld:=f_Baum3
				end;
				dec(Baeume)
			end
		until Baeume=0;
	end;

	procedure Gen_Weg(w:p_Weg; p:byte);
	var i:integer;
	begin
		inc(p,RangeRandom((zz-p)shr 1));
		if w^.r=runter then w^.y:=p else w^.x:=p;
		while Dorf[w^.x,w^.y].Feld=f_Markt do begin
			inc(p); if w^.r=runter then w^.y:=p else w^.x:=p
		end;
		w^.l:=(zz-p)shr 2+Wurf(trunc((zz-p)*0.75)); i:=1;
		repeat
			if w^.r=runter then begin
				if Dorf[w^.x,w^.y+i].Feld=f_Markt then begin
					w^.l:=pred(i); i:=xy
				end
			end else
				if Dorf[w^.x+i,w^.y].Feld=f_Markt then begin
					w^.l:=pred(i); i:=xy
				end;
			inc(i)
		until i>zz;	{ keine Wege quer durch Marktpl\"atze }
		if (w^.l=0) and (p+w^.l<zz-5) then Gen_Weg(w,succ(p));
	end;


	procedure Generate_Weg;
	begin
		new(wp); wp^.x:=0; wp^.y:=xy div 4+Wurf(xy div 2); zz:=pred(xy);
		wp^.l:=xy; wp^.r:=rechts; Weg:=wp; nr:=1;
		repeat
			q:=0;
			while q<0.75*xy do begin
				if Wurf(q)>xy/3 then inc(nr);
		  	new(wt); wt^.r:=runter; wt^.x:=nr; Gen_Weg(wt,q);
				if wt^.l>0 then begin wp^.next:=wt; wp:=wt; q:=wp^.y+wp^.l end
				else q:=xy
			end; q:=0;
			while q<0.75*xy do begin
				if Wurf(q)>xy/3 then inc(nr);
		  	new(wt); wt^.r:=rechts; wt^.y:=nr; Gen_Weg(wt,q);
				if wt^.l>0 then begin wp^.next:=wt; wp:=wt; q:=wp^.x+wp^.l end
				else q:=xy
			end;
			inc(nr); if Wurf(10)>3 then inc(nr); if Wurf(10)>3 then inc(nr);
		until nr>zz;
		wt^.next:=nil
	end;

begin {Generate_Bild}
	Baeume:=Dorf_Num shl 1; if Wurf(10)>6 then Teiche:=Wurf(Dorf_Num) else Teiche:=0;
	Haeuser:=xy*xy-Tempel-Hotels-Kneipen-HandwI-HandwII-HandwIII-Gross-HaendlI-
		HaendlII-HaendlIII-DienstI-DienstII-Heilk-Markt shl 2-Baeume-Teiche-
		RangeRandom(xy);
	zz:=0; nr:=1; Markt:=Markt div 2;
	Generate_Gebaeude; Generate_Weg
end;

procedure Generate_Dorf;
begin
	write("\nGeneriere Dorf (Größe ",Dorf_Num,')');
	case Dorf_Num of
		1:begin	{ -100 EW } 
				Tempel:=RangeRandom(1); Hotels:=Zero(Wurf(3)-2); Kneipen:=Wurf(2);
				HandwI:=Rangerandom(1); HandwII:=0; HandwIII:=0; Gross:=0;
				HaendlI:=Zero(Wurf(3)-2); HaendlII:=0; HaendlIII:=0;
				DienstI:=0; DienstII:=0; Heilk:=Zero(Wurf(3)-2);
				Durch:=1; Markt:=0; Qual:=1; PreisHa:=3; PreisHw:=-5; Einw:=100;
			end;
		2:begin	{ -250 EW }
				Tempel:=Wurf(2); Hotels:=Zero(Wurf(3)-1); Kneipen:=succ(Wurf(2));
				HandwI:=Wurf(3); HandwII:=Zero(Wurf(6)-5); HandwIII:=0; Gross:=0;
				HaendlI:=Zero(pred(Wurf(2))); HaendlII:=0; HaendlIII:=0;
				DienstI:=Zero(Wurf(6)-5); DienstII:=0; Heilk:=Zero(pred(Wurf(2)));
				Durch:=1; Markt:=0; Qual:=2; PreisHa:=2; PreisHw:=-3; Einw:=250;
			end;
		3:begin	{ -500 EW }
				Tempel:=Wurf(3); Hotels:=succ(Wurf(2)); Kneipen:=succ(Wurf(3));
				HandwI:=Wurf(3); HandwII:=Zero(Wurf(3)-2); HandwIII:=0; Gross:=0;
				HaendlI:=Wurf(2); HaendlI:=Zero(Wurf(3)-2); HaendlIII:=0;
				DienstI:=Zero(Wurf(3)-2); DienstII:=0; Heilk:=Wurf(2);
				Durch:=1; Markt:=2; Qual:=2; PreisHa:=2; PreisHw:=-2; Einw:=500;
			end;
		4:begin	{ -1000 EW }
				Tempel:=succ(Wurf(2)); Hotels:=succ(Wurf(3)); Kneipen:=Wurf(3)+2;
				HandwI:=succ(Wurf(2)); HandwII:=Zero(pred(Wurf(2)));
				HandwIII:=Zero(Wurf(6)-5); Gross:=0;
				HaendlI:=succ(Wurf(2)); HaendlII:=Zero(pred(Wurf(2)));
				HaendlIII:=Zero(Wurf(6)-5);
				DienstI:=Zero(pred(Wurf(2))); DienstII:=0; Heilk:=Wurf(3);
				Durch:=2; Markt:=4; Qual:=3; PreisHa:=2; PreisHw:=-1; Einw:=1000;
			end;
		5:begin	{ -2500 EW }
				Tempel:=-1; Hotels:=Wurf(3)+3; Kneipen:=Wurf(3)+3;
				{ -1 Tempel -> siehe St\"adtebeschreibung in "Das Land des Schwarzen Auges" }
				HandwI:=succ(Wurf(3)); HandwII:=Wurf(2); HandwIII:=Zero(pred(Wurf(2)));
				Gross:=Zero(Wurf(3)-2);
				HaendlI:=succ(Wurf(3)); HaendlII:=Wurf(2); HaendlIII:=Zero(pred(Wurf(2)));
				DienstI:=Wurf(2); DienstII:=Zero(Wurf(3)-2); Heilk:=succ(Wurf(3));
				Durch:=2; Markt:=8; Qual:=1; PreisHa:=0; PreisHw:=0; Einw:=2500;
			end;
		6:begin	{ -5000 EW }
				Tempel:=-1; Hotels:=Wurf(3)+5; Kneipen:=Wurf(3)+5;
				HandwI:=Wurf(3)+2; HandwII:=Wurf(3); HandwIII:=Zero(pred(Wurf(2)));
				Gross:=RangeRandom(2);
				HaendlI:=Wurf(3)+2; HaendlII:=succ(Wurf(3)); HaendlIII:=Wurf(2);
				DienstI:=succ(Wurf(2)); DienstII:=Wurf(2); Heilk:=Wurf(3)+3;
				Durch:=3; Markt:=12; Qual:=-1; PreisHa:=1; PreisHw:=1; Einw:=5000;
			end;
		7:begin	{ -10000 EW }
				Tempel:=-1; Hotels:=Wurf(6)+7; Kneipen:=Wurf(6)+7;
				HandwI:=Wurf(3)+4; HandwII:=Wurf(3)+2; HandwIII:=RangeRandom(2);
				Gross:=Wurf(3);
				HaendlI:=Wurf(3)+4; HaendlII:=Wurf(3)+2; HaendlIII:=Wurf(3);
				DienstI:=succ(Wurf(3)); DienstII:=Wurf(3); Heilk:=Wurf(6)+4;
				Durch:=3; Markt:=-1;	{ Markttag immer au\"ser an Feiertagen }
				Qual:=0; PreisHa:=2; PreisHw:=3; Einw:=10000
			end
	end;
	Einw:=Einw-(Einw shr 2)+Wurf(Einw shr 1);	{ +/- 25% }
end;

procedure Ausgabe_Bild;
var i,j:integer;
		x,y,l:short;
begin
  for i:=1 to xy do begin write('·');
		for j:=1 to xy do begin
			write(Ausfile," \\put(",pred(i)*32,',',pred(j)*32,"){\\usebox{\\",
							Bau[Dorf[i,j].Feld],"}}\n");
			if Dorf[i,j].Feld=f_Markt then begin
				Dorf[succ(i),j].Feld:=f_Leer; Dorf[i,succ(j)].Feld:=f_Leer;
				Dorf[succ(i),succ(j)].Feld:=f_Leer
			end;	{ Markt nimmt 2×2 Felder ein; darum nicht 4* ausgeben }
			if Dorf[i,j].num>0 then
				write(Ausfile,"  \\put(",pred(i)*32+15,',',pred(j)*32+15,
							"){\\makebox(0,0){",Dorf[i,j].num,"}}\n");
		end
	end; write(Ausfile," \\thicklines\n"); xy:=xy*32;
	while Weg<>nil do begin
	  l:=Weg^.l*32+Wurf(5); x:=Weg^.x*32; y:=Weg^.y*32;
		case Weg^.r of
			rechts:begin
							write(Ausfile," \\put(",x,',',y,"){\\line(1,0){",l,"}}\n");
							if l>xy shr 1 then
								write(Ausfile," \\put(",x,',',succ(y),"){\\line(1,0){",l,"}}\n");
						end;
			runter:begin
							write(Ausfile," \\put(",x,',',y,"){\\line(0,1){",l,"}}\n");
							if l>xy shr 1 then
								write(Ausfile," \\put(",succ(x),',',y,"){\\line(0,1){",l,"}}\n");
						end
		end;
		Weg:=Weg^.next
	end
end;

procedure Ausgabe_Text;
var i:integer;
		j,q,p:short;
		line,num,g,e,d:byte;
		bade,spez:boolean;

	function CheckOut(n:byte):boolean;
	begin
		CheckOut:=Aus_Leer or (n>0)
	end;

	procedure Ausgabe_TeX_Header(head:string);
	begin
		if num>1 then write(Ausfile,"  \\hline\n \\end{tabular}\n\\vfill\n{\\small\\sf DSA-Dorfgenerator V",Version," -- \\copyright\\ copyright 1995/96 by Henning Peters \\hfill E-Mail: faroul@beyond.hb.north.de -- Fido: 2:2426/3020.28}\n\\newpage\n");
		write(Ausfile,"{\\LARGE\\bf ",Name,"}\\\\[5pt]\n{\\bf (",Einw," Einwohner)}\\\\[15pt]\n \\begin{tabular}{|rcccc|}\n  \\hline\n  \\bf Nr. & \\bf Beschreibung & \\bf Besonderes & \\bf Qualit\"at & \\bf Preisniveau \\\\\n");
		if strlen(head)>1 then write(Ausfile,"  \\hline\\hline\n  \\multicolumn{5}{|c|}{\\large\\bf\\rule{0pt}{2ex} ",head,"}\\\\[3pt]\n");
		line:=1
	end;

	function Check_Vorh(t:t_Feld; g:byte):byte;
	var i,z:byte;
			j:integer;
	begin
		i:=Wurf(g); z:=i;
		repeat
			j:=sqr(i); if (Vorh[t] and j)<>0 then inc(i);
			if i>g then i:=1;
			if i=z then Vorh[t]:=0;
		until (Vorh[t] and j)=0;
		Vorh[t]:=Vorh[t] or j;
		Check_Vorh:=i
	end;

	procedure Aus_Hot_Kneip_Handw;
	begin
		if CheckOut(Hotels) then begin
			write(Ausfile,"  \\\hline\\hline\n  \\multicolumn{5}{|c|}{\\large\\bf\\rule{0pt}{2ex} Hotels und Gasth\"auser}\\\\\n");
	 		if Hotels>0 then begin
				write(Ausfile,"	\\multicolumn{5}{|c|}{\\small(GR=Gruppenschlafraum, EZ=Einzelzimmer,\n		DZ=Doppelzimmer)}\\\\[3pt]\n");
				for i:=1 to Hotels do begin
					q:=Range(Wurf(20)+Qual,20);
					p:=Range(Wurf(20)+PreisHa+c_QuaPreis[q],20);
					g:=Wurf(Dorf_Num); e:=RangeRandom(Dorf_Num shl 1);
					d:=RangeRandom(Dorf_Num shl 1);
					bade:=(Dorf_Num>2) and (RangeRandom(Dorf_Num shl 2)>Dorf_Num*3);
					spez:=(Dorf_Num>3) and (RangeRandom(Dorf_Num shl 2)>Dorf_Num*3);
					write(Ausfile,num:4," & ",g," GR"); inc(num); inc(line);
					if e>0 then write(Ausfile,", ",e," EZ");
					if d>0 then write(Ausfile,", ",d," DZ");
					write(Ausfile," & ");
					if bade then begin
						if spez then write(Ausfile,"Badem\"ogl.")
						else write(Ausfile,"Badem\"oglichkeit")
					end;
					if spez then begin
						if bade then write(Ausfile,", spez. Zimmerservice")
						else write(Ausfile,"spezieller Zimmerservice")
					end;
					write(Ausfile," & ");
					case q of
						1,2:	 write(Ausfile,"nobel und poliert");
						3..6:  write(Ausfile,"gut und sauber");
						7..14: write(Ausfile,"solide und sauber");
						15..18:write(Ausfile,"einfach, fraglich");
						19,20: write(Ausfile,"schlicht, schmuddelig")
					end;
					write(Ausfile," & ",PreisText(p),"\\\\\n")
				end
			end else write(Ausfile,"	\\multicolumn{5}{|c|}{keine}\\\\\n")
		end;
		if CheckOut(Kneipen) then begin
			write(Ausfile,"  \\\hline\\hline\n  \\multicolumn{5}{|c|}{\\large\\bf\\rule{0pt}{2ex} Kneipen und Sch\"anken}\\\\[3pt]\n");
			for i:=1 to Kneipen do begin
				q:=Range(Wurf(20)+Qual,20);
				p:=Range(Wurf(20)+PreisHw+c_QuaPreis[q],20);
				write(Ausfile,num:4," & "); inc(num); inc(line);
				case q of
					1,2:	 write(Ausfile,"Nobelrestaurant");
					3..6:  write(Ausfile,"gepflegtes Lokal");
					7..14: write(Ausfile,"saubere Sch\"anke");
					15..18:write(Ausfile,"einfache Kneipe");
					19,20: write(Ausfile,"schmierige Kaschemme")
				end;
				q:=Range(Wurf(20)+Qual,20); write(Ausfile," & ");
				spez:=(Dorf_Num>2) and (RangeRandom(Dorf_Num shl 2)>Dorf_Num*3);
				bade:=(Dorf_Num>2) and (RangeRandom(Dorf_Num shl 2)>Dorf_Num*3) and (not spez);
				if bade then write(Ausfile,"Musik und Gesang");
				if spez then write(Ausfile,"Tanz und Musik");
				write(Ausfile," & ",QualText(q)," & ",PreisText(p),"\\\\\n")
			end
		end;
		if CheckOut(HandwI+HandwII+HandwIII) then begin
			write(Ausfile,"  \\\hline\\hline\n  \\multicolumn{5}{|c|}{\\large\\bf\\rule{0pt}{2ex} Handwerker}\\\\[3pt]\n");
			if HandwI>0 then for i:=1 to HandwI do begin
				q:=Range(Wurf(20)+Qual,20); j:=Check_Vorh(f_HandwI,7);
				write(Ausfile,num:4," & ",c_HandwI[j]," & "); inc(num); inc(line);
				case q of
					1,2:	 write(Ausfile,"Spezialist, Wunschanfertigungen");
					3..6:  write(Ausfile,"Sonderanfertigungen");
					7..14: write(Ausfile,"solide Handwerksarbeiten");
					15..18:write(Ausfile,"einfache Arbeiten");
					19,20: write(Ausfile,"Pfuscher")
				end;
				if q<19 then q:=Range(Wurf(20)+Qual,20);
				p:=Range(Wurf(20)+PreisHw+c_QuaPreis[q],20);
				write(Ausfile," & ",QualText(q)," & ",PreisText(p),"\\\\\n")
			end;
			if line>30 then Ausgabe_TeX_Header("Handwerker");
			if HandwII>0 then for i:=1 to HandwII do begin
				q:=Range(Wurf(20)+Qual,20); j:=Check_Vorh(f_HandwII,23);
				write(Ausfile,num:4," & ",c_HandwII[j]," & "); inc(num); inc(line);
				case q of
					1,2:	 write(Ausfile,"Spezialist, Wunschanfertigungen");
					3..6:  write(Ausfile,"Sonderanfertigungen");
					7..14: write(Ausfile,"solide Handwerksarbeiten");
					15..18:write(Ausfile,"einfache Arbeiten");
					19,20: write(Ausfile,"Pfuscher")
				end;
				q:=Range(Wurf(20)+Qual,20); p:=Range(Wurf(20)+PreisHw+c_QuaPreis[q],20);
				write(Ausfile," & ",QualText(q)," & ",PreisText(p),"\\\\\n")
			end;
			if line>30 then Ausgabe_TeX_Header("Handwerker");
			if HandwIII>0 then for i:=1 to HandwIII do begin
				q:=Range(Wurf(20)+Qual,20); j:=Check_Vorh(f_HandwIII,12);
				write(Ausfile,num:4," & ",c_HandwIII[j]," & "); inc(num); inc(line);
				case q of
					1,2:	 write(Ausfile,"Spezialist, Wunschanfertigungen");
					3..6:  write(Ausfile,"Sonderanfertigungen");
					7..14: write(Ausfile,"solide Handwerksarbeiten");
					15..18:write(Ausfile,"einfache Arbeiten");
					19,20: write(Ausfile,"Pfuscher")
				end;
				q:=Range(Wurf(20)+Qual,20); p:=Range(Wurf(20)+PreisHw+c_QuaPreis[q],20);
				write(Ausfile," & ",QualText(q)," & ",PreisText(p),"\\\\\n")
			end;
			if HandwI+HandwII+HandwIII=0 then
				write(Ausfile,"	\\multicolumn{5}{|c|}{keine}\\\\\n")
		end;
		if line>30 then Ausgabe_TeX_Header(" ");
		if CheckOut(Gross) then begin
			write(Ausfile,"  \\\hline\\hline\n  \\multicolumn{5}{|c|}{\\large\\bf\\rule{0pt}{2ex} Gro\"sbetriebe}\\\\[3pt]\n");
			if Gross>0 then begin
				for i:=1 to Gross do begin j:=Check_Vorh(f_Gross,12);
					write(Ausfile,num:4," & ",c_Gross[j]," & "); inc(num); inc(line);
					q:=RangeRandom(20);
					case q of
						1,2:write(Ausfile,"Einzelverkauf");
						3,4:write(Ausfile,"w\"ochentlicher Verkauf");
						else write(Ausfile,"Verkauf nur an H\"andler/Betriebe")
					end;
					q:=Range(Wurf(20)+Qual,20); p:=Range(Wurf(20)+PreisHw+c_QuaPreis[q],20);
					write(Ausfile," & ",QualText(q)," & ",PreisText(p),"\\\\\n")
				end
			end else write(Ausfile,"	\\multicolumn{5}{|c|}{keine}\\\\\n")
		end
	end;

begin	{Ausgabe_Text}
	line:=1; num:=1; Ausgabe_TeX_Header(" ");
	if CheckOut(Markt) then begin
		write(Ausfile,"  \\hline\\hline\n  \\multicolumn{5}{|c|}{\\large\\bf\\rule{0pt}{2ex} Markttag}\\\\[3pt]\n  \\multicolumn{5}{|c|}{");
		if Markt>0 then write(Ausfile,Markt," mal im Monat")
		else if Markt<0 then write(Ausfile,"st\"andig, au\"ser an Feiertagen")
				 else write(Ausfile,"keiner");
		write(Ausfile,"}\\\\\n")
	end;
	if CheckOut(Tempel) then begin
		write(Ausfile,"  \\hline\\hline\n  \\multicolumn{5}{|c|}{\\large\\bf\\rule{0pt}{2ex} Tempel}\\\\[3pt]\n");
		if Tempel>0 then begin
			j:=Tempel shl 1;
			for i:=1 to Tempel do begin
				write(Ausfile,num:4," & ",c_Tempel[Range(Wurf(j),12)]," &&&\\\\\n");
				inc(num); inc(line)
			end;
		end else if Tempel<0 then begin
			write(Ausfile,"	\\multicolumn{5}{|c|}{",c_Siehe,"}\\\\\n"); Tempel:=Wurf(4)+2
		end else write(Ausfile,"	\\multicolumn{5}{|c|}{keine}\\\\\n");
	end;
	Aus_Hot_Kneip_Handw;
	if line>30 then Ausgabe_TeX_Header(" ");
	if CheckOut(HaendlI+HaendlII+HaendlIII) then begin
		write(Ausfile,"  \\\hline\\hline\n  \\multicolumn{5}{|c|}{\\large\\bf\\rule{0pt}{2ex} H\"andler}\\\\[3pt]\n");
		if HaendlI>0 then for i:=1 to HaendlI do begin
			q:=Range(Wurf(20)+Qual,20); p:=Range(Wurf(20)+PreisHw+c_QuaPreis[q],20);
			j:=Check_Vorh(f_HaendlI,3);
			write(Ausfile,num:4," & ",c_HaendlI[j]," & "); inc(num); inc(line);
			case q of
				1,2:	 write(Ausfile,"auch seltene Waren");
				3..6:  write(Ausfile,"gro\"se Auswahl");
				7..14: write(Ausfile,"\"ubliche Auswahl");
				15..18:write(Ausfile,"auch Gebrauchtwaren");
				19,20: write(Ausfile,"Tr\"odel und Ramsch")
			end;
			q:=(Range(Wurf(20)+Qual,20)+q)div 2;
			write(Ausfile," & ",QualText(q)," & ",PreisText(p),"\\\\\n")
		end;
		if line>30 then Ausgabe_TeX_Header("H\"andler");
		if HaendlII>0 then for i:=1 to HaendlII do begin
			q:=Range(Wurf(20)+Qual,20); p:=Range(Wurf(20)+PreisHw+c_QuaPreis[q],20);
			j:=Check_Vorh(f_HaendlII,8);
			write(Ausfile,num:4," & ",c_HaendlII[j]," & "); inc(num); inc(line);
			case q of
				1,2:	 write(Ausfile,"auch seltene Waren");
				3..6:  write(Ausfile,"gro\"se Auswahl");
				7..14: write(Ausfile,"\"ubliche Auswahl");
				15..18:write(Ausfile,"auch Gebrauchtwaren");
				19,20: write(Ausfile,"Tr\"odel und Ramsch")
			end;
			q:=(Range(Wurf(20)+Qual,20)+q)div 2;
			write(Ausfile," & ",QualText(q)," & ",PreisText(p),"\\\\\n")
		end;
		if line>30 then Ausgabe_TeX_Header("H\"andler");
		if HaendlIII>0 then for i:=1 to HaendlIII do begin
			q:=Range(Wurf(20)+Qual,20); p:=Range(Wurf(20)+PreisHw+c_QuaPreis[q],20);
			j:=Check_Vorh(f_HaendlIII,10);
			write(Ausfile,num:4," & ",c_HaendlIII[j]," & "); inc(num); inc(line);
			case q of
				1,2:	 write(Ausfile,"auch seltene Waren");
				3..6:  write(Ausfile,"gro\"se Auswahl");
				7..14: write(Ausfile,"\"ubliche Auswahl");
				15..18:write(Ausfile,"auch Gebrauchtwaren");
				19,20: write(Ausfile,"Tr\"odel und Ramsch")
			end;
			q:=(Range(Wurf(20)+Qual,20)+q)div 2;
			write(Ausfile," & ",QualText(q)," & ",PreisText(p),"\\\\\n")
		end;
		if HaendlI+HaendlII+HaendlIII=0 then
			write(Ausfile,"	\\multicolumn{5}{|c|}{keine}\\\\\n");
	end;
	if line>30 then Ausgabe_TeX_Header(" ");
	if CheckOut(DienstI+DienstII) then begin
		write(Ausfile,"  \\\hline\\hline\n  \\multicolumn{5}{|c|}{\\large\\bf\\rule{0pt}{2ex} Dienstleistungen}\\\\[3pt]\n");
		if DienstI>0 then for i:=1 to DienstI do begin
			q:=Range(Wurf(20)+Qual,20); p:=Range(Wurf(20)+PreisHw+c_QuaPreis[q],20);
			j:=Check_Vorh(f_DienstI,4);
			write(Ausfile,num:4," & ",c_DienstI[j]," & "); inc(num); inc(line);
			case q of
				1,2:	 write(Ausfile,"nur Sonderw\"unsche");
				3..6:  write(Ausfile,"auch Sonderw\"unsche");
				7..14: write(Ausfile,"solide und gut ausgef\"uhrt");
				15..18:write(Ausfile,"einfach, aber zufriedenstellend");
				19,20: write(Ausfile,"zweifelhaft")
			end;
			q:=(Range(Wurf(20)+Qual,20)+q)div 2;
			write(Ausfile," & ",QualText(q)," & ",PreisText(p),"\\\\\n")
		end;
		if line>30 then Ausgabe_TeX_Header("Dienstleistungen");
		if DienstII>0 then for i:=1 to DienstII do begin
			j:=Check_Vorh(f_DienstII,14);
			q:=Range(Wurf(20)+Qual,20); p:=Range(Wurf(20)+PreisHw+c_QuaPreis[q],20);
			write(Ausfile,num:4," & ",c_DienstII[j]," & "); inc(num); inc(line);
			case q of
				1,2:	 write(Ausfile,"nur Sonderw\"unsche");
				3..6:  write(Ausfile,"auch Sonderw\"unsche");
				7..14: write(Ausfile,"solide und gut ausgef\"uhrt");
				15..18:write(Ausfile,"einfach, aber zufriedenstellend");
				19,20: write(Ausfile,"zweifelhaft")
			end;
			q:=(Range(Wurf(20)+Qual,20)+q)div 2;
			write(Ausfile," & ",QualText(q)," & ",PreisText(p),"\\\\\n")
		end;
		if DienstI+DienstII=0 then write(Ausfile,"	\\multicolumn{5}{|c|}{keine}\\\\\n");
	end;
	if line>30 then Ausgabe_TeX_Header(" ");
	if CheckOut(Heilk) then begin
		write(Ausfile,"  \\\hline\\hline\n  \\multicolumn{5}{|c|}{\\large\\bf\\rule{0pt}{2ex} Heilkundige}\\\\[3pt]\n");
		if Heilk>0 then for i:=1 to Heilk do begin
				q:=Range(Wurf(20)+Qual,20); p:=Range(Wurf(20)+PreisHw+c_QuaPreis[q],20);
				j:=Check_Vorh(f_Heilk,4);
				write(Ausfile,num:4," & ",c_Heilk[j]," & "); inc(num); inc(line);
				case q of
					1,2:	 write(Ausfile,"studierter Medikus, Spezialist");
					3..6:	write(Ausfile,"bewanderter, guter Heiler");
					7..14: write(Ausfile,"erfahrener Heiler");
					15..18:write(Ausfile,"Wundheiler, Zahnrei\"ser");
					19,20: write(Ausfile,"Heilerfolg zweifelhaft")
				end;
				write(Ausfile," & ",QualText(q)," & ",PreisText(p),"\\\\\n")
			end
		else write(Ausfile,"	\\multicolumn{5}{|c|}{keine}\\\\\n");
	end;
	if line>28 then Ausgabe_TeX_Header(" ");
	if CheckOut(Durch) then begin
		write(Ausfile,"  \\\hline\\hline\n  \\multicolumn{5}{|c|}{\\large\\bf\\rule{0pt}{2ex} Durchfahrende H\"andler, Handwerker, K\"unstler etc.}\\\\[3pt]\n");
		if Durch>0 then begin
			for i:=1 to Durch shl 1 do begin
				if line>30 then Ausgabe_TeX_Header("Durchfahrende H\"andler, Handwerker, K\"unstler etc.");
				q:=Wurf(20); p:=Range(Wurf(20)+c_QuaPreis[q],20); j:=Check_Vorh(f_Durch,10);
				write(Ausfile," & ",c_Durch[j]," & "); inc(line);
				if j=4 then case Wurf(20) of
					1,2:write(Ausfile,"Feuerspucker/-schlucker");
					3..5:write(Ausfile,"Jongleure");
					6:write(Ausfile,"Hochseilakt");
					7,8:write(Ausfile,"Messerwerfer");
					9:write(Ausfile,"Entfesselungsk\"unstler");
					10:write(Ausfile,"Tanzb\"ar");
				end else if j=5 then case Wurf(10) of
					1,2:write(Ausfile,"nur S\"anger");
					3,4:write(Ausfile,"Lauten und Trommel");
					5,6:write(Ausfile,"Fl\"otenspiel");
					7,8:write(Ausfile,"Leierkasten");
					9,10:write(Ausfile,"Harfe")
				end;
				write(Ausfile," & ",QualText(q)," & ",PreisText(p),"\\\\\n")
			end;
			write(Ausfile,"	& \\multicolumn{4}{c|}{\\qquad Weiterhin ");
			case Durch of
				1:write(Ausfile,"gelegentlich Durchfahrende");
				2:write(Ausfile,"h\"aufig Durchfahrende");
				else write(Ausfile,"st\"andig Durchreisende, au\"serdem Stra\"senh\"andler")
			end; write(Ausfile,"}\\\\\n")
		end else write(Ausfile,"	\\multicolumn{5}{|c|}{keine}\\\\\n");
	end;
	write(Ausfile,"  \\hline\n")
end;

procedure Init_Vars;
var i,j:integer;
		t:t_Feld;
begin
  for i:=1 to c_Groesse do for j:=1 to c_Groesse do begin
		Dorf[i,j].Feld:=f_Leer; Dorf[i,j].num:=0 end;
	Bau[f_Haus1]:="HausEins"; Bau[f_Haus2]:="HausZwei"; Bau[f_Haus3]:="HausDrei";
	Bau[f_Haus4]:="HausVier"; Bau[f_Haus5]:="HausFuenf"; Bau[f_Tempel1]:="TempelEins";
	Bau[f_Tempel2]:="TempelZwei"; Bau[f_Hotel1]:="HotelEins";
	Bau[f_Hotel2]:="HotelZwei"; Bau[f_Hotel3]:="HotelDrei";
	Bau[f_Kneipe1]:="KneipeEins"; Bau[f_Kneipe2]:="KneipeZwei";
	Bau[f_HandwI]:="HandwI"; Bau[f_HandwII]:="HandwII"; Bau[f_HandwIII]:="HandwIII";
	Bau[f_Gross]:="Gross"; Bau[f_HaendlI]:="HaendlI"; Bau[f_HaendlII]:="HaendlII";
	Bau[f_HaendlIII]:="HaendlIII"; Bau[f_DienstI]:="DienstI";
	Bau[f_DienstII]:="DienstII"; Bau[f_Heilk]:="Heilk"; Bau[f_Markt]:="Markt";
	Bau[f_Teich]:="Teich"; Bau[f_Baum1]:="BaumEins"; Bau[f_Baum2]:="BaumZwei";
	Bau[f_Baum3]:="BaumDrei"; Bau[f_Leer]:="Leer";
	for t:=f_Haus1 to f_Durch do Vorh[t]:=0;
end;


begin	{ Main }
	write("\f\n			\e[1mDSA Dorfgenerator\e[0m V",Version,"\n\n		© copyright 1995/96 by Henning Peters\n	E-Mail: faroul@beyond.hb.north.de\n\n	1) bis   100 Einwohner\n	2) bis   250 Einwohner\n	3) bis   500 Einwohner\n	4) bis  1000 Einwohner\n	5) bis  2500 Einwohner\n	6) bis  5000 Einwohner\n	7) bis 10000 Einwohner\n\n	(Größe 1-4 mit grafischer Ausgabe im LaTeX-Format)\n\nWelche Größenklasse hat das Dorf? ");
	{ \e=Esc=chr(27); \f=chr(12)=ClearScreen; \e[1m=BoldOn, \e[0m=BoldOff,
		\a=Attention=chr(7); \n=Linefeed }
	str:=AllocString(60); readln(str); Dorf_Num:=str_int(str);
	if Dorf_Num<1 then Dorf_Num:=1 else if Dorf_Num>7 then Dorf_Num:=7;
	if Dorf_Num>4 then write("\nStädte dieser Größse sind auch im Buch \"Das Land des Schwarzen Auges\"\noder im \"Lexikon des Schwarzen Auges\" beschrieben.\n");
	Name:=AllocString(40); selfseed;	{ Zufallsgenerator starten }
	repeat ok:=true;
		write("\nWie soll das Dorf heißen (keine Leerzeichen)? "); readln(Name);
		if Dorf_Num<5 then begin
			strcpy(str,Name); strcat(str,".pic");
			if reopen(str,Ausfile) then begin
				close(Ausfile); ok:=false
			end
		end;
		strcpy(str,Name); strcat(str,".tex");
		if reopen(str,Ausfile) then begin
			close(Ausfile); ok:=false
		end;
		strcpy(str,Name); strcat(str,".data");
		if reopen(str,Ausfile) then begin
			close(Ausfile); ok:=false
		end;
		if not ok then begin
			write("\n\aAchtung! Zum Dorf `",Name,"' existieren bereits Dateien!\n	 Überschreiben (j/n)? ");
			readln(str); ok:=tolower(str[0])='j'
		end
	until ok;
	write("\nSollen nicht existierende Betriebe ausgegeben werden (j/n)? ");
	readln(str); Aus_Leer:=tolower(str[0])='j';
	write("\nWollen Sie die Dorfdaten selber eingeben (j/n)? ");
	readln(str); ok:=tolower(str[0])='j';
	Init_Vars;
	if ok then Eingabe else Generate_Dorf;
	strcpy(str,Name); strcat(str,".tex");
	if open(str,Ausfile,1024) then begin
		Ausgabe_Text; close(Ausfile);
	end else write("\n\n	\aKonnte `",str,"' nicht zum Schreiben öffnen!\n");
	xy:=6+Einw div 83; strcpy(str,Name); strcat(str,".data");
	if open(str,Ausfile,1024) then begin
  	write(Ausfile,"\\def\\PicSize{",xy*32+6,"} \\def\\un{",15.5/xy:1:2,"pt}\n");
		close(Ausfile);
	end else write("\aKonnte `",str,"' nicht zum Schreiben öffnen!\n");
	if Dorf_Num<5 then begin
		Generate_Bild;
		strcpy(str,Name); strcat(str,".pic");
		if open(str,Ausfile,1024) then begin
			Ausgabe_Bild; close(Ausfile);
		end else write("\n\n	\aKonnte `",str,"' nicht zum Schreiben öffnen!\n")
	end;
	write("Ok.");
	if (Dorf_Num>2) and (Dorf_Num<5) then
		write("\n\n	Bei einem Dorf dieser Größe ggf. BigLaTeX benutzen!\n");
	write("\n\n")
end.

