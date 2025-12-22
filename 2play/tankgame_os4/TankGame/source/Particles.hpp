/*
  --- Projectname: TankGame ---
  (Targetsystem: Crossplatform)
  
  Author: Dennis Busch, http://www.dennisbusch.de
          Dennis-Busch@gmx.net
*/

// this pair of files holds two classes "Animation" and "Particle" for
// the very basic particle system of TankGame

#include "myMath.hpp"
#include <stdlib.h>

#if !defined(_Particles_HEAD_INCLUDED)
#define _Particles_HEAD_INCLUDED

// for different modes of animation
enum AnimMode
{
  animForward = 0, // frames are counted up on update
  animBackward = 1, // frames are counted down on update
  animPingPong = 2 // frame count direction turns around at either end of the total frames
};

class Animation;
typedef Animation* ptrAnimation;

// simple class for handling animation frame states
class Animation
{
  private:
    int currentFrame; // -1 if animation is ended
    int totalFrames; // for update control
    int advanceDelay; // number of logic updates, before the next animation frame update
    int delayCounter;
    AnimMode mode; // for animation playback control
    int loop; // -1 loop forever, 0 don't loop, >0 loop this number of times
    bool forward; // to control pingpong animation
    
    bool firstUpdate; // to control behaviour on first call of the UpdateAndGetNewFrame method
    
    void init();
    void init(int cF, int tF, int aD, AnimMode mode, int loop); // initializes values
  
  public:
    // constructor/destructor
    Animation();
    Animation(int cF, int tF, int aD, AnimMode mode, int loop);
    ~Animation();
    
   // accessors
   void Reset(int cF, int tF, int aD, AnimMode mode, int loop) { this->init(cF, tF, aD, mode, loop); }
   
   // Updates internal values, depending on mode and loop and returns the new
   // currentFrame number or -1, if the animation has ended
   int UpdateAndGetNewFrame();
   
   int GetCurrentFrame() { return this->currentFrame; }
};


namespace particleTypes
{
  enum ParticleType
  {
    inactive = 0,
    muzzle = 1,
    shotTrail = 2,
    tankTrail = 3,
    smoke = 4,
    explosion = 5,
    fire = 6
  };
  
  static const int maxTLL = 1000000; // ONE..MILLION..FRAMES! :P
};

class Particle;
typedef Particle* ptrParticle;

// simple class for handling very specific particles for TankGame
// (particle behaviour depends on id and is hardcoded into the Update method)
class Particle
{
  private:
    particleTypes::ParticleType id; // type of particle
    Animation anim; // animation for particle (needed for some, not all types)
    flPoint2D pos; // current particle position (needed for all types)
    float angle; // current particle angle (needed for some, not all types)
    float size; // current particle size (needed for some, not all types)
    int ttl; // time to live (number of logic frames, before particle dies
             // (it can also die earlier, if the attached animation ends)
    int initialTTL; // just remembers the ttl at initialization
             
    void init();
    void init(particleTypes::ParticleType id, ptrFlPoint2D startPos, float angle, float size, int ttl);
  
  public:
    // constructor/destructor
    Particle();
    Particle(particleTypes::ParticleType id, ptrFlPoint2D startPos, float angle, float size, int ttl);
    ~Particle();
    
    // accessors
    void Reset(particleTypes::ParticleType id, ptrFlPoint2D startPos, float angle, float size, int ttl);
    
    particleTypes::ParticleType GetId() { return this->id; }
    ptrFlPoint2D GetPosPtr() { return &this->pos; }
    float GetAngle() { return this->angle; }
    float GetSize() { return this->size; }
    
    int GetFrame() { return this->anim.GetCurrentFrame(); }
    int GetTTL() { return this->ttl; }
    
    // updates the particle and returns the frame number of the attached animation
    // or -1, if the particle has died off
    // (all particle behaviours are implemented in this method)
    int UpdateAndGetAnimationFrame();
};

#endif // #if !defined(_Particles_HEAD_INCLUDED)
