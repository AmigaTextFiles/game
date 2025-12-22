/* 
 * Copyright (C) 2009  Sean McKean
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "main.h"


SDL_AudioSpec audio_spec,
              wave_spec;

SDL_AudioCVT wave_final[NUM_SAMPLES];

Uint8 *wave_buffer = NULL;

Uint32 wave_length[NUM_SAMPLES] = { 0 },
       do_intro = 1,
       have_sound = 1,
       no_delay = 0;

SDL_Surface *temp = NULL,
            *Screen = NULL,
            *img_sfc = NULL,
            *grid_sfc = NULL,
            *save_grid_sfc = NULL,
            *select_sfc = NULL,
            *select_blit_sfc = NULL,
            *connect_end_sfc = NULL,
            *connect_mask_sfc = NULL,
            *cell_sfc[NUM_CELLS] = { NULL },
            *pl_name_sfc[NUM_PLAYERS] = { NULL },
            *title_text_sfc = NULL,
            *human_turn_sfc = NULL,
            *cpu_turn_sfc = NULL,
            *turn_full_sfc = NULL,
            *points_sfc = NULL,
            *points_full_sfc = NULL,
            *tut_msg_sfc = NULL,
            *tut_grid_sfc = NULL,
            *tut_full_fill_sfc = NULL,
            *tut_fill_sfc[9];

SDL_PixelFormat *fmt = NULL;

SDL_Rect grid_rect = { 0 };

SDL_Event evt;

int img_w = 0,
    img_h = 0,
    end_w = 0,
    end_h = 0,
    font_ch_w = 0,
    font_ch_h = 0,
    which_intro = 0,
    *sample_data = NULL,
    points[NUM_PLAYERS] = { 0 },
    cell_state[NUM_CELLS] = { 0 },
    text_offset[NUM_PLAYERS] = { 0 };

Sint8 *cell_values = NULL;

const int ticks_hold = 1000 / INTRO_FPS_TARGET;

Coord_t offsets[3],
        cell_centers[NUM_CELLS];

Connect_t connectors[NUM_CONNECTORS];

TTF_Font *font = NULL;

char points_text[MAX_NAME_LENGTH + 1] = "Points: 00,11,22,33,44,55",
     pl_name[MAX_NUM_PLAYERS][MAX_NAME_LENGTH + 1],
     def_pl_name[MAX_NUM_PLAYERS][MAX_NAME_LENGTH + 1] =
        { "Player 1", "Player 2", "Player 3",
          "Player 4", "Player 5", "Player 6" };

/* Array palette holds the 256 24-bit (RGB) values for the 8-bit display. */
SDL_Color palette[256] = { { 0, 0, 0 } };

int pl_type[MAX_NUM_PLAYERS],
    pl_color[MAX_NUM_PLAYERS],
    connect_color[MAX_NUM_PLAYERS],
    def_pl_type[MAX_NUM_PLAYERS] = { HUMAN, CPU_HARD, CPU_HARD,
                                     CPU_HARD, CPU_HARD, CPU_HARD },
    def_pl_color[MAX_NUM_PLAYERS] = { RED, GREEN, BLUE,
                                      CYAN, MAGENTA, YELLOW };

int c_index = 0;

Uint8 replay = 0;


Sint8
GetCell(int x, int y)
{
    if (x < 0 || x >= img_w || y < 0 || y >= img_h)
        return -1;

    return cell_values[x + y * img_w];
}


SDL_Surface *
NewSurfaceDefault(int width, int height)
{
    SDL_Surface *sfc = SDL_CreateRGBSurface(
            SURFACE_FLAGS, width, height, fmt->BitsPerPixel,
            fmt->Rmask, fmt->Gmask, fmt->Bmask, fmt->Amask );

    if (sfc == NULL)
    {
        fprintf(stderr, "SDL_CreateRGBSurface: %s\n", SDL_GetError());
        Quit(1);
    }

    SDL_SetColors(sfc, palette, 0, 256);

    return sfc;
}


SDL_Surface *
RenderTextDefault(char *text, Uint8 color)
{
    SDL_Surface *sfc = TTF_RenderText_Solid(font, text, palette[color]);

    if (sfc == NULL)
    {
        fprintf(stderr, "TTF_RenderText_Solid: %s\n", SDL_GetError());
        Quit(4);
    }

    return sfc;
}


void
InitSDLStuff()
{
    SDL_AudioSpec desired;
    SDL_Surface *icon_sfc = NULL;
    Uint32 init_flags = SDL_INIT_VIDEO;
    int i = 0;

    srand(time(NULL));

    if (have_sound)
        init_flags |= SDL_INIT_AUDIO;
    SDL_Init(init_flags);

    if (have_sound)
    {
        /* First setup audio */
        desired.freq = 22050;
        desired.format = AUDIO_U8;
        desired.channels = 2;
        desired.samples = 1024;
        desired.callback = AudioCallback;
        sample_data = (int *)malloc(sizeof(int) * 3);
        desired.userdata = sample_data;
        if (SDL_OpenAudio(&desired, &audio_spec))
        {
            fprintf(stderr, "SDL_OpenAudio: %s\n", SDL_GetError());
            Quit(1);
        }
        LoadWave(DATA_DIR "click.wav", SAMPLE_CLICK);
        LoadWave(DATA_DIR "kcilc.wav", SAMPLE_KCILC);
        LoadWave(DATA_DIR "blip.wav", SAMPLE_BLIP);
        LoadWave(DATA_DIR "bloop.wav", SAMPLE_BLOOP);
        LoadWave(DATA_DIR "cheer.wav", SAMPLE_CHEER);
        LoadWave(DATA_DIR "boo.wav", SAMPLE_BOO);
    }

    /* Setup video mode */
    SDL_WM_SetCaption(APP_NAME, APP_NAME);
    if ((icon_sfc = IMG_Load(DATA_DIR "icon.png")) == NULL)
        fprintf(stderr, "Unable to load icon file: %s\n", IMG_GetError());
    else
    {
        SDL_WM_SetIcon(icon_sfc, NULL);
        SDL_FreeSurface(icon_sfc);
    }
    Screen = SDL_SetVideoMode(SCREEN_W, SCREEN_H, BPP, VIDEO_FLAGS);
    if (Screen == NULL)
    {
        fprintf(stderr, "SDL_SetVideoMode: %s\n", SDL_GetError());
        Quit(2);
    }
    fmt = Screen->format;

    /* Setup TTF support */
    if (TTF_Init())
    {
        fprintf(stderr, "TTF_Init: %s\n", TTF_GetError());
        Quit(4);
    }
    font = TTF_OpenFont(DATA_DIR "FreeMono.ttf", 25);
    TTF_SizeText(font, "x", &font_ch_w, &font_ch_h);

    title_text_sfc = RenderTextDefault(APP_NAME, BLUE);

    SDL_EnableUNICODE(1);  /* Needed for player name entry */
}


void
SetGamePalette()
{
    int i = 0;

    /* First, clear palette of artifacts */
    memset(palette, 0, sizeof(SDL_Color) * 256);

    /* Setup palette */
    for (i = 0; i < RED; ++i)
    {
        palette[i].r = palette[i].g = palette[i].b = i;
    }
    palette[RED].r = 255;
    palette[GREEN].g = 255;
    palette[BLUE].b = 255;
    palette[CYAN].g = palette[CYAN].b = 255;
    palette[MAGENTA].r = palette[MAGENTA].b = 255;
    palette[YELLOW].r = palette[YELLOW].g = 255;
    palette[DARK_RED].r = 127;
    palette[DARK_GREEN].g = 127;
    palette[DARK_BLUE].b = 127;
    palette[DARK_CYAN].g = palette[DARK_CYAN].b = 127;
    palette[DARK_MAGENTA].r = palette[DARK_MAGENTA].b = 127;
    palette[DARK_YELLOW].r = palette[DARK_YELLOW].g = 127;
    palette[DARK_GREY].r = palette[DARK_GREY].g = palette[DARK_GREY].b = 63;
    palette[MED_GREY].r = palette[MED_GREY].g = palette[MED_GREY].b = 127;
    palette[GREY].r = palette[GREY].g = palette[GREY].b = 191;
    palette[LIGHT_GREY].r = 223;
    palette[LIGHT_GREY].g = 223;
    palette[LIGHT_GREY].b = 223;
    palette[WHITE].r = palette[WHITE].g = palette[WHITE].b = 255;

    SDL_SetColors(Screen, palette, 0, 256);
}


