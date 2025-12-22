#include <SDL/SDL.h>
#include <SDL/SDL_mixer.h>
#include <SDL/SDL_ttf.h>
#include <GL/gl.h>
#include <GL/glu.h>
//#include <cmath>
#include <math.h>
#include <time.h>
#include <stdio.h>
#include <stdlib.h>
using namespace std;

#define PI 3.1415926
#define NUM_TARGETS 1000
#define NUM_WEAPONS 1000
#define NUM_STARS 100
#define NUM_POWERUPS 9
#define DEFAULT_PTSIZE 48

static void quit_program( int );
void playWav( char* );

float runtime() {
  return SDL_GetTicks() / 1000.0;
}

float nrand() {
  return (float)rand() / (float)RAND_MAX;
}

class Camera {
  public:
  
  float pos[3];
  float look[3];
  float fov;
};

class Ship {
  public:


  float pos[3];
  float vel[3];
  float speed;
  float gun_angle, gun_pos[2];
  float radius;
  float weapon_speed;
  float last_fire_time;
  float fire_interval, fire_power, max_fire_power, fire_regen_speed;
  bool exploding;
  float kill_time;
  bool firing;
  bool falling;

  int num_guns;
  float shield;

  Ship() {
    num_guns = 1;
    weapon_speed = 2;
    speed = 1;
  }

  void kill() {
    playWav("big_explosion.wav");
    exploding = 1;
    kill_time = runtime();
    firing = 0;
    falling = 0;
    shield = 0;
  }

  void reset() {
    exploding = 0;
    falling = 0;
    firing = 0;
    pos[0] = 0;
    pos[1] = 0;
    pos[2] = 0;
    vel[0] = 0;
    vel[1] = 0;
    vel[2] = 0;
  }
};

class Weapon {
  public:

  bool active;
  float pos[2];
  float vel[2];
  float speed, length;
};

class Target {
  public:

  bool active;
  bool exploding;
  float kill_time;
  float pos[2];
  float vel[2];
  float speed;
  float radius;

  bool is_powerup;
  int type;
  float value;
  float expire_time;

  void kill() {
    playWav("explosion.wav");
    kill_time = runtime();
    active = 0;
    exploding = 1;
    is_powerup = 0;
  }
};


class Scene {
  public:


  Camera cam;

//  Uint8 *audio_chunk;
//  Uint32 audio_len;
//  Uint8 *audio_pos;
  Mix_Chunk *sound[30];
  int current_sound;

  // Font stuff
  TTF_Font *font;
  SDL_Surface *screen;
  bool keys[512];
  float powerup_probability;
  int powerup_distribution[NUM_POWERUPS];
  int powerups_recieved[NUM_POWERUPS];
  float powerup_dist_norm[NUM_POWERUPS];
  int powerup_total;
  float powerup_color[NUM_POWERUPS][4];

  int next_weapon, next_target;

  float star_pos[NUM_STARS][3];
  int grid_lines;
  float grid_width;
  float tilt, sway, sway_freq;
  float plane_height;
  bool pause;
  bool fire_analog;
  bool flash;
  int lives, score, highest_level; 
  float x_rot, y_rot;
 
  float speed;

  int num_targets, level;
  Target target[NUM_TARGETS];
  Ship ship;
  Weapon weapon[NUM_WEAPONS];


  float jScale;

  float last_time, dt;

  SDL_Joystick *joystick;

  void normalize_probabilities() {
    powerup_total = 0;
    float adjusted_distribution[NUM_POWERUPS];
    float num_powerups_recieved = 0.0001;
    for( int i=0; i<NUM_POWERUPS; i++ ) {
      num_powerups_recieved += powerups_recieved[i];    
    }

    for( int i=0; i<NUM_POWERUPS; i++ ) {
      powerup_total += powerup_distribution[i];    
    }

    for( int i=0; i<NUM_POWERUPS; i++ ) {
      adjusted_distribution[i] = powerup_distribution[i];
      if( powerups_recieved[i] > 0 ) {
        adjusted_distribution[i] /= (powerups_recieved[i]/num_powerups_recieved) / (powerup_distribution[i]/(float)powerup_total);
      }
    }

    powerup_total = 0;
    for( int i=0; i<NUM_POWERUPS; i++ ) {
      powerup_total += adjusted_distribution[i];
    }

    float n = 0;
//printf("dist: ");
    for( int i=0; i<NUM_POWERUPS; i++ ) {
      n += adjusted_distribution[i] / (float)powerup_total;
//printf("%0.3f ", adjusted_distribution[i] / (float)powerup_total);
//printf("%0.3f ", n);
      powerup_dist_norm[i] = n;
    }
//printf("\n");
  }


