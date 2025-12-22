{
ex: set ts=2 ai
}
program Leute;	{ Generiert Liste von Leuten, zum Kampf }

{$I "include:utils/stringlib.i"}
{$I "include:utils/random.i"}
{$I-}

type t_Liste=record
			Name:string;
			next:^t_Liste
		end;

var aus:text;
		c:char;
		Liste:t_Liste;

function str_int(str:string):integer;
var i,j:integer;
		l,n:short;
begin
	i:=0; l:=pred(strlen(str));
	for j:=0 to l do begin
		n:=ord(str[j])-48;
		if (n<0) or (n>9) then str_int:=i;
		i:=i*10+n
	end;
	str_int:=i
end;

function int_str(i:integer):string;	{ i=0..99 }
var str:string;
begin str:=AllocString(4);
	if i<10 then begin
		str[0]:=chr(i+48); str[1]:='\0'
	end else begin
		str[0]:=chr(i div 10+48); str[1]:=chr(i mod 10+48); str[2]:='\0'
	end;
	int_str:=str
end;

function min(a,b:integer):integer;
begin if a<b then min:=a else min:=b end;

function max(a,b:integer):integer;
begin if a<b then max:=b else max:=a end;

procedure HandEingabe;
var waffe,name,str:string;
		c,at,pa,rs,le,tp:integer;
begin
	c:=1; name:=AllocString(50); str:=AllocString(50); waffe:=AllocString(50);
	write("\nEnde mit Name=*\n");
	if open("RAM:Gegner.tex",aus,1024) then begin
		write(aus,"\\begin{tabular}{lr@{/}lllll}\n\\bf Name & \\bf AT&\\bf PA & \\bf RS & \\bf Waffe & \\bf TP & \\bf LE\\\\\n");
		repeat
			write('\n',c,":\n Name:  "); readln(name); inc(c);
			if not streq(name,"*") then begin
				write(" AT:    "); readln(str); at:=str_int(str);
				write(" PA:    "); readln(str); pa:=str_int(str);
				write(" RS:    "); readln(str); rs:=str_int(str);
				write(" Waffe: "); readln(waffe); 
				write(" TP: W6+"); readln(str); tp:=str_int(str);
				write(" LE:    "); readln(str); le:=str_int(str);
				write(aus,' ',name," &",at:3," &",pa:3," &",rs:3," & ",waffe," & W$_6$+",tp," & ",le," \\rule[-2pt]{70mm}{.5pt} \\\\[3mm]\n")
			end
		until streq(name,"*");
		write(aus,"\\end{tabular}\n"); close(aus);
		write("\nDatei `RAM:Gegner.tex' fertig.\n\n")
	end else write("\nKonnte `RAM:Gegner.tex' nicht öffnen!\n\n");
end;

procedure AutoGen;
var waffe,name,str:string;
		anz,i,q,w,c,brs,rsp,atp,pap,lep,bat,bpa,ble:integer;
		waff,treff:array[0..4]of string;
begin
	str:=AllocString(60);
	write("\nBis zu 5 verschiedene Waffen eingeben (Default=Schwert/W6+4, *=Ende):\n"); i:=0;
	repeat
		write(succ(i),". Waffe: "); readln(str);
		if not streq(str,"*") then begin
			waff[i]:=strdup(str);
			write("	'",str,"' hat TP=  W6+\b\b\b\b\b"); readln(str); q:=max(1,str_int(str));
			write("\eM	'",waff[i],"' hat TP=",q:2,"W6+"); readln(str); w:=str_int(str);
			strcpy(str," W$_6$+"); str[0]:=chr(q+48); strcat(str,int_str(w));
			treff[i]:=strdup(str); inc(i);
		end
	until streq(str,"*") or (i=5);
	if i=0 then begin waff[0]:="Schwert"; treff[0]:="W$_6$+4"; anz:=0 end
	else anz:=pred(i);
	write("\nAT der Gegner von:    bis:\b\b\b\b\b\b\b"); readln(str);
	bat:=str_int(str);
	write("\eMAT der Gegner von: ",bat," bis: \b "); readln(str);
	atp:=max(str_int(str),succ(bat))-bat;
	write("\nPA der Gegner von:    bis:\b\b\b\b\b\b\b"); readln(str);
	bpa:=str_int(str);
	write("\eMPA der Gegner von: ",bpa," bis: \b "); readln(str);
	pap:=max(str_int(str),succ(bpa))-bpa;
	write("\nRS der Gegner von:   bis:\b\b\b\b\b\b"); readln(str);
	brs:=str_int(str);
	write("\eMRS der Gegner von: ",brs," bis: "); readln(str);
	rsp:=max(str_int(str),brs)-brs;
	write("\nLE der Gegner von:    bis:\b\b\b\b\b\b\b"); readln(str);
	ble:=str_int(str);
	write("\eMLE der Gegner von: ",ble," bis: \b "); readln(str);
	lep:=max(str_int(str),ble+5)-ble;
	write("\nAnzahl der Gegner: "); readln(str); c:=str_int(str);
	if open("RAM:Gegner.tex",aus,1024) then begin
		write(aus,"\\begin{tabular}{r@{.~}r@{/}lllll}\n\\bf Name & \\bf AT&\\bf PA & \\bf RS & \\bf Waffe & \\bf TP & \\bf LE\\\\\n");
		for i:=1 to c do begin
			q:=rangerandom(atp); w:=min(bat+q,bpa+rangerandom(pap)); { immer PA < AT }
			write(aus,i:3," &",bat+q:3," &",w:3," &",brs+rangerandom(rsp):2," & ",waff[rangerandom(anz)]," & ",treff[rangerandom(anz)]," &",ble+rangerandom(lep):3," \\rule[-2pt]{70mm}{.5pt} \\\\[3mm]\n")
		end;
		write(aus,"\\end{tabular}\n"); close(aus);
		write("\nDatei `RAM:Gegner.tex' fertig.\n\n")
	end else write("\nKonnte `RAM:Gegner.tex' nicht öffnen!\n\n");
end;

begin
	write("\f\n	\e[1mGegnerliste\e[0m\n\n\e[33mH\e[31mandeingabe oder \e[33mA\e[31mutogenerierung? ");
	readln(c);
	if tolower(c)='h' then HandEingabe else AutoGen;
end.
