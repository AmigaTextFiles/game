// -------------------------------------------
// SDL/OpenGL OpenGL application framework
// Jean-Luc PONS (2007)
// -------------------------------------------
#include "GLApp.h"

// -------------------------------------------

GLApplication::GLApplication() {

  m_bWindowed = true;
  m_strWindowTitle = "GL application";
  strcpy((char *)m_strFrameStats,"");
  m_screenWidth = 640;
  m_screenHeight = 480;

}

// -------------------------------------------

int GLApplication::ToggleFullscreen() {

  int errCode;

  InvalidateDeviceObjects();

  m_bWindowed = !m_bWindowed;

  Uint32 flags;
  if( m_bWindowed ) flags = SDL_OPENGL;
  else              flags = SDL_OPENGL | SDL_FULLSCREEN;

  if( SDL_SetVideoMode( m_screenWidth, m_screenHeight, 0, flags ) == NULL )
  {
    printf("SDL_SetVideoMode() failed.\n");
    return GL_FAIL;
  }

  SDL_Surface *vSurf = SDL_GetVideoSurface();
  m_bitsPerPixel = vSurf->format->BitsPerPixel;

  errCode = RestoreDeviceObjects();
	if( !errCode ) {
		printGlError();
		SDL_Quit();
		exit(1);
	}

  return GL_OK;
    
}

// -------------------------------------------

int GLApplication::Create(int width, int height, BOOL bFullScreen ) {

  int errCode;

  m_screenWidth = width;
  m_screenHeight = height;
  m_bWindowed = !bFullScreen;

#ifndef __amigaos4__
  if( getenv("DISPLAY")==NULL ) {
    printf("Warning, DISPLAY not defined, it may not work.\n");
  }

  //Initialize SDL
  if( SDL_Init( SDL_INIT_EVERYTHING ) < 0 )
  {
    printf("SDL_Init() failed : %s\n" , SDL_GetError() );
    return GL_FAIL;    
  }
#else

  //Initialize SDL
  if ( SDL_Init( SDL_INIT_VIDEO|SDL_INIT_TIMER|SDL_INIT_AUDIO|SDL_INIT_JOYSTICK ) < 0 )
  {
    printf("SDL_Init() failed : %s\n" , SDL_GetError() );
    SDL_Quit();
    exit(0);
  }

  SDL_ShowCursor(SDL_DISABLE);
  
#endif

  //SDL_GL_SetAttribute(SDL_GL_SWAP_CONTROL, 0);
  SDL_EnableUNICODE( 1 );
	SDL_EnableKeyRepeat(SDL_DEFAULT_REPEAT_DELAY,SDL_DEFAULT_REPEAT_INTERVAL);
    
  //Create Window
  Uint32 flags;
  if( m_bWindowed ) flags = SDL_OPENGL;
  else              flags = SDL_OPENGL | SDL_FULLSCREEN;

#ifndef __amigaos4__
  if( SDL_SetVideoMode( m_screenWidth, m_screenHeight, 0, flags ) == NULL )
  {
    printf("SDL_SetVideoMode() failed.\n");
    return false;
  }
#else
  if( SDL_SetVideoMode( m_screenWidth, m_screenHeight, 0, flags ) == NULL )
  {
    printf("SDL_SetVideoMode() failed.\n");
    SDL_Quit();
    exit(0);
  }
#endif

  SDL_Surface *vSurf = SDL_GetVideoSurface();
  m_bitsPerPixel = vSurf->format->BitsPerPixel;

  OneTimeSceneInit();
  errCode = RestoreDeviceObjects();
	if( !errCode ) {
		printGlError();
		SDL_Quit();
		exit(1);
	}

  SDL_WM_SetCaption( m_strWindowTitle, NULL );

  return GL_OK;

}

// -------------------------------------------

void GLApplication::Pause(BOOL bPause) {
}

// -------------------------------------------

int GLApplication::Resize( DWORD width, DWORD height ) {

  int errCode;
  m_screenWidth = width;
  m_screenHeight = height;

  InvalidateDeviceObjects();

  Uint32 flags;
  if( m_bWindowed ) flags = SDL_OPENGL;
  else              flags = SDL_OPENGL | SDL_FULLSCREEN;

  if( SDL_SetVideoMode( m_screenWidth, m_screenHeight, 0, flags ) == NULL )
  {
    printf("SDL_SetVideoMode() failed.\n");
    return GL_FAIL;
  }

  SDL_Surface *vSurf = SDL_GetVideoSurface();
  m_bitsPerPixel = vSurf->format->BitsPerPixel;

  errCode = RestoreDeviceObjects();
	if( !errCode ) {
		printGlError();
		SDL_Quit();
		exit(1);
	}

  return GL_OK;

}