void
InitMainData()
{
    SDL_Surface *temp_txt_sfc = NULL;
    SDL_Rect src_rect,
             dst_rect;
    Uint32 pixel = 0,
           max = 0;
    int x = 0,
        y = 0,
        i = 0,
        j = 0,
        v = 0,
        x_near = 0,
        y_near = 0,
        x_prev = 0,
        y_prev = 0;
    double dist = 0.0,
           angle = 0.0,
           x_comp = 0.0,
           y_comp = 0.0;

    turn_full_sfc = NewSurfaceDefault(SCREEN_W, font_ch_h);
    points_full_sfc = SDL_DisplayFormat(turn_full_sfc);
    for (i = 0; i < NUM_PLAYERS; ++i)
    {
        text_offset[i] =
            font_ch_w * (strchr(points_text, i + '0') - points_text);
    }

    temp_txt_sfc = RenderTextDefault("'s turn", BLACK);
    human_turn_sfc = SDL_DisplayFormat(temp_txt_sfc);
    SDL_FillRect(human_turn_sfc, NULL, WHITE);
    SDL_BlitSurface(temp_txt_sfc, NULL, human_turn_sfc, NULL);
    SDL_FreeSurface(temp_txt_sfc);

    temp_txt_sfc = RenderTextDefault("'s turn (thinking)", BLACK);
    cpu_turn_sfc = SDL_DisplayFormat(temp_txt_sfc);
    SDL_FillRect(cpu_turn_sfc, NULL, WHITE);
    SDL_BlitSurface(temp_txt_sfc, NULL, cpu_turn_sfc, NULL);
    SDL_FreeSurface(temp_txt_sfc);

    if (NUM_PLAYERS != MAX_NUM_PLAYERS)
    {
        i = (strrchr(points_text, NUM_PLAYERS + '0') - points_text) - 2;
        if (i < 0)
        {
            fprintf(stderr, "Invalid number of players!\n");
            Quit(1);
        }
        points_text[i] = '\0';
    }
    temp_txt_sfc = RenderTextDefault(points_text, BLACK);
    points_sfc = SDL_DisplayFormat(temp_txt_sfc);
    SDL_FreeSurface(temp_txt_sfc);

    /* Setup various game surfaces */
    if ((img_sfc = IMG_Load(DATA_DIR "grid.png")) == NULL)
    {
        fprintf(stderr, "IMG_Load: %s\n", IMG_GetError());
        Quit(3);
    }
    img_w = img_sfc->w;
    img_h = img_sfc->h;

    save_grid_sfc = SDL_DisplayFormat(img_sfc);
    SDL_FillRect(save_grid_sfc, NULL, WHITE);
    SDL_SetColorKey(save_grid_sfc, SDL_SRCCOLORKEY | SDL_RLEACCEL, WHITE);

    for (i = 0; i < NUM_CELLS; ++i)
    {
        cell_sfc[i] = SDL_DisplayFormat(img_sfc);
        SDL_FillRect(cell_sfc[i], NULL, WHITE);
        SDL_SetColorKey(cell_sfc[i], SDL_SRCCOLORKEY | SDL_RLEACCEL, BLACK);
    }

    cell_values = (Sint8 *)malloc(img_w * img_h * sizeof(Sint8));
    /* Sets all elements of cell_values[] to -1 */
    memset(cell_values, 0xff, img_w * img_h * sizeof(Sint8));

    for (y = 0; y < img_h; ++y)
        for (x = 0; x < img_w; ++x)
        {
            pixel = GetPixel_24bit(img_sfc, x, y);
            if ( (pixel & R_24BIT) == R_24BIT ||
                 (pixel & G_24BIT) == G_24BIT ||
                 (pixel & B_24BIT) == B_24BIT )
            {
                cell_values[x + y * img_w] = -2;
                SetPixel_8bit(save_grid_sfc, x, y, BLACK);
            }
            else if (pixel > 0)
            {
                cell_values[x + y * img_w] = (pixel & 0xff) - 1;
                SetPixel_8bit(cell_sfc[(pixel & 0xff) - 1], x, y, BLACK);
            }
        }

    for (i = 0; i < 3; ++i)
    {
        angle = M_PI / 6.0 + (double)i * 2.0 * M_PI / 3.0;
        dist = 0.0;
        do
        {
            x = dist * cos(angle) + img_w / 2;
            y = dist * sin(angle) + img_h / 2;
            dist += 1.0;
        } while (GetCell(x, y) < 0);
        x_near = x;
        y_near = y;
        do
        {
            x_prev = x;
            y_prev = y;
            x = dist * cos(angle) + img_w / 2;
            y = dist * sin(angle) + img_h / 2;
            dist += 1.0;
        } while (GetCell(x, y) > -1);
        offsets[i].x = (x_prev - x_near) / 2.0;
        offsets[i].y = (y_prev - y_near) / 2.0;
    }

    for (x = img_w / 2; x < img_w; ++x)
        for (y = 0; y < img_h; ++y)
        {
            if ( (v = GetCell(x, y)) > -1 && GetFace(v) == FACE_RIGHT &&
                 cell_centers[v].x == 0 )
            {
                cell_centers[v].x = x + offsets[0].x;
                cell_centers[v].y = y + offsets[0].y;
            }
        }
    for (x = img_w / 2; x >= 0; --x)
        for (y = 0; y < img_h; ++y)
        {
            if ( (v = GetCell(x, y)) > -1 && GetFace(v) == FACE_LEFT &&
                 cell_centers[v].x == 0 )
            {
                cell_centers[v].x = x + offsets[1].x;
                cell_centers[v].y = y + offsets[1].y;
            }
        }
    for (y = img_h / 2; y >= 0; --y)
        for (x = 0; x < img_w; ++x)
        {
            if ( (v = GetCell(x, y)) > -1 && GetFace(v) == FACE_TOP &&
                 cell_centers[v].x == 0 )
            {
                cell_centers[v].x = x + offsets[2].x;
                cell_centers[v].y = y + offsets[2].y;
            }
        }

    /* centers[x]: 0 -> lower-right, 1 -> lower-left, 2 -> top */

    /* Here is the macro to form the structure data used by DrawTriLine */
#define MAKE_CONNECTION(i, center_a, center_b, center_c, height)             \
    connectors[i].centers[0] = &cell_centers[center_a];                      \
    connectors[i].centers[1] = &cell_centers[center_b];                      \
    connectors[i].centers[2] = &cell_centers[center_c];                      \
    connectors[i].core.x = cell_centers[center_c].x;                         \
    connectors[i].core.y = cell_centers[center_c].y +                        \
                           2 * (height) * (1 - offsets[2].y) + offsets[2].y;

    MAKE_CONNECTION( 0, 15, 20,  8, 1)
    MAKE_CONNECTION( 1, 15, 19,  7, 1)
    MAKE_CONNECTION( 2, 15, 18,  6, 1)
    MAKE_CONNECTION( 3, 16, 23,  8, 2)
    MAKE_CONNECTION( 4, 16, 22,  7, 2)
    MAKE_CONNECTION( 5, 16, 21,  6, 2)
    MAKE_CONNECTION( 6, 17, 26,  8, 3)
    MAKE_CONNECTION( 7, 17, 25,  7, 3)
    MAKE_CONNECTION( 8, 17, 24,  6, 3)

    MAKE_CONNECTION( 9, 12, 20,  5, 1)
    MAKE_CONNECTION(10, 12, 19,  4, 1)
    MAKE_CONNECTION(11, 12, 18,  3, 1)
    MAKE_CONNECTION(12, 13, 23,  5, 2)
    MAKE_CONNECTION(13, 13, 22,  4, 2)
    MAKE_CONNECTION(14, 13, 21,  3, 2)
    MAKE_CONNECTION(15, 14, 26,  5, 3)
    MAKE_CONNECTION(16, 14, 25,  4, 3)
    MAKE_CONNECTION(17, 14, 24,  3, 3)

    MAKE_CONNECTION(18,  9, 20,  2, 1)
    MAKE_CONNECTION(19,  9, 19,  1, 1)
    MAKE_CONNECTION(20,  9, 18,  0, 1)
    MAKE_CONNECTION(21, 10, 23,  2, 2)
    MAKE_CONNECTION(22, 10, 22,  1, 2)
    MAKE_CONNECTION(23, 10, 21,  0, 2)
    MAKE_CONNECTION(24, 11, 26,  2, 3)
    MAKE_CONNECTION(25, 11, 25,  1, 3)
    MAKE_CONNECTION(26, 11, 24,  0, 3)

    select_sfc = SDL_DisplayFormat(img_sfc);
    SDL_FillRect(select_sfc, NULL, WHITE);
    SDL_SetColorKey(select_sfc, SDL_SRCCOLORKEY | SDL_RLEACCEL, BLACK);
    for (y = -2; y <= 2; ++y)
        for (x = -2; x <= 2; ++x)
        {
            dst_rect.x = x;
            dst_rect.y = y;
            SDL_BlitSurface(save_grid_sfc, NULL, select_sfc, &dst_rect);
        }
    select_blit_sfc = SDL_DisplayFormat(img_sfc);
    SDL_FillRect(select_blit_sfc, NULL, WHITE);
    SDL_SetColorKey(select_blit_sfc, SDL_SRCCOLORKEY | SDL_RLEACCEL, WHITE);

    end_w = end_h = (int)(CONNECT_END_RADIUS * 2);

    connect_end_sfc = NewSurfaceDefault(end_w, end_h);
    SDL_SetColorKey(connect_end_sfc, SDL_SRCCOLORKEY | SDL_RLEACCEL, WHITE);

    connect_mask_sfc = SDL_DisplayFormat(img_sfc);
    SDL_FillRect(connect_mask_sfc, NULL, WHITE);
    SDL_SetColorKey(connect_mask_sfc, SDL_SRCCOLORKEY | SDL_RLEACCEL, BLACK);

    for (y = 0; y < end_h; ++y)
        for (x = 0; x < end_w; ++x)
        {
            x_comp = CONNECT_END_RADIUS - x - 0.5;
            y_comp = CONNECT_END_RADIUS - y - 0.5;
            if ( x_comp * x_comp + y_comp * y_comp <
                 CONNECT_END_RADIUS * CONNECT_END_RADIUS )
                SetPixel_8bit(connect_mask_sfc, x, y, BLACK);
        }

    tut_msg_sfc = IMG_Load(DATA_DIR "tut-text.png");
    if (tut_msg_sfc == NULL)
    {
        fprintf(stderr, "IMG_Load: %s\n", IMG_GetError());
        Quit(3);
    }
    tut_grid_sfc = IMG_Load(DATA_DIR "tut-grid.png");
    if (tut_grid_sfc == NULL)
    {
        fprintf(stderr, "IMG_Load: %s\n", IMG_GetError());
        Quit(3);
    }
    tut_full_fill_sfc = IMG_Load(DATA_DIR "tut-grid-fill.png");
    if (tut_full_fill_sfc == NULL)
    {
        fprintf(stderr, "IMG_Load: %s\n", IMG_GetError());
        Quit(3);
    }
    src_rect.x = 0;
    src_rect.w = tut_full_fill_sfc->w;
    src_rect.h = tut_full_fill_sfc->h;
    for (i = 0; i < 9; ++i)
    {
        tut_fill_sfc[i] = NewSurfaceDefault( tut_full_fill_sfc->w,
                                             tut_full_fill_sfc->h / 9 );
        SDL_SetColorKey(tut_fill_sfc[i], SDL_SRCCOLORKEY, WHITE);
        src_rect.y = i * tut_fill_sfc[i]->h;
        SDL_BlitSurface(tut_full_fill_sfc, &src_rect, tut_fill_sfc[i], NULL);
    }

    grid_rect.x = Screen->w / 2 - img_w / 2;
    grid_rect.y = Screen->h / 2 - img_h / 2;

    temp = SDL_DisplayFormat(img_sfc);
    SDL_SetColorKey(temp, SDL_SRCCOLORKEY, WHITE);

    SDL_FillRect(Screen, NULL, WHITE);
}


void
LoadWave(char *fname, Uint16 index)
{
    if ( SDL_LoadWAV( fname, &wave_spec, &wave_buffer,
                      &wave_length[index] ) == NULL )
    {
        fprintf(stderr, "SDL_LoadWAV: File %s: %s\n", fname, SDL_GetError());
        Quit(1);
    }
    if (index == SAMPLE_BLOOP)
        wave_spec.freq = 44100;
    if ( SDL_BuildAudioCVT( &wave_final[index], wave_spec.format,
                            wave_spec.channels, wave_spec.freq,
                            audio_spec.format, audio_spec.channels,
                            audio_spec.freq ) == -1 )
    {
        fprintf(stderr, "SDL_BuildAudioCVT: %s\n", SDL_GetError());
        Quit(1);
    }
    wave_final[index].buf =
        (Uint8 *)malloc(wave_length[index] * wave_final[index].len_mult);
    memcpy(wave_final[index].buf, wave_buffer, wave_length[index]);
    SDL_FreeWAV(wave_buffer);
    wave_buffer = NULL;
    wave_final[index].len = wave_length[index];
    if (SDL_ConvertAudio(&wave_final[index]))
    {
        fprintf(stderr, "SDL_ConvertAudio: %s\n", SDL_GetError());
        Quit(1);
    }
    wave_length[index] =
        (int)(wave_length[index] * wave_final[index].len_ratio);
}

/*
 *  Get game info from config file, or if it does not exist, add
 *  default values.
 */

