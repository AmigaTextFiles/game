#ifndef _THEGOONIES_APP
#define _THEGOONIES_APP


// This is to have a 640x480 screen:
#define PERSPECTIVE_DISTANCE	-895.8F


#define THEGOONIES_STATE_NONE	-1
#define THEGOONIES_STATE_SPLASH		0
#define THEGOONIES_STATE_DISCLAIMER	1
#define THEGOONIES_STATE_MSX		2
#define THEGOONIES_STATE_KONAMI		3
#define THEGOONIES_STATE_TITLE		4
#define THEGOONIES_STATE_GAMESTART	5
#define THEGOONIES_STATE_GAME		6
#define THEGOONIES_STATE_GAMEOVER	7
#define THEGOONIES_STATE_ENDSEQUENCE	8
#define THEGOONIES_STATE_TITLEANIMATION	9
#define THEGOONIES_STATE_INTERLEVEL		10
#define THEGOONIES_STATE_HOWTOPLAY		11
#define THEGOONIES_STATE_CREDITS		12

#define GKEY_UP		0
#define GKEY_RIGHT	1
#define GKEY_DOWN	2
#define GKEY_LEFT	3
#define GKEY_FIRE	4
#define GKEY_PAUSE	5
#define GKEY_QUIT	6


#define PAUSESTATE_PLAYING		0
#define PAUSESTATE_PAUSING		1
#define PAUSESTATE_PAUSED		2
#define PAUSESTATE_UNPAUSING	3


class TheGooniesApp {
public:
	TheGooniesApp();
	~TheGooniesApp();

	bool cycle(KEYBOARDSTATE *k);
	void draw(int SCREEN_X,int SCREEN_Y);

	void save_configuration(void);
	void load_configuration(void);

protected:
	int splash_cycle(KEYBOARDSTATE *k);
	int disclaimer_cycle(KEYBOARDSTATE *k);
	int msx_cycle(KEYBOARDSTATE *k);
	int konami_cycle(KEYBOARDSTATE *k);
	int title_cycle(KEYBOARDSTATE *k);
	int gamestart_cycle(KEYBOARDSTATE *k);
	int game_cycle(KEYBOARDSTATE *k);
	int gameover_cycle(KEYBOARDSTATE *k);
	int endsequence_cycle(KEYBOARDSTATE *k);
	int titleanimation_cycle(KEYBOARDSTATE *k);
	int interlevel_cycle(KEYBOARDSTATE *k);
	int howtoplay_cycle(KEYBOARDSTATE *k);
	int credits_cycle(KEYBOARDSTATE *k);

	void splash_draw(void);
	void disclaimer_draw(void);
	void msx_draw(SFXManager *SFXM);
	void konami_draw(void);
	void title_draw(void);
	void gamestart_draw(void);
	void game_draw(void);
	void gameover_draw(void);
	void endsequence_draw(void);
	void titleanimation_draw(void);
	void interlevel_draw(void);
	void howtoplay_draw(void);
	void credits_draw(void);

	int screen_x(int x);	/* given a coordinate in 640x480, returns the proper coordinate at the current resolution */ 
	int screen_y(int y);    /* given a coordinate in 640x480, returns the proper coordinate at the current resolution */ 

	class GLTManager *m_GLTM;
	class SFXManager *m_SFXM;

	int m_screen_dx,m_screen_dy;
	int m_state;
	int m_state_cycle;
	TheGoonies *m_game;

	VirtualController *m_vc;

	// configuration:
	int m_keys_configuration[7];
	int m_sfx_volume,m_music_volume,m_ambient_volume;

	// intro screens:
	bool m_skip_intro_screens;

	// Title state:
	int m_title_state; // 0 = introducing main title, 1 = introducing a menu, 2 = exiting a menu
	int m_title_option_selected;
	int m_title_music_channel,m_title_music_current_volume;
	int m_title_current_menu;
	int m_title_next_menu;
	char m_title_password[16];
	bool m_title_waiting_keystroke;
	int m_time_since_last_key;

	// Title animation:
	int m_titleanimation_state;
	int m_titleanimation_cycle;

	// Game state:
	int m_game_state;
	int m_current_level;

	// Game over:
	int m_gameover_state;

	// Inter level:
	int m_interlevel_state;
	int m_interlevel_cycle;
	int m_interlevel_music_channel;

	// How to play:
	int m_howtoplay_state;
	int m_howtoplay_cycle;
	int m_howtoplay_difficulty;
	TheGoonies *m_test_game;

	// Credits:
	int m_credits_state;
	int m_credits_cycle;
	
	// end sequence:
	int m_endsequence_state;
	int m_endsequence_cycle;
	int m_endsequence_music_channel;
	
	// Hiscores
	int m_hiscore;
	int get_hiscore(void) {return m_hiscore;};
	void set_hiscore(int newscore) {m_hiscore=newscore;};
	
};

#endif

