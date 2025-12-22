///////////////////////////////////////////////
// 
//  Snipe2d ludum dare 48h compo entry
//
//  Jari Komppa aka Sol 
//  http://iki.fi/sol
// 
///////////////////////////////////////////////
// License
///////////////////////////////////////////////
// 
//     This software is provided 'as-is', without any express or implied
//     warranty.    In no event will the authors be held liable for any damages
//     arising from the use of this software.
// 
//     Permission is granted to anyone to use this software for any purpose,
//     including commercial applications, and to alter it and redistribute it
//     freely, subject to the following restrictions:
// 
//     1. The origin of this software must not be misrepresented; you must not
//        claim that you wrote the original software. If you use this software
//        in a product, an acknowledgment in the product documentation would be
//        appreciated but is not required.
//     2. Altered source versions must be plainly marked as such, and must not be
//        misrepresented as being the original software.
//     3. This notice may not be removed or altered from any source distribution.
// 
// (eg. same as ZLIB license)
//
///////////////////////////////////////////////
//
// Houses are taken from a satellite picture of glasgow.
//
// The sources are a mess, as I didn't even try to do anything
// really organized here.. and hey, it's a 48h compo =)
//

#include "snipe2d.h"
//#include <getopt.h>
#include "binds.h"

PREFS gPrefs;

typedef struct oes_joy_t {
  int style;    /* axis style: rel (game) or abs (mousepad) */ //not used yet
  float scale;  /* scaling factor. */
  int interval; /* handling interval, in milliseconds. */

  int time;  /* timestamp of last handling. */
  int axes;  /* number of axes */
  int buttons;  /* number of buttons. */
  int state;    /* joy shifter state. */
  float x;   /* X axis. */
  float y;   /* Y axis. */
  float z;   /* throttle? */
  SDL_Joystick* sdljoy;  /* SDL Joystick handle. */
#if 0
  /* bindings for 32 axes and 32 buttons. */
  oesbind_t axis[32];
  oesbind_t button[32];
#endif /* 0 */
} oes_joy_t;

oes_joy_t oesjoy = { 0, };


struct {
  int mousex;
  int mousey;
  int mouse0;
  int axis1;
  int joy1;
} keymarkers;


ORBITALSNIPER Game;


//char *mediaPath;

//int gPlaySound = 0;
int screen_shot_number=1;
char *invocation;

#if 0
BUTTONS gButton;
#endif /* 0 */

static const char *crosshairs_xpm[] = {
  "    16    16        3            1",
  "X c #000000",
  ". c #ffffff",
  "  c None",
  "               ",
  "       .       ",
  "     .....     ",
  "    .  .  .    ",
  "   .   .   .   ",
  "  .         .  ",
  "  .         .  ",
  " ....  .  .... ",
  "  .         .  ",
  "  .         .  ",
  "   .   .   .   ",
  "    .  .  .    ",
  "     .....     ",
  "       .       ",
  "               ",
  "               ",
  "8,8"
};

#if 0
//SDL_AudioSpec *gAudioSpec = NULL;
Mix_Chunk *gAudioZoomSample = NULL;
Mix_Chunk *gAudioFireSample = NULL;
Mix_Chunk *gAudioZoomOut = NULL;
Mix_Chunk *gAudioZoomIn = NULL;
Mix_Chunk *gAudioFire = NULL;
//Mix_Music *gAudioBGM = NULL;
int gAudioZoomSampleLen = 0;
int gAudioZoomOutLen = 0;
int gAudioZoomInLen = 0;
int gAudioZoomOfs = 0;
int gAudioFireOfs = 0;
int gAudioFireSampleLen = 0;
int gAudioFireLen = 0;
#endif /* 0 */


const char *usage = \
"Usage: %s [OPTIONS]...\n\
Overhead shooting game; kill red marks, protect blue marks, avoid white marks.\n\
\n\
Orbital Eunuchs Sniper recognizes the following command parameters:\n\
  -a       | --audio             Start with sound\n\
  -n       | --noaudio           Start without sound\n\
  -f       | --fullscreen        Start in fullscreen mode\n\
  -w       | --window            Start in a window\n\
  -1       | --diff1             Difficulty 1 (Easy)\n\
  -2       | --diff2             Difficulty 2 (Medium)\n\
  -3       | --diff3             Difficulty 3 (Hard)\n\
  -h       | --help              Display this help message and exit\n\
\n\
Orbital Eunuchs Sniper is licensed under the same terms as the ZLIB license.\n\
\n";
//  -d 1|2|3 | --difficulty 1|2|3  Set difficulty level (1 is easiest)\n\


/* Set SDL cursor. */
void
oes_cursor ()
{
	int i, row, col;
	Uint8 data[4*16];
	Uint8 mask[4*16];
	int hot_x, hot_y;
	const char **image;
	SDL_Cursor *cursor;
    
	image = crosshairs_xpm;
	i = -1;
	for ( row=0; row<16; ++row ) {
		for ( col=0; col<16; ++col ) {
			if ( col % 8 ) {
				data[i] <<= 1;
				mask[i] <<= 1;
			} else {
				++i;
				data[i] = mask[i] = 0;
			}
			switch (image[4+row][col]) {
			case 'X':
				data[i] |= 0x01;
				mask[i] |= 0x01;
				break;
			case '.':
				mask[i] |= 0x01;
				break;
			case ' ':
				break;
			}
		}
	}
	sscanf(image[4+row], "%d,%d", &hot_x, &hot_y);
	cursor = SDL_CreateCursor(data, mask, 16, 16, hot_x, hot_y);
	SDL_SetCursor (cursor);
}






/********************/
/* Background Music */
/********************/


/* Function for SDL_mixer */
static void oes_bgm_loop()
{
  sniperbgm_loop(Game.BGM);
}


sniperbgm_t *
sniperbgm_init (sniperbgm_t *self)
{
  if (!self)
      self = (sniperbgm_t*)calloc(1, sizeof(*self));
  self->BGM = NULL;
  self->playp = 0;
  self->pausep = 0;
  return self;
}

sniperbgm_t *
sniperbgm_init_music (sniperbgm_t *self, Mix_Music *m)
{
  if ((self = sniperbgm_init(self)))
    {
//      SniperBGM();
      self->BGM = m;
    }
  return self;
}

void
sniperbgm_delete (sniperbgm_t *self)
{
  sniperbgm_stop(self);  /* Don't wait for fadeout to finish. */
  Mix_FreeMusic(self->BGM);
  free(self);
}

Mix_Music *
sniperbgm_music (sniperbgm_t *self)
{
  return self->BGM;
}