void
ReadDataFromFile()
{
    int config_found = 0,
        i = 0,
        j = 0;
    char c = 0;
    FILE *config_file = NULL;
    DIR *local_dir = NULL;
    struct dirent *de = NULL;

    local_dir = opendir(".");
    config_found = 0;
    while ((de = readdir(local_dir)) != NULL)
    {
        if (strcmp(de->d_name, "config.txt") == 0)
            config_found = 1;
    }
    if (config_found == 0)
    {
        CleanupFileError();
        closedir(local_dir);
        return;
    }
    config_file = fopen("config.txt", "r");
    for (i = 0; i < NUM_PLAYERS; ++i)
    {
        /*
         *  File is probably if first character read isn't a
         *  double-quote.
         */
        if (i == 0 && (c = fgetc(config_file)) != '"')
        {
            CleanupFileError();
            fclose(config_file);
            closedir(local_dir);
            return;
        }

        if (i != 0)
            while ((c = fgetc(config_file)) != '"')
                if (feof(config_file))
                {
                    CleanupFileError();
                    fclose(config_file);
                    closedir(local_dir);
                    return;
                }

        if (c == '"')
        {
            for ( j = 0;
                  (c = fgetc(config_file)) != '"' && j < MAX_NAME_LENGTH;
                  ++j )
            {
                pl_name[i][j] = c;
            }
            pl_name[i][j] = '\0';
        }
        else
            sprintf(pl_name[i], "%s", def_pl_name[i]);

        fscanf(config_file, "%d %d", &pl_color[i], &pl_type[i]);
        if (pl_color[i] < RED || pl_color[i] > YELLOW)
            pl_color[i] = def_pl_color[i];
        if (pl_type[i] < HUMAN || pl_type[i] > CPU_HARD)
            pl_type[i] = def_pl_type[i];
        /* Set the connect color (a darker shade of pl_color[i]) */
        connect_color[i] = pl_color[i] + MAX_NUM_PLAYERS;
    }
    fscanf(config_file, "%d", &which_intro);
    if (which_intro < 1 || which_intro > NUM_INTROS)
        which_intro = 1;

    fclose(config_file);

    closedir(local_dir);
}


void
CleanupFileError()
{
    int i = 0;

    fprintf( stderr,
             "Error reading configuration file, "
             "setting up default values.\n" );
    for (i = 0; i < NUM_PLAYERS; ++i)
    {
        sprintf(pl_name[i], "%s", def_pl_name[i]);
        pl_color[i] = def_pl_color[i];
        pl_type[i] = def_pl_type[i];
    }
    which_intro = 1;
}


void
WriteDataToFile()
{
    int i = 0;
    FILE *config_file = NULL;

    /* Write the info back to the file after data is updated */
    config_file = fopen("config.txt", "w");
    for (i = 0; i < NUM_PLAYERS; ++i)
    {
        fprintf(config_file, "\"%s\"\n", pl_name[i]);
        fprintf(config_file, "%d %d\n", pl_color[i], pl_type[i]);
    }
    fprintf(config_file, "%d\n", (which_intro % NUM_INTROS) + 1);

    fclose(config_file);
}


void
ResetData()
{
    int i = 0;

    /* Sets all elements of cell_state[] to -1 */
    memset(cell_state, 0xff, NUM_CELLS * sizeof(int));
    /* Sets all elements of points[] to 0 */
    memset(points, 0, NUM_PLAYERS * sizeof(int));
    c_index = 0;

    grid_sfc = SDL_DisplayFormat(save_grid_sfc);

    if (have_sound)
    {
        sample_data[INDEX] = -1;
        sample_data[OFFSET] = 0;
        sample_data[PANNING] = PAN_NORMAL;
        SDL_PauseAudio(0);
    }

    ReadDataFromFile();

    GetPlayerData();

    WriteDataToFile();

    /* Run the intro animation (any one of three) if desired. */
    if (do_intro)
        ShowGridAnimation(which_intro - 1);

    SDL_FillRect(select_blit_sfc, NULL, WHITE);
    RenderTurnText(0);
}


