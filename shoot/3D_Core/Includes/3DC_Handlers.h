/************************************/
/*** Object Prototypes & Handlers ***/
/*** Copyright (c) J.Gregory 1996 ***/
/***     Version 1.32 11/03/98    ***/
/************************************/

/***********************************/
/*** Object Class Prototypes etc ***/
/***********************************/

/* NOTE - Extra fields must be added after flags field
          or after HP struct if damage flag set.

   Active Object Handlers ID Range  -> 500000 to 599999
   Passive Object handlers ID Range -> 600000 to 699999

*/

/*****************************/
/*** Viewpoint Definitions ***/
/*****************************/

struct VPData {                           /* Extended Viewpoint Data     */
  LONG DataSize;                          /* Size of this structure      */
  LONG Flags;                             /* Flags                       */
  struct HitPoints HP;                    /* Viewpoints Hit Points       */
  struct WObject *LastProj;               /* Last Projectile Fired ptr   */
  LONG LastHP;                            /* Last Hit points Total       */
  LONG FlashDur;                          /* VP Hit Flash Timer          */
  LONG NextShot;                          /* Cycle Time until next Shot  */
  WORD ViewHead;                          /* View Heading (for sideslip) */
  WORD LastHead;                          /* Heading from prior frame    */
  };

WORD    VPTemplate(LONG x,LONG y,LONG h, LONG head); /* VP class builder */
void    VPMove(struct WObject *wob);      /* VP Movement handler         */

void    VPScreenFlash(void);
void    VPHandleKeys(LONG *spd, WORD *head);
void    VPHandleMove(void);
void    VPHandleFire(void);

/*************************/
/*** Gun Turret (Live) ***/
/*************************/

struct GunTurData {                       /* Extended Gun Turret Data   */
  LONG DataSize;                          /* Size of this structure     */
  LONG Flags;                             /* Flags                      */
  struct HitPoints HP;                    /* Turret HitPoints           */
  LONG LastLook;                          /* Last LOS Check Time        */
  LONG LastFire;                          /* Last Fire Event Time       */
  WORD State;                             /* Private GT State Tracking  */
  WORD Pad;                               /* Must be multiple of 4 long */
  };

#define           HDLRGUNTURID  500000    /* Handler Binding ID         */
struct WObject   *GunTurTemplate(void);
void              GunTurMove(struct WObject *wob);

/******************************/
/*** Bullet Definitions Etc ***/
/******************************/

struct BulletData {                       /* Extended Bullet Data      */
  LONG    DataSize;                       /* Size of this structure    */
  LONG    Flags;                          /* Flags                     */
  struct  HitPoints HP;                   /* Bullets hit points        */
  WORD    LifeTime;                       /* Life time in VBlanks      */
  struct  WObject *Parent;                /* Parent Object Pointer     */
  WORD    Pad;                            /* Pad to Longword multiple  */
  };

#define HDLRBULLETID      500100          /* Handler Binding ID's       */
#define HDLRFIREBOLTID    500101
#define HDLRPLASBOLTID    500102

struct  WObject *Bullet   = NULL;         /* Ptr to bullet base classes */
struct  WObject *FireBolt = NULL;
struct  WObject *PlasBolt = NULL;

WORD    BulletTemplate(void);             /* Bullet base class builders */
void    BulletMove(struct WObject *wob);  
WORD    BulletColl(struct WObject *me, struct WObject *wob);

WORD    FireBoltTemplate(void);
void    FireBoltMove(struct WObject *wob);
WORD    FireBoltColl(struct WObject *me, struct WObject *wob);

WORD    PlasBoltTemplate(void);
void    PlasBoltMove(struct WObject *wob);
WORD    PlasBoltColl(struct WObject *me, struct WObject *wob);

/****************************************/
/*** Small Red/Blue Explosions (Live) ***/
/****************************************/

struct SRExpData {
  LONG DataSize;
  LONG Flags;
  LONG Time;
  LONG Frame;
  };

#define HDLRSREXPID       500200
#define HDLRSBEXPID       500201
struct  WObject *SRExp = NULL;
struct  WObject *SBExp = NULL;
WORD    SRExpTemplate(void);
WORD    SBExpTemplate(void);
void    SRExpMove(struct WObject *wob);

/*******************************/
/*** Constant Sound Handlers ***/
/*******************************/

struct ContSndData {
  LONG DataSize;
  LONG Flags;
  WORD Handle;
  WORD pad;
  };
  
#define HDLRCONTSNDID 500300
struct  WObject *ContSnd = NULL;
struct  WObject *ContSndTemplate(void);
void             ContSndMove(struct WObject *wob);

/****************************/
/*** Passive Mine Handler ***/
/****************************/

#define HDLRMINE1ID   600000
WORD Mine1(struct WObject *me, struct WObject *wob);

/***********************************/
/*** Build Template Objects etc. ***/
/***********************************/

/* returns -1 if failed otherwise 0 */

