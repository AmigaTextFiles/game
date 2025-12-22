/*
 * LangTrans.m ; translate a spell name into magical sounding words
 */

/**** Note
* This file is very new and experimental
* I dont actually use it yet.  As the translate function is rather
* processor hungry you sould probably call it once for each spell
* when it is being defined, rather than when the spell is cast.
* Define a new property p_sGarbled.
****/

/***** Create some properties
* p_trS is the SOURCE string
* p_trD is the DESTINATION string
*****/

define tp_magic p_trS CreateStringProp().
define tp_magic p_trD CreateStringProp().


/*** Create Standard Translate Table
* You should probably have one for each "language"
***/

define tp_magic langStandard CreateThing(nil).
/*
langStandard@p_trS:=" ,ar,au,bless,blind,bur,cu,de,en,light,lo,"
	    "mor,move,ness,ning,per,ra,re,son,tect,tri,ven,"
	    "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z".
langStandard@p_trD:=" ,abra,kada,fido,nose,mosa,judi,oculo,unso,dies,hi,"
	    "zak,sido,lacri,illa,duda,gru,candus,sabru,infra,cula,nofo,"
	    "a,b,q,e,z,y,o,p,u,y,t,r,w,i,a,s,d,f,g,h,j,z,x,n,l,k".
*/

langStandard@p_trS:=" ,ab,al,ar,br,ch,er,ee,ea,gh,ing,in,ng,oa,oo,or,qu,so,"
	"st,th,us,a,b,c,d,e,f,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z".
langStandard@p_trD:=" im,oar,os,me,ab,us,ill,ya,pr,ath,fa,gan,ur,eh,ka,li,"
	"ra,zok,an,er,o,z,g,h,u,c,j,y,m,n,p,k,l,e,q,t,v,z,x,i,s,b,r,a,w".


/**** Now the routine to do the translation
*The translated, or mangled string is built up piece by piece,
*by replacing letter clusters in the spell name, with another.
*The letter clusters are definined in p_trS, seperated by commas.
*The cluster replacements are definined in p_trD, in the same order.
*
*Note: when there are clusters beginning with the same letters
*as longer clusters, then longer clusters MUST appear before the
*shorter cluster.  i.e. "ab" appears before "a".
*
*Note: unmatched letter clusters will be deleted, hence the
* one-letter clusters.
*****/

define tp_magic proc langTranslate(string spellName;thing ta)string:
  string mangled,temp,c,trS,trD;
  int i,l;

  mangled:="";
  trS:=ta@p_trS;
  trD:=ta@p_trD;

  while spellName~="" do
    i:=0;
    c:=SelectWord(trS,i);
    while c~="" do
      l:=Length(c);
      temp:=SubString(spellName,0,l);
      if temp=c then
	mangled:=mangled+SelectWord(trD,i);
	c:="";
      else
	i:=i+1;
	c:=SelectWord(trS,i);
      fi;
    od;
    spellName:=SubString(spellName,l,100);
  od;
  mangled
corp.


/****
****/

define tp_magic proc utility AddMangledName(thing spell, lang)void:
  if lang~=nil then
    spell@p_sMangled:=langTranslate(FormatName(spell@p_sName),lang);
  else
    spell@p_sMangled:=langTranslate(FormatName(spell@p_sName),langStandard);
  fi;
corp.


/**** End of file ****/