void
GetPlayerData()
{
    SDL_Surface *color_select_sfc = NULL,
                *human_pl_sfc = NULL,
                *cpu_m_sfc = NULL,
                *cpu_h_sfc = NULL,
                *st_btn_sfc = NULL,
                *st_txt_sfc = NULL,
                *settings_txt_sfc = NULL,
                *tutorial_txt_sfc = NULL,
                *name_txt_sfc = NULL,
                *color_txt_sfc = NULL,
                *type_txt_sfc = NULL,
                *current_txt_sfc = NULL,
                *temp_txt_sfc = NULL;
    SDL_Rect src_rect,
             dst_rect,
             hit_rect[NUM_HIT_RECTS],
             title_dst_rect = { Screen->w / 2 - title_text_sfc->w / 2, 0 };
    SDL_Color fade_palette[256],
              *color;
    char name_buffer[MAX_NAME_LENGTH + 1];
    Uint16 unicode = 0;
    int offset_y[NUM_PLAYERS],
        mb_left_down = 0,
        set_pl_name = -1,
        time_count = 0,
        name_buf_i = 0,
        exit_loop = 0,
        color_set = 0,
        fade_out = -1,
        data_ok = 0,
        m_x = 0,
        m_y = 0,
        i = 0,
        j = 0,
        x = 0,
        y = 0;

    SDL_SetColors(title_text_sfc, &palette[BLUE], 1, 1);

    settings_txt_sfc = RenderTextDefault("Settings", BLACK);

    for (i = 0; i < NUM_PLAYERS; ++i)
    {
        if (pl_name_sfc[i] != NULL)
            SDL_FreeSurface(pl_name_sfc[i]);
        pl_name_sfc[i] = RenderTextDefault(pl_name[i], BLACK);
    }

    color_select_sfc = NewSurfaceDefault(90, 60);
    SDL_FillRect(color_select_sfc, NULL, WHITE);
    DrawRect_8bit(color_select_sfc, 2, 2, 26, 26, 0, RED);
    DrawRect_8bit(color_select_sfc, 32, 2, 26, 26, 0, GREEN);
    DrawRect_8bit(color_select_sfc, 62, 2, 26, 26, 0, BLUE);
    DrawRect_8bit(color_select_sfc, 2, 32, 26, 26, 0, CYAN);
    DrawRect_8bit(color_select_sfc, 32, 32, 26, 26, 0, MAGENTA);
    DrawRect_8bit(color_select_sfc, 62, 32, 26, 26, 0, YELLOW);

    human_pl_sfc = IMG_Load(DATA_DIR "mouse.png");
    if (human_pl_sfc == NULL)
    {
        fprintf(stderr, "IMG_Load: %s\n", IMG_GetError());
        Quit(3);
    }
    cpu_m_sfc = IMG_Load(DATA_DIR "pc-med.png");
    if (cpu_m_sfc == NULL)
    {
        fprintf(stderr, "IMG_Load: %s\n", IMG_GetError());
        Quit(3);
    }
    cpu_h_sfc = IMG_Load(DATA_DIR "pc-hard.png");
    if (cpu_h_sfc == NULL)
    {
        fprintf(stderr, "IMG_Load: %s\n", IMG_GetError());
        Quit(3);
    }

    st_txt_sfc = RenderTextDefault("start", WHITE);
    st_btn_sfc = NewSurfaceDefault(st_txt_sfc->w + 4, st_txt_sfc->h + 4);
    SDL_FillRect(st_btn_sfc, NULL, GREY);

    tutorial_txt_sfc = RenderTextDefault("Press 't' for tutorial", BLACK);
    name_txt_sfc = RenderTextDefault("Set player name", BLACK);
    color_txt_sfc = RenderTextDefault("Set player color", BLACK);
    type_txt_sfc = RenderTextDefault("Set player type (human/pc)", BLACK);

    offset_y[0] = 2 * font_ch_h;
    offset_y[1] = 4 * font_ch_h;
    offset_y[2] = 6 * font_ch_h;

#define SET_HIT_RECT(index, _x, _y, _w, _h)  \
        hit_rect[index].x = _x;              \
        hit_rect[index].y = _y;              \
        hit_rect[index].w = _w;              \
        hit_rect[index].h = _h;              

    for (i = 0; i < NUM_PLAYERS; ++i)
    {
        j = i * NUM_PLAYER_HIT_RECTS;

        /* Player name */
        SET_HIT_RECT(j, 0, offset_y[i], SCREEN_W / 2, font_ch_h + 4)

        /* Six player colors */
        SET_HIT_RECT(j + 1, SCREEN_W / 2, offset_y[i], 30, 30)
        SET_HIT_RECT(j + 2, SCREEN_W / 2 + 30, offset_y[i], 30, 30)
        SET_HIT_RECT(j + 3, SCREEN_W / 2 + 60, offset_y[i], 30, 30)
        SET_HIT_RECT(j + 4, SCREEN_W / 2, offset_y[i] + 30, 30, 30)
        SET_HIT_RECT(j + 5, SCREEN_W / 2 + 30, offset_y[i] + 30, 30, 30)
        SET_HIT_RECT(j + 6, SCREEN_W / 2 + 60, offset_y[i] + 30, 30, 30)

        /* Two player types */
        SET_HIT_RECT( j + 7,
                      SCREEN_W / 2 + color_select_sfc->w, offset_y[i],
                      human_pl_sfc->w + 4, human_pl_sfc->h + 4 )
        SET_HIT_RECT( j + 8,
                      SCREEN_W / 2 + color_select_sfc->w + human_pl_sfc->w + 4,
                      offset_y[i], cpu_m_sfc->w + 4, cpu_m_sfc->h + 4 )
        SET_HIT_RECT( j + 9,
                      SCREEN_W / 2 + color_select_sfc->w + human_pl_sfc->w +
                      cpu_m_sfc->w + 8, offset_y[i],
                      cpu_h_sfc->w + 4, cpu_h_sfc->h + 4 )
    }

    hit_rect[BTN_HIT_RECT].x = Screen->w / 2 - st_btn_sfc->w / 2;
    hit_rect[BTN_HIT_RECT].y = Screen->h - st_btn_sfc->h - font_ch_h - 5;
    hit_rect[BTN_HIT_RECT].w = st_btn_sfc->w;
    hit_rect[BTN_HIT_RECT].h = st_btn_sfc->h;

    for (i = 0; i < NUM_PLAYERS; ++i)
        connect_color[i] = pl_color[i] + MAX_NUM_PLAYERS;

    data_ok = 1;
    for (i = 0; i < NUM_PLAYERS - 1 && data_ok; ++i)
        for (j = i + 1; j < NUM_PLAYERS && data_ok; ++j)
            if (pl_color[i] == pl_color[j])
                data_ok = 0;

    time_count = SDL_GetTicks();

    while (!exit_loop)
    {
        if (fade_out == -1)
        {
            SDL_GetMouseState(&m_x, &m_y);

            current_txt_sfc = tutorial_txt_sfc;
            for (i = 0; i < BTN_HIT_RECT; ++i)
            {
                if ( m_x >= hit_rect[i].x &&
                     m_x < hit_rect[i].x + hit_rect[i].w &&
                     m_y >= hit_rect[i].y &&
                     m_y < hit_rect[i].y + hit_rect[i].h )
                {
                    x = i % NUM_PLAYER_HIT_RECTS;
                    y = i / NUM_PLAYER_HIT_RECTS;

                    if (x == 0)
                        current_txt_sfc = name_txt_sfc;
                    else if (x < 7)
                        current_txt_sfc = color_txt_sfc;
                    else if (x < 10)
                        current_txt_sfc = type_txt_sfc;
                }
            }

            if (mb_left_down)
            {
                for (i = 0; i < NUM_HIT_RECTS; ++i)
                {
                    if ( m_x >= hit_rect[i].x &&
                         m_x < hit_rect[i].x + hit_rect[i].w &&
                         m_y >= hit_rect[i].y &&
                         m_y < hit_rect[i].y + hit_rect[i].h )
                    {
                        if (i == BTN_HIT_RECT)
                        {
                            if (data_ok == 1)
                                fade_out = 0;
                        }
                        else
                        {
                            x = i % NUM_PLAYER_HIT_RECTS;
                            y = i / NUM_PLAYER_HIT_RECTS;

                            /* Change a player's name */
                            if (x == 0)
                            {
                                if (set_pl_name != y)
                                {
                                    if (set_pl_name > -1 && name_buf_i > 0)
                                    {
                                        snprintf( pl_name[set_pl_name],
                                                  MAX_NAME_LENGTH,
                                                  "%s", name_buffer );
                                        pl_name_sfc[set_pl_name] =
                                            RenderTextDefault(
                                                    pl_name[set_pl_name],
                                                    BLACK );
                                    }
                                    PlaySound(SAMPLE_CLICK, PAN_NORMAL);
                                    set_pl_name = y;
                                    name_buf_i = 0;
                                    name_buffer[0] = '\0';
                                }
                                else if (set_pl_name > -1)
                                {
                                    if (name_buf_i > 0)
                                    {
                                        snprintf( pl_name[set_pl_name],
                                                  MAX_NAME_LENGTH,
                                                  "%s", name_buffer );
                                        pl_name_sfc[set_pl_name] =
                                            RenderTextDefault(
                                                    pl_name[set_pl_name],
                                                    BLACK );
                                    }
                                    PlaySound(SAMPLE_CLICK, PAN_NORMAL);
                                    set_pl_name = -1;
                                    name_buf_i = 0;
                                    name_buffer[0] = '\0';
                                }
                            }
                            /* Change a player's color */
                            else if (x < 7)
                            {
                                if (pl_color[y] != x - 1 + RED)
                                {
                                    PlaySound(SAMPLE_CLICK, PAN_NORMAL);
                                    pl_color[y] = x - 1 + RED;
                                    color_set = 1;
                                }
                            }
                            /* Change a player's type */
                            else if (x < 10)
                            {
                                if (pl_type[y] != x - 7 + HUMAN)
                                {
                                    PlaySound(SAMPLE_CLICK, PAN_NORMAL);
                                    pl_type[y] = x - 7 + HUMAN;
                                }
                            }
                        }
                    }
                }
                if (color_set)
                {
                    for (i = 0; i < NUM_PLAYERS; ++i)
                        connect_color[i] = pl_color[i] + MAX_NUM_PLAYERS;
                    color_set = 0;
                }

                mb_left_down = 0;
            }

            data_ok = 1;
            for (i = 0; i < NUM_PLAYERS - 1 && data_ok; ++i)
                for (j = i + 1; j < NUM_PLAYERS && data_ok; ++j)
                    if (pl_color[i] == pl_color[j])
                        data_ok = 0;

            if (set_pl_name > -1)
                data_ok = 0;

            SDL_FillRect(Screen, NULL, WHITE);
            SDL_BlitSurface(title_text_sfc, NULL, Screen, &title_dst_rect);
            dst_rect.x = SCREEN_W / 2 - settings_txt_sfc->w / 2;
            dst_rect.y = font_ch_h - 4;
            SDL_BlitSurface(settings_txt_sfc, NULL, Screen, &dst_rect);

            /* Draw a rectangle around the name we are setting, if any */
            if (set_pl_name > -1)
            {
                i = set_pl_name * NUM_PLAYER_HIT_RECTS;
                DrawRect_8bit( Screen, hit_rect[i].x, hit_rect[i].y,
                               hit_rect[i].w, hit_rect[i].h, 2, BLACK );
            }

            for (i = 0; i < NUM_PLAYERS; ++i)
            {
                dst_rect.x = 2;
                dst_rect.y = offset_y[i] + 2;
                if (set_pl_name == i && name_buf_i > 0)
                {
                    temp_txt_sfc = RenderTextDefault(name_buffer, GREY);
                    src_rect.x = MAX(0, temp_txt_sfc->w + 4 - SCREEN_W / 2);
                    src_rect.w = temp_txt_sfc->w - src_rect.x;
                    src_rect.y = 0;
                    src_rect.h = font_ch_h;
                    SDL_BlitSurface( temp_txt_sfc, &src_rect,
                                     Screen, &dst_rect );
                    SDL_FreeSurface(temp_txt_sfc);
                }
                else
                {
                    src_rect.x = 0;
                    src_rect.w = SCREEN_W / 2;
                    src_rect.y = 0;
                    src_rect.h = font_ch_h;
                    SDL_BlitSurface( pl_name_sfc[i], &src_rect,
                                     Screen, &dst_rect );
                }
                dst_rect.x = SCREEN_W / 2;
                dst_rect.y -= 2;
                SDL_BlitSurface(color_select_sfc, NULL, Screen, &dst_rect);
                dst_rect.x += color_select_sfc->w + 2;
                dst_rect.y += 2;
                SDL_BlitSurface(human_pl_sfc, NULL, Screen, &dst_rect);
                dst_rect.x += human_pl_sfc->w + 4;
                SDL_BlitSurface(cpu_m_sfc, NULL, Screen, &dst_rect);
                dst_rect.x += cpu_m_sfc->w + 4;
                SDL_BlitSurface(cpu_h_sfc, NULL, Screen, &dst_rect);

                dst_rect.x = SCREEN_W / 2 - current_txt_sfc->w / 2;
                dst_rect.y = SCREEN_H - font_ch_h;
                DrawRect_8bit( Screen, 0, dst_rect.y, SCREEN_W, font_ch_h,
                               0, WHITE );
                SDL_BlitSurface(current_txt_sfc, NULL, Screen, &dst_rect);

                /* Draw surrounding rectangles */
                j = i * NUM_PLAYER_HIT_RECTS;

                if (pl_color[i] >= RED && pl_color[i] <= YELLOW)
                {
                    x = HR_RED + pl_color[i] - RED;
                    DrawRect_8bit( Screen,
                                   hit_rect[x + j].x, hit_rect[x + j].y,
                                   hit_rect[x + j].w, hit_rect[x + j].h,
                                   2, BLACK );
                }
                else
                {
                    fprintf( stderr, "Invalid color type: %d, %d\n",
                             i, pl_color[i] );
                }

                if (pl_type[i] >= HUMAN && pl_type[i] <= CPU_HARD)
                {
                    x = HR_HUMAN + pl_type[i] - HUMAN;
                    DrawRect_8bit( Screen,
                                   hit_rect[x + j].x, hit_rect[x + j].y,
                                   hit_rect[x + j].w, hit_rect[x + j].h,
                                   2, BLACK );
                }
                else
                {
                    fprintf( stderr, "Invalid player type: %d, %d\n",
                             i, pl_type[i] );
                }
            }

            if (data_ok == 1)
            {
                DrawRect_8bit( st_btn_sfc,
                               0, 0, st_btn_sfc->w, st_btn_sfc->h,
                               BUTTON_BORDER_SIZE, DARK_GREEN );
                SDL_SetColors(st_txt_sfc, &palette[DARK_GREEN], 1, 1);
                dst_rect.x = BUTTON_BORDER_SIZE;
                dst_rect.y = BUTTON_BORDER_SIZE;
                SDL_BlitSurface(st_txt_sfc, NULL, st_btn_sfc, &dst_rect);
            }
            else
            {
                DrawRect_8bit( st_btn_sfc,
                               0, 0, st_btn_sfc->w, st_btn_sfc->h,
                               BUTTON_BORDER_SIZE, DARK_RED );
                SDL_SetColors(st_txt_sfc, &palette[DARK_RED], 1, 1);
                dst_rect.x = BUTTON_BORDER_SIZE;
                dst_rect.y = BUTTON_BORDER_SIZE;
                SDL_BlitSurface(st_txt_sfc, NULL, st_btn_sfc, &dst_rect);
            }

            if (data_ok)
            {
                if ( m_x >= hit_rect[BTN_HIT_RECT].x &&
                     m_x < hit_rect[BTN_HIT_RECT].x +
                     hit_rect[BTN_HIT_RECT].w &&
                     m_y >= hit_rect[BTN_HIT_RECT].y &&
                     m_y < hit_rect[BTN_HIT_RECT].y +
                     hit_rect[BTN_HIT_RECT].h )
                {
                    DrawRect_8bit( st_btn_sfc, 0, 0,
                                   st_btn_sfc->w, st_btn_sfc->h,
                                   BUTTON_BORDER_SIZE, GREEN );
                }
                else
                {
                    DrawRect_8bit( st_btn_sfc, 0, 0,
                                   st_btn_sfc->w, st_btn_sfc->h,
                                   BUTTON_BORDER_SIZE, DARK_GREEN );
                }
            }

            SDL_BlitSurface(st_btn_sfc, NULL, Screen, &hit_rect[BTN_HIT_RECT]);

            SDL_UpdateRect(Screen, 0, 0, 0, 0);
        }
        else  /* Fading out to game display */
        {
            fade_out += FADE_DELTA;
            if (fade_out >= 256)
            {
                fade_out = 256;
                exit_loop = LEAVE_LOOP;
            }

            /* Fade all colors to white, then move to the play screen */
            for (i = 0; i < 256; ++i)
            {
                fade_palette[i].r = palette[i].r +
                    (int)((255.0f - palette[i].r) * (float)fade_out / 256.0);
                fade_palette[i].g = palette[i].g +
                    (int)((255.0f - palette[i].g) * (float)fade_out / 256.0);
                fade_palette[i].b = palette[i].b +
                    (int)((255.0f - palette[i].b) * (float)fade_out / 256.0);
            }

            SDL_SetColors(Screen, fade_palette, 0, 256);

            SDL_UpdateRect(Screen, 0, 0, 0, 0);

            while (SDL_GetTicks() - time_count < ticks_hold)
                SDL_Delay(1);
            time_count = SDL_GetTicks();
        }

        while (SDL_PollEvent(&evt))
        {
            switch (evt.type)
            {
                case SDL_QUIT:
                    exit_loop = QUIT;
                    break;

                case SDL_KEYDOWN:
                    if (evt.key.keysym.sym == SDLK_ESCAPE)
                    {
                        if (set_pl_name == -1)
                            exit_loop = QUIT;
                        else
                        {
                            /*
                             *  If setting a name and escape is pressed,
                             *  de-select name and don't set it.
                             */
                            set_pl_name = -1;
                        }
                    }
                    else if (evt.key.keysym.sym == SDLK_RETURN)
                    {
                        if (set_pl_name > -1)
                        {
                            if (name_buf_i > 0)
                            {
                                snprintf( pl_name[set_pl_name],
                                          MAX_NAME_LENGTH, "%s", name_buffer );
                                SDL_FreeSurface(pl_name_sfc[set_pl_name]);
                                pl_name_sfc[set_pl_name] =
                                    RenderTextDefault(
                                            pl_name[set_pl_name], BLACK );
                            }
                            set_pl_name = -1;
                        }
                        else if (data_ok == 1 && fade_out == -1)
                            fade_out = 0;
                    }
                    else if (set_pl_name > -1)  /* Setting a name */
                    {
                        if (evt.key.keysym.sym == SDLK_BACKSPACE)
                        {
                            if (name_buf_i > 0)
                                name_buffer[--name_buf_i] = '\0';
                        }
                        else if (name_buf_i < MAX_NAME_LENGTH)
                        {
                            unicode = evt.key.keysym.unicode;
                            if (unicode >= ' ')
                            {
                                name_buffer[name_buf_i++] = unicode;
                                name_buffer[name_buf_i] = '\0';
                            }
                        }
                    }
                    else if (evt.key.keysym.sym == SDLK_t)
                    {
                        ShowTutorialScreen();
                    }
                    break;

                case SDL_MOUSEBUTTONDOWN:
                    if (fade_out > -1)
                        exit_loop = LEAVE_LOOP;
                    else if (evt.button.button == 1)
                        mb_left_down = 1;
                    break;
            }
        }
    }

    SDL_FreeSurface(color_select_sfc);
    SDL_FreeSurface(human_pl_sfc);
    SDL_FreeSurface(cpu_m_sfc);
    SDL_FreeSurface(cpu_h_sfc);
    SDL_FreeSurface(st_btn_sfc);
    SDL_FreeSurface(st_txt_sfc);
    SDL_FreeSurface(settings_txt_sfc);
    SDL_FreeSurface(name_txt_sfc);
    SDL_FreeSurface(color_txt_sfc);
    SDL_FreeSurface(type_txt_sfc);
    SDL_FreeSurface(tutorial_txt_sfc);

    if (exit_loop == QUIT)
        Quit(0);

    SDL_FillRect(Screen, NULL, WHITE);

    SetGamePalette();

    /* Reset colors of player names */
    for (i = 0; i < NUM_PLAYERS; ++i)
    {
        color = &palette[pl_color[i]];
        SDL_SetColors(pl_name_sfc[i], color, 1, 1);
    }
}