WORD C3D_BuildTemplates(void) {
  WORD ret=0;
  struct WObject *wob;

  /*** Build Templates & Register Active Handlers ***/

  if(!ret) ret = BulletTemplate();
  if(!ret) ret = C3D_RegHInfo(HDLRBULLETID,0L,"Basic Bullet Thing",Bullet);

  if(!ret) ret = FireBoltTemplate();
  if(!ret) ret = C3D_RegHInfo(HDLRFIREBOLTID,0L,"FireBolt",FireBolt);

  if(!ret) ret = PlasBoltTemplate();
  if(!ret) ret = C3D_RegHInfo(HDLRPLASBOLTID,0L,"Plasma Bolt",PlasBolt);

  if(!ret) ret = SRExpTemplate();
  if(!ret) ret = C3D_RegHInfo(HDLRSREXPID,0L,"Small Red Explosion",SRExp);

  if(!ret) ret = SBExpTemplate();
  if(!ret) ret = C3D_RegHInfo(HDLRSBEXPID,0L,"Small Blue Explosion",SBExp);

  if(!ret) wob = GunTurTemplate();
  if(wob)  ret = C3D_RegHInfo(HDLRGUNTURID,0L,"Gun Turret",wob);
      else ret = -1;

  if(!ret) wob = ContSndTemplate();
  if(wob)  ret = C3D_RegHInfo(HDLRCONTSNDID,
                              HDLRCONTSNDID+99,
                              "Continuous Sound",wob);
      else ret = -1;

  /*** Register Passive Object Handlers ***/

  if(!ret) ret = C3D_RegHInfo(HDLRMINE1ID,0L,"Passive Mine 1",&Mine1);

  return ret;
  } 



/************************************/
/*** Clear Template Base Pointers ***/
/************************************/

/* Template struct themselves cleared by C3D_ClearObjects()
   this function called by FLUSH script command
*/

void C3D_ClearTemplateBases(void) {
  C3D_FreeHInfo();                    /* Clear Handlers Database */
  VP       = NULL;
  Bullet   = NULL;
  SRExp    = NULL;
  SBExp    = NULL;
  FireBolt = NULL;
  }



/******************************/
/*** Build ViewPoint Object ***/
/******************************/

/* Note VP template called by INITVP command */

WORD VPTemplate(LONG x, LONG y, LONG h, LONG head) {
  WORD idx;
  struct VPData *vpd;

  vpd = AllocVec(sizeof(struct VPData), MEMF_PUBLIC | MEMF_CLEAR);
  if(vpd == NULL) {
    printf("Could not allocate RAM for veiwpoint data\n");
    return -1;
    }

  idx = C3D_FindFreeObject();
  if(idx == -1) {
    printf("No Free Objects for Viewpoint\n");
    FreeVec(vpd);
    return -1;
    }

  VP = &WObject[idx];
  VP->Wx        = x;
  VP->Wy        = y;
  VP->Height    = h;
  VP->Heading   = head;
  VP->Radius    = 2048;
  VP->Size      = 512;
  VP->Speed     = 2560;
  VP->MovFunc   = &VPMove;
  VP->ColFunc   = NULL;
  VP->Flags     = WOBMOVED;
  VP->ID        = 0;
  VP->ObjDef[0] = 0;
  VP->ObjDef[1] = 0;
  VP->ObjDef[2] = 0;
  VP->ObjDef[3] = 0;
  VP->Data      = vpd;

  vpd->DataSize     = sizeof(struct VPData);
  vpd->Flags       |= HDLRFLG_DAMAGE;       /* Object has damage struct  */
  vpd->HP.TotHP     = 1000;                 /* Totals Hitpoints          */
  vpd->HP.QuadHP[0] = 400;                  /* Hitpoints for each side   */
  vpd->HP.QuadHP[1] = 400;
  vpd->HP.QuadHP[2] = 400;
  vpd->HP.QuadHP[3] = 400;
  vpd->HP.Damage    = 1;                    /* Damage dealt in collision */
  vpd->LastHP       = vpd->HP.TotHP;
  vpd->FlashDur     = 0;
  vpd->NextShot     = 0;
 
  return 0;
  }

/*** Viewpoints movement handler ***/

void VPMove(struct WObject *vpt) {
  char str[80];
  struct VPData *vpd = VP->Data;

  VPScreenFlash();
  VPHandleKeys(&VP->Speed, &VP->Heading);
  VPHandleMove();
  VPHandleFire();

  /* Display Stuff */
  
  sprintf(str,"Frame Delay:%02ld  ",FrameDelay);
  Move(CPRPort,10,10);
  Text(CPRPort,str,strlen(str));
 
  sprintf(str,"X:%06ld Y:%06ld  ",VP->Wx,VP->Wy);
  Move(CPRPort,10,20);
  Text(CPRPort,str,strlen(str));
  
  sprintf(str,"HP-> T:%d 1:%d 2:%d 3:%d 4:%d  ",
              vpd->HP.TotHP,
              vpd->HP.QuadHP[0],
              vpd->HP.QuadHP[1],
              vpd->HP.QuadHP[2],
              vpd->HP.QuadHP[3]);
              
  Move(CPRPort,10,30);
  Text(CPRPort,str,strlen(str));
  
  }


