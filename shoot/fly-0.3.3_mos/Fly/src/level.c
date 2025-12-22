#include <stdlib.h>
#include <stdio.h>
#include "vector.h"
#include "level.h"
#include "wall.h"
#include "explosion.h"
#include "laser.h"
#include "scenario.h"
#include "timing.h"
#include "text.h"
#include "map.h"

void game_over();
void rasonly(); // TODO: put in "glutils.h"

static char *flyer_files[] = { DATA_DIR"models/player-smooth.obj",
                               DATA_DIR"models/spaceship0.obj", 
                               DATA_DIR"models/spaceship1.obj",
                               DATA_DIR"models/spaceship2.obj" };

static char *level_files[] = { DATA_DIR"levels/l1.lvl" };

static char *song_files[] = { DATA_DIR"sound/gas15.mod" };

void Level_init(struct Level *l)
{
    l->num_level = 0;
    l->show_text = 1;
    l->random = 1;
    l->flyers = list_create(LIST_AUTO_DELETE, NO_CALLBACK);
    l->lasers = list_create(LIST_AUTO_DELETE, NO_CALLBACK);
    l->walls = list_create(LIST_AUTO_DELETE, NO_CALLBACK);
    l->explosions = list_create(LIST_AUTO_DELETE, NO_CALLBACK);
    
    l->camera = Camera_new(8);
}

void Level_load(struct Level *l, char *filename)
{
    FILE *file;
    int i, width, height;
    Flyer *enemy;
    Object3d *wall;
    char line[200];

    printf("loading %s...\n", filename);
    file = fopen(filename, "r");
    if (file == NULL) {
	perror(filename);
	exit(0);
    }
    // Init player
    l->player = (Flyer *)malloc(sizeof(Flyer));
    Flyer_init(l->player,flyer_files[0]);
    list_add(l->flyers, l->player);
    l->player->o.r[1] = -90;
    Object3d_set_vel(&(l->player->o), 15.0);
    l->player->energy = 50;

    // Process map
    fgets(line, 200, file);
    width = strlen(line);
    height = 1;
    do {
	for (i = 0; i < width; i++) {
	    if (line[i] == 'P') {	// player
		(l->player)->o.tr[0] = i;
		(l->player)->o.tr[2] = height - 1;
	    } else if (line[i] == 'E') {	// enemy
		enemy = (Flyer *) malloc(sizeof(Flyer));
		Flyer_init(enemy, flyer_files[1]);
                list_add(l->flyers, enemy);
		enemy->o.tr[0] = i;
		enemy->o.tr[2] = height - 1;

		enemy->o.r[1] = ((float) rand() / (float) RAND_MAX) * 360;
		enemy->o.color[0] = 0.0;
		enemy->o.color[1] = 0.5;
		enemy->o.color[2] = 0.3;
		enemy->fire_time = 1000;
		enemy->energy = 30;
		VECTOR_CPY(enemy->tmpcolor, enemy->o.color);
		Object3d_set_vel(&(enemy->o), 13.0);
	    } else if (line[i] >= '0' && line[i] <= '9') {	// wall
		wall = (Object3d *) malloc(sizeof(Object3d));
		Wall_init(wall);
                list_add(l->walls, wall);
		wall->tr[0] = i;
		wall->tr[2] = height - 1;

		wall->tr[1] = 0.5;

		//wall->r[1] = ((float)rand() / (float)RAND_MAX) * 360;
	    }
	}

	height++;
    } while (fgets(line, 200, file) != NULL);

    Scenario_set_size(width, height);
}