  Scene() {
    for( int i=0; i<512; i++ ) {
      keys[i] = false;
    } 
    powerup_distribution[0] = 7; // increase fire rate
    powerup_color[0][0] = 0;powerup_color[0][1] = 0.6;powerup_color[0][2] = 0;powerup_color[0][3] = 1;
    powerup_distribution[1] = 10; // increase power regeneration
    powerup_color[1][0] = 0.7;powerup_color[1][1] = 0.3;powerup_color[1][2] = 0.7;powerup_color[1][3] = 1;
    powerup_distribution[2] = 0; // increase power reserve
    powerup_color[2][0] = 0.3;powerup_color[2][1] = 0.3;powerup_color[2][2] = 0.7;powerup_color[2][3] = 1;
    powerup_distribution[3] = 3; // add gun
    powerup_color[3][0] = 0.6;powerup_color[3][1] = 0;powerup_color[3][2] = 0;powerup_color[3][3] = 1;
    powerup_distribution[4] = 10; // add shield
    powerup_color[4][0] = 1;powerup_color[4][1] = 1;powerup_color[4][2] = 1;powerup_color[4][3] = 1;
    powerup_distribution[5] = 4; // extra life
    powerup_color[5][0] = 0;powerup_color[5][1] = 0;powerup_color[5][2] = 0;powerup_color[5][3] = 1;
    powerup_distribution[6] = 4; // faster weapon
    powerup_color[6][0] = 0.6;powerup_color[6][1] = 0.6;powerup_color[6][2] = 0;powerup_color[6][3] = 1;
    powerup_distribution[7] = 6; // larger board
    powerup_color[7][0] = 0.6;powerup_color[7][1] = 0.6;powerup_color[7][2] = 0;powerup_color[7][3] = 0;
    powerup_distribution[8] = 3; // faster ship
    powerup_color[8][0] = 0;powerup_color[8][1] = 1;powerup_color[8][2] = 1;powerup_color[8][3] = 0.6;

    powerup_probability = 0.9;
   
    speed = 0.8;

    normalize_probabilities();

    grid_width = 2;
    grid_lines = 11;
    tilt = 60.0;
    sway = 4.0;
    sway_freq = 2.0;
    highest_level = 0;

    for( int i=0; i<2; i++ ) {
      ship.pos[i] = 0;
      ship.vel[i] = 0;
      ship.gun_pos[i] = 0;
      for( int j=0; j<NUM_WEAPONS; j++ ) {
        weapon[j].pos[i] = 0.0;
        weapon[j].vel[i] = 0.0;
      }
      for( int j=0; j<NUM_TARGETS; j++ ) {
        target[j].pos[i] = 0.0;
        target[j].vel[i] = 0.0;
        target[j].speed = 0.8;
        target[j].radius = .05;
      }
    }
    ship.gun_angle = 0;
    next_weapon = 0;
    next_target = 0;
    level = 0;
    num_targets = 0;
    ship.radius = .05;
    ship.fire_interval = 0.07;
    ship.fire_regen_speed = 1.5;
    ship.fire_power = 3;  
    ship.max_fire_power = 5;  
    lives = 5;
    score = 0;
    cam.pos[2] = 100.0;
    cam.fov = 60.0;
    pause = 1;
    jScale = .00007;
  }

  void make_powerup(Target* t) {
    int type = 0;
    float type_seed = nrand();
    while( powerup_dist_norm[type] < type_seed ) {
      type++;
    }
    t->is_powerup = 1;
    t->type = type;
    t->value = (nrand()+1.0) / 2.0;
    t->radius *= (1.5-t->value);
    t->expire_time = last_time + (nrand()+1.0) * 3.0;
  }



