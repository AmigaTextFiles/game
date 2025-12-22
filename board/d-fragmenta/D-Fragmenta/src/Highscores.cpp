#ifndef __amigaos4__
#include <fstream> // (i/o)fstreams
#endif

#include <assert.h>

//#include <string>

#include "highscores.h"


/** Pointer to the singleton */
Highscores* Highscores::m_instance = NULL;


/** Default constructor */
Highscores::Highscores()
{
	m_highscores = new Highscore[ Parameters::m_hiscores ]; 
	m_changed = false;

	// load highscores
	if ( ! load() )
	{
		// if problems, try to clear the list - sorry hackers :)
		clearList();
	}
}


/** Destructor */
Highscores::~Highscores()
{
	// Save highscores if there was changes
	if ( m_changed )
	{
		save();
	}

	delete [] m_highscores;
}


/** Reset highscore list */
void Highscores::clearList(void)
{
	delete [] m_highscores;
	m_highscores = new Highscore[ Parameters::m_hiscores ];
}


/** Return the pointer to the singleton object */
Highscores* Highscores::instance()
{
	if ( NULL == m_instance )
	{
		m_instance = new Highscores();
	}

	return m_instance;
}


/** Load highscores */ 
bool Highscores::load()
{
	bool result = true;

#ifdef __amigaos4__
    FILE *pFile = fopen( Parameters::m_hiscoreFile, "rb" );
    if ( pFile )
    {
        unsigned int number;
        if ( 1 == fread( &number, sizeof(unsigned int), 1, pFile ) )
        {
            for (unsigned int i = 0; i < number; i++)
            {
                char tempName[7] = { 0 };

                if ( 1 != fread( tempName, 6*sizeof(char), 1, pFile ) )
                {
                    break;
                }

                m_highscores[i].name = tempName;
                //strncpy( m_highscores[i].name, tempName, 6 );

                unsigned int tempScore;

                if ( 1 != fread( &tempScore, sizeof(unsigned int), 1, pFile ) )
                {
                    break;
                }

                m_highscores[i].score = tempScore;
            }
        }
        fclose( pFile );
    }
#else
	ifstream stream( Parameters::m_hiscoreFile );
	if ( stream.is_open() )
	{
		unsigned int number;

		try {

			// how many highscores
			stream >> number;

			if ( number != Parameters::m_hiscores )
			{
				throw exception();
			}

			for ( unsigned int i = 0; i < number; i++ )
			{
				string temp;

				stream >> temp;
				
				// Limit the name length if some lonely soul tries to hack hiscores file :)
				// (probably he can hack it anyway so what the heck. Too bored to crypt it)
				if (temp.length() > 6)
				{
					temp.erase(6, temp.length()-6);
				}

				m_highscores[i].name = temp;
				
				stream >> m_highscores[i].score;
			}
	
		}
		catch ( ... )
		{
			assert( false );
			result = false;
		}
	}
#endif

	return result;
}


/** Write highscore file */
bool Highscores::save()
{
	bool result = true;

#ifdef __amigaos4__
// Avoid stream bloat...
    FILE *pFile = fopen( Parameters::m_hiscoreFile, "wb" );
    if ( pFile )
    {
        unsigned int number = Parameters::m_hiscores;
        if ( 1 == fwrite( &number, sizeof(unsigned int), 1, pFile ) )
        {
            for (unsigned int i = 0; i < number; i++)
            {
                char tempName[7] = { 0 };
                strncpy( tempName, m_highscores[i].name.c_str(), 6 );

                if ( 1 != fwrite( tempName, 6*sizeof(char), 1, pFile ) )
                {
                    break;
                }

                unsigned int tempScore = m_highscores[i].score;

                if ( 1 != fwrite( &tempScore, sizeof(unsigned int), 1, pFile ) )
                {
                    break;
                }
            }
        }
        fclose( pFile );
    }
#else
	ofstream stream( Parameters::m_hiscoreFile );
	if ( stream.is_open() )
	{	
		try {

			// Number of highscores
			stream << Parameters::m_hiscores << std::endl;

			for ( unsigned int i = 0; i < Parameters::m_hiscores; i++ )
			{
				stream << m_highscores[i].name << std::endl;
				stream << m_highscores[i].score << std::endl;
			}
	
		}
		catch ( ... )
		{
			assert( false );
			result = false;
		}
	}
#endif

	return result;
}


/** Check if we have a nice hiscore
@param score Comparable score
@return Index to new hiscore slot */
unsigned int Highscores::isNewHiscore(unsigned int score)
{
	for (unsigned int i = 0; i < Parameters::m_hiscores; i++)
	{
		if ( score > m_highscores[i].score )
		{
			// New hiscore! Return the index
			m_changed = true;
			return i;
		}
	}

	return Parameters::m_hiscores;
}


/** Put new highscore into the list
@param hs New highscore
@param index Index of the slot
*/
void Highscores::updateList(Highscore& hs, unsigned int index)
{
	unsigned int i;
	for ( i = Parameters::m_hiscores - 1; i > index; i-- )
	{
		// Re-order the list
		m_highscores[i] = m_highscores[i - 1];
	}

	m_highscores[i] = hs;
}
