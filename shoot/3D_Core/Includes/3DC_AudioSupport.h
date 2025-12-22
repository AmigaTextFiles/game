/************************************/
/***    Audio Support Functions   ***/
/*** Copyright (c) J.Gregory 1996 ***/
/***    Version 1.02  20/10/97    ***/
/************************************/


/****** Attempt to Allocate all Audio Channels ******/

/* Returns -1 on failure, otherwise 0 */

WORD C3D_InitAudio(void) {
  UBYTE chans[] = {15};

  C3D_FreeAudio();              /* Free resources if allready allocated */

  AudioMP = CreatePort(0,0);
  if(!AudioMP) {
    printf("Failed to allocate MsgPort for Audio IO\n");
    return -1;
    }

  AudioIO = AllocVec(sizeof(struct IOAudio), MEMF_PUBLIC | MEMF_CLEAR);
  if(!AudioIO) {
    printf("Failed to allocate Audio IO Request RAM\n");
    C3D_FreeAudio();
    return -1;
    }

  AudioIO->ioa_Request.io_Message.mn_ReplyPort   = AudioMP;
  AudioIO->ioa_AllocKey                          = 0;
  AudioIO->ioa_Request.io_Message.mn_Node.ln_Pri = 127;
  AudioIO->ioa_Data                              = chans;
  AudioIO->ioa_Length                            = sizeof(chans);

  AudioStat = OpenDevice(AUDIONAME,0L,(struct IORequest *) AudioIO,0L);
  if(AudioStat) {
    printf("Failed to open %s\n",AUDIONAME);
    C3D_FreeAudio();
    return -1;
    }

  SampList=AllocVec(sizeof(struct Sample)*MAXSAMPLES, MEMF_PUBLIC | MEMF_CLEAR);
  if(!SampList) {
    printf("Failed to allocate ram for sample list\n");
    C3D_FreeAudio();
    return -1;
    }

  ChanAlloc = AllocVec(sizeof(struct Channel)*4,MEMF_PUBLIC | MEMF_CLEAR);
  if(!ChanAlloc) {
    printf("No RAM for channel allocations\n");
    C3D_FreeAudio();
    return -1;
    }
    
  return 0;
  }

/****** De-allocate Audio Resources ******/

void C3D_FreeAudio(void) {
  if(!AudioStat) CloseDevice((struct IORequest *) AudioIO);
  if(AudioIO)    FreeVec(AudioIO);
  if(AudioMP)    DeletePort(AudioMP);
  if(ChanAlloc)  FreeVec(ChanAlloc);
  if(SampList) {
    C3D_FreeSamples();
    FreeVec(SampList);
    }
   
  AudioStat = -1;         /* Set Pointers and flags to un-used */
  AudioIO   = NULL;
  AudioMP   = NULL;
  SampList  = NULL;
  ChanAlloc = NULL;
  }

/****** Load Sample from Disk ******/

/* Returns 0 on success, otherwise -1 */

WORD C3D_LoadSample(BYTE *filename) {
  BPTR handle = NULL;
  LONG len,size;

  if(NextSamp==MAXSAMPLES) {
    printf("Maximum number of samples allready loaded\n");
    return -1;
    }
  
  handle = Open(filename, MODE_OLDFILE);
  if(!handle) {
    printf("Could not load sample: %s\n",filename);
    return -1;
    }

  Seek(handle,0,OFFSET_END);
  size = Seek(handle,0L,OFFSET_BEGINNING);
  if(!size) {
    printf("Zero length Sample :%s\n",filename);     
    Close(handle);
    return -1;
    }

  SampList[NextSamp].Data = AllocVec(size, MEMF_CHIP | MEMF_CLEAR);
  if(!SampList[NextSamp].Data) {
    printf("No CHIP RAM available for sample: %s\n",filename);
    Close(handle);
    return -1;
    }

  len = Read(handle,SampList[NextSamp].Data,size);
  if(len != size) {
    printf("Failed to Read sample: %s\n",filename);
    Close(handle);
    FreeVec(SampList[NextSamp].Data);
    SampList[NextSamp].Data = NULL;
    return -1;
    }

  SampList[NextSamp].Length  = size;

  NextSamp++;
  Close(handle);
  return 0;
  }

/****** Free All Loaded Samples ******/

