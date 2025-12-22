// #define LOGTASKS
// enable that if you want the Amiga versions to tell you about task-
// related events

#define RENDEZVOUS "CodeWar"
#ifndef M_PI
    #define M_PI 3.1415926536
#endif
#ifndef UNUSED
    #define UNUSED
#endif

#define OC openconsole()

float cw_get_acceleration(float* x, float* y);
double cw_get_acceleration_d(double* x, double* y);
float cw_get_acceleration_setting(float* x, float* y);
double cw_get_acceleration_setting_d(double* x, double* y);
float cw_get_time_interval(void);
double cw_get_time_interval_d(void);
float cw_get_velocity(float* x, float* y);
double cw_get_velocity_d(double* x, double* y);
float cw_get_elapsed_time(void);
double cw_get_elapsed_time_d(void);
float cw_get_version(void);
double cw_get_version_d(void);
float cw_scan(float direction, float range);
double cw_scan_d(double direction, double range);

void cw_atomic(float velocity, float direction, float detonate);
void cw_atomic_d(double velocity, double direction, double detonate);
void cw_bomb(float detonate);
void cw_bomb_d(double detonate);
void cw_cannon(float velocity, float direction, float detonate);
void cw_cannon_d(double velocity, double direction, double detonate);
void cw_missile(float velocity, float direction, float detonate);
void cw_missile_d(double velocity, double direction, double detonate);
void cw_get_position(float* x, float* y);
void cw_get_position_d(double* x, double* y);
void cw_get_field_limits(float* x_axis, float* y_axis);
void cw_get_field_limits_d(double* x_axis, double* y_axis);
void cw_power(float acceleration, float direction);
void cw_power_d(double acceleration, double direction);
void cw_turn(float direction);
void cw_turn_d(double direction);
void cw_teleport(float x, float y);
void cw_teleport_d(double x, double y);

int cw_register_network_program(char* name, UNUSED char* hostname);
int cw_register_program(char* name);
int cw_get_damage(void);
int cw_get_damage_max(void);
int cw_get_shields(void);
int cw_get_mass(void);
int cw_get_missiles(void);
int cw_get_atomics(void);
int cw_get_cannons(void);
int cw_get_bombs(void);
int cw_get_xcraft_force(void);
int cw_get_boundary_type(void);
int cw_get_energy(void);
int cw_get_channel_bandwidth(void);
void cw_boost_shields(int energy);
void cw_print_buffer(char* buffer);
void cw_channel_transmit(UNUSED int channel, UNUSED unsigned char data);
void cw_halt(void);
unsigned char cw_channel_receive(UNUSED int ch);

#ifdef WIN32
    void openconsole(void);
#endif