void
sniperbgm_use (sniperbgm_t *self, Mix_Music *m)
{
  self->BGM = m;
}

void
sniperbgm_start (sniperbgm_t *self)
{
  if (self->BGM)
    {
      if (Mix_PlayMusic(self->BGM, 0))
          printf("Mix_PlayMusic: %s\n", Mix_GetError());
    }
  Mix_HookMusicFinished(oes_bgm_loop);
  self->playp = 1;
  self->time_start = SDL_GetTicks();
}

void
sniperbgm_stimulate (sniperbgm_t *self)
{
  if (self->playp) return;
  if (Mix_FadeInMusic(self->BGM, 0, sniperbgm_FadeInTime))
      printf("Mix_PlayMusic: %s\n", Mix_GetError());
  Mix_HookMusicFinished(oes_bgm_loop);
  self->playp = 1;
  self->time_start = SDL_GetTicks();
}

void
sniperbgm_depress (sniperbgm_t *self)
{
  Mix_HookMusicFinished(NULL);
  if (!Mix_FadeOutMusic(sniperbgm_FadeOutTime))
      Mix_HaltMusic();
  self->playp = 0;
}

void
sniperbgm_stop (sniperbgm_t *self)
{
  Mix_HaltMusic();
  Mix_HookMusicFinished(NULL);
  self->playp = 0;
}

void
sniperbgm_pause (sniperbgm_t *self, int newstate)
{
  switch (newstate)
    {
      case 0: /* pause */
        Mix_PauseMusic();
        self->pausep = 1;
        break;
      case 1: /* resume */
        Mix_ResumeMusic();
        self->pausep = 0;
        break;
      default: /* toggle */
        if (self->pausep) Mix_ResumeMusic(); else Mix_PauseMusic();
        self->pausep = !self->pausep;
        break;
    }
}

void
sniperbgm_jumpto (sniperbgm_t *self, float pos)
{
  Mix_SetMusicPosition(pos);
}

void
sniperbgm_rewind (sniperbgm_t *self)
{
  Mix_RewindMusic();
}

void
sniperbgm_loop (sniperbgm_t *self)
{
  sniperbgm_start(self);
  sniperbgm_jumpto(self, sniperbgm_RepeatJumpPos);
}

void
sniperbgm_release (sniperbgm_t *self)
{
  /* Prepare for release of sound device. */
  /* Figure out where in the BGM we currently are. */
  self->time_stop = SDL_GetTicks();
  self->bookmark = (self->time_stop - self->time_start) / 1000.0;
  sniperbgm_stop(self);
}

void
sniperbgm_grab (sniperbgm_t *self)
{
  /* Try to resume BGM after reopening sound device. */
  sniperbgm_start(self);
  sniperbgm_jumpto(self, self->bookmark);
  self->time_start -= (int)(self->bookmark * 1000); /* For next pause. */
}





/******************/
/* Options parser */
/******************/

static int
parse_option (PETOPT *pp, PETOPTS *pov, const char *arg)
{
	switch (pov->s) {
		case 'n': // no audio
			gPrefs.audio = 0;
			break;
		case 'f': // fullscreen
			gPrefs.fullscreen = 1;
			break;
		case 'w': // window
			gPrefs.fullscreen = 0;
			break;
		case 'a': // audio
			gPrefs.audio = 1;
			break;
		case '1':
			gPrefs.difficulty = 1;
			break;
		case '2':
			gPrefs.difficulty = 2;
			break;
		case '3':
			gPrefs.difficulty = 3;
			break;		
 		case 'h':
			fprintf (stderr, usage, invocation);
			exit (0);
			break;
	}
}

void parse_args(int argc, char **argv)
{
	int fs, au, ds, petopt_err, i;
	PETOPTS pov[] = {
	{ 'n',	POF_BOOL,	"noaudio",	&au,	"Disable Audio" },
	{ 'f',	POF_BOOL,	"fullscreen",	&fs,	"Enable Fullscreen" },
	{ 'w',	POF_BOOL,	"windowed",	&fs,	"Disable Fullscreen" },
	{ 'a',	POF_BOOL,	"audio",	&au,	"Enable Audio" },
	{ '1',	POF_OPT|POF_INT,"diff1",	&ds,	"Difficulty Setting 1" },
	{ '2',	POF_OPT|POF_INT,"diff2",	&ds,	"Difficulty Setting 2" },
	{ '3',	POF_OPT|POF_INT,"diff3",	&ds,	"Difficulty Setting 3" },
	{ 'h',	0,		"help",		NULL,	"Extended mode" },
	{ -1,	0,		0,		NULL,	NULL },
	};

	PETOPT *pop;

	petopt_err = petopt_setup (&pop, 0, argc, argv, pov, parse_option, NULL);
	if (petopt_err > 0) {
		fprintf (stderr, "Unable to initialise petopt: %s\n", strerror(petopt_err));
		exit (1);
	}
	petopt_err = petopt_parse (pop, &argc, &argv);
	if (petopt_err > 0) {
		fprintf(stderr, "petopt_parse_all: %s\n", strerror(petopt_err));
		exit(1);
	}
	petopt_cleanup (pop);
	
	return;
}






/***************/
/* Audio stuff */
/***************/

#if 0
void audiomixer(void *userdata, Uint8 *stream, int len)
{
    int l = len / 2;
    short * buf = (short*)stream;
    memset(stream,0,len);
    if (gPlaySound & (1<<1))
    {
        gPlaySound &= ~(1<<1);
        Game.AudioZoom.ofs = 0;
        Game.AudioZoom.data = Game.AudioZoomOut.data;
        Game.AudioZoom.len = Game.AudioZoomOut.len;
    }
    if (gPlaySound & (1<<2))
    {
        gPlaySound &= ~(1<<2);
        Game.AudioZoom.ofs = 0;
        Game.AudioZoom.data = Game.AudioZoomIn.data;
        Game.AudioZoom.len = Game.AudioZoomIn.len;
    }
    if (gPlaySound & (1<<3))
    {
        gPlaySound &= ~(1<<3);
        Game.AudioFireSample.ofs = 0;
        Game.AudioFireSample.data = Game.AudioFire.data;
        Game.AudioFireSample.len = Game.AudioFire.len;
    }
    if (Game.AudioZoom.data != NULL)
    {
        int n = l;
        if (n + Game.AudioZoom.ofs > Game.AudioZoom.len)
            n = Game.AudioZoom.len - Game.AudioZoom.ofs;
        int i;
        for (i = 0; i < n; i++)
            buf[i] = Game.AudioZoom.data[i + Game.AudioZoom.ofs] / 2;
        Game.AudioZoom.ofs += n;
        if (l != n)
        {
            Game.AudioZoom.data = NULL;
        }
    }
    if (Game.AudioFireSample != NULL)
    {
        int n = l;
        if (n + Game.AudioFireSample.ofs > Game.AudioFireSample.len)
            n = Game.AudioFireSample.len - Game.AudioFireSample.ofs;
        int i;
        for (i = 0; i < n; i++)
            buf[i] += Game.AudioFireSample.data[i + Game.AudioFireSample.ofs] / 2;
        Game.AudioFireSample.ofs += n;
        if (l != n)
        {
            Game.AudioFireSample.data = NULL;
        }
    }    
}
#endif /* 0 */