void C3D_FreeSamples(void) {
  WORD idx;
  
  for(idx=0;idx<MAXSAMPLES;idx++) {
    if(SampList[idx].Data) {
      FreeVec(SampList[idx].Data);
      SampList[idx].Data = NULL;
      }
    }
  NextSamp=0;
  }

/****** Halt Interrupted Audio Sample DMA ******/

void C3D_InterruptSample(void) {
  WORD chan;
  
  for(chan=0;chan<4;chan++) {
    if(ChanAlloc[chan].Status == SAMP_PENDING) {
      switch(chan) {     /* Halt DMA for required channel */
        case 0:
          custom->dmacon = DMAF_AUD0;
          break;
        case 1:
          custom->dmacon = DMAF_AUD1;
          break;
        case 2:
          custom->dmacon = DMAF_AUD2;
          break;
        case 3: 
          custom->dmacon = DMAF_AUD3;
          break;
        }          
      }
    }  
  }

/****** Start Allocated Samples Playing ******/

void C3D_StartSample(void) {
  struct Channel *ch;
  WORD chan;

  for(chan=0;chan<4;chan++) {
    ch = &ChanAlloc[chan];
    if(ch->Status == SAMP_PENDING) {
      custom->aud[chan].ac_ptr = (unsigned short *) ch->Data;
      custom->aud[chan].ac_per = ch->Period;
      custom->aud[chan].ac_len = ch->Length/2;
      custom->aud[chan].ac_vol = ch->Volume;   
      
      ch->Blanks = (ch->Period * ch->Length) / 76923;
      VBD.TermAud[chan] = VBD.Count + ch->Blanks;
      
      switch(chan) {     /* Start DMA */
        case 0:
          custom->dmacon = DMAF_SETCLR | DMAF_AUD0;
          break;
        case 1:
          custom->dmacon = DMAF_SETCLR | DMAF_AUD1;
          break;
        case 2:
          custom->dmacon = DMAF_SETCLR | DMAF_AUD2;
          break;
        case 3: 
          custom->dmacon = DMAF_SETCLR | DMAF_AUD3;
          break;
        }
      ch->Status = SAMP_LAUNCHED;
      }
    else if(ch->Status == SAMP_LAUNCHED) {
      if(VBD.TermAud[chan] < VBD.Count) ch->Status = SAMP_DONE;
      }  
    }
  }

/****** Allocate Sample to Play ******/

/*
Parameters  chan    -1   = Find free or bumpable channel
                    0->3 = Grab specified channel regardless
            samp    Sample number to play
            col     Volume to play sample at
            period  Period of 1 byte of sample (Normally 428)
            pri     Priority used for bumping channels in use
            x,y     Location of sound set to 0,0 to ignore distance
    
Returns +int on success (sample handle)
        -1 if no free or interruptable channels
        -2 if invalid parameters
        -3 if sound dropped as volume 0 (distance reduced)

Distance Options
================

If x,y are non zero values the volume and priority are adjusted base on range
note the volume is adjusted and then bounded to 0-63 so starting voulme can be
higher.

Base Priorities should be :-

-64 - Low Priority Sounds (Background stuff)
  0 - Medium Priority Sounds
 64 - High Priority Sounds
*/

WORD C3D_PlaySample(WORD chan, WORD samp, WORD vol, WORD period, BYTE pri, LONG x, LONG y) {
  LONG d1,d2,pri1;

  if(x||y) {
    d1 = VP->Wx-x;                /* Roughly Calculate sound to VP distance */
    d2 = VP->Wy-y;
    if(d1<0) d1 = 0-d1;
    if(d2<0) d2 = 0-d2;
    if(d2>d1) d1 = d2;

    d1 >>= 12;                    /* Calc volume/priority modifier from distance */

    pri1 = pri;                   /* Reduce Volume/Priority */
    pri1 -= d1;
    vol  -= d1;
    if(pri1 < -127) pri1 = -127;  /* Bound priority */
    pri = pri1;

    if(vol<1) return -3;          /* Terminate if voulme reduced to 0 */
    }

  if(!SampList[samp].Data) {
    printf("No such sample !!!\n");
    return -2;
    }

  if(chan==-1) {
    chan=C3D_FindChannel(pri);
    if(chan==-1) return -1;
    }
      
  if(chan<0 || chan >3) {
    printf("Invalid audio channel specified\n");
    return -2;
    }
  
  if(vol<0)   vol    = 0;
  if(vol>63)  vol    = 63;
  if(!period) period = 428;

  PlayHandle++;
  if(PlayHandle < 0) PlayHandle = 1;

  ChanAlloc[chan].Data   = SampList[samp].Data;
  ChanAlloc[chan].Length = SampList[samp].Length;
  ChanAlloc[chan].Period = period;
  ChanAlloc[chan].Volume = vol;
  ChanAlloc[chan].Pri    = pri;
  ChanAlloc[chan].Status = SAMP_PENDING;
  ChanAlloc[chan].Handle = PlayHandle;

  return PlayHandle;
  }

