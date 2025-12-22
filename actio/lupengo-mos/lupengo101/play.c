///////////////////////////////////////////////////////////////////////////////
// File         : play.c
// Info         : Game related functions
// Written by   : Carlo Borreo borreo@softhome.net
///////////////////////////////////////////////////////////////////////////////

#include "lupengo.h"

#define ISPOS(N)	((N)>=MINPOS && (N)<=MAXPOS)
#define ISFIRST(N)	ISPOS( (N)-FIRST  )
#define ISSECOND(N)	ISPOS( (N)-SECOND )
#define ISPLAYER(N)	(ISFIRST(N) || ISSECOND(N))
#define ISLUPONE(N)	ISPOS( (N)-LUPONE )
#define PLTOPIC(PL)	( FIRST + (PL)*(SECOND-FIRST) )
#define PLTOFADE(PL)	( FADE1 + (PL)*(FADE2 -FADE1) )

#define POSD 0
#define POSL 1
#define POSR 2
#define POSU 3

#define MINPOS 0
#define MAXPOS 3

#define FIRST	CARLONID
#define SECOND	PIGD
#define LUPONE	LUPONED

#define ENEMIES		4
#define MAXEGG		20

static int Players[ GAMETYPES ] = { 1, 2 } ;
static int PlayerIcon[ MAXPLAYERS ] = { FIRST, MONSTER } ;

static int
	bx0[ 4 ] = { BX0,BX1,BX0,BX0 },
	bx1[ 4 ] = { BX0,BX1,BX1,BX1 },
	by0[ 4 ] = { BY0,BY0,BY0,BY1 },
	by1[ 4 ] = { BY1,BY1,BY0,BY1 } ;
static int lastdx[ ENEMIES ], lastdy[ ENEMIES ] ;

static int RemainingLives, CurrentLevel, eggs ;
static long CurrentScore, NextExtra ;
static int trisdone, PlaySpeed, Smartness;
static int countdown, trainer, flash ;
static int enemyx[ ENEMIES ], enemyy[ ENEMIES ], slp[ ENEMIES ] ;
static int eggy[ MAXEGG ], eggx[ MAXEGG ] ;
static int myx[ MAXPLAYERS ], myy[ MAXPLAYERS ], living[ MAXPLAYERS ], agony[ MAXPLAYERS ] ;
static int black[ 4 ] ;
static int crx[ ENEMIES + 2], cry[ ENEMIES + 2 ], oldshp[ ENEMIES + 2 ], newshp[ ENEMIES + 2 ];

int joyx, joyy, fire ;

#define ISTRIS(X,Y)  ( PictureReadScreen( (X), (Y) ) == TRIS )
#define LOOKB(DX,DY) (isborder(x+(DX),y+(DY)) && PictureReadScreen(x-(DX),y-(DY)) != TRIS )
#define SQR(X) ((X)*(X))
#define DIST(PL) (SQR(myx[PL]-x)+SQR(myy[PL]-y))
#define INFIELD(X,Y)	(X>BX0 && X<BX1 && Y>BY0 && Y<BY1)

static int rnd( int low, int high )
	{
	return ( rand() % ( high - low + 1 ) ) + low ;
	}

static void VertReport( int v, int pos, int pic1, int pic5 )
	{
	int y = BY0 ;

	while ( y <= BY1 && v >= 5 )
		{
		v -= 5 ;
		PicturePutScreen( pos, y ++, pic5 ) ;
		}
	while ( y <= BY1 &&  v > 0 )
		{
		v -- ;
		PicturePutScreen( pos, y ++, pic1 ) ;
		}
	while ( y <= BY1 )
		PicturePutScreen( pos, y ++, BLANK ) ;
	}

static void EggReport( int n )
	{
	VertReport( n, 0, LITEGG, BIGEGG ) ;
	}

static void LevelReport( int n )
	{
	VertReport( n, 0, LITFLAG, BIGFLAG ) ;
	}

void UpdateLives( int lives )
	{
	int i;

	for ( i = 0 ; i < 8 ; i++ )
		PicturePutScreen( i + 1, 0, i < lives ? PlayerIcon[ CurrentGameType ] : BLANK ) ;
	}