  void update_objects() {
    flash = 0;
    mark_time();

    plane_height += ((num_targets * 0.3) - plane_height) * 5 * dt;


      // Fire if it is time

    if( ship.firing && ship.fire_power > 0 && last_time - ship.last_fire_time > ship.fire_interval ) {
      fire_weapon();
      ship.last_fire_time = last_time;
    }
   
      // regenerate fire power

    ship.fire_power += dt * ship.fire_regen_speed;
    if( ship.fire_power > ship.max_fire_power ) {
      ship.fire_power = ship.max_fire_power;
    }

      // handle an exploding ship

    if( ship.exploding && last_time - ship.kill_time > 0.6 ) {
      ship.reset();
      if( lives < 1 ) {
        quit_program(0);
      }
      speed -= .04;
      for( int k=0; k<NUM_TARGETS; k++ ) {
        target[k].active = 0;
        target[k].is_powerup = 0;
        target[k].exploding = 0;
      }
      level = (int)floor((float)level * 0.8);
      next_level();
    }

    if( ship.falling ) {
      x_rot -= x_rot * 5 * dt;
      y_rot -= x_rot * 5 * dt;
    }
    else if ( ship.exploding ) {
      x_rot -= x_rot * 5.0 * dt;
      y_rot -= y_rot * 5.0 * dt;
    }
    else {
      x_rot += (- tilt * (2.0*ship.pos[0]/grid_width) - x_rot) * 5.0 * dt;
      y_rot += (tilt * (2.0*ship.pos[1]/grid_width) - y_rot) * 5.0 * dt;
    }

    cam.pos[2] -= (cam.pos[2]-(1.1 * grid_width/tan(180.0/PI*cam.fov))) * 5.0 * dt;

    if( ship.falling ) {
      for( int i=0; i<3; i++ ) {
        cam.look[i] -= (cam.look[i]-ship.pos[i]) * dt;
      }
    }
    else {
      for( int i=0; i<3; i++ ) {
        cam.look[i] -= cam.look[i] * dt;
      }
    }
 
    if( fire_analog && (ship.gun_pos[0] != 0 || ship.gun_pos[1] != 0) ) {
      ship.gun_angle = atan(ship.gun_pos[0] / ship.gun_pos[1]);
      if( ship.gun_pos[1] >= 0 ) {
        ship.gun_angle += PI;
      }
    }

    for( int i=0; i<2; i++ ) {
      ship.pos[i] += ship.vel[i] * dt;
      if( ! ship.exploding ) {
        if( ship.pos[i] > grid_width/2.0 ) {
          ship.pos[i] =  grid_width/2.0;
        //  ship.falling = 1;
        }
        if( ship.pos[i] < -grid_width/2.0 ) {
          ship.pos[i] = - grid_width/2.0;
        //  ship.falling = 1;
        }
      }
    }
    if( ship.falling ) {
      ship.vel[2] -= dt;
      ship.pos[2] += ship.vel[2] * dt;
      if( ship.pos[2] < -plane_height ) {
        ship.pos[2] = -plane_height;
        ship.falling = 0;
        lose_life();
      }
    }



    if( num_targets == 0 ) {
      next_level();
    }


      // update weapons

    for( int w=0; w<NUM_WEAPONS; w++ ) {
      if( weapon[w].active ) {
        weapon[w].pos[0] += dt * weapon[w].vel[0]; 
        weapon[w].pos[1] += dt * weapon[w].vel[1]; 
        float dist_travel = weapon[w].speed * dt;  

        if( weapon[w].pos[0] > grid_width+dist_travel ||  weapon[w].pos[0] < - (grid_width+dist_travel) || weapon[w].pos[1] >  grid_width+dist_travel ||  weapon[w].pos[1] < - (grid_width+dist_travel) ) {
          weapon[w].active = 0;
        }

          // detect weapon hits

        for( int t=0; t<NUM_TARGETS; t++ ) {
          if( target[t].active ) {
            float dx = (target[t].pos[0]-weapon[w].pos[0]);
            float dy = (target[t].pos[1]-weapon[w].pos[1]);
            float dist = sqrt(dx*dx + dy*dy);
            float dx1 = ((target[t].pos[0]+weapon[w].vel[0]*dt)-weapon[w].pos[0]);
            float dy1 = ((target[t].pos[1]+weapon[w].vel[1]*dt)-weapon[w].pos[1]);
            float dist1 = sqrt(dx1*dx1 + dy1*dy1);
            float cost = weapon[w].vel[0]/weapon[w].speed;
            float sint = weapon[w].vel[1]/weapon[w].speed;
            float wpos[2] = { cost*weapon[w].pos[0]+sint*weapon[w].pos[1], -sint*weapon[w].pos[0]+cost*weapon[w].pos[1]};
            float tpos[2] = { cost*target[t].pos[0]+sint*target[t].pos[1], -sint*target[t].pos[0]+cost*target[t].pos[1]};

            if( dist < target[t].radius || dist1 < target[t].radius || (wpos[1] < tpos[1] + target[t].radius && wpos[1] > tpos[1] - target[t].radius && wpos[0] > tpos[0] && wpos[0] < tpos[0] + weapon[w].speed*dt)) {

              // Decide if we get a powerup
              if( ! target[t].is_powerup ) {
                num_targets--;
                target[t].kill();
                score += 5 * (level-1) + 100;
              }

              if( (! target[t].is_powerup) && nrand() < (powerup_probability / (float)level) ) {
                target[t].active = 1;
                make_powerup(&target[t]);
              }
              weapon[w].active = 0;
            }
          }
        }
      }
    }

        // update targets

    for( int t=0; t<NUM_TARGETS; t++ ) {
      if( target[t].exploding ) {
        if( last_time - target[t].kill_time > 0.1 ) {
          target[t].exploding = 0;
        }
      }
      else if( target[t].active ) {
        if( target[t].is_powerup && last_time > target[t].expire_time ) {
          target[t].active = 0;
        }

        target[t].pos[0] += dt * target[t].vel[0]; 
        target[t].pos[1] += dt * target[t].vel[1]; 
          // detect ship hit
        
        float dx = (target[t].pos[0]-ship.pos[0]);
        float dy = (target[t].pos[1]-ship.pos[1]);
        float dist = sqrt(dx*dx + dy*dy);
        if( ! ship.exploding && dist < (target[t].radius + ship.radius) ) {
          if( target[t].is_powerup ) {
            target[t].active = 0;
            apply_powerup(target[t].type, target[t].value);
            flash = 1;
          }
          else {
            if( ship.shield > 0 ) {
              ship.shield -= 1.0;
              playWav("shield_down.wav");
              target[t].kill();
              num_targets--;
            }
            else {
              lose_life();    
            }
          }
        }

          // bounce

        for( int k=0; k<2; k++ ) {
          if( (target[t].pos[k] >  grid_width/2.0 && target[t].vel[k] > 0) || (target[t].pos[k] < - grid_width/2.0 && target[t].vel[k] < 0) ) {
            target[t].vel[k] *= -1;
          }
        }    
      }
    }
  }

  void apply_powerup(int type, float value) {
    powerups_recieved[type]++;

    if( type == 0 ) {
      ship.fire_interval /= 2.0 * (1.0 - (value/5.0));
    }
    else if( type == 1 ) {
      ship.fire_regen_speed *= 2.0 * (1.0 + (value/10.0));
    }
    else if( type == 2 ) {
      ship.max_fire_power += 4.0 * value;
    }
    else if( type == 3 ) {
      ship.num_guns++;
    }
    else if( type == 4 ) {
      playWav("shield_up.wav");
      ship.shield += value;
    }
    else if( type == 5 ) {
      lives++;
    }
    else if( type == 6 ) {
      ship.weapon_speed *= 1.0 + value;
    }
    else if( type == 7 ) {
      grid_width += 2.0*(grid_width / (float)(grid_lines-1));
      grid_lines += 2;
    }
    else if( type == 8 ) {
      ship.speed *= 1.0 + value/3.0;
    }

    normalize_probabilities();
  }

  void lose_life() {
    ship.kill();
    lives--;
  }


  void fire_weapon() {
    ship.fire_power -= ship.num_guns;
    float w = .15 / ship.num_guns;
    float x = w * cos(ship.gun_angle+PI/2.0);
    float y = w * sin(ship.gun_angle+PI/2.0);
    for( int i=0; i<ship.num_guns; i++ ) {
      weapon[next_weapon].active = 1;
      weapon[next_weapon].speed = ship.weapon_speed;
      weapon[next_weapon].length = weapon[next_weapon].speed;
      weapon[next_weapon].vel[0] = weapon[next_weapon].speed * cos(ship.gun_angle); // + ship.vel[0];
      weapon[next_weapon].vel[1] = weapon[next_weapon].speed * sin(ship.gun_angle); // + ship.vel[1];
      weapon[next_weapon].pos[0] = ship.pos[0] + x*(ship.num_guns-1)/2.0 - x*i;
      weapon[next_weapon].pos[1] = ship.pos[1] + y*(ship.num_guns-1)/2.0 - y*i;
      next_weapon = (next_weapon+1) % 1000;
    }
    playWav("fire.wav");
  }