void Level_rand(struct Level *l, int level)
{
    int i;
    int num_enemies, num_walls;
    Flyer *enemy;
    Object3d *wall;

    // Init player
    l->player = (Flyer *) malloc(sizeof(Flyer));
    Flyer_init(l->player, flyer_files[0]);
    list_add(l->flyers, l->player);
    (l->player)->energy = 100;
    (l->player)->o.tr[0] = Scenario_get_width() / 2 + 0.5;
    (l->player)->o.tr[2] = Scenario_get_height() / 2;
    (l->player)->o.r[1] = -90;
    Object3d_set_vel(&((l->player)->o), 15.0);

    // Init enemies
    num_enemies = level * 2;
    for (i = 0; i < num_enemies; i++) {
	enemy = (Flyer *) malloc(sizeof(Flyer));

        // 20% flyer 1, 80% flyer 3
        if(i * 100 / num_enemies < 80) { 
	    Flyer_init(enemy, flyer_files[3]);
            enemy->AI = Flyer_AI2;
        } else {
	    Flyer_init(enemy, flyer_files[1]);
        }

        list_add(l->flyers, enemy);
	enemy->o.tr[0] = Scenario_get_width() *
	    ((float) rand() / (float) RAND_MAX);

	enemy->o.tr[2] = Scenario_get_height() *
	    ((float) rand() / (float) RAND_MAX);

	enemy->o.r[1] = ((float) rand() / (float) RAND_MAX) * 360;
	enemy->o.color[0] = 0.0;
	enemy->o.color[1] = 0.5;
	enemy->o.color[2] = 0.3;
	enemy->fire_time = 1000;
	enemy->energy = 60;
	VECTOR_CPY(enemy->tmpcolor, enemy->o.color);
	Object3d_set_vel(&(enemy->o), 13.0);
    }

    // Init wals
    num_walls = level * 2;
    for (i = 0; i < num_walls; i++) {
	wall = (Object3d *) malloc(sizeof(Object3d));
	Wall_init(wall);
        list_add(l->walls, wall);
	wall->tr[0] = Scenario_get_width() *
	    ((float) rand() / (float) RAND_MAX);

	wall->tr[2] = Scenario_get_height() *
	    ((float) rand() / (float) RAND_MAX);

	wall->tr[1] = 0.0;

	wall->r[1] = ((float) rand() / (float) RAND_MAX) * 360;
    }
}

void Level_update(struct Level *l)
{
    Flyer *flyer;
    Laser *laser;
    Explosion *expl;
    List_Entry *tmp_current;
    
    for (flyer = list_first(l->flyers); flyer != NULL; flyer = list_next(l->flyers)) { // MOVE FLYERS
	if (flyer == l->player) {
	    Level_process_keys(l);
	} else {
            tmp_current = l->flyers->cur_entry;
            flyer->AI(l, flyer);
            l->flyers->cur_entry = tmp_current;
	}

	Flyer_update_pos(flyer);

	if (flyer == l->player)
	    Camera_update_pos(l->camera, l->player);
    }

    for (laser = list_first(l->lasers); laser != NULL; laser = list_next(l->lasers)) { // MOVE LASERS
	if (!Laser_update_pos(laser)) list_delete_current(l->lasers);
    }

    for (expl = list_first(l->explosions); expl != NULL; expl = list_next(l->explosions)) { // MOVE EXPLOSIONS
	if (!Explosion_update_pos(expl)) list_delete_current(l->explosions);
    }
}

void Level_frame(struct Level *l)
{
    if( l->flyers->count - 1 == 0 && l->player != NULL && l->explosions->count==0) { 
        Level_next(l);
    }
            
    Level_update(l);
    Level_collisions(l); 
    Level_draw(l);
}

void Level_draw(struct Level *l)
{
    Flyer *flyer;
    Laser *laser;
    Explosion *expl;
    Object3d *wall;
    static char info_string[100];
    
    glClear(GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT);	// Clear The Screen

    Camera_set(l->camera);

    glDisable(GL_DEPTH_TEST);
    Scenario_draw(1);		// DRAW SCENARIO
    glEnable(GL_DEPTH_TEST);

    for (flyer = list_first(l->flyers); flyer != NULL; flyer = list_next(l->flyers)) { // DRAW FLYERS
	Flyer_draw(flyer);
    }

    for (wall = list_first(l->walls); wall != NULL; wall = list_next(l->walls)) { // DRAW WALLS
	Object3d_draw_list(wall);
    }

    glDisable(GL_CULL_FACE);

    for (expl = list_first(l->explosions); expl != NULL; expl = list_next(l->explosions)) { // DRAW EXPLOSIONS
	Explosion_draw(expl);
    }

    glDisable(GL_LIGHTING);


    for (laser = list_first(l->lasers); laser != NULL; laser = list_next(l->lasers)) { // DRAW LASERS
	Laser_draw(laser);
    }

    glEnable(GL_LIGHTING);
    glEnable(GL_CULL_FACE);
    
    rasonly();
    glDisable(GL_DEPTH_TEST);
    Map_draw(l);  // DRAW MAP

    if(l->player != NULL)
        sprintf(info_string, 
            "Level: %d  Energy: %d%% Remain: %d  FPS: %d",
            l->num_level, l->player->energy, l->flyers->count - 1, fps);
    if(l->show_text) 
        Text_draw(info_string, 10, Camera_get_height() - 20, 1.0, 1.0, 0.0); // DRAW TEXT
    
    if(l->player == NULL) game_over();
    glEnable(GL_DEPTH_TEST);
 
    SDL_GL_SwapBuffers();
}