static void addscore( int n )
	{
	char t[ 16 ] ;
	int i ;

	CurrentScore += n ;
	while ( CurrentScore >= NextExtra )
		{
		RemainingLives ++ ;
		NextExtra = NextExtra + ExtraLifeEvery ;
		UpdateLives( RemainingLives ) ;
		}
	sprintf( t, "%ld", CurrentScore ) ;
	for ( i = BX1 - 8 ; i <= BX1 ; i ++ )
		PicturePutScreen( i, 0, BLANK ) ;
	PictureWriteString( BX1 + 1, 0, t, WSF_RIGHTALIGN ) ;
	}

static void flasheggs( void )
	{
	EggReport( eggs ) ;
	flash = FlashTime ;
	}

static void freeloc( int *px, int *py, int shape, int back )
	{
	do {
		*px=rnd( BX0+1,BX1-1 ) ;
		*py=rnd( BY0+1,BY1-1 ) ;
		}
	while ( PictureReadScreen( *px, *py ) != back ) ;
	PicturePutScreen( *px, *py, shape ) ;
	}

static int isborder( int x, int y )
	{
	return PictureReadScreen( x, y )==BORDER || PictureReadScreen( x, y )==BLACK ;
	}

static void checktris( int x, int y )
	{
	int sc, k ;
	char buf[ 16 ] ;

	if (
		( ISTRIS(x+1,y) && (ISTRIS(x+2,y) || ISTRIS(x-1,y)) ) ||
		( ISTRIS(x-1,y) && ISTRIS(x-2,y) ) ||
		( ISTRIS(x,y+1) && (ISTRIS(x,y+2) || ISTRIS(x,y-1)) ) ||
		( ISTRIS(x,y-1) && ISTRIS(x,y-2) )
		)
		{
		PlaySound( "tris" ) ;
		k=LOOKB(0,1) || LOOKB(0,-1) || LOOKB(-1,0) || LOOKB(1,0) ;
		for ( sc = ( k ? 5000 : 10000 ) ; sc > 0 ; sc -= 100 )
			{
			sprintf( buf, "%d", sc ) ;
			PictureDisplayText( buf, DF_NOWAIT ) ;
			SDL_Delay( 50 ) ;
			addscore( 100 ) ;
			}
		PictureDisplayText( NULL, DF_NOWAIT ) ;
		trisdone = 1 ;
		for ( k = 0 ; k < ENEMIES ; k ++ )
			if ( enemyx[ k ] )
				{
				slp[ k ] = 30 ;
				PicturePutScreen( enemyx[ k ], enemyy[ k ], DOWN ) ;
				}
		}
	}

static void clearcr( int n )
	{
	int x, y ;

	x = crx[ n ];
	y = cry[ n ];
	if ( x != 0 && PictureReadScreen( x, y ) == oldshp[ n ] )
		{
		PicturePutScreen(x, y, newshp[n]);
		crx[ n ] = 0 ;
		}
	}

static void defercr( int x, int y, int shp1, int shp2, int n )
	{
	crx[n]=x;
	cry[n]=y;
	oldshp[n]=shp1;
	newshp[n]=shp2;
	PicturePutScreen(x,y,shp1);
	}

static void killed( int pl )
	{
	PlaySound( "died" ) ;
	agony[ pl ] = 8 ;
	clearcr( pl ) ;
	}