void
ShowTutorialScreen()
{
    SDL_Rect src_rect,
             dst_rect;
    int exit_loop = 0,
        m_x = 0,
        m_y = 0,
        i = 0,
        j = 0,
        x = 0,
        y = 0;

    j = -1;

    while (!exit_loop)
    {
        SDL_GetMouseState(&m_x, &m_y);
        m_x -= SCREEN_W / 2 - tut_grid_sfc->w / 2;
        m_y -= SCREEN_H - tut_grid_sfc->h - 4;

        for (i = 0; i < 9; ++i)
        {
            if ( m_x >= 0 && m_x < tut_grid_sfc->w &&
                 m_y >= 0 && m_y < tut_grid_sfc->h &&
                 GetPixel_8bit(tut_fill_sfc[i], m_x, m_y) == BLUE )
                j = i;
        }

        SDL_FillRect(Screen, NULL, WHITE);

        SDL_BlitSurface(tut_msg_sfc, NULL, Screen, NULL);
        dst_rect.x = SCREEN_W / 2 - tut_grid_sfc->w / 2;
        dst_rect.y = SCREEN_H - tut_grid_sfc->h - 4;
        SDL_BlitSurface(tut_grid_sfc, NULL, Screen, &dst_rect);
        if (j > -1)
        {
            SDL_BlitSurface(tut_fill_sfc[j], NULL, Screen, &dst_rect);
        }

        SDL_UpdateRect(Screen, 0, 0, 0, 0);

        while (SDL_PollEvent(&evt))
        {
            switch (evt.type)
            {
                case SDL_QUIT:
                    exit_loop = QUIT;
                    break;

                case SDL_KEYDOWN:
                case SDL_MOUSEBUTTONDOWN:
                    exit_loop = LEAVE_LOOP;
                    if (evt.key.keysym.sym == SDLK_SPACE)
                        SDL_SaveBMP(Screen, "sshots/ss2.bmp");
                    break;
            }
        }
    }

    if (exit_loop == QUIT)
        Quit(0);
}


void
ShowLogo()
{
    SDL_Surface *text_sfc[2] = { NULL, NULL };
    SDL_Color color[2] = { { 255, 255, 255 }, { 255, 255, 255 } },
              title_color = { 255, 255, 255 };
    SDL_Rect dst_rect;
    int i = 0,
        display_title = 0,
        title_shade = 255,
        hold_count = 0,
        time_count = 0,
        exit_loop = 0,
        fade_out = 0,
        shade[2] = { 255, 255 };

    /* Set Screen palette to basic greyscale */
    for (i = 0; i < 256; ++i)
        palette[i].r = palette[i].g = palette[i].b = i;
    SDL_SetColors(Screen, palette, 0, 256);

    text_sfc[0] = RenderTextDefault("Gamechild Software", WHITE);
    text_sfc[1] = RenderTextDefault("Presents", WHITE);

    time_count = SDL_GetTicks();

    while (!exit_loop)
    {
        SDL_FillRect(Screen, NULL, WHITE);
        if (display_title)
        {
            if (title_shade <= 0)
            {
                title_shade = 0;
                dst_rect.y -= TEXT_MOVE_DELTA;
                if (dst_rect.y <= 0)
                {
                    dst_rect.y = 0;
                    exit_loop = LEAVE_LOOP;
                }
            }
            title_color.r = title_color.g = title_shade;
            SDL_SetColors(title_text_sfc, &title_color, 1, 1);
            SDL_BlitSurface(title_text_sfc, NULL, Screen, &dst_rect);
            title_shade -= FADE_DELTA;
        }
        else
        {
            SDL_SetColors(text_sfc[0], &color[0], 1, 1);
            dst_rect.x = Screen->w / 2 - text_sfc[0]->w / 2;
            dst_rect.y = Screen->h / 2 - text_sfc[0]->h;
            SDL_BlitSurface(text_sfc[0], NULL, Screen, &dst_rect);
            SDL_SetColors(text_sfc[1], &color[1], 1, 1);
            dst_rect.x = Screen->w / 2 - text_sfc[1]->w / 2;
            dst_rect.y += text_sfc[0]->h;
            SDL_BlitSurface(text_sfc[1], NULL, Screen, &dst_rect);
            if (fade_out)
            {
                if (hold_count < TITLE_HOLD_COUNT)
                    hold_count++;
                else
                {
                    shade[0] += FADE_DELTA;
                    shade[1] += FADE_DELTA;
                    if (shade[0] >= 255)
                    {
                        display_title = 1;
                        title_shade = 255;
                        dst_rect.x = Screen->w / 2 - title_text_sfc->w / 2;
                        dst_rect.y = Screen->h / 2 - title_text_sfc->h / 2;
                        for (i = 0; i < 255; ++i)
                        {
                            palette[i].r = palette[i].g = i;
                            palette[i].b = 255;
                        }
                        SDL_SetColors(Screen, palette, 0, 256);
                        SDL_FillRect(Screen, NULL, WHITE);
                    }
                }
            }
            else  /* Fade in "Presents" title lines one at a time */
            {
                shade[0] -= FADE_DELTA;
                if (shade[0] <= 0)
                {
                    shade[0] = 0;
                    shade[1] -= FADE_DELTA;
                    if (shade[1] <= 0)
                    {
                        shade[1] = 0;
                        fade_out = 1;
                    }
                }
            }

            color[0].r = color[0].g = color[0].b = shade[0];
            color[1].r = color[1].g = color[1].b = shade[1];
        }
        SDL_UpdateRect(Screen, 0, 0, 0, 0);

        while (SDL_PollEvent(&evt))
        {
            switch (evt.type)
            {
                case SDL_QUIT:
                    exit_loop = QUIT;
                    break;

                case SDL_KEYDOWN:
                case SDL_MOUSEBUTTONDOWN:
                    exit_loop = LEAVE_LOOP;
                    break;
            }
        }

        while (SDL_GetTicks() - time_count < ticks_hold)
            SDL_Delay(1);
        time_count = SDL_GetTicks();
    }

    SDL_FreeSurface(text_sfc[0]);
    text_sfc[0] = NULL;
    SDL_FreeSurface(text_sfc[1]);
    text_sfc[1] = NULL;

    if (exit_loop == QUIT)
        Quit(0);
}


