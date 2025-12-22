#ifndef _HIGHSCORES_H_
#	define _HIGHSCORES_H_


#include <string>
using namespace std;

#include "parameters.h"

/** struct to hold name and score */
struct Highscore {
	string		    name;
	//char name[7];
    unsigned int	score;

	// default constructor
	Highscore() {
		score = 0;
		name = "Nobody";
        //strncpy(name, "Nobody\0", 7);
	}

};


/** Singleton implementation for highscore. Takes care of storing,
saving and loading highscores */
class Highscores {

	// Private constructor, initialization only through instance()!
	Highscores();

	Highscore * m_highscores;

	static Highscores* m_instance;

	bool m_changed;

public:
	~Highscores();

	static Highscores* instance();
	
	bool load();
	bool save();

	void clearList(void);

	void updateList(Highscore& hs, unsigned int index);

	unsigned int	isNewHiscore(unsigned int score);

	/** Return name */
	char * getName(unsigned int i)
	{
		return const_cast<char *>( m_highscores[i].name.c_str() );
	}

	/** Return highscore */
	unsigned int getScore(unsigned int i)
	{
		return m_highscores[i].score;
	}
};


#endif