/* Sillily expensive, but faster. */
char chanuse[16];

void oes_sound_finish (int chan)
{
  chanuse[chan] = 0;
}

void oes_sound_play (int aSound)
{
    int chan;
    if (!gPrefs.audio)
	return;
//    SDL_LockAudio();
//    gPlaySound |= 1 << aSound;
//    SDL_UnlockAudio();
    /* Find a free channel. */
    for (chan = 0; (chan < 16) && (chanuse[chan]); chan++);
    if (chan >= 16) return; /* out of channels. */
    chanuse[chan] = 1;
    switch (aSound) {
	case 1:
	    Mix_PlayChannel(chan, Game.AudioZoomOut, 0);
	    break;
	case 2:
	    Mix_PlayChannel(chan, Game.AudioZoomIn, 0);
	    break;
	case 3:
	    Mix_PlayChannel(chan, Game.AudioFire, 0);
	    break;
    }
}

int oes_audio_open ()
{
#ifdef PLAY_AUDIO
    if (gPrefs.audio)
	{
#if 1
	    /* XXX: take settings from prefs. */
	    if (Mix_OpenAudio(44100, AUDIO_S16, 2, 4096)) {
		printf("Mix_OpenAudio(): %s\n", Mix_GetError());
	    }
	    Mix_AllocateChannels(17);
	    Mix_ChannelFinished(oes_sound_finish);
#else
	    SDL_AudioSpec *as = (SDL_AudioSpec*)malloc(sizeof(SDL_AudioSpec));
	    as->freq = 44100;
	    as->format = AUDIO_S16;
	    as->channels = 2;
	    as->samples = 4096;
	    as->callback = audiomixer;
	    as->userdata = NULL;
	    if (SDL_OpenAudio(as, NULL) < 0)
		{
		    fprintf(stderr, "Unable to init SDL audio: %s\n", SDL_GetError());
		    exit(1);
		}
	    Game.sdlaudio = as;
#endif /* 0 */
	}
#endif
  return 0;
}

int oes_audio_close ()
{
  Mix_CloseAudio();
  return 0;
}






/*****************************/
/* Game and system resources */
/*****************************/


/* initialize game data. */
ORBITALSNIPER *
oes_game_init (ORBITALSNIPER *self)
{
  int i;
  int tick;

  if (!self)
      self = (ORBITALSNIPER*)calloc(1, sizeof(ORBITALSNIPER));

  tick = SDL_GetTicks();
  self->MouseX = 0;
  self->MouseY = 0;
  self->MouseZ = 1.0f;
  self->CoordScale = 1.0f;
  self->WobbleX = 0;
  self->WobbleY = 0;
  self->CenterX = 0;
  self->CenterY = 0;
  self->ControlState = 0;
  self->Reloading = 0;
  self->Score = 0;
  self->vip.count = 0;
  self->baddy.count = 0;
  self->WobbleIndex = 0;
  self->vip.goal = 0;
  self->pedestrian.dead = 0;
  self->baddy.dead = 0;
  self->SightedCharacter = NULL;

  if (oesjoy.sdljoy) {
      SDL_JoystickClose(oesjoy.sdljoy);
      oesjoy.sdljoy = NULL;
  }
  oesjoy.x = 0;  oesjoy.y = 0;  oesjoy.z = 0;  oesjoy.state = 0;
  oesjoy.axes = 0;  oesjoy.buttons = 0;
  if (gPrefs.joystick) {
      /* want to use joystick. */
//printf("Detected %d joysticks\n", SDL_NumJoysticks());
      if ((oesjoy.sdljoy = SDL_JoystickOpen(gPrefs.joystick - 1))) { /* off-by-one */
          oesjoy.axes = SDL_JoystickNumAxes(oesjoy.sdljoy);
          oesjoy.buttons = SDL_JoystickNumButtons(oesjoy.sdljoy);
      }
  }

  for (i = 0; i < self->num_characters; i++)
  {
      self->characters[i].mType = -1;
  }
  for (i = 0; i < (int)(self->num_characters * 0.75f); i++)
  {
      int id = spawn_ai(2);
      int j;
      for (j = 0; j < 1000; j++) // Run 1000 physics loops for all pedestrians..
          handle_ai(self->characters[id]);
  }
  self->vip.time = 2000;
  self->vip.period = 20000;
  self->baddy.time = 3000;
  self->baddy.period = 8000;
  self->WobbleIndex = 0;
  self->StartTick = tick;
  self->FrameCount = 0;
  self->LastTick = tick;
  self->GameState = 1;
  self->GameStartTick = tick;
  SDL_ShowCursor (0);
}