void
ShowGridAnimation(int which)
{
    SDL_Surface *front_sfc = NULL,
                *across_sfc[3] = { NULL, NULL, NULL };
    SDL_Rect offset_rect;
    int x = 0,
        y = 0,
        i = 0,
        surf_x = 0,
        surf_y = 0,
        exit_loop = 0,
        time_count = SDL_GetTicks(),
        perimeter_dir[3] = { 1, 2, 0 },
        circle_radius = 1;
    Uint32 c = 0;
    double x_add = 0.0,
           y_add = 0.0,
           x_comp = 0.0,
           y_comp = 0.0,
           cur_angle = 0.0,
           offset_dist = 0.0,
           angle_offset = 0.0,
           angles[3];
    Coord_t coord_a[3],
            coord_b = { img_w / 2, img_h / 2 };

    switch (which)
    {
        case 0:
            for (i = 0; i < 3; ++i)
            {
                angles[i] = (double)i * 2.0 * M_PI / 3.0 + M_PI / 2.0 - 0.01;
                x_add = img_w / 2;
                y_add = img_h / 2;
                x_comp = cos(angles[i]);
                y_comp = sin(angles[i]);
                while ( (int)x_add > 0 && (int)x_add < img_w - 1 &&
                        (int)y_add > 0 && (int)y_add < img_h - 1 )
                {
                    x_add += x_comp;
                    y_add += y_comp;
                }
                coord_a[i].x = (int)x_add;
                coord_a[i].y = (int)y_add;
            }
            /* No break here, fall through to initialize front_sfc */
        case 1:
            front_sfc = SDL_DisplayFormat(img_sfc);
            SDL_FillRect(front_sfc, NULL, WHITE);
            SDL_SetColorKey(front_sfc, SDL_SRCCOLORKEY, BLACK);
            break;

        case 2:
            front_sfc = SDL_DisplayFormat(img_sfc);
            SDL_FillRect(front_sfc, NULL, WHITE);
            SDL_SetColorKey(front_sfc, 0, 0);
            for (i = 0; i < 3; ++i)
            {
                across_sfc[i] = SDL_DisplayFormat(img_sfc);
                SDL_FillRect(across_sfc[i], NULL, WHITE);
                SDL_SetColorKey(across_sfc[i], SDL_SRCCOLORKEY, WHITE);
            }
            for (y = 0; y < img_h; ++y)
                for (x = 0; x < img_w; ++x)
                {
                    c = GetPixel_24bit(img_sfc, x, y);
                    /*
                     *  If c is on grid-line, paint pixel in corresponding
                     *  across_sfc(s).
                     */
                    if ((c & G_24BIT) == G_24BIT)
                        SetPixel_8bit(across_sfc[0], x, y, BLACK);
                    if ((c & B_24BIT) == B_24BIT)
                        SetPixel_8bit(across_sfc[1], x, y, BLACK);
                    if ((c & R_24BIT) == R_24BIT)
                        SetPixel_8bit(across_sfc[2], x, y, BLACK);
                }
            i = 0;
            angle_offset = M_PI / 6.0 + (double)i * 2.0 * M_PI / 3.0;
            offset_dist = INTRO_OFFSET_DIST;
            break;

        default:
            return;
    }

    while (!exit_loop)
    {
        SDL_FillRect(Screen, NULL, WHITE);
        if (which == 0)
        {
            for (i = 0; i < 3; ++i)
            {
                do
                {
                    switch (perimeter_dir[i])
                    {
                        case 0:
                            coord_a[i].y++;
                            if (coord_a[i].y == img_h - 1)
                                perimeter_dir[i]++;
                            break;

                        case 1:
                            coord_a[i].x--;
                            if (coord_a[i].x == 0)
                                perimeter_dir[i]++;
                            break;

                        case 2:
                            coord_a[i].y--;
                            if (coord_a[i].y == 0)
                                perimeter_dir[i]++;
                            break;

                        default:
                            coord_a[i].x++;
                            if (coord_a[i].x == img_w - 1)
                                perimeter_dir[i] = 0;
                    }
                    DrawLine_8bit(front_sfc, &coord_b, &coord_a[i], BLACK);
                    cur_angle = atan2( coord_a[i].y - coord_b.y,
                                       coord_a[i].x - coord_b.x );
                    while (cur_angle - angles[i] < 0.0)
                    {
                        cur_angle += 2 * M_PI;
                    }
                } while ( cur_angle - angles[i] <
                          fmod(angle_offset, 2.0 * M_PI) );
            }

            SDL_BlitSurface(grid_sfc, NULL, Screen, &grid_rect);
            SDL_BlitSurface(front_sfc, NULL, Screen, &grid_rect);

            if (angle_offset > 2.0 * M_PI / 3.0)
                exit_loop = LEAVE_LOOP;
            angle_offset += 0.03;
        }
        else if (which == 1)
        {
            SDL_BlitSurface(grid_sfc, NULL, Screen, &grid_rect);
            for (y = 0; y < circle_radius * 2; ++y)
                for (x = 0; x < circle_radius * 2; ++x)
                {
                    x_comp = (double)circle_radius - (double)x - 0.5;
                    y_comp = (double)circle_radius - (double)y - 0.5;
                    surf_x = grid_rect.w / 2 - circle_radius + x;
                    surf_y = grid_rect.h / 2 - circle_radius + y;
                    if ( GetPixel_8bit(front_sfc, surf_x, surf_y) == WHITE &&
                         x_comp * x_comp + y_comp * y_comp <
                         circle_radius * circle_radius )
                    {
                        SetPixel_8bit(front_sfc, surf_x, surf_y, BLACK);
                    }
                }
            SDL_BlitSurface(front_sfc, NULL, Screen, &grid_rect);
            circle_radius += 2;
            if (circle_radius > HEX_RADIUS)
                exit_loop = LEAVE_LOOP;
        }
        else if (which == 2)
        {
            if (i < 2)
                offset_rect.x = offset_dist * cos(angle_offset) + grid_rect.x;
            else
                offset_rect.x = grid_rect.x;
            offset_rect.y = offset_dist * sin(angle_offset) + grid_rect.y;
            SDL_BlitSurface(front_sfc, NULL, Screen, &grid_rect);
            SDL_BlitSurface(across_sfc[i], NULL, Screen, &offset_rect);
            offset_dist -= 10.0;
            if (offset_dist <= 0.0)
            {
                SDL_BlitSurface(across_sfc[i], NULL, front_sfc, NULL);
                offset_dist = INTRO_OFFSET_DIST;
                angle_offset = (double)++i * 2.0 * M_PI / 3.0 + M_PI / 6.0;
                if (i == 3)
                    exit_loop = LEAVE_LOOP;
            }
        }

        SDL_UpdateRect(Screen, 0, 0, 0, 0);

        while (SDL_PollEvent(&evt))
        {
            switch (evt.type)
            {
                case SDL_QUIT:
                    exit_loop = QUIT;
                    break;

                case SDL_KEYDOWN:
                case SDL_MOUSEBUTTONDOWN:
                    exit_loop = LEAVE_LOOP;
                    break;
            }
        }

        while (SDL_GetTicks() - time_count < ticks_hold)
            SDL_Delay(1);
        time_count = SDL_GetTicks();
    }

    if (front_sfc)
        SDL_FreeSurface(front_sfc);
    for (i = 0; i < 3; ++i)
        if (across_sfc[i])
            SDL_FreeSurface(across_sfc[i]);

    if (exit_loop == QUIT)
        Quit(0);
}

void
RenderTurnText(int current_player)
{
    SDL_Surface *pl_points_sfc = NULL,
                *turn_sfc = NULL;
    SDL_Rect src_rect = { 0, 0 },
             dst_rect = { 0, 0 };
    int i = 0;
    char s[4] = "";

    if (pl_type[current_player] == HUMAN)
        turn_sfc = human_turn_sfc;
    else
        turn_sfc = cpu_turn_sfc;
    SDL_FillRect(turn_full_sfc, NULL, LIGHT_GREY);
    src_rect.w = MIN(pl_name_sfc[current_player]->w, SCREEN_W - turn_sfc->w);
    src_rect.h = font_ch_h;
    SDL_BlitSurface( pl_name_sfc[current_player], &src_rect, turn_full_sfc,
                     &dst_rect );
    dst_rect.x = MIN(pl_name_sfc[current_player]->w, SCREEN_W - turn_sfc->w);
    SDL_BlitSurface(turn_sfc, NULL, turn_full_sfc, &dst_rect);

    src_rect.w = font_ch_w * 2;
    src_rect.h = font_ch_h;
    SDL_FillRect(points_full_sfc, NULL, LIGHT_GREY);
    for (i = 0; i < NUM_PLAYERS; ++i)
    {
        sprintf(s, "%2d", points[i]);
        pl_points_sfc = RenderTextDefault(s, pl_color[i]);
        dst_rect.x = text_offset[i];
        SDL_BlitSurface(points_full_sfc, &src_rect, points_sfc, &dst_rect);
        SDL_BlitSurface(pl_points_sfc, NULL, points_sfc, &dst_rect);
        SDL_FreeSurface(pl_points_sfc);
        pl_points_sfc = NULL;
    }
    SDL_BlitSurface(points_sfc, NULL, points_full_sfc, NULL);
}


void
AudioCallback(void *data, Uint8 *stream, int len)
{
    int *control_ints = (int *)data,
        offset = 0;
    Uint8 sample = 0;
    static float factors[3] = { 0.5f, 1.0f, 0.0f };
    float left = 0.0f,
          right = 0.0f;

    if (control_ints[INDEX] == -1)
        return;

    for (offset = 0; offset < len; ++offset)
    {
        sample = wave_final[control_ints[INDEX]].buf[control_ints[OFFSET]++];

        /*
         *  If panning is not full center, set left and right factors
         *  accordingly.
         */
        if (control_ints[PANNING] != PAN_NORMAL)
        {
            left = factors[control_ints[PANNING]];
            right = factors[(3 - control_ints[PANNING]) % 3];
        }
        else
        {
            left = right = 1.0f;
        }

        if ((offset & 1) == 0)  /* Left channel */
        {
            stream[offset] = (Uint8)(left * sample + (1.0f - left) * 127);
        }
        else  /* Right channel */
        {
            stream[offset] = (Uint8)(right * sample + (1.0f - right) * 127);
        }

        if (control_ints[OFFSET] >= wave_length[control_ints[INDEX]])
        {
            control_ints[INDEX] = -1;
            return;
        }
    }
}


void
PlaySound(int sample, int panning)
{
    if (have_sound)
    {
        SDL_LockAudio();
        sample_data[INDEX] = sample;
        sample_data[OFFSET] = 0;
        sample_data[PANNING] = panning;
        SDL_UnlockAudio();
    }
}


void
DrawTriLine(SDL_Surface *sfc, int index, int color)
{
    SDL_Rect rect;
    int q = 0;

    SDL_FillRect(connect_end_sfc, NULL, connect_color[color]);
    SDL_BlitSurface(connect_mask_sfc, NULL, connect_end_sfc, NULL);

    for (q = 0; q < 3; ++q)
    {
        DrawWideLineWOffset_8bit( sfc, connectors[index].centers[q],
                                  &connectors[index].core, &grid_rect,
                                  connect_color[color] );
        rect.x = connectors[index].centers[q]->x - CONNECT_END_RADIUS + 1 +
                 grid_rect.x;
        rect.y = connectors[index].centers[q]->y - CONNECT_END_RADIUS + 1 +
                 grid_rect.y;
        SDL_BlitSurface(connect_end_sfc, NULL, sfc, &rect);
    }
    rect.x = connectors[index].core.x - CONNECT_END_RADIUS + 1 + grid_rect.x;
    rect.y = connectors[index].core.y - CONNECT_END_RADIUS + 1 + grid_rect.y;
    SDL_BlitSurface(connect_end_sfc, NULL, sfc, &rect);
}


int
ConnectValue(int side, int connection)
{
    return GetCell( connectors[connection].centers[side]->x,
                    connectors[connection].centers[side]->y );
}


int
TestConnection(int value, int connection, int color)
{
    int i = 0,
        side = GetFace(value);

    if (ConnectValue(side, connection) != value)
        return -1;

    if (color == -1)
    {
        if (cell_state[value] > -1)
            color = cell_state[value];
        else
            color = PlayerUp();
    }

    for (i = 1; i <= 2; ++i)
        if (cell_state[ConnectValue((side + i) % 3, connection)] != color)
            return -1;

    return color;
}