/*** Handle VP Hit Screen Flash ***/

void VPScreenFlash(void) {
  struct VPData *vpd = VP->Data;

  if(vpd->LastHP != vpd->HP.TotHP) vpd->FlashDur+=16;
  vpd->LastHP = vpd->HP.TotHP;
  
  if(vpd->FlashDur>0) {
    CurColTran = ColTran64;
    vpd->FlashDur-=FrameDelay;
    }
  else CurColTran = NULL;

  }


/*** Handle User Movement Keypresses ***/

void VPHandleKeys(LONG *spd, WORD *head) {  
  WORD hs,s=0,h=0;
  struct VPData *vpd = VP->Data;
  
  /** Handle Movement Keys **/

  vpd->ViewHead=-1;
  vpd->LastHead=VP->Heading;
  *spd=0;

  if(ASM_KeyStatus(C3D_Keys,C3DPrefs->KeyAct2)) { s=1260; hs=2; }  
  else { s=840; hs=1; }

  if(ASM_KeyStatus(C3D_Keys,C3DPrefs->KeyFwd)) *spd=s; 
  if(ASM_KeyStatus(C3D_Keys,C3DPrefs->KeyBak)) *spd=0-s;

  if(ASM_KeyStatus(C3D_Keys,C3DPrefs->KeyLft)) h-=1; 
  if(ASM_KeyStatus(C3D_Keys,C3DPrefs->KeyRgt)) h+=1; 


  if(ASM_KeyStatus(C3D_Keys,C3DPrefs->KeySide) && h) {
    vpd->ViewHead=*head;
    if(*spd<0) h=0-h;
    if(*spd) *head+=(h<<7); else { *head+=(h<<8); *spd=640; }
    }
  else *head += (h * (FrameDelay<<hs));

  if(*head < 0)    *head+=1024;
  if(*head > 1023) *head-=1024;

  if(vpd->ViewHead<0) vpd->ViewHead=*head;
  }


/*** Handle Actual Movement ***/

void VPHandleMove(void) {
  LONG lastx,lasty,ang;
  WORD col,n,zone;
  struct VPData  *vpd = VP->Data;
  struct WObject *wob;
  struct ColArea *coa;

  lastx = VP->Wx;                             /* Record current location  */
  lasty = VP->Wy;

  if(VP->Speed != 0) C3D_MoveWOB(VP,0);
          
  col=C3D_CheckCollision(VP,vpd->LastProj);   /* Check for collision      */
  if(col<=-2) {                               /* Restore old location -   */
    VP->Wx = lastx;                           /* as required              */
    VP->Wy = lasty;
    }

  /** Handle Glancing Collision **/
  
  if(col<=-2) {
    n=0;
    while(ColWork->Ret[n] && n<41) {

      /** Glancing WObject Collision **/

      if(ColWork->Ret[n]==3) {
        wob=(struct WObject *) ColWork->Ret[n+1]; n=wob->ActObj;
        ang=ASM_FindAngle(0,0,ActObj[n].Rx,ActObj[n].Ry,HP_TanTab);

        n=0;
        if(VP->Speed>0) {
          if(ang<=256) { VP->Heading += 128; n=1; }
          if(ang>=768) { VP->Heading -= 128; n=1; }
          }
        else {
          if(ang>256 && ang<=512) { VP->Heading -= 128; n=1; }
          if(ang<768 && ang> 512) { VP->Heading += 128; n=1; }
          }

        if(VP->Heading < 0   ) VP->Heading+=1024;
        if(VP->Heading > 1023) VP->Heading-=1024;  

        if(n) { VP->Speed>>=2; C3D_MoveWOB(VP,0); VP->Speed<<=2; }
        else C3D_MoveWOB(VP,0);

        col=C3D_CheckCollision(VP,wob);
        if(col<=-2) {                             
          VP->Wx = lastx;                        
          VP->Wy = lasty;
          }
         
        n=41;
        }

       /** Glancing ColArea Collision **/
        
       else if(ColWork->Ret[n]==2) {
        coa=(struct ColArea *) ColWork->Ret[n+1];

        n=0;
        if(VP->Speed<0) {
          VP->Speed=0-VP->Speed;
          VP->Heading+=512;
          if(VP->Heading > 1023) VP->Heading-=1024;
          n=1;
          }

        zone=0;
        if(VP->Wx < (coa->Wx - VP->Radius))  zone=1;
        else if(VP->Wx > (coa->Wx2 + VP->Radius)) zone=3;
        if(!zone) {
          if(VP->Wy < coa->Wy)  zone=2;
          else if(VP->Wy > coa->Wy2) zone=4;
          }

        if(zone==1) {
          if(VP->Heading < 768) VP->Heading=512; else VP->Heading=0;
          }
        
        if(zone==2) {
          if(VP->Heading < 512) VP->Heading=256; else VP->Heading=768;
          }  

        if(zone==3) {
          if(VP->Heading < 256) VP->Heading=0; else VP->Heading=512;
          }

        if(zone==4) {
          if(VP->Heading < 512) VP->Heading=256; else VP->Heading=768;
          }

        VP->Speed>>=2; C3D_MoveWOB(VP,0); VP->Speed<<=2; 
        
        col=C3D_CheckCollision(VP,wob); 
        if(col<=-2) {                             
          printf("Zone %d  Heading %d  col %ld\n",zone,VP->Heading,col);
          VP->Wx = lastx;                        
          VP->Wy = lasty;
          }

        if(n) VP->Speed=0-VP->Speed;

        n=41;
        }

      n+=2;
      }        
    }

  /** Reset heading for differing view/move headings **/

  VP->Heading = vpd->ViewHead;

  /** Set Object distance re-calc flag on VP moved **/

  if((VP->Wx!=lastx) || (VP->Wy!=lasty)) VP->Flags |= WOBMOVED;
  else VP->Flags &= ~WOBMOVED;
  }