/* One-time setup at start. */
int
oes_setup ()
{
/* load audio, load images, load models(?), allocate objects. */
  int i;
  const char *city_img = "citee2.png";
  const char *charseq_img = "charseq.png";
  const char *aimap_img = "aimap.png";
  const char *font_img = "font4x6.png";
  const char *zoomin_snd = "camera_in.wav";
  const char *zoomout_snd = "camera_out.wav";
  const char *boing_snd = "twang.wav";
  const char *bgmusic = "oes.ogg";

//  char path[ strlen(mediaPath) + 1 + 30 + 1 ];
//  path = (char*)calloc(strlen(mediaPath) + 1 + 30 + 1, sizeof(char));
  char *path;
  /* free on function exit. */
  path = (char*)malloc((strlen(Game.mediaPath) + 1 + 30 + 1) * sizeof(char));


  /* Configure difficulty. */
  configure_difficulty();
  /* Initialise high scores. */
  init_hiscores();
    
  /* Initialise SDL */
    //if ( SDL_Init(SDL_INIT_VIDEO | SDL_INIT_NOPARACHUTE) < 0 ) 
//    if ( SDL_Init(SDL_INIT_VIDEO) < 0 ) 
  if ( SDL_Init(SDL_INIT_VIDEO | SDL_INIT_JOYSTICK) < 0 )
    {
      fprintf(stderr, "Unable to init SDL: %s\n", SDL_GetError());
      exit(1);
    }
    
  atexit(SDL_Quit);
    
  //gScreen = SDL_SetVideoMode(640, 480, 16, SDL_SWSURFACE); 
#ifdef OSX_SUX
  Game.Screen = SDL_SetVideoMode(640, 480, 16, (gPrefs.fullscreen ? SDL_FULLSCREEN : 0) | SDL_SWSURFACE);
#else
  Game.Screen = SDL_SetVideoMode(640, 480, 16, (gPrefs.fullscreen ? SDL_FULLSCREEN : 0) | SDL_SWSURFACE | SDL_DOUBLEBUF);
#endif
  SDL_WM_SetCaption("ORBITAL EUNUCHS SNIPER", "ORBITAL_EUNUCHS_SNIPER");
  if (Game.Screen == NULL) 
    {
      fprintf(stderr, "Unable to set 640x480 video: %s\n", SDL_GetError());
      exit(1);
    }
  /* Cursor */
  oes_cursor();
//  init_logoscreen();
    
  oes_audio_open();


  Game.BGM = sniperbgm_init(Game.BGM);

  sprintf(path, "%s", city_img);
  SDL_Surface *temp = IMG_Load(path);
  Game.Map = SDL_ConvertSurface(temp, Game.Screen->format,SDL_SWSURFACE);
  SDL_FreeSurface(temp);
    
  sprintf(path, "%s", charseq_img);
  temp = IMG_Load(path);
  Game.CharSprite = SDL_ConvertSurface(temp, Game.Screen->format,SDL_SWSURFACE);
  SDL_FreeSurface(temp);

  sprintf(path, "%s", aimap_img);
  Game.AIMap = IMG_Load(path);
    
  // Okay, this is ugly. Load font several times & change the color of each.
    
  for (i = 0; i < 5; i++)
  {
      sprintf(path, "%s", font_img);
      Game.Font[i] = IMG_Load(path);
      SDL_SetColorKey(Game.Font[i],SDL_SRCCOLORKEY,1); // set color index 1 (black) transparent
  }
  *(int*)&(Game.Font[0]->format->palette->colors[0]) = 0x000000; // black
  *(int*)&(Game.Font[1]->format->palette->colors[0]) = 0xffffff; // white
  *(int*)&(Game.Font[2]->format->palette->colors[0]) = 0x00ff00; // green
  *(int*)&(Game.Font[3]->format->palette->colors[0]) = 0x00ffff; // yellow
  *(int*)&(Game.Font[4]->format->palette->colors[0]) = 0x0000ff; // red
    
  precalc_ai();
    
  Game.num_characters = 2048;
  Game.characters = (CHARACTER*)calloc(Game.num_characters, sizeof(CHARACTER));

#ifdef PLAY_AUDIO
  if (gPrefs.audio)
    {
      sprintf(path, "%s", zoomin_snd);
      Game.AudioZoomIn = Mix_LoadWAV(path);
      sprintf(path, "%s", zoomout_snd);
      Game.AudioZoomOut = Mix_LoadWAV(path);
      sprintf(path, "%s", boing_snd);
      Game.AudioFire = Mix_LoadWAV(path);
      sprintf(path, "%s", bgmusic);
//      Game.BGM = Mix_LoadMUS(path);
      sniperbgm_use(Game.BGM, Mix_LoadMUS(path));

//      SDL_PauseAudio(0); // let it play
    }
#endif

  oes_game_init(&Game);
  return 0;
}

/* One-time teardown at exit. */
void
oes_teardown ()
{
  if (oesjoy.sdljoy)
    {
      SDL_JoystickClose(oesjoy.sdljoy);
      oesjoy.sdljoy = NULL;
    }
}

/* Temporarily release system resources. */
int
oes_suspend ()
{
  if (Game.GameState != OESGAME_PLAY) return 0;
  sniperbgm_release(Game.BGM);
  oes_audio_close();
  SDL_WM_GrabInput(SDL_GRAB_OFF);
  SDL_ShowCursor(1);
  Game.GameState = OESGAME_PAUSED;
  return 0;
}

/* Reassert system resources that were temporarily released. */
int
oes_resume ()
{
  if (Game.GameState != OESGAME_PAUSED) return 0;
  if (Game.GrabP)
    {
      SDL_ShowCursor(0);
      SDL_WM_GrabInput(SDL_GRAB_ON);
    }
  oes_audio_open();
  sniperbgm_grab(Game.BGM);
  Game.GameState = OESGAME_UNPAUSED;
  return 0;
}






/**************/
/* Game logic */
/**************/

#define PHYSICS_MS 10
// 10ms physics loops == 100 loops per sec, 'should be enough'..

void oes_reindeer()
{
    Game.SightedCharacter = NULL;
    int tick = SDL_GetTicks();    
    Game.FrameCount++;
    if (Game.Reloading)
    {
        Game.Reloading -= tick - Game.LastTick;
        if (Game.Reloading < 0)
            Game.Reloading = 0;
    }
    
    Game.CenterX = (640.0f - 640.0f * Game.CoordScale) / 2;
    Game.CenterY = (480.0f - 480.0f * Game.CoordScale) / 2;
    Game.WobbleX = (float)(sin(Game.WobbleIndex * 0.000654387) + 
        sin(Game.WobbleIndex * 0.000547867)*2 + 
        sin(Game.WobbleIndex * 0.000700133)) * (WOBBLE / 4.0f);
    Game.WobbleY = (float)(sin(Game.WobbleIndex * 0.000537234) + 
        sin(Game.WobbleIndex * 0.000732897) + 
        sin(Game.WobbleIndex * 0.000600613)*2) * (WOBBLE / 4.0f);
    
    
    
#ifdef UNREAL_DITHER
    zoom_unreal(Game.Map, Game.MouseX + Game.CenterX + Game.WobbleX, Game.MouseY + Game.CenterY + Game.WobbleY, Game.CoordScale);    
#else
    zoom(Game.Map, Game.MouseX + Game.CenterX + Game.WobbleX, Game.MouseY + Game.CenterY + Game.WobbleX, Game.CoordScale);    
#endif   
    
    int i;
    int physics_loops = (tick - Game.LastTick) / PHYSICS_MS;
    int j;
    for (i = 0; i < Game.num_characters; i++)
    {
        for (j = 0; j < physics_loops; j++)
            handle_ai(Game.characters[i]);
        if (!Game.GameState)
            return;
        drawCharacter(Game.characters[i]);
    }
    
    target();
    
    for (j = 0; j < physics_loops; j++)
    {
        int physicstick = Game.LastTick - Game.GameStartTick;
        Game.WobbleIndex += PHYSICS_MS;
        
        // spawn VIPs
        if (physicstick >= Game.vip.time)
        {
            
            if (Game.vip.count == 2 && rand() < 2048)
                spawn_ai(1);
            if (Game.vip.count == 1 && rand() < 8192)
                spawn_ai(1);
            if (Game.vip.count == 0)            
                spawn_ai(1);
            Game.vip.time += (int)Game.vip.period;
        }
        // spawn baddies
        if (physicstick >= Game.baddy.time)
        {
            spawn_ai(0);
            Game.baddy.time += (int)Game.baddy.period;
        }
        if (((Game.LastTick / PHYSICS_MS) & 3) == 0) 
            Game.baddy.period--;
        
        if (Game.baddy.period < 3000)
            Game.baddy.period = 3000; // Eventually it will be impossible to kill all bad guys.
        
        Game.LastTick += PHYSICS_MS;     
    }
    
    
    SDL_Flip(Game.Screen);    
}