  void next_level() {
    level++;
    if( level > highest_level ) {
      highest_level = level;
    }
    for( int j=0; j<level; j++ ) {

      int c = 0;
      do {
        c++;
        next_target = (next_target + 1) % 100;
        if( c > 100 ) {
          printf("DAmn diggity.\n");
          quit_program(1);
        }
      } while( target[next_target].active );

      int i = next_target;
      target[i].active = 1;
      target[i].exploding = 0;
      target[i].is_powerup = 0;

      int axis = rand();
      float side = floor(nrand() * 2.0) * (grid_width+.5) - ((grid_width+.5)/2.0);
      float pos = ((float)rand() / (float)RAND_MAX * grid_width) - grid_width/2.0;
      target[i].pos[axis % 2] = pos;
      target[i].pos[(axis+1) % 2] = side;
      target[i].radius = 0.05;

      target[i].speed = speed;
      float angle = ((float)rand() / (float)RAND_MAX * PI / 4.0) + (PI / 8.0) 
                    + floor((float)rand() / (float)RAND_MAX * 4.0) * (PI/2.0);
      target[i].vel[0] = target[i].speed * cos(angle);      
      target[i].vel[1] = target[i].speed * sin(angle);
    }
    speed += 0.02;
    num_targets = level;
  }
  

  void mark_time() {
    float time = SDL_GetTicks() / 1000.0;
    dt = time - last_time;
    if( dt > .1 ) {
      dt = 0;
    }
    last_time = time;
  }

} scn;

void playWav( char* file ) {

  scn.current_sound = (scn.current_sound + 1) % 30;
  Mix_FreeChunk(scn.sound[scn.current_sound]);

  scn.sound[scn.current_sound] = Mix_LoadWAV(file);
  Mix_PlayChannel(-1, scn.sound[scn.current_sound], 0);

}

static void quit_program( int code )
{
  printf("Score: %d\nHigh level: %d\n", scn.score, scn.highest_level);
//   printf("Final distribution: ");
//   float dist_total, real_total;
//   dist_total = real_total = 0;
// 
//   for( int i=0; i<NUM_POWERUPS; i++ ) {
//     dist_total += scn.powerup_distribution[i];
//     real_total += scn.powerups_recieved[i];
//   }
//   for( int i=0; i<NUM_POWERUPS; i++ ) {
//     printf("%0.1f ", scn.powerups_recieved[i] * dist_total/real_total);
//   }
//   printf("\n");

  Mix_CloseAudio();

  SDL_JoystickClose(scn.joystick);
  SDL_Quit( );

  TTF_CloseFont(scn.font);

  /* Exit program. */
  exit( code );
}


static void handle_key_up( SDL_keysym* keysym ) {
  int n = keysym->sym;
  scn.keys[n] = false;
//  printf("released key %d\n", n);
  if( n >= 273 && n <= 276 ) {
    // process motion change
    scn.ship.vel[0] = 0;
    scn.ship.vel[1] = 0;
    if( scn.keys[273] ) // up
      scn.ship.vel[1] += scn.ship.speed;
    if( scn.keys[274] ) // dn
      scn.ship.vel[1] -= scn.ship.speed;
    if( scn.keys[275] ) // rt
      scn.ship.vel[0] += scn.ship.speed;
    if( scn.keys[276] ) // lt
      scn.ship.vel[0] -= scn.ship.speed;
  }
  
  if( n >= 97 && n <= 119 ) {
    scn.ship.firing = 0;
  }
  
}


static void handle_key_down( SDL_keysym* keysym ) {
  int n = keysym->sym;
  if( n == SDLK_ESCAPE )
    quit_program( 0 );
  else if( n == SDLK_SPACE ) {
    scn.pause = ! scn.pause;
    scn.mark_time();
  }
  else {
    scn.keys[n] = true;
//    printf("pressed button %d\n", keysym->sym);
  }
  
  if( n >= 273 && n <= 276 ) {
    // process motion change
    scn.ship.vel[0] = 0;
    scn.ship.vel[1] = 0;
    if( scn.keys[273] ) // up
      scn.ship.vel[1] += scn.ship.speed;
    if( scn.keys[274] ) // dn
      scn.ship.vel[1] -= scn.ship.speed;
    if( scn.keys[275] ) // rt
      scn.ship.vel[0] += scn.ship.speed;
    if( scn.keys[276] ) // lt
      scn.ship.vel[0] -= scn.ship.speed;
  }
  
  else if( n == 119 ) {  // w
    scn.ship.gun_angle = PI/2.0;
    scn.ship.firing = 1;
    scn.fire_analog = 0;
  }
  else if( n == 115 ) {  // s
    scn.ship.gun_angle = 3.0*PI/2.0;
    scn.ship.firing = 1;
    scn.fire_analog = 0;
  }
  else if( n == 100 ) {  // d
    scn.ship.gun_angle = 0;
    scn.ship.firing = 1;
    scn.fire_analog = 0;
  }
  else if( n == 97 ) {  // a
    scn.ship.gun_angle = PI;
    scn.ship.firing = 1;
    scn.fire_analog = 0;
  }
}
 
