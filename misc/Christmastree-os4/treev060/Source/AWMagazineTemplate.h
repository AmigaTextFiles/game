// Copyright Andrew Williams and the University of Bolton
// Do what you like with the program, but please include your 
// sourcecode with any distribution and retain my copyright notices

/* Version 3.1 */

#ifndef __AWMAGAZINETEMPLATEINCLUDED__
#define __AWMAGAZINETEMPLATEINCLUDED__		(1)

#include <vector>

// This is the template-based version of the original AWMagazine class
// I think that in the vast majority of cases, you can simply treat this
// as an AWMagazine, in which case you do EXACTLY what you used to. The
// new arrangement is fully backwardly compatible with the old approach.
//
// What the template class allows is for you to create magazines of things
// which are not AWBullets. However, even if you want to do this, your class
// *must* provide some AWBullet-style features, including a constructor that
// takes a filename plus the number of frames.


template <class T>
class AWMagazineTemplate {

private:
	Uint32 lastShotTicks;
	Uint32 shotInterval;

public:
	std::vector<T*> magazine;

	// We construct a magazine with three parameters. The last 
	//  two are standard for constructing AWBullets (and AWSprites 
	//  of course). The first determines the how many of this type
	//  bullet we want our program to handle
	AWMagazineTemplate(Uint32 hmb, char *bmpName, Uint32 hmf);

	// This returns a reference to a specific item, based
	// on the index, i. It is normally used in the main program
	// when you want to loop through all the items. Don't 
	// forget to check if the item is inUse or not.
	T* get(unsigned i);

	// This searches through the items in the magazine, looking
	// for one which is not currently "inUse". If it finds one, it
	// returns a pointer to it, and you can treat that pointer like
	// a pointer to any AWSprite in your game - for example, you can
	// set its velocity or acceleration etc.
	T* allocate_a_bullet();

	// This determines whether it's time to fire yet
	// This allows us to prevent repeat firing too fast
	bool time_to_auto_fire();
	void set_auto_fire(Uint32 interval);



	/* This tells us how many bullets there are in the magazine.
	 * Note that it's not concerned with whether the bullets are
	 * inUse or not. It's just telling us how many there are in
	 * total.
	 */
	Uint32 size();

	/*
	 * These functions are provided for convenience. If you use these, 
	 * you don't need a loop within your game loop to update all the
	 * bullets individually.
	 */
	void update_everything(Uint32 topLeftX, Uint32 topLeftY);

	void update_everything();

	/*
	 * This function is provided because normally a particular type
	 * of bullet/missile will always have the same transparent colour.
	 */
	void set_transparent_colour(int R, int G, int B);

};

// We construct a magazine with three parameters. The last 
//  two are standard for constructing AWBullets (and AWSprites 
//  of course). The first determines the how many of this type
//  bullet we want our program to handle
template <class T>
AWMagazineTemplate<T>::AWMagazineTemplate(Uint32 hmb, char *bmpName, Uint32 hmf) {
	if(hmb < 1) hmb = 1;
	for(int i=0; i < hmb; i++) {
		magazine.push_back(new T(bmpName, hmf));
	}
	Uint32 ticks = SDL_GetTicks();
	lastShotTicks = ticks;
	shotInterval = 0;

};

// This searches through the bullets in the magazine, looking
// for one which is not currently "inUse". If it finds one, it
// returns a pointer to it, and you can treat that pointer like
// a pointer to any AWSprite in your game - for example, you can
// set its velocity or acceleration etc.
template <class T>
T* AWMagazineTemplate<T>::allocate_a_bullet() {
	int i;
	if(time_to_auto_fire() == false) return NULL;

	for(i = 0; i < size(); i++) {
		if(magazine[i]->inUse == false) {
			magazine[i]->inUse = true;
			return magazine[i];
		}
	}
	return NULL;
}

// This determines whether it's time to fire yet
// This allows us to prevent repeat firing too fast
template <class T>
bool AWMagazineTemplate<T>::time_to_auto_fire() {
	if(shotInterval == 0) return true;
	Uint32 ticks = SDL_GetTicks();
	if((ticks - lastShotTicks) > shotInterval) {
		lastShotTicks = ticks;
		return true;
	}
	return false;
}

template <class T>
void AWMagazineTemplate<T>::set_auto_fire(Uint32 interval) {
	shotInterval = interval;
}

// This returns a reference to a specific bullet, based
// on the index, i. It is normally used in the main program
// when you want to loop through all the bullets. Don't 
// forget to check if the bullet is inUse or not.
template <class T>
T* AWMagazineTemplate<T>::get(unsigned i) {
	if(i >= 0 && i < size())
		return (T *)magazine[i];
	else 
		return NULL;
}


/* This tells us how many bullets there are in the magazine.
 * Note that it's not concerned with whether the bullets are
 * inUse or not. It's just telling us how many there are in
 * total.
 */
template <class T>
Uint32 AWMagazineTemplate<T>::size() {
	return magazine.size();
}

/*
 * These functions are provided for convenience. If you use these, 
 * you don't need a loop within your game loop to update all the
 * bullets individually.
 */
template <class T>
void AWMagazineTemplate<T>::update_everything(Uint32 topLeftX, Uint32 topLeftY) {
	for(int i=0; i < size(); i++) {
		magazine[i]->update_everything(topLeftX, topLeftY);
	}
}


template <class T>
void AWMagazineTemplate<T>::update_everything() {
	update_everything(0, 0);
}

/*
 * This function is provided because normally a particular type
 * of bullet/missile will always have the same transparent colour.
 */
template <class T>
void AWMagazineTemplate<T>::set_transparent_colour(int R, int G, int B) {
	for(int i=0; i < size(); i++) {
		magazine[i]->set_transparent_colour(R, G, B);
	}
}

#endif