int oes_game_state (int newstate)
{
	switch ((Game.GameState = newstate)) {
	case 0:
		/* need init */
		break;
	case 1:
		/* main game state. */
		break;
	case 2:
		/* paused state. */
		break;
	case 3:
		/* just unpaused.  Need re-init, transit to 1. */
		break;
	}
}

/*
Alter input grab state.
0 = try to release
1 = try to grab
-1 = toggle whatever it is.
*/
int oes_game_grab (int newstate)
{
	int tryGrabState;

	if (SDL_GetVideoSurface()->flags & SDL_FULLSCREEN) {
		/* Don't release grab in fullscreen. */
		SDL_WM_GrabInput(SDL_GRAB_ON);
		SDL_ShowCursor(0);
		Game.GrabP = 1;
		return 0;
	}
	tryGrabState = (newstate == -1) ? !Game.GrabP : newstate;
	switch (tryGrabState) {
	case 0:
		SDL_WM_GrabInput(SDL_GRAB_OFF);
		Game.GrabP = 0;
		SDL_ShowCursor(1);
		break;
	case 1:
		SDL_ShowCursor(0);
		SDL_WM_GrabInput(SDL_GRAB_ON);
		Game.GrabP = 1;
		break;
	}
	return Game.GrabP;
}

int oes_game_zoom (float amt)
{
	float oldcoord = Game.CoordScale;

	Game.MouseZ += amt;
	if (Game.MouseZ > 1.25) Game.MouseZ = 1.25;
	if (Game.MouseZ < 0.05f) Game.MouseZ = 0.05f;
#ifndef CAMERA_STEPS
	Game.CoordScale = Game.MouseZ;
#else /* CAMERA_STEPS */
	Game.CoordScale = ((int)(Game.MouseZ * 4)) / 4.0f;
	if (Game.CoordScale < 0.05f) Game.CoordScale = 0.05f;
#endif /* CAMERA_STEPS */
	if (oldcoord < Game.CoordScale)
		oes_sound_play(1);
	if (oldcoord > Game.CoordScale)
		oes_sound_play(2);
	return 0;
}

/*
Set paused state.
0 = force play/resume
1 = force pause
-1 = toggle paused state
*/
int oes_game_pause (int newstate)
{
  int tryPause;
  int tick;

  tryPause = newstate;
  if (newstate == -1)
    {
      if (Game.GameState == OESGAME_PAUSED)
          tryPause = 0;
      else
          tryPause = 1;
    }
  tick = SDL_GetTicks();
  switch (tryPause)
    {
      case 0:
        if (Game.GameState == OESGAME_PAUSED)
          {
//printf("UNPAUSING\n");
            /* resume */
            oes_resume();  /* regain system resources. */
            Game.AfterPauseTick = tick;
            Game.GameStartTick += Game.AfterPauseTick - Game.BeforePauseTick;
            Game.GameState = OESGAME_PLAY;
            break;
          }
        break;
      case 1:
        if (Game.GameState == OESGAME_PLAY)
          {
            /* go to pause */
//printf("Pausing\n");
            Game.BeforePauseTick = tick;
            oes_suspend();  /* release system resources. */
            Game.GameState = OESGAME_PAUSED;
          }
        break;
    }
  return tryPause;
}

/* Boss event. */
int
oes_game_hide (int newstate)
{
  SDL_WM_IconifyWindow();
  oes_game_pause(1);
  return 1;
}






/******************/
/* OES Game Binds */
/******************/


/* No-operation */
int oes_bind_nop (int val)
{
  /* do-nothing */
  return 0;
}


/* On-release-only binds */

int oes_bind_grab (int val)
{
	if (val) return 0;
	return oes_game_grab(-1);
}

/* toggle fullscreen... on key release */
int oes_bind_fullscreen (int val)
{
	if (val) return 0;  /* toggle on release. */

	gPrefs.fullscreen = !gPrefs.fullscreen;
	if (((Game.Screen->flags & SDL_FULLSCREEN) == SDL_FULLSCREEN) ^ (gPrefs.fullscreen)) {
		SDL_WM_ToggleFullScreen(Game.Screen);
	}
//	SDL_WM_ToggleFullScreen(Game.Screen);
//	gPrefs.fullscreen = !gPrefs.fullscreen;
	return 0;
}

/* Boss Key */
int oes_bind_hide (int val)
{
	if (val) return 0; /* trigger on release */
	oes_game_hide(1);
	return 0;
}

/* Forceful end of game. */
int
oes_bind_abandon (int pressed)
{
	if (pressed) return 0;
	oes_resume();
	Game.GameOverReason = OESREASON_AWOL;
	return 0;
}


/* On-press binds */

/* paused mode. */
int oes_bind_pause (int val)
{
	if (!val) return 0;
	return oes_game_pause(-1);
}

/* the extra information around the targeting reticles */
int oes_bind_verbosity (int val)
{
	if (!val) return 0;
	Game.verbosity = (Game.verbosity + 1) % 3;
	gPrefs.verbose = Game.verbosity;
	return 0;
}

/* save screenshot */
int oes_bind_screenshot (int val)
{
	if (!val) return 0;
	SDL_SaveBMP(SDL_GetVideoSurface(),"screenshot.bmp");
	screen_shot_number++;
	return 0;
}

int oes_bind_fire (int val)
{
	if (!val) return 0;
	if (Game.GameState == OESGAME_PLAY) {
		if (!Game.Reloading) {
			oes_sound_play(3);
			shoot();
		}
	} else if (Game.GameState = OESGAME_PAUSED) {
		if (Game.LastTick - Game.SemiPause < 500) {
//			Game.GameState = OESGAME_UNPAUSED;
			oes_game_pause(0);
		} else {
			Game.SemiPause = Game.LastTick;
		}
	}
}