/*** Handle User Fire Keypresses ***/

void VPHandleFire(void) {
  WORD n;
  struct VPData *vpd = VP->Data;
  struct BulletData *bd;

  /** Handle Fire (Act1) Key **/
                  
  if(ASM_KeyStatus(C3D_Keys,C3DPrefs->KeyAct1)) {  
    if(VBD.Count > vpd->NextShot) {
      n = C3D_CloneWObject(PlasBolt, VP->Wx, VP->Wy, 0, VP->Heading);
      bd = WObject[n].Data; bd->Parent = VP;
      vpd->LastProj = &WObject[n];
      vpd->NextShot = VBD.Count + 16;
      }
    }

  }


/************************************/
/*** Build Simple Bullet Template ***/
/************************************/

WORD BulletTemplate(void) {
  WORD bull,ret;
  struct BulletData *bd;

  bd = AllocVec(sizeof(struct BulletData), MEMF_PUBLIC | MEMF_CLEAR);
  if(bd == NULL) {
    printf("Could not allocate RAM for bullet template data\n");
    return -1;
    }

  bull=C3D_FindFreeObject();           
  if(bull == -1) {
    printf("No Objects free for bullet template\n");
    FreeVec(bd);
    return -1;
    }
  
  Bullet = &WObject[bull];            /* Fill in Bullet WObject   */
  Bullet->Wx        = NULLCOORD;
  Bullet->Wy        = NULLCOORD;
  Bullet->Height    = 0;
  Bullet->Heading   = 0;
  Bullet->Size      = 512;
  Bullet->Radius    = 1024;
  Bullet->Speed     = 1500;
  Bullet->ObjDef[0] = 1001;
  Bullet->ObjDef[1] = 0;
  Bullet->ObjDef[2] = 0;
  Bullet->ObjDef[3] = 0;
  Bullet->MovFunc   = &BulletMove;
  Bullet->ColFunc   = &BulletColl;
  Bullet->Data      = bd;
  
  bd->DataSize     = sizeof(struct BulletData);
  bd->Flags       |= HDLRFLG_DAMAGE;  /* Object has damage struct  */
  bd->HP.TotHP     = 10;              /* Total hit points          */
  bd->HP.QuadHP[0] = -1;              /* No quadrant HP's required */
  bd->HP.QuadHP[1] = -1; 
  bd->HP.QuadHP[2] = -1;
  bd->HP.QuadHP[3] = -1; 
  bd->HP.Damage    = 25;              /* Damage bullet does        */
  bd->LifeTime     = 100;             /* Life time in VBlanks      */
  bd->Parent       = NULL;
 
  ret = C3D_FixWObjID(Bullet);    

  return ret;
  }
  
/*** Bullet move handler ***/
  
void BulletMove(struct WObject *wob) {
  WORD col;
  struct BulletData *bd;

  bd = wob->Data;                             /* Get ptr to bullet data */
  
  if(bd->HP.TotHP == 0) {
    C3D_FreeWObject(0xFFFF,wob);              /* Kill if HP=0           */
    return;
    }
    
  bd->LifeTime -= FrameDelay;                 /* Kill if lifetime up    */
  if(bd->LifeTime <= 0) {
    C3D_FreeWObject(0xFFFF,wob);
    return;
    }

  C3D_MoveWOB(wob,0);                         /* Do First Half of move  */
  col = C3D_CheckCollision(wob,bd->Parent);   /* Do collision check     */

  if(!col) {
    C3D_MoveWOB(wob,0);                       /* Do Second move         */
    col = C3D_CheckCollision(wob,bd->Parent); /* Do collision check     */
    }
  }

/*** Bullet Collision Handler ***/

