/*
 	File:        PageOptions_amiga.cpp
  Description: Graphic and sound options page - AmigaOS4 (missing windowed option)
  Program:     BlockOut
  Author:      Jean-Luc PONS

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
*/

#include "Menu.h"

void PageGSOptions::Prepare(int iParam,void *pParam) {
  nbItem  = 6;
  selItem = 0;
}

void PageGSOptions::Render() {
  
  int size;
      
  mParent->RenderTitle("GRAPHICS & SOUND");

  mParent->RenderText(0,0,(selItem==0),"Sound            :");
  if( mParent->GetSetup()->GetSound() )
    mParent->RenderText(19,0,FALSE,"Enabled");
  else
    mParent->RenderText(19,0,FALSE,"Disabled");

  mParent->RenderText(0,1,(selItem==1),"Rotation Speed   :");
  mParent->RenderText(19,1,FALSE,"S[           ]F");
  int aSpeed = mParent->GetSetup()->GetAnimationSpeed();
  int i;
  for(i=0;i<=aSpeed;i++)
    mParent->RenderText(21+i,1,TRUE,".");
  for(;i<=ASPEED_FAST;i++)
    mParent->RenderText(21+i,1,FALSE,".");

  mParent->RenderText(0,2,(selItem==2),"Transparent face :");
  mParent->RenderText(19,2,FALSE,"T[           ]O");
  int fTrans = mParent->GetSetup()->GetTransparentFace();
  for(i=0;i<=fTrans;i++)
    mParent->RenderText(21+i,2,TRUE,".");
  for(;i<=FTRANS_MAX;i++)
    mParent->RenderText(21+i,2,FALSE,".");

  mParent->RenderText(0,3,(selItem==3),"Style            :");
  mParent->RenderText(19,3,FALSE,(char *)mParent->GetSetup()->GetStyleName());

  mParent->RenderText(0,4,(selItem==4),"Sound preset     :");
  mParent->RenderText(19,4,FALSE,(char *)mParent->GetSetup()->GetSoundTypeName());

  mParent->RenderText(0,5,(selItem==5),"Frame limiter    :");
  mParent->RenderText(19,5,FALSE,(char *)mParent->GetSetup()->GetFrLimitName());

}

int PageGSOptions::Process(BYTE *keys,float fTime) {

  int exitValue = 0;

  ProcessDefault(keys,fTime);

  if( keys[SDLK_RETURN] ) {
  
    switch( selItem ) {
      case 0: // Sound
      case 1: // Rotation speed
      case 2: // Transparent face
      case 3: // Style
      case 4: // Sound preset
      case 5: // Frame limiter
        exitValue = ProcessKey(SDLK_RIGHT);
        break;
    }
    keys[SDLK_RETURN] = 0;
  }

  if( keys[SDLK_LEFT]  ) {
    exitValue = ProcessKey(SDLK_LEFT);
    keys[SDLK_LEFT] = 0;
  }

  if( keys[SDLK_RIGHT]  ) {
    exitValue = ProcessKey(SDLK_RIGHT);
    keys[SDLK_RIGHT] = 0;
  }

  if( keys[SDLK_ESCAPE] ) {
     mParent->ToPage(&mParent->mainMenuPage);
     keys[SDLK_ESCAPE] = 0;
  }

  return exitValue;
}

int PageGSOptions::ProcessKey(int key) {

   int x;
   int exitValue = 0;

    switch( selItem ) {
      case 0: // Sound
        if( key==SDLK_RIGHT || key==SDLK_LEFT ) {
          BOOL sound = mParent->GetSetup()->GetSound();
          mParent->GetSetup()->SetSound(!sound);
          mParent->GetSound()->SetEnable(!sound);
          mParent->GetSound()->PlayBlub();
        }
      break;
      case 1: // Rotation speed
        switch( key ) {
          case SDLK_RIGHT:
            x = mParent->GetSetup()->GetAnimationSpeed();
            if( x<ASPEED_FAST )
              mParent->GetSetup()->SetAnimationSpeed(x+1);
            else
              mParent->GetSetup()->SetAnimationSpeed(ASPEED_SLOW);
            break;
          case SDLK_LEFT:
            x = mParent->GetSetup()->GetAnimationSpeed();
            if( x>ASPEED_SLOW )
              mParent->GetSetup()->SetAnimationSpeed(x-1);
            else
              mParent->GetSetup()->SetAnimationSpeed(ASPEED_FAST);
            break;
        }
      break;
      case 2: // Transparent face
        switch( key ) {
          case SDLK_RIGHT:
            x = mParent->GetSetup()->GetTransparentFace();
            if( x<FTRANS_MAX )
              mParent->GetSetup()->SetTransparentFace(x+1);
            else
              mParent->GetSetup()->SetTransparentFace(FTRANS_MIN);
            break;
          case SDLK_LEFT:
            x = mParent->GetSetup()->GetTransparentFace();
            if( x>FTRANS_MIN )
              mParent->GetSetup()->SetTransparentFace(x-1);
            else
              mParent->GetSetup()->SetTransparentFace(FTRANS_MAX);
            break;
        }
      break;
      case 3: // Game style
        switch( key ) {
          case SDLK_RIGHT:
            x = mParent->GetSetup()->GetStyle();
            if( x<STYLE_ARCADE )
              mParent->GetSetup()->SetStyle(x+1);
            else
              mParent->GetSetup()->SetStyle(STYLE_CLASSIC);
            break;
          case SDLK_LEFT:
            x = mParent->GetSetup()->GetStyle();
            if( x>STYLE_CLASSIC )
              mParent->GetSetup()->SetStyle(x-1);
            else
              mParent->GetSetup()->SetStyle(STYLE_ARCADE);
            break;
        }
      break;
      case 4: // Sound preset
        switch( key ) {
          case SDLK_RIGHT:
            x = mParent->GetSetup()->GetSoundType();
            if( x<SOUND_BLOCKOUT )
              mParent->GetSetup()->SetSoundType(x+1);
            else
              mParent->GetSetup()->SetSoundType(SOUND_BLOCKOUT2);
            break;
          case SDLK_LEFT:
            x = mParent->GetSetup()->GetSoundType();
            if( x>SOUND_BLOCKOUT2 )
              mParent->GetSetup()->SetSoundType(x-1);
            else
              mParent->GetSetup()->SetSoundType(SOUND_BLOCKOUT);
            break;
        }
      break;
      case 5: // Frame limiter
        switch( key ) {
          case SDLK_RIGHT:
            x = mParent->GetSetup()->GetFrLimiter();
            if( x<FR_LIMIT100 )
              mParent->GetSetup()->SetFrLimiter(x+1);
            else
              mParent->GetSetup()->SetFrLimiter(FR_NOLIMIT);
            break;
          case SDLK_LEFT:
            x = mParent->GetSetup()->GetFrLimiter();
            if( x>FR_NOLIMIT )
              mParent->GetSetup()->SetFrLimiter(x-1);
            else
              mParent->GetSetup()->SetFrLimiter(FR_LIMIT100);
            break;
        }
      break;			
    }

    return exitValue;

}