/* zooming mode */
int oes_bind_zoom (int val)
{
	Game.ControlState = val ? 1 : 0;
}

/* Zoom in */
int oes_bind_zoomin (int val)
{
	if (!val) return 0;
	if (Game.GameState != OESGAME_PLAY) return 1;
	oes_game_zoom(-0.20f);
	return val;
}

/* Zoom out */
int oes_bind_zoomout (int val)
{
	if (!val) return 0;
	if (Game.GameState != OESGAME_PLAY) return 1;
	oes_game_zoom(0.20f);
	return val;
}



/* Continuous-value binds */

/* Mouse motion, horizontal */
int oes_bind_mhoriz (int val)
{
	if (!Game.GrabP) {
		/* A little confusing if not grabbed... */
		return 1;
	}
	if (Game.GameState != OESGAME_PLAY) return 1;
	if (Game.ControlState == 0) {
		Game.MouseX += val * Game.CoordScale;
		if (Game.MouseX < -320) Game.MouseX = -320;
		if (Game.MouseX > (800 -320)) Game.MouseX = (800 - 320);
	} else {
		0;  /* nothing on horizontal while zoomshift */
	}
	return 0;
}

/* Mouse motion, vertical */
int oes_bind_mvert (int val)
{
	if (!Game.GrabP) {
		/* A little confusing if not grabbed... */
		return 1;
	}
	if (Game.GameState != OESGAME_PLAY) return 1;
	if (Game.ControlState == 0) {
		Game.MouseY += val * Game.CoordScale;
		if (Game.MouseY < -240) Game.MouseY = -240;
		if (Game.MouseY > (600 - 240)) Game.MouseY = (600 - 240);
	} else {
		oes_game_zoom (val * 0.005f);
	}
	return 0;
}

/* Axis, horizontal */
int oes_bind_jhoriz (int val)
{
	if (!Game.GrabP) return 1;
	if (Game.GameState != OESGAME_PLAY) return 1;
	oesjoy.x = (val * oesjoy.scale) / 32767.0;
	return val;
}

/* Axis, vertical */
int oes_bind_jvert (int val)
{
	if (!Game.GrabP) return 1;
	if (Game.GameState != OESGAME_PLAY) return 1;
	oesjoy.y = (val * oesjoy.scale) / 32767.0;
	return val;
}

/* Axis, depth (zoom) */
int oes_bind_jdeep (int val)
{
	float joyz;

	if (!Game.GrabP) return 1;
	if (Game.GameState != OESGAME_PLAY) return 1;
	oesjoy.z = val;
/* XXX: what about going backwards? */
	/*                    out     in  */
	/* map oes.joyz from 1.25 to 0.05 */
	/*                    0     32767 */
	/* deltas: 1.20 : 32767 */
//	joyz = (oesjoy.z * 1.20 / 32767.0) + 0.05;
	joyz = 1.25 - (oesjoy.z * 1.20 / 32767.0);
	Game.MouseZ = joyz;
	oes_game_zoom(0);

	return val;
}









/* After binds. */



/* game binding names (from config file) */
oes_xlat_t oesxlat[] = {
 { "mousex", oes_bind_mhoriz },
 { "mousey", oes_bind_mvert },
 { "joyx", oes_bind_jhoriz },
 { "joyy", oes_bind_jvert },
 { "joyz", oes_bind_jdeep },
 { "fire", oes_bind_fire },
 { "zoom", oes_bind_zoom },
 { "zoomin", oes_bind_zoomin },
 { "zoomout", oes_bind_zoomout },
 { "verbosity", oes_bind_verbosity },
 { "screenshot", oes_bind_screenshot },
 { "fullscreen", oes_bind_fullscreen },
 { "hide", oes_bind_hide },
 { "abandon", oes_bind_abandon },
 { "pause", oes_bind_pause },
 { "grab", oes_bind_grab },
 { 0, 0 },
};




/*******************/
/* Events handling */
/*******************/


/* Called at intervals, handling joystick axes. */
int oes_game_joystick (int ticks)
{
/* Joystick axes handling. */
	int joyx, joyy;
	if (!oesjoy.sdljoy) return 0;
	if (ticks > oesjoy.time + oesjoy.interval) {
//printf("JOY HANDLE\n");
		joyx = (int)(oesjoy.x);
		joyy = (int)(oesjoy.y);
		switch (oesjoy.state) {
		case 0: /* normal */
			oes_bind_mhoriz(joyx);
			oes_bind_mvert(joyy);
			break;
		case 1: /* shifted 1 */
			oes_game_zoom(joyy * 0.005);
			break;
		}
		oesjoy.time = ticks;
	}
}


int oes_game_events ()
{
  SDL_Event event;
  int kmod;
  int oeskey;
  oesbind_t binding; /* function pointer */

  while (SDL_PollEvent(&event))
    {
      switch (event.type)
        {
          case SDL_KEYDOWN:
            binding = NULL;
            kmod = SDL_GetModState();
            oeskey = event.key.keysym.sym;
            switch (event.key.keysym.sym)
              {
                /* Rebindable keys */
                default:
                  binding = oeskeymap_get(&oeskeymap, oeskey);
                  break;
              }
            if (binding)
                binding(1);
            break;
          case SDL_KEYUP:
            binding = NULL;
            kmod = SDL_GetModState();
            oeskey = event.key.keysym.sym;
            switch (event.key.keysym.sym)
              {
                /* Hard-coded keys */
                case SDLK_F12: /* failsafe */
                  exit(69);
                  break;
                case SDLK_F4: /* failsafe */
                  if (kmod & KMOD_ALT) exit(69);
                  break;
                case SDLK_RETURN:
                  if (kmod & KMOD_ALT)
                    {
                      binding = oes_bind_fullscreen;
                    }
                  break;
                case SDLK_z:
                  if (kmod & KMOD_CTRL)
                    {
                      binding = oes_bind_hide;
                    }
                  break;
                case SDLK_g:
                  if (kmod & KMOD_CTRL)
                    {
                      binding = oes_bind_grab;
                    }
                  break;
                /* Rebindable keys */
                default:
                  binding = oeskeymap_get(&oeskeymap, oeskey);
                  break;
              }
            if (binding)
                binding(0);
            break;
          case SDL_MOUSEMOTION:
//            binding = oeskeymap_get(&oeskeymap, oeskeymap_resolve("MOUSEX"));
            binding = oeskeymap_get(&oeskeymap, keymarkers.mousex);
            if (binding)
                binding(event.motion.xrel);
            binding = oeskeymap_get(&oeskeymap, keymarkers.mousey);
            if (binding)
                binding(event.motion.yrel);
//            oes_bind_mhoriz(event.motion.xrel);
//            oes_bind_mvert(event.motion.yrel);
            break;
          case SDL_MOUSEBUTTONDOWN:
//            oeskey = oeskeymap_resolve("MOUSE0") + event.button.button;
            oeskey = keymarkers.mouse0 + event.button.button;
            binding = oeskeymap_get(&oeskeymap, oeskey);
            if (binding)
                binding(1);
            break;
          case SDL_MOUSEBUTTONUP:
            oeskey = keymarkers.mouse0 + event.button.button;
            binding = oeskeymap_get(&oeskeymap, oeskey);
            if (binding)
                binding(0);
            break;
          case SDL_JOYAXISMOTION:
//            oeskey = oeskeymap_resolve("AXIS1") + event.jaxis.axis;
            oeskey = keymarkers.axis1 + event.jaxis.axis;
            binding = oeskeymap_get(&oeskeymap, oeskey);
            if (binding)
              {
                binding(event.jaxis.value);
              }
            break;
          case SDL_JOYBUTTONDOWN:
//            oeskey = oeskeymap_resolve("JOY1") + event.jbutton.button;
            oeskey = keymarkers.joy1 + event.jbutton.button;
            binding = oeskeymap_get(&oeskeymap, oeskey);
            if (binding)
                binding(1);
            break;
          case SDL_JOYBUTTONUP:
            oeskey = keymarkers.joy1 + event.jbutton.button;
            binding = oeskeymap_get(&oeskeymap, oeskey);
            if (binding)
                binding(0);
            break;
          case SDL_QUIT:
            Game.GameOverReason = OESREASON_QUIT;
            return 1;
            break;
          default:
            break;
        } //switch event.type
    } //while SDL_PollEvent

  if (Game.GameState == OESGAME_PAUSED)
    {  /* Don't hog CPU when paused. */
      SDL_Delay(100);
    }
  return 0;
}