static void startscreen( void )
	{
	int i, j ;
	int ax, ay, bx, by ;
	int x, y ;
	static int dx[ 4 ] = { 2,0,-2,0, };
	static int dy[ 4 ] = { 0,2,0,-2, };

	PictureSetRefresh( 0 );
	PictureClearAll() ;
	for ( i = BX0 ; i <= BX1 ; i ++ )
		for (  j= BY0 ; j <= BY1 ; j ++ )
			PicturePutScreen( i, j, ( INFIELD(i,j) ? WALL : BORDER) ) ;
	LevelReport( CurrentLevel ) ;

	// Start of maze creation
	ax=ay=4;
	PicturePutScreen( 4, 4, 4 ) ;
	do
		{
		for ( i = 0, j = rnd( 0, 3 ) ; i < 4 ; i ++, j = ( ( j + 1 ) & 3 ) )
			{
			bx = ax + dx[ j ] ;
			by = ay + dy[ j ] ;
			if ( INFIELD( bx, by ) && PictureReadScreen( bx, by ) == WALL )
				{
				PicturePutScreen( bx, by, j ) ;
				PicturePutScreen( ax + dx[j]/2, ay + dy[j]/2, BLANK ) ;
				ax = bx ;
				ay = by ;
				break ;
				}
			}
		if ( i == 4 )
			{
			j=PictureReadScreen( ax,ay ) ;
			PicturePutScreen( ax, ay, BLANK ) ;
			ax = ax - dx[ j ] ;
			ay = ay - dy[ j ] ;
			}
		} while ( j < 4 ) ;
	// end of maze creation

	for ( i = 0 ; i < 3 ; i ++ )
		freeloc(&x, &y, TRIS, WALL);
	trisdone=0;
	for ( i = 0 ; i < ENEMIES ; i ++ )
		enemyx[ i ] = 1 ;
	eggs = 2 + CurrentLevel ;
	if ( eggs > MAXEGG )
		eggs = MAXEGG ;
	PlaySpeed = 8 - CurrentLevel ;
	if ( PlaySpeed < 1 )
		PlaySpeed = 1 ;
	for ( i = 0 ; i < eggs ; i ++ )
		freeloc( &(eggx[i]), &(eggy[i]), EGGWALL, WALL ) ;
	Smartness = countdown = 0 ;
	addscore( 0 ) ;
	UpdateLives( RemainingLives ) ;
	for ( i = 0 ; i <= 3 ; i ++ )
		{
		black[i]=0;
		for ( x = bx0[ i ] ; x <= bx1[ i ] ; x ++ )
			for ( y = by0[ i ] ; y <= by1[ i ] ; y ++ )
				PicturePutScreen(x,y,BORDER);
		}
	for ( i = 0 ; i < ENEMIES ; i ++ )
		{
		if ( enemyx[ i ] )
			freeloc(& (enemyx[i]), & (enemyy[i]), LUPONEL, BLANK) ;
		slp[i]=0;
		}
	flasheggs();
	for ( i = 0 ; i < Players[ CurrentGameType ] ; i++ )
		if ( living[ i ] )
			freeloc(& myx[i], & myy[i], PLTOFADE(i), BLANK) ;
	agony[ 0 ] = agony[ 1 ] = 0 ;
	PictureSetRefresh( 1 ) ;
	PictureRefreshScreen() ;
	}

static int isegg( int x, int y )
	{
	int i ;

	for ( i = 0 ; i < eggs ; i ++ )
		if ( eggx[ i ] == x && eggy[ i ] == y )
			return i ;

	return -1 ;
	}

static void pushblock( int x, int y, int dx, int dy, int pl )
	{
	int i,e,t,pk;
	int nkilled, killscore, scored;

	switch( pk = PictureReadScreen( x, y ) )
		{
		case WALL:
		case W400:
		case W1600:
		case W6400:
		case W25600:
			scored=W400-1;
			pk=WALL;
			break;
		case TRIS:
		case T1:
		case T2:
		case T3:
		case T4:
			scored=T1-1;
			pk=TRIS;
			break;
		default:
			scored=0;
			break;
		}
	e=isegg(x,y);
	nkilled=0;
	killscore=400;
	for (;;) {
  		switch (PictureReadScreen( x+dx, y+dy ))
			{
			case LUPONEL:
			case LUPONER:
			case LUPONED:
			case LUPONEU:
			case EGGBREAK1:
			case EGGBREAK2:
			case DOWN:
			case HALFDOWN:
	  			addscore( killscore ) ;
	  			killscore *= 4 ;
	  			nkilled ++ ;
	  			for ( i = 0 ; i < ENEMIES ; i ++ )
	  				if (enemyx[i]==x+dx && enemyy[i]==y+dy)
	  					enemyx[i]=0;
	  			// don't break! do case BLANK, too!
			case BLANK:
		  		PicturePutScreen(x,y,BLANK);
	  			x+=dx;
	  			y+=dy;
	  			PicturePutScreen(x,y,pk);
	  			break;
			default:
	  			if (nkilled && scored)
	  				defercr(x,y,scored+nkilled,pk,pl);
	  			if ( e != -1 )
	  				{
	  				eggx[ e ] = x ;
	  				eggy[ e ] = y ;
	  				}
	  			if ( ISPLAYER(pk) )
					{
					t=( ISFIRST(pk) ? 0 : 1);
					myx[t]=x; myy[t]=y;
					}
	  			if (pk==TRIS && !trisdone)
					checktris(x,y);
	  			return;
			}
  		}
	}