static void process_events( void )
{
  SDL_Event event;

  while( SDL_PollEvent( &event ) ) {

    switch( event.type ) {
    case SDL_MOUSEMOTION:


    break;
    case SDL_KEYDOWN:
      /* Handle key presses. */
      handle_key_down( &event.key.keysym );
      break;
    
    case SDL_KEYUP:
      handle_key_up( &event.key.keysym );
      break;
      
      
   case SDL_JOYAXISMOTION:  /* Handle Joystick Motion */

      if( ! scn.ship.falling && ! scn.ship.exploding ) {
        if( event.jaxis.axis == 0) {
          scn.ship.vel[0] =(float)event.jaxis.value * scn.jScale * scn.ship.speed; 
        }
        if( event.jaxis.axis == 1) {
          scn.ship.vel[1] = -(float)event.jaxis.value * scn.jScale * scn.ship.speed; 
        }
      }

      if( event.jaxis.axis == 2) {
        scn.ship.gun_pos[0] = event.jaxis.value;
        if( ! scn.ship.firing ) {
          scn.fire_analog = 1;
        }
      }
      if( event.jaxis.axis == 4) {
        scn.ship.gun_pos[1] = - event.jaxis.value;
        if( ! scn.ship.firing ) {
          scn.fire_analog = 1;
        }
      }

    break;
    case SDL_JOYBUTTONDOWN:
      if( event.jbutton.button == 9 ) {
        scn.pause = ! scn.pause;
        scn.mark_time();
      }
      else {
        if( ! scn.ship.exploding ) {
          if( event.jbutton.button == 0 ) {
            scn.ship.gun_angle = PI/2.0;
            scn.ship.firing = 1;
            scn.fire_analog = 0;
          }
          else if( event.jbutton.button == 1 ) {
            scn.ship.gun_angle = 0;
            scn.ship.firing = 1;
            scn.fire_analog = 0;
          }
          else if( event.jbutton.button == 2 ) {
            scn.ship.gun_angle = 3*PI/2.0;
            scn.ship.firing = 1;
            scn.fire_analog = 0;
          }
          else if( event.jbutton.button == 3 ) {
            scn.ship.gun_angle = PI ;
            scn.ship.firing = 1;
            scn.fire_analog = 0;
          }
          else {
            scn.ship.firing = 1;
            scn.fire_analog = 1;
          }
        }
      }

    break;
    case SDL_JOYBUTTONUP:
      scn.ship.firing = 0;
    break;
    case SDL_QUIT:
      /* Handle quit_program requests (like Ctrl-c). */
      quit_program( 0 );
      break;
    }
  }
}

void glScale1f( float s ) {
  glScalef(s, s, s);
}

void draw_circle() {
  glBegin(GL_TRIANGLE_FAN);
  glVertex3f(0, 0, 0);
  for( float t=0; t<=2*PI; t+=2*PI/24.0 ) {
    glVertex3f(cos(t), sin(t), 0.01);
  }
  glEnd();
}

void draw_explosion(float r, float g, float b, float a) {
  glBegin(GL_TRIANGLE_STRIP);
  for( float t=0; t<=2*PI+.01; t+=2*PI/48.0 ) {
    glColor4f(0, 0, 0, 0);
    glVertex3f(0.7 * cos(t), 0.7 * sin(t), 0);
    glColor4f(r, g, b, a);
    glVertex3f(cos(t), sin(t), 0);
  }
  glEnd();
}


void draw_grid() {
  if( scn.flash ) {
    glLineWidth(3);
    glColor4f(1.0, 1.0, 1.0, 0.5);
  }
  else {
    glLineWidth(2);
    glColor4f(0.4, 0.7, 0.1, 0.5);
  }
  glBegin(GL_LINES);
  for( float i=0; i<=scn.grid_lines; i++) {
    float x = - scn.grid_width/2.0 + i*scn.grid_width/(float)scn.grid_lines;
    glVertex3f(x, - scn.grid_width/2.0, 0);
    glVertex3f(x,  scn.grid_width/2.0, 0);
    glVertex3f(- scn.grid_width/2.0, x, 0);
    glVertex3f( scn.grid_width/2.0, x, 0);
  } 
  glEnd();
}

void draw_ship() {
  glEnable(GL_DEPTH_TEST);
  glPushMatrix();

    glTranslatef(scn.ship.pos[0], scn.ship.pos[1], scn.ship.pos[2]);

    if( scn.ship.exploding ) {
      glPushMatrix();
        float radius = (scn.ship.radius / 2.0) + 4.0 * (scn.last_time - scn.ship.kill_time);
        float alpha = 1.0-(radius);
        glScale1f(radius);
        glPushMatrix();
          draw_explosion(1.0, 0.0, 0.0, alpha);
        
          glTranslatef(0, 0, 0.2);
          draw_explosion(1.0, 0.0, 0.0, alpha);
 
          glScale1f(0.8);
          glTranslatef(0, 0, 0.2);
          draw_explosion(1.0, 0.0, 0.0, alpha);
        glPopMatrix();
        

        glScalef(0.7, 0.7, 1);
        glPushMatrix();
          draw_explosion(1.0, 0.8, 0.0, alpha);
        
          glTranslatef(0, 0, 0.2);
          draw_explosion(1.0, 0.8, 0.0, alpha);
 
          glScale1f(0.8);
          glTranslatef(0, 0, 0.2);
          draw_explosion(1.0, 0.8, 0.0, alpha);
        glPopMatrix();
      glPopMatrix();
    }
    else {
      glPointSize(10);
      glColor4f(.5, .9, 1.0, 1.0);
      glScale1f(scn.ship.radius);
      draw_circle();
      glColor4f(0, 0, 0, 0.7);
      glScale1f(0.9);
      glTranslatef(0, 0, 0.01);
      draw_circle();
      glTranslatef(0, 0, 0.5);
      glColor4f(.1, .4, 1.0, 1.0);
      draw_circle();
      if( scn.ship.shield > 0 ) {
        glScale1f(1.5);
        glColor4f(1.0, 1.0, 1.0, 0.5);
        draw_circle();
      }


      glTranslatef(0, 0, 0.01);
      glColor4f(1, 1, 1, 1);
      glBegin(GL_LINES);
        glVertex3f(0, 0, 0);
        glVertex3f(cos(scn.ship.gun_angle), sin(scn.ship.gun_angle), 0);
      glEnd();
    }
  glPopMatrix();
}

