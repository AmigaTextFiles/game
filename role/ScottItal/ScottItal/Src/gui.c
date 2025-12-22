struct EasyStruct NoGFX =
{
   sizeof(struct EasyStruct),0,
   "Problemi con la Grafica",
   "%s",
   "Ben fatto"
};

struct EasyStruct NoScreen =
{
   sizeof(struct EasyStruct),0,
   "Impossibile aprire lo schermo",
   "Non posso aprire il rechiesto PublicScreen.\nVerrà usato il default PubScreen.",
   "Giusto"
};

struct EasyStruct NoPens =
{
   sizeof(struct EasyStruct),0,
   "Problema Allocazione Colori",
   "Non posso allocare abbastanza penne libere.\nLa grafica verrà esclusa!",
   "Che peccato"
};

struct EasyStruct ClosePub =
{
   sizeof(struct EasyStruct),0,
   "Public Screen Request",
   "Prego chiudi tutte le finestre sullo schermo.",
   "Naturalmente"
};

struct EasyStruct NoProp =
{
   sizeof(struct EasyStruct),0,
   "Text Font Problema Informazione",
   "'%s' è un PROPORTIONALE font.\nPrego usa un NON PROPORZIONALE font!",
   "Naturalmente"
};

struct EasyStruct GameInfo =
{
   sizeof(struct EasyStruct),0,
   "Informazioni gioco",
   "%s",
   "Molto interessante"
};

struct EasyStruct BigWins =
{
   sizeof(struct EasyStruct),0,
   "Sistema Problemi Report",
   "Le finestre sono troppo grandi per lo schermo!\nProva il TANDYFLAG-ToolType (-t),\nUsa un font più piccolo o\napri uno schermo più grande :-)",
   "Controllo questo"
};

struct EasyStruct Quit =
{
   sizeof(struct EasyStruct),0,
   "Request di conferma",
   "Vuoi veramente uscire %s?",
   "Si|No"
};

struct EasyStruct About =
{
   sizeof(struct EasyStruct),0,
   "Informazione molto importante",
   "AMIGA SCOTT-Free V1.90, 1996-2002\n© Andreas Aumayr, Weidenweg 22\nA-4209 Engerwitzdorf, AUSTRIA\nE-Mail: anden@gmx.at\n\nBasato su SCOTT-Free per UNIX\n© Swansea University Comp. Soc.\nTraduzione italiana di Betori Alessandro",
   "Invierò una cartolina ad Andreas"
};

struct EasyStruct NoMem =
{
   sizeof(struct EasyStruct),0,
   "Sistema Problema Report",
   "Memoria esaurita!\nUscita.",
   "Capito"
};

struct EasyStruct Library =
{
   sizeof(struct EasyStruct),0,
   "Sistema Problema Report",
   "Impossibile aprire\n'%s-Library'",
   "Capito"
};

struct EasyStruct FError =
{
   sizeof(struct EasyStruct),0,
   "DOS Problema Report",
   "Impossibile leggere Adventure-Datafile\n'%s'",
   "Capito"
};

struct EasyStruct ConFail =
{
   sizeof(struct EasyStruct),0,
   "Sistema Problema Report",
   "Fallita apertura Console-Finestra\n'%s'",
   "Capito"
};

struct NewMenu newmenu[] =
{
   {
      NM_TITLE,"SCOTT-Free",NULL,0,0,NULL
   },
   {
      NM_ITEM,"Circa","?",0,0,NULL
   },
   {
      NM_ITEM,NM_BARLABEL,NULL,0,0,NULL
   },
   {
      NM_ITEM,"Datafile ...","D",0,0,NULL
   },
   {
      NM_ITEM,NM_BARLABEL,NULL,0,0,NULL
   },
   {
      NM_ITEM,"Aiuto","H",0,0,NULL
   },
   {
      NM_ITEM,NM_BARLABEL,NULL,0,0,NULL
   },
   {
      NM_ITEM,"Fine","Q",0,0,NULL
   },
   {
      NM_TITLE,"Avventura",NULL,0,0,NULL
   },
   {
      NM_ITEM,"Informazioni Gioco","G",0,0,NULL
   },
   {
      NM_ITEM,NM_BARLABEL,NULL,0,0,NULL
   },
   {
      NM_ITEM,"Ricarica ...","R",0,0,NULL
   },
   {
      NM_ITEM,"Memorizza ...","S",0,0,NULL
   },
   {
      NM_ITEM,NM_BARLABEL,NULL,0,0,NULL
   },
   {
      NM_ITEM,"Ricomincia","N",0,0,NULL
   },
   {
      NM_TITLE,"Comandi",NULL,0,0,NULL
   },
   {
      NM_ITEM,"Guarda","L",0,0,NULL
   },
   {
      NM_ITEM,"Inventario","I",0,0,NULL
   },
   {
      NM_ITEM,"Prendi tutto","A",0,0,NULL
   },
   {
      NM_ITEM,NM_BARLABEL,NULL,0,0,NULL
   },
   {
      NM_ITEM,"Punteggio","C",0,0,NULL
   },
   {
      NM_TITLE,"Preferenze",NULL,0,0,NULL
   },
   {
      NM_ITEM,"Grafica","P",CHECKIT|MENUTOGGLE|CHECKED,0,NULL
   },
   {
      NM_ITEM,"Parlato","E",CHECKIT|MENUTOGGLE,0,NULL
   },
   {
      NM_END,NULL,0,0,NULL
   },
};