WORD BulletColl(struct WObject *me, struct WObject *wob) {
  struct BulletData *bd = me->Data;

  bd->HP.TotHP = 0;                           /* If coll then suicide   */
  C3D_PlaySample(-1,0,63,428,0,wob->Wx,wob->Wy);
  return 0;
  }


/***********************************/
/**                               **/
/**  Live Game Handler Functions  **/
/**                               **/
/***********************************/


/*********************************/
/*** Build Gun Turret Template ***/
/*********************************/

/* Returns NULL on template build failure otherwise pointer
   to template WObject
*/

struct WObject *GunTurTemplate(void) {
  WORD widx;
  struct GunTurData *gtd;
  struct WObject *wob;

  gtd = AllocVec(sizeof(struct GunTurData), MEMF_PUBLIC | MEMF_CLEAR);
  if(gtd == NULL) {
    printf("Could not allocate RAM for GunTurret template data\n");
    return NULL;
    }

  widx=C3D_FindFreeObject();
  if(widx == -1) {
    printf("No Objects free for Gun Turret template\n");
    FreeVec(gtd);
    return NULL;
    }

  wob = &WObject[widx];
  wob->Wx        = NULLCOORD;
  wob->Wy        = NULLCOORD;
  wob->Height    = 0;
  wob->Heading   = 0;
  wob->Size      = 512;
  wob->Radius    = 4096;
  wob->Speed     = 1;
  wob->ObjDef[0] = 0;       /* Not Set - Taken from bound Map Object */
  wob->ObjDef[1] = 0;
  wob->ObjDef[2] = 0;
  wob->ObjDef[3] = 0;
  wob->MovFunc   = &GunTurMove;
  wob->ColFunc   = NULL;
  wob->Data      = gtd;

  gtd->DataSize     = sizeof(struct GunTurData);
  gtd->Flags       |= HDLRFLG_DAMAGE;            /* Object has damage struct   */
  gtd->HP.TotHP     = 200;                       /* Total hit points           */
  gtd->HP.QuadHP[0] = -1;                        /* No Quadrant Hp's required  */
  gtd->HP.QuadHP[1] = -1;
  gtd->HP.QuadHP[2] = -1;
  gtd->HP.QuadHP[3] = -1;
  gtd->HP.Damage    = 1;                         /* Damage dealt in collision  */

  /* ret = C3D_FixWObjID(wob); Not Required as done during Map bind            */

  return wob;
  }

/*** Gun Turret Move Handler ***/

void GunTurMove(struct WObject *wob) {
  WORD ang,dif,dir,idx,trn;
  LONG los;
  struct GunTurData *gtd = wob->Data;
  struct BulletData *bd;


  if(gtd->LastLook==0) {
    gtd->LastLook=++Interval & 31;               /* Alloc Interval on 1st call */
    gtd->LastFire=gtd->LastLook;
    }
 
  if(gtd->HP.TotHP == 0) {                                /* Suicide if HP = 0 */
    C3D_FreeWObject(0xFFFF,wob);
    return;
    }

  if(gtd->LastLook<VBD.Count) {                   /* Do LOS check every second */
    los = (LONG) C3D_CheckLOS(VP->Height,wob->Wx,wob->Wy,VP->Wx,VP->Wy);
    gtd->LastLook += 50;                          /* Set Next LOS Check Timer  */
    if(los==0) gtd->State=10000;                  /* Set Track & Fire State    */
    else if(gtd->State==10000)
            gtd->State=256/FrameDelay;            /* Set Lock Lost Slew State  */
    }

  if(gtd->State==10000) {                         /**** Handle Track & Fire ****/
    ang = ASM_FindAngle(wob->Wx,wob->Wy,VP->Wx,VP->Wy ,HP_TanTab);
    ang = 0-(ang-1024);                           /* Flip to clockwise         */

    dif = ang - wob->Heading;                     /* Calc angular distance     */
    if(dif<0) {                                   /* And + - direction req'd   */
      dif = 0 - dif;
      dir = -1;
      }
    else dir = 1;
    if(dif>512) dir = 0 - dir;                    /* dif>512 other dir shorter */

    trn = FrameDelay<<1;                          /* Turn may not be >distance */
    if(trn>dif) trn = dif;
    if(dir<0)   trn = 0-trn;

    wob->Heading += trn;                          /* Change heading & bound    */
    if(wob->Heading>1023) wob->Heading-=1024;
    if(wob->Heading<0)    wob->Heading+=1024;


    if(wob->Heading==ang &&                       /***** If lined up FIRE! *****/
       gtd->LastFire<VBD.Count) {
      while(gtd->LastFire<VBD.Count) gtd->LastFire += 75;
      idx = C3D_CloneWObject(FireBolt,wob->Wx,wob->Wy,0,wob->Heading);
      if(idx>=0) { 
        bd = WObject[idx].Data;                   /* Bullet ignores parent */
        bd->Parent = wob;
        }
      else printf("GunTurret Out of Objects !!!!\n");
      }
    }

  if(gtd->State>0 && gtd->State<10000) {          /*** Handle Lock Lost Slew ***/
    gtd->State   -= 1;
    wob->Heading += FrameDelay;
    if(wob->Heading > 1023) wob->Heading-=1024;
    }

  }