int
QuitQuery()
{
    SDL_Surface *temp_txt_sfc = NULL;
    SDL_Rect dst_rect;
    int exit_loop = 0,
        value = 0;

    temp_txt_sfc = RenderTextDefault("Quit (Yes/No/Menu) ?", RED);
    DrawRect_8bit( Screen, 0, SCREEN_H - font_ch_h, SCREEN_W, font_ch_h, 0,
                   WHITE );
    dst_rect.x = SCREEN_W / 2 - temp_txt_sfc->w / 2;
    dst_rect.y = SCREEN_H - font_ch_h;
    SDL_BlitSurface(temp_txt_sfc, NULL, Screen, &dst_rect);
    SDL_UpdateRect(Screen, 0, 0, 0, 0);

    while (!exit_loop)
    {
        while (SDL_PollEvent(&evt))
        {
            if (evt.type == SDL_QUIT)
            {
                value = QUIT;
                exit_loop = LEAVE_LOOP;
            }
            else if (evt.type == SDL_KEYDOWN)
            {
                if (evt.key.keysym.sym == SDLK_y)
                {
                    value = QUIT;
                    exit_loop = LEAVE_LOOP;
                }
                else if ( evt.key.keysym.sym == SDLK_n ||
                          evt.key.keysym.sym == SDLK_ESCAPE )
                {
                    value = 0;
                    exit_loop = LEAVE_LOOP;
                }
                else if (evt.key.keysym.sym == SDLK_m)
                {
                    value = LEAVE_LOOP;
                    exit_loop = LEAVE_LOOP;
                }
            }
        }
    }

    DrawRect_8bit( Screen, 0, SCREEN_H - font_ch_h, SCREEN_W, font_ch_h, 0,
                   WHITE );
    SDL_UpdateRect(Screen, 0, 0, 0, 0);

    SDL_FreeSurface(temp_txt_sfc);

    return value;
}

int
DisplayWinMessage( int center_x, int center_y )
{
    SDL_Surface *text_sfc[2] = { NULL, NULL },
                *message_sfc = NULL;
    SDL_Rect rect;
    char *text[5] = { "Winner%s:", "s(tie)", "with %d point%s", "s",
                      "%d way tie, no winners!" },
         buffer[MAX_MESSAGE_LENGTH + 1] = "";
    int i = 0,
        max_w = 0,
        width = 0,
        height = 0,
        winner = 0,
        num_tied = 0,
        win_total = 0,
        exit_loop = 0,
        human_played = 0,
        human_scored = 0;

    human_played = 0;
    for (i = 0; i < NUM_PLAYERS; ++i)
    {
        win_total = MAX(win_total, points[i]);
        if (pl_type[i] == HUMAN)
            human_played = 1;
    }

    for (i = 0; i < NUM_PLAYERS; ++i)
        if (points[i] == win_total)
        {
            winner = i;
            num_tied++;
            if (pl_type[i] == HUMAN)
                human_scored = 1;
        }

    if (have_sound && human_played)
    {
        /*
         *  If not an all-player tie and at least one human player scored,
         *  then play one wave file, else play the other.
         */
        if (pl_type[winner] == HUMAN)
            PlaySound(SAMPLE_CHEER, PAN_NORMAL);
        else
            PlaySound(SAMPLE_BOO, PAN_NORMAL);
    }

    if (num_tied > 1)
    {
        sprintf(buffer, "Tie for score of %d:", win_total);
        text_sfc[0] = RenderTextDefault(buffer, BLACK);
        text_sfc[1] = RenderTextDefault("wins by default", BLACK);
    }
    else
    {
        text_sfc[0] = RenderTextDefault("Winner:", BLACK);
        sprintf( buffer, "with %d point%s", win_total,
                 (win_total != 1) ? "s" : "" );
        text_sfc[1] = RenderTextDefault(buffer, BLACK);
    }
    for (i = 0; i < 2; ++i)
        max_w = MAX(max_w, text_sfc[i]->w);
    for (i = 0; i < NUM_PLAYERS; ++i)
        max_w = MAX(max_w, pl_name_sfc[i]->w);
    width = max_w + 2 * MESSAGE_BORDER_SIZE;
    height = 3 * font_ch_h + 2 * MESSAGE_BORDER_SIZE;

    message_sfc = NewSurfaceDefault(width, height);
    SDL_FillRect(message_sfc, NULL, LIGHT_GREY);
    DrawRect_8bit(message_sfc, 0, 0, message_sfc->w, message_sfc->h, 1, BLACK);

    rect.x = width / 2 - text_sfc[0]->w / 2;
    rect.y = MESSAGE_BORDER_SIZE;
    SDL_BlitSurface(text_sfc[0], NULL, message_sfc, &rect);
    rect.x = width / 2 - text_sfc[1]->w / 2;
    rect.y = message_sfc->h - MESSAGE_BORDER_SIZE - font_ch_h;
    SDL_BlitSurface(text_sfc[1], NULL, message_sfc, &rect);
    rect.x = width / 2 - pl_name_sfc[winner]->w / 2;
    rect.y = MESSAGE_BORDER_SIZE + font_ch_h;
    SDL_BlitSurface(pl_name_sfc[winner], NULL, message_sfc, &rect);

    rect.x = center_x - message_sfc->w / 2;
    rect.y = center_y - message_sfc->h / 2;
    SDL_BlitSurface(message_sfc, NULL, Screen, &rect);
    SDL_UpdateRect(Screen, 0, 0, 0, 0);

    for (i = 0; i < 2; ++i)
    {
        if (text_sfc[i])
            SDL_FreeSurface(text_sfc[i]);
    }
    SDL_FreeSurface(message_sfc);

    while (!exit_loop)
    {
        SDL_WaitEvent(&evt);
        do
        {
            switch (evt.type)
            {
                case SDL_QUIT:
                    Quit(0);
                    break;

                case SDL_KEYDOWN:
                    if (evt.key.keysym.sym == SDLK_ESCAPE)
                        Quit(0);
                    exit_loop = LEAVE_LOOP;
                    break;

                case SDL_MOUSEBUTTONDOWN:
                    exit_loop = LEAVE_LOOP;
                    break;
            }
        } while (SDL_PollEvent(&evt));
    }

    return winner;
}


void
ShowEndScreen()
{
    SDL_Surface *ask_sfc = NULL,
                *confirm_sfc = NULL,
                *no_points_sfc = NULL,
                *pl_point_sfc[NUM_PLAYERS];
    SDL_Rect dst_rect,
             confirm_rect;
    char buffer[POINT_STR_SIZE + 1] = "",
         no_points_str[MAX_MESSAGE_LENGTH + 1] = "No points remaining:   ";
    int i = 0,
        c = 0,
        m_x = 0,
        m_y = 0,
        ticks = 0,
        value = 0,
        color = 0,
        winner = 0,
        exit_loop = 0,
        on_confirm = 0;

    replay = 0;

    SDL_FillRect(Screen, NULL, WHITE);
    SDL_BlitSurface(grid_sfc, NULL, Screen, &grid_rect);

    winner = DisplayWinMessage(SCREEN_W / 2, SCREEN_H / 2);

    ask_sfc = RenderTextDefault("Want to play again?", DARK_GREY);
    confirm_sfc = RenderTextDefault("Want to play again!", GREY);
    confirm_rect.x = SCREEN_W / 2 - ask_sfc->w / 2;
    confirm_rect.y = SCREEN_H - font_ch_h;

    no_points_sfc = RenderTextDefault(no_points_str, BLACK);
    for (i = 0; i < NUM_PLAYERS; ++i)
    {
        snprintf(buffer, POINT_STR_SIZE, "%d", points[i]);
        pl_point_sfc[i] = RenderTextDefault(buffer, pl_color[i]);
    }

    ticks = SDL_GetTicks();

    while (!exit_loop)
    {
        SDL_GetMouseState(&m_x, &m_y);
        if ( m_x >= confirm_rect.x && m_x < confirm_rect.x + ask_sfc->w &&
             m_y >= confirm_rect.y && m_y < confirm_rect.y + ask_sfc->h )
            on_confirm = 1;
        else
            on_confirm = 0;
        m_x -= grid_rect.x;
        m_y -= grid_rect.y;
        if ( (m_x >= 0 && m_x < img_w && m_y >= 0 && m_y < img_h) &&
             (value = GetCell(m_x, m_y)) > -1 )
            color = cell_state[value];
        else
            color = winner;
        if (color < 0)
            color = winner;

        SDL_FillRect(Screen, NULL, WHITE);
        SDL_BlitSurface(grid_sfc, NULL, Screen, &grid_rect);
        for (c = 0; c < NUM_CONNECTORS; ++c)
        {
            for (value = 0; value < 9; ++value)
                if ( cell_state[value] == color &&
                     TestConnection(value, c, color) > -1 )
                    DrawTriLine(Screen, c, color);
        }
        dst_rect.x = SCREEN_W / 2 - no_points_sfc->w / 2;
        dst_rect.y = 0;
        SDL_BlitSurface(no_points_sfc, NULL, Screen, &dst_rect);
        dst_rect.x += (strlen(no_points_str) - 2) * font_ch_w;
        dst_rect.w = font_ch_w * (points[color] > 9 ? 2 : 1);
        dst_rect.h = font_ch_h;
        if ( color != winner || (SDL_GetTicks() - ticks) % 500 < 250)
            SDL_FillRect(Screen, &dst_rect, LIGHT_GREY);
        else
            SDL_FillRect(Screen, &dst_rect, MED_GREY);
        SDL_BlitSurface(pl_point_sfc[color], NULL, Screen, &dst_rect);
        if (on_confirm)
            SDL_BlitSurface(confirm_sfc, NULL, Screen, &confirm_rect);
        else
            SDL_BlitSurface(ask_sfc, NULL, Screen, &confirm_rect);
        SDL_UpdateRect(Screen, 0, 0, 0, 0);

        while (SDL_PollEvent(&evt))
        {
            switch (evt.type)
            {
                case SDL_QUIT:
                    exit_loop = QUIT;
                    break;

                case SDL_KEYDOWN:
                    if (evt.key.keysym.sym == SDLK_y)
                    {
                        replay = 1;
                        exit_loop = LEAVE_LOOP;
                    }
                    else if ( evt.key.keysym.sym == SDLK_ESCAPE ||
                              evt.key.keysym.sym == SDLK_q ||
                              evt.key.keysym.sym == SDLK_n )
                        exit_loop = QUIT;
                    break;

                case SDL_MOUSEBUTTONDOWN:
                    if (on_confirm && evt.button.button == 1)
                    {
                        replay = 1;
                        exit_loop = LEAVE_LOOP;
                    }
                    break;
            }
        }
    }

    if (ask_sfc)
        SDL_FreeSurface(ask_sfc);
    if (confirm_sfc)
        SDL_FreeSurface(confirm_sfc);
    if (no_points_sfc)
        SDL_FreeSurface(no_points_sfc);
    for (i = 0; i < NUM_PLAYERS; ++i)
        if (pl_point_sfc[i])
            SDL_FreeSurface(pl_point_sfc[i]);

    if (exit_loop == QUIT)
        Quit(0);
    return;
}


int
GetFace(int value)
{
    if (value < 0)
        return FACE_NONE;
    else if (value < 9)
        return FACE_TOP;
    else if (value < 18)
        return FACE_RIGHT;
    else
        return FACE_LEFT;
}

int
GetPan(int value)
{
    if (value < 0)
        return PAN_NORMAL;
    else if (value < 9)
        return PAN_TOP;
    else if (value < 18)
        return PAN_RIGHT;
    else
        return PAN_LEFT;
}


