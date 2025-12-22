#include "robot.h"
#include "SDL_mixer.h"

static Mix_Music *music  = NULL;
static Mix_Chunk *ball   = NULL;
static Mix_Chunk *discus = NULL;
static Mix_Chunk *robot  = NULL;
static Mix_Chunk *tick   = NULL;
static Mix_Chunk *timeup = NULL;

static void stopaudio(void);

static Mix_Chunk *loadwav(const char *filename)
{
	Mix_Chunk *chunk;
	chunk = Mix_LoadWAV(filename);
	if (chunk == NULL)
		error("Mixer error loading %s: %s", filename, Mix_GetError());
	return chunk;
}

void startaudio(void)
{
	if (SDL_InitSubSystem(SDL_INIT_AUDIO) < 0)
		error("Audio error: %s", SDL_GetError());

#ifdef __WIN32
	if (Mix_OpenAudio(44100, MIX_DEFAULT_FORMAT, 2, 4096) < 0)
#else
	if (Mix_OpenAudio(44100, MIX_DEFAULT_FORMAT, 2, 4096) < 0)
#endif
		error("Mixer error: %s", Mix_GetError());

	music = Mix_LoadMUS(SHAREPATH "REPBEAT.IT");

	if (music == NULL)
		error("Mixer error: %s", Mix_GetError());

	ball   = loadwav(SHAREPATH "ball.wav"  );
	discus = loadwav(SHAREPATH "discus.wav");
	robot  = loadwav(SHAREPATH "robot.wav" );
	tick   = loadwav(SHAREPATH "tick.wav"  );
	timeup = loadwav(SHAREPATH "timeup.wav");

	atexit(stopaudio);

	Mix_PlayMusic(music, -1);
}

static void stopaudio(void)
{
	Mix_FreeChunk(ball);
	Mix_FreeChunk(discus);
	Mix_FreeChunk(robot);
	Mix_FreeChunk(tick);
	Mix_FreeChunk(timeup);
	ball = discus = robot = tick = timeup = NULL;

	Mix_FreeMusic(music);

	Mix_CloseAudio();
}

void playsfx(int sfx)
{
	Mix_Chunk *sample = tick;

	if (sfx == SFX_BALL)
		sample = ball;
	else if (sfx == SFX_DISCUS)
		sample = discus;
	else if (sfx == SFX_ROBOT)
		sample = robot;
	else if (sfx == SFX_TIMEUP)
		sample = timeup;

	Mix_PlayChannel(-1, sample, 0);
}

void pausemusic(void)
{
	Mix_PauseMusic();
}

void unpausemusic(void)
{
	Mix_ResumeMusic();
}
