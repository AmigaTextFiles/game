#ifndef _BOARD_H_
#	define _BOARD_H_

#include <SDL/SDL.h>

/** Enumerate different pieces for clarity */
enum PIECE {
	RED,
	GREEN,
	BLUE,
	YELLOW,
	JOKER,
	BLACK,
	BROWN,
	NONE,
	BLACK_FRAME,
	NOT_OK,
	OK
};


/** Struct to hold coordinates */
struct CoordinatePair {
	unsigned int x;
	unsigned int y;

	CoordinatePair(unsigned int _x, unsigned int _y)
		: x(_x), y(_y)
	{}

	CoordinatePair()
		: x(0), y(0)
	{}
};


/** Model 2d board... */
class Board {

	/** Game board */
	int				*m_board;

	/** Clone of game board for undo */
	int				*m_undoPieces;

	/** Coordinates of free pieces still left */
	CoordinatePair	*m_freePieces;

	/** Pieces that appeared last turn */
	CoordinatePair  *m_lastPieces;

	/** Table to hold info about already visited blocks for recursive
	findConnected() function */
	int				*m_connected;

	/** ...score? */
	unsigned int	m_score;

	/** Score from previous turn */
	unsigned int	m_undoScore;

	/** Amount of free pieces still left */	
	unsigned int	m_free;

	/** Current turn number */
	unsigned int	m_turn;

	/** Is undo available ? */
	bool			m_undo;

	/** VideoInfo struct */
	const SDL_VideoInfo*	m_videoInfo;

	/** Game graphics are blitted onto this */
	SDL_Surface*		m_surface;

	/** Board GFX is loaded into this */
	SDL_Surface*		m_boardGFX;

	/** Pieces GFX are loaded into this */
	SDL_Surface*		m_piecesGFX;

	/** and font... */
	SDL_Surface*		m_fontGFX;

	/** Player's current level */
	unsigned int		m_level;

/////////////////////////////
// private member functions :
/////////////////////////////

//	unsigned int		howManySame(unsigned int x, unsigned int y) const;
//
//	unsigned int		howManyJokers(unsigned int x, unsigned int y) const;

	/** Mark lately appeared blocks to help play to see them */
//	void	markLastBlocks(void);

	/** Return a random number between [min, max] */
	unsigned int		getRnd(unsigned int min, unsigned int max) const;

	/** Inlined max function */
	int		max(int x, int y) const
	{
		return (x < y ? y : x);
	}

	/** Recursive function that search connected blocks (see checkBoard() too) */
	unsigned int	findConnected(unsigned int x,unsigned int y);


///////////////////
// public interface
///////////////////

public: 

	Board();
	~Board();

	/** Get the playing level */
	unsigned int	getLevel(void) const { return m_level; };

	/** Set the playing level */
	void			setLevel(unsigned int level) { m_level = level; };

	/** Return the number of the free blocks */
	unsigned int	getFree(void) const { return m_free; };

	/** Find free slots from the board */
	unsigned int	findFree(void);

	/** Return score */
	unsigned int	getScore(void) const { return m_score; };

	/** Return turn number */
	unsigned int	getTurn(void) const { return m_turn; };

	/** Return piece at (x,y) */
	unsigned int	get(unsigned int x, unsigned int y) const;
	
	/** Set piece at (x,y) */
	void	set(unsigned int x, unsigned int y, unsigned int p);

	/** Set undo state */
	void	setUndo(bool undo) { m_undo = undo; }

	/** Get undo state */
	bool	getUndo(void) const { return m_undo; }

	/** Undo board*/
	void	undo(void);

	/** Initialize board*/
	bool	init(void);

	/** Clear board */
	void	clear(void);

	/** Check board for connected pieces*/
	void	checkBoard(void);

	/** Put new pieces onto the board */
	void	nextTurn(void);

	/** Draw the main surface and blocks */
	void	draw(void) const;

	/** Handle player's block moving */
	bool	moveBlock(unsigned int fromX, unsigned int fromY, unsigned int toX, unsigned int toY);

	/** Show highscores */
	void	demo(unsigned int time) const;

	/** Blit text with colour */
	void	writeText(char* text, unsigned int x, unsigned int y, SDL_Color *color) const;

	/** Switch buffers */
	void	update(void) const { SDL_Flip(m_surface); };

	/** Blit a GFX piece from m_piecesGFX */
	void	blitMark(unsigned int x, unsigned int y, unsigned int offset) const;

	/** Blit New Game button */
	void	blitNewGame(SDL_Color* col)  const;
	
	/** Blit Undo button */
	void	blitUndo(SDL_Color* col) const;
};

#endif