/****** Find free or bumpable channel ******/

/* Returns free/bumpable channel or -1 if nothing available */

WORD C3D_FindChannel(BYTE pri) {
  WORD chan, lchan, low = 32760;
  
  for(chan=0;chan<4;chan++) {
    if(ChanAlloc[chan].Status == SAMP_DONE) return chan;
    if(ChanAlloc[chan].Pri < low) {
      low = ChanAlloc[chan].Pri;
      lchan = chan;
      }
    }

  if(low <= pri) return lchan; 

  return -1;
  }


/****** Continue Existing Sample ******/

/* args - WORD handle - sample handle to continue
        - LONG x      - sound location 
        - LONG y      - sound location
        - WORD vol    - base volume
        - WORD pri    - base priority
        
 NOTE if x & y both 0 no distance volume calculation done
      same rules apply as for playsample()
        
   rets - WORD - 0 on success
                -1 on fail (no sample to continue
                -3 sound to quiet to continue
*/

WORD C3D_ContSample(WORD handle, LONG x, LONG y, WORD vol, WORD pri) {
  WORD chan=0, live=-1, pri1;
  LONG d1,d2;
  
  /** Check Sample is Playing **/

  while(chan<4) {
    if(ChanAlloc[chan].Handle==handle) {
      live=chan;
      chan=32000;
      }
    chan++;
    }

  if(live==-1) return -1;
  if(ChanAlloc[live].Status!=SAMP_LAUNCHED) return -1;

  /** Calc sound volume if required **/

  if(x||y) {
    d1 = VP->Wx-x;                /* Roughly Calculate sound to VP distance */
    d2 = VP->Wy-y;
    if(d1<0) d1 = 0-d1;
    if(d2<0) d2 = 0-d2;
    if(d2>d1) d1 = d2;

    d1 >>= 12;                    /* Calc volume/priority modifier from distance */

    pri1 = pri;                   /* Reduce Volume/Priority */
    pri1 -= d1;
    vol  -= d1;
    if(pri1 < -127) pri1 = -127;  /* Bound priority */
    pri = pri1;

    if(vol<1) return -3;          /* Terminate if voulme reduced to 0 */
    }
  
  if(vol<0)   vol    = 0;         /* Clip volume to valid range */
  if(vol>63)  vol    = 63;

  /** Update Channel Allocation **/

  ChanAlloc[live].Pri    = pri;
  ChanAlloc[live].Volume = vol;

  /** Update Hardware & New End Time **/

  custom->aud[live].ac_vol = vol;   
      
  VBD.TermAud[live] = VBD.Count+ChanAlloc[live].Blanks;
      
  switch(live) {                  /* Ensure DMA Enabled */
    case 0:
      custom->dmacon = DMAF_SETCLR | DMAF_AUD0;
      break;
    case 1:
      custom->dmacon = DMAF_SETCLR | DMAF_AUD1;
      break;
    case 2:
      custom->dmacon = DMAF_SETCLR | DMAF_AUD2;
      break;
    case 3: 
      custom->dmacon = DMAF_SETCLR | DMAF_AUD3;
      break;
    }
  
  return 0;
  }


/****** Return Status of a played sample ******/

/* Returns status of sample see defines for exact details,
   however 0=done otherwise still pending/playing
*/

WORD C3D_PlayStatus(WORD handle) {
  WORD chan=0, ret=0;
  
  while(chan < 4) {   
    if(ChanAlloc[chan].Handle == handle) {
      ret = ChanAlloc[chan].Status;
      chan = 32000;
      }
    chan++;
    }  

  return ret;
  }