/* Main game stub. */
int
oes_game ()
{
  int tick;

  oesjoy.time = Game.LastTick;
  Game.GameStartTick = SDL_GetTicks();
  Game.LastTick = Game.GameStartTick;
  sniperbgm_stimulate(Game.BGM);
  Game.GameOverReason = OESREASON_NONE;

  oes_game_grab(1);
  while (Game.GameOverReason == OESREASON_NONE)
    {
      tick = SDL_GetTicks();
      switch (Game.GameState)
        {
          case OESGAME_CHAOS:
            oes_game_init(&Game);
            sniperbgm_stimulate(Game.BGM);
            Game.GameState = OESGAME_PLAY;
            break;
          case OESGAME_PLAY:
            oes_reindeer();
            break;
          case OESGAME_PAUSED:
            Game.LastTick = tick;
            break;
          case OESGAME_UNPAUSED:
            oes_game_pause(0);
            break;
          default:
            Game.GameState = OESGAME_CHAOS;
            break;
        }
            
      /* SDL events. */
      oes_game_events();
      /* joystick-interval handling. */
      oes_game_joystick(tick);
    }
  Game.GameOverTicks = SDL_GetTicks();
  oes_game_grab(0);
  sniperbgm_depress(Game.BGM);
  Game.GameState = OESGAME_CHAOS;

  if (Game.GameOverReason == OESREASON_QUIT)
      return 0;
  return 1;
}


/* Launche web browser to point to a URI. */
int
oes_web (const char *uri)
{
  char cmd[256];

/* Don't check URI protocol.  Assume browser understands all. */
  oes_game_hide(1);
  snprintf(cmd, sizeof(cmd), "%s \"%s\"", gPrefs.wwwbrowser, uri);
  system(cmd);
}


/* Widget signal fallback (unhandled/unblocked widget signals) */
//int oes_uisignal (oesui_t *gui, const char *signame)
int
oes_uisignal (oesui_t *gui, oesui_signal_t *sig)
{
  const char *signame;
  SDL_Rect r;

  signame = UISIG_NAME(sig);
  if (0);
  else if (0 == strcmp(signame, "start-game"))
    {
      oesui_event(gui, OESUI_CLOSE, 0);
      if (oes_game())
          oesui_open(gui, "gameover");
      else
          gui->retcode = 1;
      return 1;
    }
  else if (0 == strcmp(signame, "go-main"))
    {
      oesui_open(gui, "main");
      return 1;
    }
  else if (0 == strcmp(signame, "go-prefs"))
    {
      oesui_open(gui, "prefs");
      return 1;
    }
  else if (0 == strcmp(signame, "go-scores"))
    {
      oesui_open(gui, "highscores");
      return 1;
    }
  else if (0 == strcmp(signame, "frob-fullscreen"))
    {
      oes_bind_fullscreen(0);
      oesui_event(gui, OESUI_UPDATE, 0);
      return 1;
    }
  else if (0 == strcmp(signame, "frob-audio"))
    {
      gPrefs.audio = !gPrefs.audio;
      oesui_event(gui, OESUI_UPDATE, 0);
      return 1;
    }
  else if (0 == strcmp(signame, "frob-skill"))
    {
      gPrefs.difficulty++;
      if (gPrefs.difficulty > 3)
          gPrefs.difficulty = 1;
      oesui_event(gui, OESUI_UPDATE, 0);
      return 1;
    }
  else if (0 == strcmp(signame, "highscores"))
    {
      r.x = UISIG_ARG(sig, 1).i;
      r.y = UISIG_ARG(sig, 2).i;
      r.w = UISIG_ARG(sig, 3).i;
      r.h = UISIG_ARG(sig, 4).i;
      draw_hiscores(gui->screen, &r);
    }
  else if (0 == strcmp(signame, "gameover"))
    {
      r.x = UISIG_ARG(sig, 1).i;
      r.y = UISIG_ARG(sig, 2).i;
      r.w = UISIG_ARG(sig, 3).i;
      r.h = UISIG_ARG(sig, 4).i;
      draw_gameover(gui->screen, &r);
    }
  else if (0 == strcmp(signame, "quit"))
    {
      gui->retcode = 1;
      return 1;
    }
  else if (0 == strcmp(signame, "url-oes"))
    {
#define WEBBROWSER mozilla
      /* http://www.icculus.org/oes/ */
      oes_web("http://www.icculus.org/oes/");
    }
  else if (0 == strcmp(signame, "url-os"))
    {
      /* http://www.iki.fi/sol/ */
      oes_web("http://www.iki.fi/sol/");
    }
  else if (0 == strcmp(signame, "url-td"))
    {
      /* http://www.timedoctor.org/ */
      oes_web("http://www.timedoctor.org/");
    }
  else if (0 == strcmp(signame, "url-io"))
    {
      /* http://www.icculus.org/ */
      oes_web("http://www.icculus.org/");
    }
  else if (0 == strcmp(signame, "url-ov"))
    {
      /* http://www.vorbis.com/ */
      oes_web("http://www.vorbis.com/");
    }
  return 0;
}