void draw_weapons() {
  float s = 1.0;
  for( int i=0; i<1000; i++ ) {
    if( scn.weapon[i].active ) {
      glPushMatrix();
        float angle = (180.0 / PI) * atan(scn.weapon[i].vel[1]/scn.weapon[i].vel[0]);
        if( scn.weapon[i].vel[0] >= 0 ) {
          angle += 180;
        }
        glTranslatef(scn.weapon[i].pos[0], scn.weapon[i].pos[1], 0.05);
        glRotatef(angle,0,0,1);
        glLineWidth(3);
        float w =  0.8*scn.dt/scn.weapon[i].speed;
        glBegin(GL_TRIANGLES);
          s = .1;
          glColor4f(0, 1, 0, 1.0);
          glVertex3f(0, 0, 0);
          glColor4f(1, 1, 0, 0);
//          glVertex3f(s*(-2*w*scn.dt*scn.weapon[i].vel[0]-(w*scn.weapon[i].vel[1])), s*(-2*w*scn.dt*scn.weapon[i].vel[1]+(w*scn.weapon[i].vel[0])), 0);
//          glVertex3f(s*(-2*w*scn.dt*scn.weapon[i].vel[0]+(w*scn.weapon[i].vel[1])), s*(-2*w*scn.dt*scn.weapon[i].vel[1]-(w*scn.weapon[i].vel[0])), 0);
          glVertex3f((1*s),(-.3*s),0);
          glVertex3f((1*s),(.3*s),0);
          glColor4f(0, 1, 1, 1.0);
          glVertex3f(0, 0, 0);
          glColor4f(0, 1, 1, .3);
//          glVertex3f(s*(-scn.dt*scn.weapon[i].vel[0]-(w*scn.weapon[i].vel[1])), s*(-scn.dt*scn.weapon[i].vel[1]+(w*scn.weapon[i].vel[0])), 0);
//          glVertex3f(s*(-scn.dt*scn.weapon[i].vel[0]+(w*scn.weapon[i].vel[1])), s*(-scn.dt*scn.weapon[i].vel[1]-(w*scn.weapon[i].vel[0])), 0);
          glVertex3f(scn.dt*scn.weapon[i].speed,(-.15*s),0);
          glVertex3f(scn.dt*scn.weapon[i].speed,(.15*s),0);

//          w *= 0.5;
//          glColor4f(1, 1, 1, 1.0);
//          glVertex3f(0, 0, 0);
//          glColor4f(1, 1, 0, 0.3);
//          glVertex3f(s*(-scn.dt*scn.weapon[i].vel[0]-(w*scn.weapon[i].vel[1])), s*(-scn.dt*scn.weapon[i].vel[1]+(w*scn.weapon[i].vel[0])), 0);
//          glVertex3f(s*(-scn.dt*scn.weapon[i].vel[0]+(w*scn.weapon[i].vel[1])), s*(-scn.dt*scn.weapon[i].vel[1]-(w*scn.weapon[i].vel[0])), 0);
        glEnd();
      glPopMatrix();
    }
  }
}

void draw_targets() {

  glEnable(GL_DEPTH_TEST);
  for( int i=0; i<100; i++ ) {
    if( scn.target[i].active ) {
      glPushMatrix();
        glTranslatef(scn.target[i].pos[0], scn.target[i].pos[1], 0.01);
        glScale1f(scn.target[i].radius);
        glColor4f(.6, .6, .4, 1);
        draw_circle();
        glScale1f(0.9);
        glTranslatef(0, 0, 0.01);
        glColor4f(0, 0, 0, 0.7);
        draw_circle();
        glTranslatef(0, 0, 0.5);
        if( scn.target[i].is_powerup ) {
          glColor4f(scn.powerup_color[scn.target[i].type][0], scn.powerup_color[scn.target[i].type][1], scn.powerup_color[scn.target[i].type][2], scn.powerup_color[scn.target[i].type][3]);
        } else {
          glColor4f(.3, .3, .3, 1);
        }
        draw_circle();
      glPopMatrix();
    }
    else if( scn.target[i].exploding ) {
      glPushMatrix();
        glTranslatef(scn.target[i].pos[0], scn.target[i].pos[1], 0.01);
        float radius = (scn.target[i].radius / 2.0) + 4.0 * (scn.last_time - scn.target[i].kill_time);
        float alpha = 1.0-(radius);
        glScale1f(radius);
        draw_explosion(0.4, 0.4, 1.0, alpha);
        
        glTranslatef(0, 0, 0.2);
        draw_explosion(0.4, 0.4, 1.0, alpha);
 
        glScale1f(0.8);
        glTranslatef(0, 0, 0.2);
        draw_explosion(0.4, 0.4, 1.0, alpha);
      glPopMatrix();
    }
  }
}


/* Quick utility function for texture creation */
// Taken from glfont.c for drawing font
static int power_of_two(int input)
{
	int value = 1;

	while ( value < input ) {
		value <<= 1;
	}
	return value;
}

// Taken from glfont.c for drawing font
GLuint SDL_GL_LoadTexture(SDL_Surface *surface, GLfloat *texcoord)
{
	GLuint texture;
	int w, h;
	SDL_Surface *image;
	SDL_Rect area;
	Uint32 saved_flags;
	Uint8  saved_alpha;

	/* Use the surface width and height expanded to powers of 2 */
	w = power_of_two(surface->w);
	h = power_of_two(surface->h);
	texcoord[0] = 0.0f;			/* Min X */
	texcoord[1] = 0.0f;			/* Min Y */
	texcoord[2] = (GLfloat)surface->w / w;	/* Max X */
	texcoord[3] = (GLfloat)surface->h / h;	/* Max Y */

	image = SDL_CreateRGBSurface(
			SDL_SWSURFACE,
			w, h,
			32,
			0xFF000000,
			0x00FF0000, 
			0x0000FF00, 
			0x000000FF
		       );
	if ( image == NULL ) {
		return 0;
	}

	/* Save the alpha blending attributes */
	saved_flags = surface->flags&(SDL_SRCALPHA|SDL_RLEACCELOK);
	saved_alpha = surface->format->alpha;
	if ( (saved_flags & SDL_SRCALPHA) == SDL_SRCALPHA ) {
		SDL_SetAlpha(surface, 0, 0);
	}

	/* Copy the surface into the GL texture image */
	area.x = 0;
	area.y = 0;
	area.w = surface->w;
	area.h = surface->h;
	SDL_BlitSurface(surface, &area, image, &area);

	/* Restore the alpha blending attributes */
	if ( (saved_flags & SDL_SRCALPHA) == SDL_SRCALPHA ) {
		SDL_SetAlpha(surface, saved_flags, saved_alpha);
	}

	/* Create an OpenGL texture for the image */
	glGenTextures(1, &texture);
	glBindTexture(GL_TEXTURE_2D, texture);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
	glTexImage2D(GL_TEXTURE_2D,
		     0,
		     GL_RGBA,
		     w, h,
		     0,
		     GL_RGBA,
		     GL_UNSIGNED_BYTE,
		     image->pixels);
	SDL_FreeSurface(image); /* No longer needed */

	return texture;
}