void Level_collisions(struct Level *l)
{
    Object3d *o1, *o2;
    Laser *laser;
    Flyer *f1, *f2;
    List_Entry *tmp_current;
    
    // collision of l->lasers with the l->flyers
    for (laser = list_first(l->lasers); laser != NULL; laser = list_next(l->lasers)) {
	o2 = &(laser->o);
        for (f1 = list_first(l->flyers); f1 != NULL; f1 = list_next(l->flyers)) {
	    if (Object3d_collision(&(f1->o), o2)) {
		f1->energy -= 20;
		f1->o.state |= STATE_IMPACT;
		f1->impact_time_last = actual_tick;

		if (f1->energy <= 0) {
		    if (f1 == l->player)
			l->player = NULL;
                    else l->player->points += 1;
		    
                    Flyer_explode(f1, l->explosions);
                    list_delete_current(l->flyers);
		}

                list_delete_current(l->lasers);
		break;
	    }
	}
    }

    // collision between flyers
    for (f1 = list_first(l->flyers); f1 != NULL; f1 = list_next(l->flyers)) {
        tmp_current = l->flyers->cur_entry;
        for (f2 = list_next(l->flyers); f2 != NULL; f2 = list_next(l->flyers)) {
	    if (Object3d_collision(&(f1->o), &(f2->o))) {
		if (f2 == l->player) l->player = NULL;
		if (f1 == l->player) l->player = NULL;

		Flyer_explode(f1, l->explosions);
		Flyer_explode(f2, l->explosions);
                list_delete_current(l->flyers);
                l->flyers->cur_entry = tmp_current;
                tmp_current = NULL;
                list_delete_current(l->flyers);
		break;
	    }
	}
        if(tmp_current != NULL) 
                l->flyers->cur_entry = tmp_current;
    }

    // collision of flyers and lasers with walls
    for (o1 = list_first(l->walls); o1 != NULL; o1 = list_next(l->walls)) {
        for (laser = list_first(l->lasers); laser != NULL; laser = list_next(l->lasers)) {
	    if (Object3d_collision(o1, &(laser->o))) {
                list_delete_current(l->lasers);
	    }
	}

        for (f1 = list_first(l->flyers); f1 != NULL; f1 = list_next(l->flyers)) {
	    if (Object3d_collision(o1, &(f1->o))) {
		if (f1 == l->player)
		    l->player = NULL;
		
                Flyer_explode(f1, l->explosions);
                list_delete_current(l->flyers);
	    }
	}
    }
}

void Level_free(struct Level *l)
{
    if(l->flyers != NULL) list_delete(l->flyers);
    if(l->lasers != NULL) list_delete(l->lasers);
    if(l->walls != NULL) list_delete(l->walls);
    if(l->explosions != NULL) list_delete(l->explosions);
  
    if(l->music != NULL) Mix_FreeMusic(l->music);
}

void Level_process_keyup(struct Level *l, SDLKey key)
{

    if (key == SDLK_1) l->camera = Camera_new(7);
    if (key == SDLK_2) l->camera = Camera_new(8);
    if (key == SDLK_3) l->camera = Camera_new(1);
    if (key == SDLK_4) l->camera = Camera_new(5);
    if (key == SDLK_5) l->camera = Camera_new(0);
    if (key == SDLK_6) l->camera = Camera_new(2);
    if (key == SDLK_7) l->camera = Camera_new(3);
    if (key == SDLK_8) l->camera = Camera_new(4);
    if (key == SDLK_9) l->camera = Camera_new(6);

    if (key == SDLK_m) {
	l->camera->iry = l->camera->iry + 180;
	l->camera->itx = -l->camera->itx;
	l->camera->itz = -l->camera->itz;
    }

    if (key == SDLK_z)
	printf("Camera it(%f, %f, %f) ir(%f, %f, %f)\n",
	       l->camera->itx, l->camera->ity, l->camera->itz,
	       l->camera->irx, l->camera->iry, l->camera->irz);

    if ((key == SDLK_SPACE || key == SDLK_LCTRL) && l->player != NULL) {
	Flyer_fire(l->player, l->lasers);
    }

    if (key == SDLK_b)
	l->camera->type = ++l->camera->type % 3; // change l->camera type

    if (key == SDLK_LEFT || key == SDLK_RIGHT) {
        if(l->player)
            l->player->o.r[0] = 0.0;
    }

}