static void crashblock( int x, int y, int pl )
	{
	int t, e ;

	if ( ( e = isegg( x, y ) ) != -1 )
		{
		defercr( x, y, EGGCRASH, BLANK, pl ) ;
		addscore( 500 ) ;
		t = eggx[ e ] ; eggx[ e ] = eggx[ eggs - 1 ] ; eggx[ eggs - 1 ] = t ;
		t = eggy[ e ] ; eggy[ e ] = eggy[ eggs - 1 ] ; eggy[ eggs - 1 ] = t ;
		eggs -- ;
		EggReport( eggs ) ;
		}
	else
		{
		defercr( x, y, MYCRASH, BLANK, pl ) ;
		addscore( 30 ) ;
		}
	}

static void movewall( int xside )
	{
	unsigned int side = xside ;
	int x, y, xj, yj, enpic, i ;

	for ( x = bx0[ side ] ; x <= bx1[ side ] ; x ++ )
		for ( y = by0[ side ] ; y <= by1[ side ] ; y ++ )
			{
			PicturePutScreen( x, y, side >= 2 ? ICEX : ICEY ) ;
			enpic = PictureReadScreen( xj = x - joyx, yj = y - joyy ) ;
			if ( ISLUPONE( enpic ) )
				{
				PicturePutScreen( xj, yj, DOWN ) ;
				for ( i = 0 ; i < ENEMIES ; i ++ )
					if ( enemyx[ i ] == xj && enemyy[ i ] == yj )
						slp[ i ] = 15 ;
				}
			}
	SDL_Delay( 200 ) ;
	for ( x = bx0[ side ] ; x <= bx1[ side ] ; x ++ )
		for ( y = by0[ side ] ; y <= by1[ side ] ; y ++ )
			PicturePutScreen( x, y, BLACK ) ;
	black[ side ] = 15 ;
	}

static int sgn( int x )
	{
	if ( x > 0 )
		return 1 ;
	if ( x < 0 )
		return -1 ;
	return 0 ;
	}

static int posof( int x, int y )
	{
	if ( x < 0 )
		return POSL ;
	if ( x > 0 )
		return POSR ;
	return ( y < 0 ? POSU : POSD ) ;
	}

static void agonize( int pl )
	{
	if (--agony[pl])
		PicturePutScreen(myx[pl], myy[pl], agony[pl] & 1 ? DEAD : DEAD2);
	else
		{
		PicturePutScreen(myx[pl], myy[pl], LUPONED);
		Smartness=0;
		living[pl]=0;
		}
	}

// Return 0=still playing, 1=game over