void
Quit(int code)
{
    int i = 0;

    if (code == 0)
    {
        /* Display parting words on successful exit */
        printf("\nThank you for playing!\n");
        printf("\n\nGamechild Software is:\n");
        printf("\nSean McKean, with a little help from the internet...\n");
    }

    /* Free all allocated resources */

    if (have_sound)
    {
        /* Halt audio first */
        SDL_PauseAudio(1);

        if (sample_data)
            free(sample_data);

        for (i = 0; i < NUM_SAMPLES; ++i)
        {
            if (wave_final[i].buf)
                SDL_FreeWAV(wave_final[i].buf);
        }

        SDL_CloseAudio();
    }

    if (cell_values)
        free(cell_values);

    if (temp)
        SDL_FreeSurface(temp);

    if (img_sfc)
        SDL_FreeSurface(img_sfc);

    if (save_grid_sfc)
        SDL_FreeSurface(save_grid_sfc);

    if (grid_sfc)
        SDL_FreeSurface(grid_sfc);

    if (select_sfc)
        SDL_FreeSurface(select_sfc);

    if (select_blit_sfc)
        SDL_FreeSurface(select_blit_sfc);

    if (connect_end_sfc)
        SDL_FreeSurface(connect_end_sfc);

    if (connect_mask_sfc)
        SDL_FreeSurface(connect_mask_sfc);

    for (i = 0; i < NUM_CELLS; ++i)
    {
        if (cell_sfc[i])
            SDL_FreeSurface(cell_sfc[i]);
    }

    for (i = 0; i < NUM_PLAYERS; ++i)
    {
        if (pl_name_sfc[i])
            SDL_FreeSurface(pl_name_sfc[i]);
    }

    if (title_text_sfc)
        SDL_FreeSurface(title_text_sfc);

    if (human_turn_sfc)
        SDL_FreeSurface(human_turn_sfc);

    if (cpu_turn_sfc)
        SDL_FreeSurface(cpu_turn_sfc);

    if (turn_full_sfc)
        SDL_FreeSurface(turn_full_sfc);

    if (points_sfc)
        SDL_FreeSurface(points_sfc);

    if (points_full_sfc)
        SDL_FreeSurface(points_full_sfc);

    if (tut_msg_sfc)
        SDL_FreeSurface(tut_msg_sfc);

    if (tut_grid_sfc)
        SDL_FreeSurface(tut_grid_sfc);

    if (tut_full_fill_sfc)
        SDL_FreeSurface(tut_full_fill_sfc);

    for (i = 0; i < 9; ++i)
    {
        if (tut_fill_sfc[i])
            SDL_FreeSurface(tut_fill_sfc[i]);
    }

    TTF_CloseFont(font);

    TTF_Quit();
    SDL_Quit();

    exit(code);
}


void
SetNextPlayer()
{
    c_index = (c_index + 1) % NUM_PLAYERS;
}


int
PlayerUp()
{
    return c_index;
}


int
PointsRemain(int color)
{
    int cells_free[NUM_CELLS];
    int count = 0,
        c = 0,
        i = 0,
        v = 0;

    /* First gather empty cells */
    for (i = 0; i < NUM_CELLS; ++i)
    {
        if (cell_state[i] == -1)
            cells_free[count++] = i;
    }

    /* Only continue if count is in reasonable range. */
    if (count > 9)
        return 1;

    /*
     *  Iterate over all available cells until a point is found; else
     *  run the next test.
     */
    for (i = 0; i < count; ++i)
    {
        for (c = 0; c < NUM_CONNECTORS; ++c)
            if (TestConnection(cells_free[i], c, color) > -1)
                return 1;
    }

    /*
     *  Recursively call function until a point connection is found or
     *  not.
     */
    for (i = 0; i < count; ++i)
    {
        cell_state[cells_free[i]] = color;
        v = PointsRemain((color + 1) % NUM_PLAYERS);
        cell_state[cells_free[i]] = -1;
        if (v)
            return 1;
    }

    return 0;
}


void
MainLoop()
{
    SDL_Rect dst_rect;
    int exit_loop = 0,
        color = 0,
        i = 0,
        v = 0,
        c = 0,
        m_x = 0,
        m_y = 0,
        redo = 0,
        cpu_turn = 0,
        play_count = 0,
        point_played = 0,
        mb_left_down = 0,
        mouse_on_connection = 0;

    while (!exit_loop)
    {
        do
        {
            SDL_GetMouseState(&m_x, &m_y);
            m_x -= grid_rect.x;
            m_y -= grid_rect.y;
            v = -1;
            if (pl_type[PlayerUp()] == HUMAN)
                cpu_turn = 0;
            else
                cpu_turn = 1;
            if ( cpu_turn ||
                 ( (m_x >= 0 && m_x < img_w && m_y >= 0 && m_y < img_h) &&
                   (v = GetCell(m_x, m_y)) > -1 && cell_state[v] == -1 ) )
            {
                if (cpu_turn || mb_left_down)
                {
                    if (cpu_turn)
                    {
                        do
                        {
                            redo = 0;
                            if (pl_type[PlayerUp()] == CPU_MED)
                                v = ComputerPickCellLevelMedium();
                            else
                                v = ComputerPickCellLevelHard();
                            if (v == -2)
                            {
                                if ((exit_loop = QuitQuery()) == 0)
                                    redo = 1;
                                /*
                                 *  Give PC a bogus choice, to keep from
                                 *  complaining.
                                 */
                                else
                                    v = 0;
                            }
                            else if (v == -1)
                            {
                                fprintf( stderr,
                                         "Computer could not mark "
                                         "any cells\n" );
                                SetNextPlayer();
                                continue;
                            }

                        } while (redo == 1);
                    }

                    cell_state[v] = PlayerUp();
                    point_played = 0;
                    for (c = 0; c < NUM_CONNECTORS; ++c)
                    {
                        if (TestConnection(v, c, PlayerUp()) > -1)
                        {
                            point_played = 1;
                            points[PlayerUp()]++;
                            if (have_sound)
                            {
                                if (cpu_turn == 0)
                                    PlaySound(SAMPLE_BLIP, PAN_NORMAL);
                                else
                                    PlaySound(SAMPLE_BLOOP, PAN_NORMAL);
                            }
                        }
                    }
                    color = pl_color[PlayerUp()];
                    SDL_FillRect(temp, NULL, color);
                    SDL_BlitSurface(cell_sfc[v], NULL, temp, NULL);
                    SDL_BlitSurface(temp, NULL, grid_sfc, NULL);
                    play_count++;
                    SetNextPlayer();

                    /*
                     *  If no remaining cells can score points, show
                     *  end screen.
                     */
                    if (PointsRemain(PlayerUp()) == 0)
                    {
                        ShowEndScreen();
                        return;
                    }
                    else if (have_sound && !point_played)
                    {
                        if (cpu_turn == 0)
                            PlaySound(SAMPLE_CLICK, GetPan(v));
                        else
                            PlaySound(SAMPLE_KCILC, GetPan(v));
                    }

                    RenderTurnText(PlayerUp());
                }
                else if (cpu_turn == 0)
                {
                    color = pl_color[PlayerUp()];
                    SDL_FillRect(temp, NULL, color);
                    SDL_BlitSurface(cell_sfc[v], NULL, temp, NULL);
                    SDL_BlitSurface(select_sfc, NULL, temp, NULL);
                    SDL_FillRect(select_blit_sfc, NULL, WHITE);
                    SDL_BlitSurface(temp, NULL, select_blit_sfc, NULL);
                }
            }
            else if (pl_type[PlayerUp()] == HUMAN)
                SDL_FillRect(select_blit_sfc, NULL, WHITE);

            mb_left_down = 0;

            SDL_FillRect(Screen, NULL, WHITE);

            SDL_BlitSurface(grid_sfc, NULL, Screen, &grid_rect);
            SDL_BlitSurface(select_blit_sfc, NULL, Screen, &grid_rect);

            mouse_on_connection = 0;
            if (v > -1)
            {
                for (c = 0; c < NUM_CONNECTORS; ++c)
                {
                    for (i = 0; i < 3; ++i)
                    {
                        if ( ConnectValue(i, c) == v &&
                             (color = TestConnection(v, c, -1)) > -1 )
                        {
                            DrawTriLine(Screen, c, color);
                            mouse_on_connection = 1;
                        }
                    }
                }
            }

            dst_rect.x = 0;
            dst_rect.y = 0;
            SDL_BlitSurface(turn_full_sfc, NULL, Screen, &dst_rect);
            dst_rect.y = SCREEN_H - font_ch_h;
            SDL_BlitSurface(points_full_sfc, NULL, Screen, &dst_rect);

            if (exit_loop == 0)
                SDL_UpdateRect(Screen, 0, 0, 0, 0);

        } while (cpu_turn && exit_loop == 0);

        if (exit_loop == 0)
            SDL_WaitEvent(&evt);
        do
        {
            switch (evt.type)
            {
                case SDL_QUIT:
                    Quit(0);

                case SDL_KEYDOWN:
                    if ( evt.key.keysym.sym == SDLK_ESCAPE ||
                         evt.key.keysym.sym == SDLK_q )
                    {
                        exit_loop = QuitQuery();
                    }
                    break;

                case SDL_MOUSEBUTTONDOWN:
                    if (evt.button.button == 1)
                        mb_left_down = 1;
                    break;
            }
        } while (SDL_PollEvent(&evt));
    }

    if (exit_loop == QUIT)
        Quit(0);
}


void
DisplayUsage(int exit_code)
{
    fprintf(stderr, "Valid command-line arguments are:\n");
    fprintf(stderr, " -ni to skip intro's, -ns to disable sound, "
                    "and -tf to keep the computer\n");
    fprintf(stderr, " from delaying while choosing a cell.\n");
    fprintf(stderr, " -h displays this message.\n");
    Quit(exit_code);
}


int
main(int argc, char *argv[])
{
    int arg = 0;

    for (arg = 1; arg < argc; ++arg)
    {
        if ( strcmp(argv[arg], "-ni") == 0 ||
             strcmp(argv[arg], "--no-intro") == 0 )
            do_intro = 0;
        else if ( strcmp(argv[arg], "-ns") == 0 ||
                  strcmp(argv[arg], "--no-sound") == 0 )
            have_sound = 0;
        else if ( strcmp(argv[arg], "-tf") == 0 ||
                  strcmp(argv[arg], "--think-fast") == 0 )
            no_delay = 1;
        else if ( strcmp(argv[arg], "-h") == 0 ||
                  strcmp(argv[arg], "--help") == 0 )
            DisplayUsage(-2);
        else
        {
            fprintf(stderr, "Unrecognized argument to program %s\n", argv[0]);
            DisplayUsage(-1);
        }
    }

    InitSDLStuff();
    if (do_intro)
        ShowLogo();
    SetGamePalette();
    InitMainData();
    do
    {
        ResetData();
        MainLoop();
        if (have_sound)
            SDL_PauseAudio(1);
    } while (replay = 1);

    return 0;
}