/********************************/
/*** Build Fire Bolt Template ***/
/********************************/

WORD FireBoltTemplate(void) {
  WORD fblt,ret;
  struct BulletData *bd;

  bd = AllocVec(sizeof(struct BulletData), MEMF_PUBLIC | MEMF_CLEAR);
  if(bd == NULL) {
    printf("Could not allocate RAM for Fire Bolt template data\n");
    return -1;
    }

  fblt=C3D_FindFreeObject();
  if(fblt == -1) {
    printf("No Objects free for Fire Bolt template\n");
    FreeVec(bd);
    return -1;
    }

  FireBolt = &WObject[fblt];            /* Fill in Bullet WObject   */
  FireBolt->Wx        = NULLCOORD;
  FireBolt->Wy        = NULLCOORD;
  FireBolt->Height    = 0;
  FireBolt->Heading   = 0;
  FireBolt->Size      = 64;
  FireBolt->Radius    = 1024;
  FireBolt->Speed     = 1500;
  FireBolt->ObjDef[0] = 1012;
  FireBolt->ObjDef[1] = 0;
  FireBolt->ObjDef[2] = 0;
  FireBolt->ObjDef[3] = 0;
  FireBolt->MovFunc   = &FireBoltMove;
  FireBolt->ColFunc   = &FireBoltColl;
  FireBolt->Data      = bd;

  bd->DataSize     = sizeof(struct BulletData);
  bd->Flags       |= HDLRFLG_DAMAGE;  /* Object has damage struct  */
  bd->HP.TotHP     = 10;              /* Total hit points          */
  bd->HP.QuadHP[0] = -1;              /* No quadrant HP's required */
  bd->HP.QuadHP[1] = -1;
  bd->HP.QuadHP[2] = -1;
  bd->HP.QuadHP[3] = -1;
  bd->HP.Damage    = 25;              /* Damage FireBolt does      */
  bd->LifeTime     = 200;             /* Life time in VBlanks      */
  bd->Parent       = NULL;

  ret = C3D_FixWObjID(FireBolt);

  return ret;
  }

/*** FireBolt move handler ***/

void FireBoltMove(struct WObject *wob) {
  WORD col,idx;
  struct BulletData *bd;

  bd = wob->Data;                             /* Get ptr to bullet data */

  if(bd->LifeTime == 200)
   C3D_PlaySample(-1,2,48,428,SNDMEDPRI,wob->Wx,wob->Wy); /* Play Launch Sound */


  bd->LifeTime -= FrameDelay;                 /* Kill if lifetime up    */
  if(bd->LifeTime <= 0) bd->HP.TotHP = 0;

  if(bd->HP.TotHP == 0) {
    C3D_FreeWObject(0xFFFF,wob);              /* Kill if HP=0           */
    idx = C3D_CloneWObject(SRExp,wob->Wx,wob->Wy,0,wob->Heading);
    if(idx>=0) WObject[idx].Speed = wob->Speed;
    else printf("SRExp Out of Objects !!!!\n");
    }

  C3D_MoveWOB(wob,0);                         /* Do First Half of move  */
  col = C3D_CheckCollision(wob,bd->Parent);   /* Do collision check     */

  if(!col) {
    C3D_MoveWOB(wob,0);                       /* Do Second move         */
    col = C3D_CheckCollision(wob,bd->Parent); /* Do collision check     */
    }
  }

/*** FireBolt Collision Handler ***/

WORD FireBoltColl(struct WObject *me, struct WObject *wob) {
  struct BulletData *bd = me->Data;

  bd->HP.TotHP = 0;                           /* If coll then suicide   */
  return 0;
  }


/**********************************/
/*** Build Plasma Bolt Template ***/
/**********************************/