void draw_text(char * buff) {
  SDL_Color white = { 0xFF, 0xFF, 0xFF, 0 };
  SDL_Color black = { 0x00, 0x00, 0x00, 0 };
  SDL_SetColors(scn.screen, &white, 10, 5);

  SDL_Surface *text;
  text = TTF_RenderText_Solid(scn.font, buff, white);
  int w = text->w;
  int h = text->h;

  GLfloat texcoord[4];
  GLuint texture = SDL_GL_LoadTexture(text, texcoord);
  GLfloat texMinX = texcoord[0];
  GLfloat texMinY = texcoord[1];
  GLfloat texMaxX = texcoord[2];
  GLfloat texMaxY = texcoord[3];
  SDL_FreeSurface(text);

// printf("%d",h);
// printf("%d",(texMaxY-texMinY));

//  glBegin(GL_POINTS);
//    glVertex3f(0,0,0);
//  glEnd();

  glBindTexture(GL_TEXTURE_2D, texture);
  glEnable(GL_TEXTURE_2D);
  glBegin(GL_TRIANGLE_STRIP);
    glTexCoord2f(texMinX, texMaxY); glVertex3f(0,0,0);
    glTexCoord2f(texMaxX, texMaxY); glVertex3f(w/2.0,0,0);
    glTexCoord2f(texMinX, texMinY); glVertex3f(0,h/2.0,0);
    glTexCoord2f(texMaxX, texMinY); glVertex3f(w/2.0,h/2.0,0);
  glEnd();
  glDisable(GL_TEXTURE_2D);
  glDeleteTextures(1,&texture);
}

void draw_hud() {
  glDisable(GL_DEPTH_TEST);
  glMatrixMode(GL_PROJECTION);
  glPushMatrix();
    glLoadIdentity();
    glOrtho(-100, 100, -100, 100, -100, 100);
    glMatrixMode(GL_MODELVIEW);
    glPushMatrix();
      glLoadIdentity();
      float fp = -95 + (scn.ship.fire_power * 2.0);
      glColor4f(0.7, 0.3, 0.7, 0.7);
      glBegin(GL_QUADS);
        glVertex3f(99,-95,0);
        glVertex3f(99, fp,0);
        glVertex3f(97.2, fp,0);
        glVertex3f(97.2,-95,0);
      glEnd();
      fp = -95.2 + (scn.ship.max_fire_power * 2.0);
      glColor4f(0.3, 0.3, 0.7, 0.7);
      glLineWidth(1);
      glBegin(GL_LINE_LOOP);
        glVertex3f(97,-95.2,0);
        glVertex3f(97, fp,0);
        glVertex3f(99.2, fp,0);
        glVertex3f(99.2,-95.2,0);
      glEnd();


      float sh = -95 + (1.0 / scn.ship.fire_interval);
      glColor4f(0.0, 0.9, 0.0, 0.7);
      glBegin(GL_QUADS);
        glVertex3f(96,-95, 0);
        glVertex3f(96, sh, 0);
        glVertex3f(94, sh, 0);
        glVertex3f(94,-95, 0);
      glEnd();

      sh = -95 + (scn.ship.shield * 4.0);
      glColor4f(0.9, 0.9, 0.9, 0.7);
      glBegin(GL_QUADS);
        glVertex3f(93,-95, 0);
        glVertex3f(93, sh, 0);
        glVertex3f(91, sh, 0);
        glVertex3f(91,-95, 0);
      glEnd();


      // Remaining Lives
      glColor4f(0.1, 0.4, 1.0, 0.7);
      glPushMatrix();
        glTranslatef(-95, -95, 0); 
        glScale1f(3.0);
        for( int i=0; i<scn.lives-1; i++ ) {
          draw_circle();
          glTranslatef(2.5, 0, 0);
        }
      glPopMatrix();
      

      // Current Level
      glColor4f(0.9, 0.9, 0.1, 0.7);
      glPushMatrix();
      glTranslatef(-90,85,0);
      glScale1f(0.5);
        char* buff = new char[100];
        sprintf(buff,"%d",scn.level);
        draw_text(buff);
      glPopMatrix();

      // Current Score
      glColor4f(0.9, 0.9, 0.1, 0.7);
      glPushMatrix();
      glTranslatef(70,85,0);
      glScale1f(0.5);
        sprintf(buff,"%d",scn.score);
        draw_text(buff);
      glPopMatrix();
      delete[] buff;

      
    glPopMatrix();
    glMatrixMode(GL_PROJECTION);
  glPopMatrix();
}


void draw_ground() {

  float c[2];
  if( scn.flash ) {
    c[0] = 0.1;
    c[1] = 0.3;
  }
  else {
    c[0] = 0.0;
    c[1] = 0.1;
  }
  float a = 0.8 - 0.2 * fabs(scn.ship.pos[0] + scn.ship.pos[1]);

  for( int i=-6; i<6; i++ ) {
    for( int j=-6; j<6; j++ ) {
      int ind = (i+j+1000) % 2;
      glColor4f(c[ind], c[ind], c[ind], a);
      glBegin(GL_QUADS);
        glVertex3f(i, j, 0);
        glVertex3f(i+1, j, 0);
        glVertex3f(i+1, j+1, 0);
        glVertex3f(i, j+1, 0);
      glEnd();
    }
  }
}

