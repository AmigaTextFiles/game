/*
  --- Projectname: TankGame ---
  (Targetsystem: Crossplatform)
  
  Author: Dennis Busch, http://www.dennisbusch.de
          Dennis-Busch@gmx.net
*/

#include "Particles.hpp"

#ifndef NULL
#define NULL 0
#endif

void Animation::init()
{
  this->currentFrame = -1;
  this->totalFrames = 0;
  this->advanceDelay = 0;
  this->mode = animForward;
  this->loop = 0;
  this->firstUpdate = true;
  this->forward = true;
}

void Animation::init(int cF, int tF, int aD, AnimMode mode, int loop)
{
  this->currentFrame = cF;
  this->totalFrames = tF;
  this->advanceDelay = aD;
  this->mode = mode;
  this->loop = loop;
  this->firstUpdate = true;
  this->forward = true;
}

Animation::Animation()
{
  this->init();
}

Animation::Animation(int cF, int tF, int aD, AnimMode mode, int loop)
{
  this->init(cF, tF, aD, mode, loop);
}

Animation::~Animation()
{
  // nothing to do
}

// Updates internal values, depending on mode and loop and returns the new
// currentFrame number or -1, if the animation has ended
int Animation::UpdateAndGetNewFrame()
{
  if(this->currentFrame == -1) // do nothing, if animation is inactive
    return -1;

  if(this->firstUpdate)
  {
    switch(this->mode)
    {
      case animForward:
        this->currentFrame = 0; // first frame
      break;
      
      case animBackward:
        this->currentFrame = 0 + this->totalFrames; // last frame
      break;
      
      case animPingPong:
        this->currentFrame = 0; // first frame
      break;
    }
  
    this->delayCounter = this->advanceDelay;
    this->firstUpdate = false;
  }
  else // not the firstUpdate
  {
    // first, decrement the delayCounter, to see if an update is necessary
    this->delayCounter--;
    
    if(this->delayCounter <= 0) // need to advance the frame?
    {
      if(this->mode == animForward)
      {
        if(this->currentFrame + 1 < this->totalFrames) // if next frame is valid
          this->currentFrame++; // advance frame
        else // next frame could be first frame again
        {
          if(this->loop > 0 || this->loop == -1) // if there are still loops to go
          {
            this->currentFrame = 0; // go back to first frame
            this->loop = (this->loop == -1) ? -1 : this->loop -1; // control looping
          }
          else // loop == 0 ?
          {
            this->currentFrame = -1; // end animation
          }
        }
      }
      
      if(this->mode == animBackward)
      {
        if(this->currentFrame - 1 >= 0) // if previous frame is valid
          this->currentFrame--; // advance to previous frame
        else // next frame could be last frame again
        {
          if(this->loop > 0 || this->loop == -1) // if there are still loops to go
          {
            this->currentFrame = 0 + this->totalFrames; // go back to last frame
            this->loop = (this->loop == -1) ? -1 : this->loop -1; // control looping
          }
          else // loop == 0 ?
          {
            this->currentFrame = -1; // end animation
          }
        }
      }
      
      if(this->mode == animPingPong)
      {
        if(this->forward)
        {
          if(this->currentFrame + 1 < this->totalFrames) // if next frame is valid
            this->currentFrame++; // advance to next frame
          else
            this->forward = false; // change direction
        }
        
        if(!this->forward) // changed direction?
        {
          if(this->currentFrame - 1 >= 0) // if previous frame is valid
            this->currentFrame--; // advance to previous frame
          else // turned around again?
          {
            if(this->loop > 0 || this->loop == -1) // if there are still loops to go
            {
              this->forward = true; // turn around again
              if(this->currentFrame + 1 < this->totalFrames) // if next frame is valid
                this->currentFrame++; // advance to next frame
              this->loop = (this->loop == -1) ? -1 : this->loop -1; // control looping
            }
            else // loop == 0 ?
            {
              this->currentFrame = -1; // end animation
            }
          }
        }
      }
     
      this->delayCounter = this->advanceDelay; // reset delay counter for next update 
    }
  }
  
  return this->currentFrame; // will be -1 if the animation has ended
}


/// START OF PARTICLE IMPLEMENTATION


void Particle::init()
{
  this->id = particleTypes::inactive;
  this->anim.Reset(-1,0, 0, animForward, 0);
  this->pos.x = 0.0f;
  this->pos.y = 0.0f;
  this->angle = 0.0f;
  this->size = 1.0f;
  this->ttl = 0;
  this->initialTTL = this->ttl;
}


void Particle::init(particleTypes::ParticleType id, ptrFlPoint2D startPos, float angle, float size, int ttl)
{
  this->id = id;
  if(startPos != NULL)
    this->pos = *startPos;
  else
  {
    this->pos.x = 0.0f;
    this->pos.y = 0.0f;
  }
  this->angle = Cartesian::normalizeAngle(angle);
  this->size = fabs(size);
  this->ttl = ttl;
  this->initialTTL = ttl;
  
  // init animation, if necessary
  this->anim.Reset(-1,0, 0, animForward, 0);
  if(this->id == particleTypes::explosion)
  {
    this->anim.Reset(0, 8, 4, animForward, 0);
  }
}

Particle::Particle()
{
  this->init();
}

Particle::Particle(particleTypes::ParticleType id, ptrFlPoint2D startPos, float angle, float size, int ttl)
{
  this->init(id, startPos, angle, size, ttl);
}

Particle::~Particle()
{
  // nothing to do
}

void Particle::Reset(particleTypes::ParticleType id, ptrFlPoint2D startPos, float angle, float size, int ttl)
{
  this->init(id, startPos, angle, size, ttl);
}


int Particle::UpdateAndGetAnimationFrame()
{
  if(this->ttl >= 0 && this->id != particleTypes::inactive) // particle is alive and active?
  {
    bool usesAnimation = false;
    int retVal = -1;
  
// behaviour for explosion
    if(this->id == particleTypes::explosion)
    {
      retVal = this->anim.UpdateAndGetNewFrame(); // explosion just playback and do nothing else
      usesAnimation = true;
    }
    
// behaviour for shotTrail
    if(this->id == particleTypes::shotTrail)
    {
      // shotTrails just get larger
      if(this->ttl > this->initialTTL / 2)
        this->size += 0.3f;
      else // and shrink in the last third of their lifetime
        this->size -= 0.125f;
    }
    
// behaviour for smoke
    if(this->id == particleTypes::smoke)
    {
      // smoke gets larger all the time
      this->size += 0.25f;
      // smoke also moves upwards a bit and randomly a bit to the side
      this->pos.y -= 0.5f;
      if(rand()%10 < 5)
        this->pos.x -= 0.5f * (float)(rand()%3);
      else
        this->pos.x += 0.5f * (float)(rand()%3);
    }
    
// behavior for muzzle
    if(this->id == particleTypes::muzzle)
    {
      this->size -= 0.25f;
      if(this->size < 0.0f)
        this->size = 0.0f;
    }
    
    // TODO add other behaviours here
  
    if(usesAnimation && retVal == -1)
    {
      this->ttl = -1; // die early, if animation has ended
      this->Reset(particleTypes::inactive, NULL, 0.0f, 0.0f, -1);
    }
    else
    {
      this->ttl--; // decrease life counter
      if(this->ttl < 0) // die?
        this->Reset(particleTypes::inactive, NULL, 0.0f, 0.0f, -1);
    }
      
    return retVal;
  }
  else
    return -1;
}

#undef NULL