WORD PlasBoltTemplate(void) {
  WORD pblt,ret;
  struct BulletData *bd;

  bd = AllocVec(sizeof(struct BulletData), MEMF_PUBLIC | MEMF_CLEAR);
  if(bd == NULL) {
    printf("Could not allocate RAM for Plasma Bolt template data\n");
    return -1;
    }

  pblt=C3D_FindFreeObject();
  if(pblt == -1) {
    printf("No Objects free for Plasma Bolt template\n");
    FreeVec(bd);
    return -1;
    }

  PlasBolt = &WObject[pblt];            /* Fill in Bullet WObject   */
  PlasBolt->Wx        = NULLCOORD;
  PlasBolt->Wy        = NULLCOORD;
  PlasBolt->Height    = 0;
  PlasBolt->Heading   = 0;
  PlasBolt->Size      = 64;
  PlasBolt->Radius    = 1024;
  PlasBolt->Speed     = 1500;
  PlasBolt->ObjDef[0] = 1013;
  PlasBolt->ObjDef[1] = 0;
  PlasBolt->ObjDef[2] = 0;
  PlasBolt->ObjDef[3] = 0;
  PlasBolt->MovFunc   = &PlasBoltMove;
  PlasBolt->ColFunc   = &PlasBoltColl;
  PlasBolt->Data      = bd;

  bd->DataSize     = sizeof(struct BulletData);
  bd->Flags       |= HDLRFLG_DAMAGE;  /* Object has damage struct  */
  bd->HP.TotHP     = 10;              /* Total hit points          */
  bd->HP.QuadHP[0] = -1;              /* No quadrant HP's required */
  bd->HP.QuadHP[1] = -1;
  bd->HP.QuadHP[2] = -1;
  bd->HP.QuadHP[3] = -1;
  bd->HP.Damage    = 25;              /* Damage FireBolt does      */
  bd->LifeTime     = 200;             /* Life time in VBlanks      */
  bd->Parent       = NULL;

  ret = C3D_FixWObjID(PlasBolt);

  return ret;
  }

/*** PlasBolt move handler ***/

void PlasBoltMove(struct WObject *wob) {
  WORD col,idx;
  struct BulletData *bd;

  bd = wob->Data;                             /* Get ptr to bullet data */

  if(bd->LifeTime == 200)
   C3D_PlaySample(-1,3,48,428,SNDMEDPRI,wob->Wx,wob->Wy); /* Play Launch Sound */

  bd->LifeTime -= FrameDelay;                 /* Kill if lifetime up    */
  if(bd->LifeTime <= 0) bd->HP.TotHP=0;

  if(bd->HP.TotHP == 0) {
    C3D_FreeWObject(0xFFFF,wob);              /* Kill if HP=0           */
    idx = C3D_CloneWObject(SBExp,wob->Wx,wob->Wy,0,wob->Heading);
    if(idx>=0) WObject[idx].Speed = wob->Speed;
    else printf("SBExp Out of Objects !!!!\n");
    }

  C3D_MoveWOB(wob,0);                         /* Do First Half of move  */
  col = C3D_CheckCollision(wob,bd->Parent);   /* Do collision check     */

  if(!col) {
    C3D_MoveWOB(wob,0);                       /* Do Second move         */
    col = C3D_CheckCollision(wob,bd->Parent); /* Do collision check     */
    }
  }

/*** PlasBolt Collision Handler ***/

WORD PlasBoltColl(struct WObject *me, struct WObject *wob) {
  struct BulletData *bd = me->Data;

  bd->HP.TotHP = 0;                           /* If coll then suicide   */
  return 0;
  }


/************************************/
/*** Small Red Explosion Template ***/
/************************************/

WORD SRExpTemplate(void) {
  WORD exp,ret;
  struct SRExpData *ed;

  ed = AllocVec(sizeof(struct SRExpData), MEMF_PUBLIC | MEMF_CLEAR);
  if(ed == NULL) {
    printf("Could not allocate RAM for Small Red Explosion template data\n");
    return -1;
    }

  exp=C3D_FindFreeObject();
  if(exp == -1) {
    printf("No Objects free for Small Red Explosion template\n");
    FreeVec(ed);
    return -1;
    }

  SRExp = &WObject[exp];
  SRExp->Wx        = NULLCOORD;
  SRExp->Wy        = NULLCOORD;
  SRExp->Height    = 0;
  SRExp->Heading   = 0;
  SRExp->Size      = 512;
  SRExp->Radius    = 0;
  SRExp->Speed     = 0;
  SRExp->ObjDef[0] = 1011;
  SRExp->ObjDef[1] = 0;
  SRExp->ObjDef[2] = 0;
  SRExp->ObjDef[3] = 0;
  SRExp->MovFunc   = &SRExpMove;
  SRExp->ColFunc   = NULL;
  SRExp->Data      = ed;

  ed->DataSize     = sizeof(struct SRExpData);
  ed->Flags        = 0;
  ed->Time         = -1;
  ed->Frame        = 1;

  ret = C3D_FixWObjID(SRExp);

  return ret;
  }

/*** Explosion move handler ***/

void SRExpMove(struct WObject *wob) {
  struct SRExpData *ed;
  struct ObjDef *obdf;

  ed   = wob->Data;                           /* Get ptr to explosion data */
  obdf = (struct ObjDef *) wob->ObjDef[0];    /* Get pointer to object def */

  if(ed->Time == -1) C3D_PlaySample(-1,1,63,428,SNDMEDPRI,wob->Wx,wob->Wy);

  if(ed->Frame == -1) {
    C3D_FreeWObject(0xFFFF,wob);              /* Kill if all Frames played */
    return;
    }

  if(ed->Time == -1) ed->Time = VBD.Count;    /* Init time store           */

  if(VBD.Count > ed->Time + obdf->FDelay) {   /* Sync life time to ObjDef  */
    ed->Time   = VBD.Count;                   /* animation statistics      */
    ed->Frame += 1;
    if(ed->Frame >= obdf->Frames) ed->Frame = -1;
    }
  }