void Level_process_keys(struct Level *l)
{
    Uint8 *keys;
    keys = SDL_GetKeyState(NULL);
    if (keys[SDLK_q]) l->camera->itx += 0.1;
    if (keys[SDLK_w]) l->camera->ity += 0.1;
    if (keys[SDLK_e]) l->camera->itz += 0.1;
    if (keys[SDLK_a]) l->camera->itx -= 0.1;
    if (keys[SDLK_s]) l->camera->ity -= 0.1;
    if (keys[SDLK_d]) l->camera->itz -= 0.1;
    if (keys[SDLK_r]) l->camera->irx += 0.5;
    if (keys[SDLK_t]) l->camera->iry += 0.5;
    if (keys[SDLK_y]) l->camera->irz += 0.5;
    if (keys[SDLK_f]) l->camera->irx -= 0.5;
    if (keys[SDLK_g]) l->camera->iry -= 0.5;
    if (keys[SDLK_h]) l->camera->irz -= 0.5;

    if (keys[SDLK_LEFT]) {
        if(l->player->o.r[0] < 30.0) l->player->o.r[0] += 5.0;
        if(keys[SDLK_RSHIFT] || keys[SDLK_LSHIFT])
            Object3d_shift(&(l->player->o), 0.3);
        else
	    Object3d_spin(&(l->player->o), l->player->spin_vel * dt / 1000.0);
    }

    if (keys[SDLK_RIGHT]) {
        if(l->player->o.r[0] > -30.0) l->player->o.r[0] -= 5.0;
        if(keys[SDLK_RSHIFT] || keys[SDLK_LSHIFT])
            Object3d_shift(&(l->player->o), -0.3);
        else
	    Object3d_spin(&(l->player->o), -l->player->spin_vel * dt / 1000.0);
    }

    if (keys[SDLK_UP]) {
        float mod = Vector_mod(l->player->o.v); 
	
        if(mod >= 20.0) mod = 20.0;
        else Object3d_set_vel(&(l->player->o), mod + 0.3);
    }

    if (keys[SDLK_DOWN]) {
        float mod = Vector_mod(l->player->o.v);
        
        if(mod <= 0.0) mod = 0.0;
        else Object3d_set_vel(&(l->player->o), mod - 0.3);
    }
}

void Level_next(struct Level *l)
{
    int level = l->num_level;

    Level_free(l);
    Level_init(l);

    l->num_level = level + 1;

    if(l->random) {
        Level_rand(l, l->num_level);
    } else {
        if(l->name[0] != '\0')
            Level_load(l, l->name);
        else
            Level_load(l, level_files[l->num_level]);
    }
    
    l->music = Mix_LoadMUS(song_files[0]);

    if(!l->music) printf("Song not found\n");
    else Mix_PlayMusic(l->music, -1);
}



/* TODO: Calc correctly the text position */
void game_over()
{
    static char str[] = "GAME OVER";
    static char str2[] = "Press 'ENTER' to start";
    int x,y;
    
    x = ( Camera_get_width() ) / 2;
    y = ( Camera_get_height() ) / 2;
    Text_draw(str, x, y, 0.8, 0.8, 0.8); 

    x = ( Camera_get_width() - strlen(str2) * 7) / 2;
    y = ( Camera_get_height() - 40) / 2;
    Text_draw(str2, x, y, 0.8, 0.8, 0.8); 
    Text_draw("(c) 2002 Rafael Garcia <bladecoder@gmx.net>", 5, 5, 0.8, 0.8, 0.8); 
}