static void draw_screen( void )
{
  glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );

  glMatrixMode( GL_MODELVIEW );
  glLoadIdentity( );
  gluLookAt(scn.cam.pos[0], scn.cam.pos[1], scn.cam.pos[2], scn.cam.look[0], scn.cam.look[1], scn.cam.look[2], 0, 1, 
0);


  glPushMatrix();

    glRotatef(scn.y_rot, 1, 0, 0);
    glRotatef(scn.x_rot, 0, 1, 0);

    glPushMatrix();
      glTranslatef(0, 0, -scn.plane_height * 2.0);
      glScalef(1, 1, -1);
      glRotatef(scn.ship.pos[1] + scn.sway * sin(scn.last_time * scn.sway_freq), 1, 0, 0);
      glRotatef(scn.ship.pos[0] + scn.sway * cos(scn.last_time * scn.sway_freq), 0, 1, 0);
      draw_ship();
      draw_weapons();
      draw_targets();
      draw_grid();
    glPopMatrix();

    glPushMatrix();
      glTranslatef(0, 0, -scn.plane_height);
      draw_ground();
    glPopMatrix();

    glPushMatrix();
      glRotatef(scn.ship.pos[1] + scn.sway * sin(scn.last_time * scn.sway_freq), 1, 0, 0);
      glRotatef(scn.ship.pos[0] + scn.sway * cos(scn.last_time * scn.sway_freq), 0, 1, 0);

      draw_grid();
      draw_ship();
      draw_weapons();
      draw_targets();
    glPopMatrix();
  glPopMatrix();

  draw_hud();

  SDL_GL_SwapBuffers( );
}


static void setup_opengl( int width, int height )
{
  float ratio = (float) width / (float) height;

  /* Our shading model--Gouraud (smooth). */
  glShadeModel( GL_SMOOTH );

  glCullFace( GL_BACK );
  glFrontFace( GL_CCW );
  glEnable( GL_CULL_FACE );
  glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  glEnable (GL_BLEND);
  glEnable (GL_ALPHA_TEST);
  glAlphaFunc (GL_ALWAYS, 0.5);
  glDisable(GL_DEPTH_TEST);
  glClearColor( 0, 0, 0, 0 );
  glEnable(GL_POINT_SMOOTH);
  glViewport( 0, 0, width, height );

  glMatrixMode( GL_PROJECTION );
  glLoadIdentity( );
  gluPerspective( scn.cam.fov, ratio, 0.02, 1024.0 );
}

int main( int argc, char* argv[] )
{
  const SDL_VideoInfo* info = NULL;
  int width = 0;
  int height = 0;
  int bpp = 0;
  int flags = 0;
  int i;

  if ( SDL_Init( SDL_INIT_VIDEO | SDL_INIT_JOYSTICK | SDL_INIT_AUDIO ) < 0 )  {
    fprintf(stderr, "Couldn't initialize SDL: %s\n", SDL_GetError());
    quit_program( 1 );
  }

  /* Initialize the TTF library */
  if ( TTF_Init() < 0 ) {
    fprintf(stderr, "Couldn't initialize TTF: %s\n", SDL_GetError());
    quit_program( 1 );
  }
  int ptsize = DEFAULT_PTSIZE;
  scn.font = TTF_OpenFont("FONTS:_ttf/Vera.ttf", ptsize);
  if ( scn.font == NULL ) {
    fprintf(stderr, "Couldn't load pt font from %s\n", SDL_GetError());
    quit_program( 1 );
  }
  TTF_SetFontStyle(scn.font, TTF_STYLE_NORMAL);  // Usage: TTF_SetFontStyle(<font>,<renderstyle(int)>)


  info = SDL_GetVideoInfo( );

  if( !info ) {
    /* This should probably never happen. */
    fprintf( stderr, "Video query failed: %s\n",
       SDL_GetError( ) );
    quit_program( 1);
  }

  width = 640;
  height = 480;

  for ( i = 1; i < argc; i++ )
    {
        if ( 0 == strcmp( argv[ i ], "-width" ) )
        {
            i++;
            width = atoi( argv[ i ] );
        }
        if ( 0 == strcmp( argv[ i ], "-height" ) )
        {
            i++;
            height = atoi( argv[ i ] );
        }
    }

  bpp = info->vfmt->BitsPerPixel;

  SDL_GL_SetAttribute( SDL_GL_RED_SIZE, 5 );
  SDL_GL_SetAttribute( SDL_GL_GREEN_SIZE, 5 );
  SDL_GL_SetAttribute( SDL_GL_BLUE_SIZE, 5 );
  SDL_GL_SetAttribute( SDL_GL_DEPTH_SIZE, 16 );
  SDL_GL_SetAttribute( SDL_GL_DOUBLEBUFFER, 1 );

  flags = SDL_OPENGL | SDL_FULLSCREEN;

  scn.screen = SDL_SetVideoMode( width, height, bpp, flags );
  if( scn.screen == 0 ) {
    fprintf( stderr, "Video mode set failed: %s\n",
       SDL_GetError( ) );
    quit_program( 1 );
  }

  setup_opengl( width, height );


  /* Joystick setup  */
  SDL_JoystickEventState(SDL_ENABLE);
  scn.joystick = SDL_JoystickOpen(0);


  SDL_ShowCursor(0);

  srand(time(NULL));

  int audio_rate = 22050;
  Uint16 audio_format = AUDIO_S16; 
  int audio_channels = 2;
  int audio_buffers = 1024;

  if(Mix_OpenAudio(audio_rate, audio_format, audio_channels, audio_buffers)) {
    printf("Unable to open audio!\n");
  }

  while( 1 ) {
    /* Process incoming events. */
    process_events( );

    if( ! scn.pause ) {
      scn.update_objects();
    }

    /* Draw the screen. */
    draw_screen( );
  }

  return 0;
}