/*************************************/
/*** Small Blue Explosion Template ***/
/*************************************/

/* NOTE - Uses Small Red Explosion Move Function & Data structure */

WORD SBExpTemplate(void) {
  WORD exp,ret;
  struct SRExpData *ed;

  ed = AllocVec(sizeof(struct SRExpData), MEMF_PUBLIC | MEMF_CLEAR);
  if(ed == NULL) {
    printf("Could not allocate RAM for Small Blue Explosion template data\n");
    return -1;
    }

  exp=C3D_FindFreeObject();
  if(exp == -1) {
    printf("No Objects free for Small Blue Explosion template\n");
    FreeVec(ed);
    return -1;
    }

  SBExp = &WObject[exp];
  SBExp->Wx        = NULLCOORD;
  SBExp->Wy        = NULLCOORD;
  SBExp->Height    = 0;
  SBExp->Heading   = 0;
  SBExp->Size      = 512;
  SBExp->Radius    = 0;
  SBExp->Speed     = 0;
  SBExp->ObjDef[0] = 1015;
  SBExp->ObjDef[1] = 0;
  SBExp->ObjDef[2] = 0;
  SBExp->ObjDef[3] = 0;
  SBExp->MovFunc   = &SRExpMove;
  SBExp->ColFunc   = NULL;
  SBExp->Data      = ed;

  ed->DataSize     = sizeof(struct SRExpData);
  ed->Flags        = 0;
  ed->Time         = -1;
  ed->Frame        = 1;

  ret = C3D_FixWObjID(SBExp);

  return ret;
  }


/*********************************************/
/*** Build Constant Sound Handler Template ***/
/*********************************************/

/* Returns NULL on template build failure otherwise pointer
   to template WObject

   NOTE - Actual sample played is derived from the ID number
          on the WObject minus the handler ID base
          (HDLRFIRESNDID)
*/

struct WObject *ContSndTemplate(void) {
  WORD widx;
  struct ContSndData *csd;
  struct WObject *wob;

  csd = AllocVec(sizeof(struct ContSndData), MEMF_PUBLIC | MEMF_CLEAR);
  if(csd == NULL) {
    printf("Could not allocate RAM for Continuous Sound template data\n");
    return NULL;
    }

  widx=C3D_FindFreeObject();
  if(widx == -1) {
    printf("No Objects free for Continuous Sound template\n");
    FreeVec(csd);
    return NULL;
    }

  wob = &WObject[widx];
  wob->Wx        = NULLCOORD;
  wob->Wy        = NULLCOORD;
  wob->Height    = 0;
  wob->Heading   = 0;
  wob->Size      = 0;
  wob->Radius    = 0;
  wob->Speed     = 1;    /* Set to ensure move handler called     */
  wob->ObjDef[0] = 0;    /* Not Set - Taken from bound Map Object */
  wob->ObjDef[1] = 0;
  wob->ObjDef[2] = 0;
  wob->ObjDef[3] = 0;
  wob->MovFunc   = &ContSndMove;
  wob->ColFunc   = NULL;
  wob->Data      = csd;

  csd->DataSize     = sizeof(struct ContSndData);
  csd->Flags        = 0;                         
  csd->Handle       = 0;

  /* ret = C3D_FixWObjID(wob); Not Required as done during Map bind */

  return wob;
  }

/*** Continuous Sound Movement Handler ***/

/* Uses handler ID range of 100 the actual id minus the id base
   dictates the actual sample used.
*/

void ContSndMove(struct WObject *wob) {
  WORD ret,samp;
  struct ContSndData *csd = wob->Data;

  if(wob->ActObj == 0xFFFF) return; /* If not active ignore */

  ret=C3D_ContSample(csd->Handle,wob->Wx,wob->Wy,32,SNDLOWPRI);
  if(ret) { 
    samp = wob->ID - HDLRCONTSNDID;
    csd->Handle=C3D_PlaySample(-1,samp,32,428,SNDLOWPRI,wob->Wx,wob->Wy);
    }

  }


/*******************************/
/*** Passive Object Handlers ***/
/*******************************/

/* Passive Mine Handler 1

   Explodes on contact creating a small red explosion
   Damages other object involved in collision
   Replaces ObjDef 1 with ObjDef 2 for de-activated image   
*/

WORD Mine1(struct WObject *me, struct WObject *wob) {
  WORD idx;

  if(me->ID) {
    C3D_CloneWObject(SRExp,me->Wx,me->Wy,0,0);
    me->ID=0;

    me->ObjDef[0] = me->ObjDef[1];

    idx = me->ActObj;
    if(idx != -1) ActObj[idx].ActDef= (struct ObjDef *)me->ObjDef[0];

    C3D_Damage(me,wob,25);
    }

  return 0;
  }