int
oes_binds_init ()
{
 int x;
/* TODO: bind map */
/* sane joystick defaults. */
    oesjoy.style = 0;
    oesjoy.scale = 10.0f;
    oesjoy.interval = 20;
#if 0
    oesjoy.axis[0] = oes_bind_jhoriz;
    oesjoy.axis[1] = oes_bind_jvert;
    oesjoy.axis[2] = oes_bind_jdeep;
    oesjoy.button[0] = oes_bind_fire;
    oesjoy.button[1] = oes_bind_zoom;
    oesjoy.button[2] = oes_bind_zoomout;
    oesjoy.button[3] = oes_bind_zoomin;
#endif /* 0 */

  oeskeymap_init(&oeskeymap);
  oeskeymap_load(&oeskeymap, gPrefs.bindpath);
//  oeskeymap_set(&oeskeymap, SDLK_a, oes_bind_fire); //test
  oeskeymap_set(&oeskeymap, SDLK_v, oes_bind_verbosity, 1);
  oeskeymap_set(&oeskeymap, SDLK_p, oes_bind_pause, 1);
  oeskeymap_set(&oeskeymap, SDLK_s, oes_bind_screenshot, 1);
  oeskeymap_set(&oeskeymap, SDLK_ESCAPE, oes_bind_abandon, 1);
  oeskeymap_set(&oeskeymap, oeskeymap_resolve("MOUSEX"), oes_bind_mhoriz, 1);
  oeskeymap_set(&oeskeymap, oeskeymap_resolve("MOUSEY"), oes_bind_mvert, 1);
  oeskeymap_set(&oeskeymap, oeskeymap_resolve("MOUSE1"), oes_bind_fire, 1);
  oeskeymap_set(&oeskeymap, oeskeymap_resolve("MOUSE2"), oes_bind_zoom, 1);
  oeskeymap_set(&oeskeymap, oeskeymap_resolve("MOUSE4"), oes_bind_zoomin, 1);
  oeskeymap_set(&oeskeymap, oeskeymap_resolve("MOUSE5"), oes_bind_zoomout, 1);
  oeskeymap_set(&oeskeymap, oeskeymap_resolve("JOY1"), oes_bind_fire, 1);
  oeskeymap_set(&oeskeymap, oeskeymap_resolve("JOY2"), oes_bind_zoom, 1);
  oeskeymap_set(&oeskeymap, oeskeymap_resolve("JOY3"), oes_bind_zoomin, 1);
  oeskeymap_set(&oeskeymap, oeskeymap_resolve("JOY4"), oes_bind_zoomout, 1);
  oeskeymap_set(&oeskeymap, oeskeymap_resolve("AXIS1"), oes_bind_jhoriz, 10);
  oeskeymap_set(&oeskeymap, oeskeymap_resolve("AXIS2"), oes_bind_jvert, 10);
  oeskeymap_set(&oeskeymap, oeskeymap_resolve("AXIS3"), oes_bind_jdeep, 10);
  keymarkers.mousex = oeskeymap_resolve("MOUSEX");
  keymarkers.mousey = oeskeymap_resolve("MOUSEY");
  keymarkers.mouse0 = oeskeymap_resolve("MOUSE0");
  keymarkers.axis1 = oeskeymap_resolve("AXIS1");
  keymarkers.joy1 = oeskeymap_resolve("JOY1");

  return 0;
}


int main(int argc, char *argv[])
{
    oesui_t *gui;

    srand(SDL_GetTicks());
   
    Game.mediaPath = (char*)calloc(strlen(argv[0]), sizeof(char));
//   invocation = (char*)malloc(strlen(argv[0]) + 1); memcpy(invocation, argv[0], strlen(argv[0]));
    invocation = strdup(argv[0]);
    sprintf(Game.mediaPath, "%s", dirname(invocation));
    free(invocation);
    invocation = argv[0];

    /* Load Preferences. */
    prefs_init(&gPrefs);
    prefs_load(&gPrefs);
    Game.verbosity = gPrefs.verbose;

    /* Parse options, which may override saved preferences. */
    parse_args(argc, argv);

    oes_binds_init();
    oes_setup ();  /* prefs initialized in here */


    gui = oesui_init_surface(NULL, Game.Screen);  /* initialise gui */
    oesui_load(gui, "menus.cfg");  /* Load gui data */
    oesui_sighandle(gui, oes_uisignal);  /* widget signal handler */
    oesui_open(gui, "main");  /* Main menu */
    oesui_loop(gui);  /* Main UI loop */


    oes_teardown ();
//    delete[] mediaPath;
    free(Game.mediaPath);

//    oes_audio_close();
    return 0;
}


void configure_difficulty()
{
    gPrefs.difficulty = (gPrefs.difficulty < 1 ? 1 : gPrefs.difficulty);
    gPrefs.difficulty = (gPrefs.difficulty > 3 ? 3 : gPrefs.difficulty);
    switch (gPrefs.difficulty)
	{
	case 1:
	    Game.ReloadTime = 1500;
	    Game.ScoreMod = 1.5;
	    break;
	case 2:
	    Game.ReloadTime = 3000;
	    Game.ScoreMod = 1.0;
	    break;
	case 3:
	    Game.ReloadTime = 4000;
	    Game.ScoreMod = 0.5;
	    break;
	}
}

#if 0
void draw_button (SDL_Surface *b, int x, int y)
{
    SDL_Rect d;

    d.x = x;
    d.y = y;
    d.h = 32;
    d.w = 196;

    SDL_BlitSurface (b, NULL, Game.Screen, &d);
}
#endif /* 0 */

SDL_Surface *oes_load_img (const char *path)
{
    SDL_Surface *sfc = NULL;
    char lpath[PATH_MAX];
    snprintf (lpath, PATH_MAX, "%s", path);
    sfc = IMG_Load (lpath);
    if (!sfc) {
	std::cerr << "Unable to load image: " << SDL_GetError() << std::endl;
	exit (1);
    }
    return sfc;
}

#if 0
bool hovering (int x, int y, int w, int h)
{
    int lx, ly;
    SDL_GetMouseState (&lx, &ly);
    if ((lx > x) && (ly > y) &&
	(lx < x + w) && (ly < y + h))
	return true;
    return false;
}
#endif /* 0 */