static int PlayOneStep( void )
	{
	int en, i, t, pl, x, y, dx, dy, pk, endscreen ;

	// Flash eggs if required
	if ( flash )
		{
		flash -- ;
		for ( i = 0 ; i < eggs ; i ++ )
			PicturePutScreen( eggx[ i ], eggy[ i ], ( flash & 1 ) ? EGG : EGGWALL) ;
		}

	// Restore moved walls if required
	for ( i = 0 ; i <= 3 ; i ++ )
		if ( black[ i ] && -- black[i] == 0 )
			for ( x = bx0[ i ] ; x <= bx1[ i ] ; x ++ )
				for ( y = by0[ i ] ; y <= by1[ i ] ; y ++ )
					PicturePutScreen( x, y, BORDER ) ;

	// Level completed and extra time over ?
	if ( countdown && -- countdown == 0 )
		{
		CurrentLevel ++ ;
		PictureDisplayText( strgofornext, 0 ) ;
		startscreen() ;
		return 0 ;
		}

	// Game over ?
	if ( ! living[ 0 ] && ! living[ 1 ] && RemainingLives <= 0 )
		{
		PictureDisplayText( strgameover, 0 ) ;
		// Duplicate call since DemoStop() clears demo status
		if ( DemoGetStatus() == DEMO_READING )
			DemoStop() ;
		else
			{
			DemoStop() ;
			TopTenAddScore( CurrentGameType, CurrentScore, CurrentLevel ) ;
			}
		PlaySound( "gameover" ) ;
		return 1 ;
		}

	// Move players
	for ( pl = 0 ; pl < Players[ CurrentGameType ] ; pl++ )
		{
	    	if ( ! living[ pl ] )
			{
			// In 2 players mode, a player may be "resurrected"
			// when the other player gains an extra life
			if ( RemainingLives > 0 )
				{
				if ( ! trainer )
					{
					RemainingLives -- ;
					UpdateLives( RemainingLives ) ;
					}
				freeloc( & myx[pl], & myy[pl], pl ? FADE2 : FADE1, BLANK ) ;
				living[ pl ] = 1 ;
				}
			continue ;
			}
		// Animate the happy wolf if required
	    	if ( agony[ pl ] )
			{
			agonize( pl ) ;
			continue ;
			}
		readjoy( pl ) ;

		// Uncomment the following command to forbid diags
		// if ( joyx )
		//		joyy = 0 ;

	    	if ( joyx || joyy )
			PicturePutScreen( myx[ pl ], myy[ pl ], PLTOPIC( pl )+posof( joyx, joyy ) ) ;
	    	clearcr( pl ) ;
	    	x = myx[ pl ] + joyx ;
	    	y = myy[ pl ] + joyy ;
	    	switch ( pk = PictureReadScreen( x, y ) )
	    		{
		   	case BORDER:
				if ( ! fire )
					break ;
				// Don't allow diagonal
				if ( joyx && PictureReadScreen( x, myy[ pl ] ) == BORDER )
					joyy = 0 ;
				if ( joyy )
					joyx = 0 ;
				if ( joyx < 0 )
					movewall( 0 ) ;
				if ( joyx > 0 )
					movewall( 1 ) ;
				if ( joyy < 0 )
					movewall( 2 ) ;
				if ( joyy > 0 )
					movewall( 3 ) ;
				break;
		   	case DOWN:
		   	case HALFDOWN:
				addscore( 100 ) ;
				for ( i = 0 ; i < ENEMIES ; i ++ )
					if ( enemyx[ i ] == x && enemyy[ i ] == y )
						enemyx[ i ] = 0 ;
				// don't break; go on with case BLANK
		      	case BLANK:
					t=PictureReadScreen( myx[ pl ], myy[ pl ] ) ;
					PicturePutScreen( myx[ pl ], myy[ pl ], BLANK ) ;
					PicturePutScreen( x, y, t ) ;
					myx[ pl ] = x ;
					myy[ pl ] = y ;
					break ;
		      	case WALL:
		      	case W400:
		      	case W1600:
		      	case W6400:
		      	case W25600:
		      	case EGG:
		      	case EGGWALL:
					if ( ! fire )
						break ;
					t = PictureReadScreen( x + joyx, y + joyy ) ;
					if ( ! ISLUPONE(t) && t!=BLANK && t!=DOWN && t!=HALFDOWN &&t!=EGGBREAK1 && t!=EGGBREAK2)
						{
						crashblock(x, y, pl ) ;
						break ;
						}
					// else don't break; go on with next case
		      	case TRIS:
		      	case CARLONID:
		      	case CARLONIL:
		      	case CARLONIR:
		      	case CARLONIU:
		      	case PIGD:
		      	case PIGL:
		      	case PIGR:
		      	case PIGU:
					if (fire)
						pushblock(x,y,joyx,joyy,pl);
					break;
		      	case LUPONED:
		      	case LUPONEL:
		      	case LUPONER:
		      	case LUPONEU:
					PicturePutScreen(myx[pl],myy[pl],BLANK);
					myx[pl]+=joyx;
					myy[pl]+=joyy;
					PicturePutScreen(myx[pl],myy[pl],DEAD);
					killed(pl);
		      	default:
		      		break;
		      	}
	    	}

	// Move enemies
	endscreen = 1 ;
	for ( en = 0 ; en < ENEMIES ; en ++ )
		{
	    	x = enemyx[ en ] ;
	    	y = enemyy[ en ] ;
	    	clearcr( en + 2 ) ;
	    	if ( x == 0 )
	    		{
			if ( eggs == 0 )
				continue ;
			enemyx[ en ] = x = eggx[ eggs - 1 ] ;
			enemyy[ en ] = y = eggy[ eggs - 1 ] ;
			eggs -- ;
			PicturePutScreen( x, y, EGGBREAK1 ) ;
			slp[ en ] = 112 ;
			flasheggs() ;
			}
	   	endscreen = 0 ;
	    	if ( slp[ en ] )
	    		{
			switch( -- slp[ en ] )
				{
				case   5: PicturePutScreen(x,y,HALFDOWN ); break ;
				case 105: PicturePutScreen(x,y,EGGBREAK2); break ;
				case 100: slp[ en ] = 0 ;	// go on
				case   0: PicturePutScreen(x,y,LUPONED  ); break ;
				}
			continue ;
			}
	    	if ( PictureReadScreen( x, y ) == DEAD || PictureReadScreen( x, y ) == DEAD2 )
	    		continue ;
	    	pk = PictureReadScreen( x + lastdx[ en ], y + lastdy[ en ] ) ;
	    	if ( ( ISPLAYER(pk) || pk==BLANK ) && rnd(0,2) )
	    		dx = lastdx[ en ], dy = lastdy[ en ] ;
		else if ( rnd( 0, Smartness ) < 200 )
			dx = rnd( -1, 1 ), dy = rnd( -1, 1 ) ;
		else
			{
			pl = ( living[ 1 ] && DIST( 1 ) < DIST( 0 ) ) ;
			dx = sgn( myx[ pl ] - x ), dy = sgn( myy[ pl ] - y ) ;
			}
		if ( dx && dy )
			{
	 		if ( rnd( 0, 1 ) )
	    			dx = 0 ;
	    		else
	    			 dy = 0 ;
	    		}
	    	lastdx[ en ] = dx, lastdy[ en ] = dy ;
	    	PicturePutScreen( x, y, LUPONE + posof( dx, dy ) ) ;
	    	switch( PictureReadScreen( x + dx, y + dy ) )
			{
			case CARLONID:
			case CARLONIL:
			case CARLONIR:
			case CARLONIU:
			case PIGD:
			case PIGL:
			case PIGR:
			case PIGU:
				PicturePutScreen( x, y, BLANK) ;
				PicturePutScreen( enemyx[ en ] = x + dx, enemyy[ en ] = y + dy, DEAD ) ;
				pl= ( myx[ 0 ] == x + dx && myy[ 0 ] == y + dy ? 0 : 1 ) ;
				killed( pl ) ;
				break ;
			case BLANK:
				t=PictureReadScreen( x, y );
				PicturePutScreen( x, y, BLANK ) ;
				PicturePutScreen( enemyx[ en ] = x + dx, enemyy[ en ] = y + dy, t ) ;
				break ;
			case EGGWALL:
			case WALL:
			case W400:
			case W1600:
			case W6400:
			case W25600:
				if ( isegg( x + dx, y + dy ) == -1 && rnd( 0, 1 ) )
					defercr( x + dx, y + dy, ENCRASH, BLANK, en + 2 ) ;
				break ;
			}
		}
	if ( endscreen && countdown == 0 )
		countdown = 10 ;
	Smartness ++ ;

	return 0 ;
	}

void PlayNewGame( int gametype )
	{
	int i ;

	CurrentGameType = gametype ;
	for ( i = 0 ; i < ENEMIES ; i ++ )
		lastdx[ i ] = lastdy[ i ]= 0 ;
	for ( i = 0 ; i < Players[ CurrentGameType ] ; i++ )
		living[ i ] = 1 ;
	CurrentScore = 0 ;
	CurrentLevel = 1 ;
	RemainingLives = StartLives[ CurrentGameType ] - 1 ;
	NextExtra = ExtraLifeEvery ;
	startscreen() ;
	}

int PlayMainLoop( void )
	{
	int ret ;

	ret = PlayOneStep() ;
	if ( PlaySpeed )
		SDL_Delay( PlaySpeed * 40 ) ;

	return ret ;
	}