// -------------------------------------------

int GLApplication::Run() {

  SDL_Event event;

  bool quit = false;
  int  nbFrame = 0;
  int  lastTick = 0;
  int  lastFrTick = 0;
  int  errCode;
  int  fTick;
  int  firstTick;

  m_fTime        = 0.0f;
  m_fElapsedTime = 0.0f;
  m_fFPS         = 0.0f;
  lastTick = lastFrTick = firstTick = SDL_GetTicks();

  //Wait for user exit
  while( quit == false )
  {
        
     //While there are events to handle
  	 while( SDL_PollEvent( &event ) )
		 {            
			  if( event.type == SDL_QUIT )
          quit = true;
        else
          EventProc(&event);
     }

     fTick = SDL_GetTicks();

     // Update timing
     nbFrame++;
     if( (fTick - lastTick) >= 1000 ) {
        int t0 = fTick;
        int t = t0 - lastTick;
        m_fFPS = (float)(nbFrame*1000) / (float)t;
        nbFrame = 0;
        lastTick = t0;
        sprintf(m_strFrameStats,"%.2f fps (%dx%dx%d)",m_fFPS,m_screenWidth,m_screenHeight,m_bitsPerPixel);
     }

     m_fTime = (float) ( fTick - firstTick ) / 1000.0f;
     m_fElapsedTime = (fTick - lastFrTick) / 1000.0f;
     lastFrTick = fTick;

     if(!quit) errCode = FrameMove();
     if( !errCode ) quit = true;
		 if( glGetError() != GL_NO_ERROR ) { printGlError(); quit = true; }

     if(!quit) errCode = Render();
     if( !errCode ) quit = true;
		 if( glGetError() != GL_NO_ERROR ) { printGlError(); quit = true; }

     //Swap buffer
	   SDL_GL_SwapBuffers();
	    
	}
	
	//Clean up
  SDL_Quit();
	
	return GL_OK;

}

// -------------------------------------------

void GLApplication::SetMaterial(GLMATERIAL *mat) {

  float acolor[] = { mat->Ambient.r, mat->Ambient.g, mat->Ambient.b, mat->Ambient.a };
  glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT, acolor);
  float dcolor[] = { mat->Diffuse.r, mat->Diffuse.g, mat->Diffuse.b, mat->Diffuse.a };
  glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, dcolor);
  float scolor[] = { mat->Specular.r, mat->Specular.g, mat->Specular.b, mat->Specular.a };
  glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, scolor);
  float ecolor[] = { mat->Emissive.r, mat->Emissive.g, mat->Emissive.b, mat->Emissive.a };
  glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, ecolor);
  glMaterialf(GL_FRONT_AND_BACK, GL_SHININESS, mat->Power);
	glColor4f(mat->Ambient.r, mat->Ambient.g, mat->Ambient.b, mat->Ambient.a);

}

// -------------------------------------------

void GLApplication::printGlError() {

	GLenum errCode = glGetError();
	switch( errCode ) {
		case GL_INVALID_ENUM:
			printf("OpenGL failure: An unacceptable value is specified for an enumerated argument. The offending function is ignored, having no side effect other than to set the error flag.\n");
			break;
		case GL_INVALID_VALUE:
			printf("OpenGL failure: A numeric argument is out of range. The offending function is ignored, having no side effect other than to set the error flag.\n");
			break;
		case GL_INVALID_OPERATION:
			printf("OpenGL failure: The specified operation is not allowed in the current state. The offending function is ignored, having no side effect other than to set the error flag.\n");
			break;
		case GL_STACK_OVERFLOW:
			printf("OpenGL failure: This function would cause a stack overflow. The offending function is ignored, having no side effect other than to set the error flag.\n");
			break;
		case GL_STACK_UNDERFLOW:
			printf("OpenGL failure: This function would cause a stack underflow. The offending function is ignored, having no side effect other than to set the error flag.\n");
			break;
		case GL_OUT_OF_MEMORY:
			printf("OpenGL failure: There is not enough memory left to execute the function. The state of OpenGL is undefined, except for the state of the error flags, after this error is recorded.\n");
			break;
	}

}

