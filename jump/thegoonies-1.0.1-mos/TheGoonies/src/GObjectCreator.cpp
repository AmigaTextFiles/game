#ifdef KITSCHY_DEBUG_MEMORY 
#include "debug_memorymanager.h"
#endif


#ifdef _WIN32
#include "windows.h"
#endif

#include "stdlib.h"
#include "string.h"
#include "assert.h"

#include "GL/gl.h"
#include "GL/glu.h"
#include "SDL.h"
#include "SDL_image.h"
#include "SDL_mixer.h"

#include "List.h"

#include "auxiliar.h"
#include "2DCMC.h"
#include "Symbol.h"
#include "GLTile.h"
#include "keyboardstate.h"

#include "GLTManager.h"
#include "SFXManager.h"

#include "GObject.h"
#include "GO_enemy.h"
#include "GO_key.h"
#include "GO_cagedoor.h"
#include "GO_fallingrock.h"
#include "GO_skull.h"
#include "GO_jumpingskull.h"
#include "GO_trickyskull.h"
#include "GO_drop.h"
#include "GO_dropgenerator.h"
#include "GO_skulldoor.h"
#include "GO_wateropening.h"
#include "GO_entrydoor.h"
#include "GO_exitdoor.h"
#include "GO_character.h"
#include "GO_rope.h"
#include "GO_water.h"
#include "GO_lava.h"
#include "GO_bigrock.h"
#include "GO_bat.h"
#include "GO_skeleton.h"
#include "GO_fratelli.h"
#include "GO_bullet.h"
#include "GO_item.h"
#include "GO_pipe_water.h"
#include "GO_bone.h"
#include "GO_closingwall.h"
#include "GO_flame.h"
#include "GO_ghost.h"
#include "GO_musicalnote.h"


Symbol *key=new Symbol("GO_key");
Symbol *cagedoor=new Symbol("GO_cagedoor");
Symbol *fallingrock=new Symbol("GO_fallingrock");
Symbol *fallingrock_blue=new Symbol("GO_fallingrock_blue");
Symbol *fallingrock_green=new Symbol("GO_fallingrock_green");
Symbol *fallingrock_yellow=new Symbol("GO_fallingrock_yellow");
Symbol *skull=new Symbol("GO_skull");
Symbol *jumpingskull=new Symbol("GO_jumpingskull");
Symbol *trickyskull=new Symbol("GO_trickyskull");
Symbol *drop=new Symbol("GO_drop");
Symbol *dropgenerator=new Symbol("GO_dropgenerator");
Symbol *skulldoor=new Symbol("GO_skulldoor");
Symbol *wateropening=new Symbol("GO_wateropening");
Symbol *wateropening_blue=new Symbol("GO_wateropening_blue");
Symbol *wateropening_green=new Symbol("GO_wateropening_green");
Symbol *wateropening_yellow=new Symbol("GO_wateropening_yellow");
Symbol *water=new Symbol("GO_water");
Symbol *lava=new Symbol("GO_lava");
Symbol *entrydoor=new Symbol("GO_entrydoor");
Symbol *exitdoor=new Symbol("GO_exitdoor");
Symbol *character=new Symbol("GO_character");
Symbol *ropetop=new Symbol("GO_ropetop");
Symbol *rope=new Symbol("GO_rope");
Symbol *ropebottom=new Symbol("GO_ropebottom");
Symbol *bigrock=new Symbol("GO_bigrock");
Symbol *bigrock_blue=new Symbol("GO_bigrock_blue");
Symbol *bigrock_green=new Symbol("GO_bigrock_green");
Symbol *bigrock_yellow=new Symbol("GO_bigrock_yellow");
Symbol *bat=new Symbol("GO_bat");
Symbol *skeleton=new Symbol("GO_skeleton");
Symbol *fratelli_yellow=new Symbol("GO_fratelli_yellow");
Symbol *fratelli_blue=new Symbol("GO_fratelli_blue");
Symbol *fratelli_green=new Symbol("GO_fratelli_green");
Symbol *fratelli_red=new Symbol("GO_fratelli_red");
Symbol *fratelli_white=new Symbol("GO_fratelli_white");
Symbol *fratelli_grey=new Symbol("GO_fratelli_grey");
Symbol *bullet=new Symbol("GO_bullet");
Symbol *item=new Symbol("GO_item");
Symbol *pipewater_left=new Symbol("GO_pipe_water_left");
Symbol *pipewater_right=new Symbol("GO_pipe_water_right");
Symbol *bone=new Symbol("GO_bone");
Symbol *closingwall=new Symbol("GO_closingwall");
Symbol *closingwall_blue=new Symbol("GO_closingwall_blue");
Symbol *closingwall_green=new Symbol("GO_closingwall_green");
Symbol *closingwall_yellow=new Symbol("GO_closingwall_yellow");
Symbol *flame=new Symbol("GO_flame");
Symbol *ghost=new Symbol("GO_ghost");
Symbol *musicalnote=new Symbol("GO_musicalnote");

GObject *GObject_create(Symbol *name,int x,int y,int sfx_volume,List<int> *parameters)
{
	if (name->cmp(key)) return new GO_key(x,y,sfx_volume);
	if (name->cmp(cagedoor)) return new GO_cagedoor(x,y,sfx_volume,*(parameters->operator [](0)),*(parameters->operator [](1)));
	if (name->cmp(fallingrock)) return new GO_fallingrock(x,y,sfx_volume,0);
	if (name->cmp(fallingrock_blue)) return new GO_fallingrock(x,y,sfx_volume,1);
	if (name->cmp(fallingrock_green)) return new GO_fallingrock(x,y,sfx_volume,2);
	if (name->cmp(fallingrock_yellow)) return new GO_fallingrock(x,y,sfx_volume,3);
	if (name->cmp(skull)) return new GO_skull(x,y,sfx_volume,*(parameters->operator [](0)));
	if (name->cmp(jumpingskull)) return new GO_jumpingskull(x,y,sfx_volume,*(parameters->operator [](0)));
	if (name->cmp(trickyskull)) return new GO_trickyskull(x,y,sfx_volume,*(parameters->operator [](0)));
	if (name->cmp(drop)) return new GO_drop(x,y,sfx_volume);
	if (name->cmp(dropgenerator)) return new GO_dropgenerator(x,y,sfx_volume);
	if (name->cmp(skulldoor)) {
		if (parameters!=0 && parameters->Length()==3) {
			return new GO_skulldoor(x,y,sfx_volume,*(parameters->operator [](0)),*(parameters->operator [](1)),*(parameters->operator [](2)));
		} else {
			return new GO_skulldoor(x,y,sfx_volume);
		} // if 
	} // if 
	if (name->cmp(wateropening)) return new GO_wateropening(x,y,sfx_volume,0);
	if (name->cmp(wateropening_blue)) return new GO_wateropening(x,y,sfx_volume,1);
	if (name->cmp(wateropening_green)) return new GO_wateropening(x,y,sfx_volume,2);
	if (name->cmp(wateropening_yellow)) return new GO_wateropening(x,y,sfx_volume,3);
	if (name->cmp(water)) return new GO_water(x,y,sfx_volume);
	if (name->cmp(lava)) return new GO_lava(x,y,sfx_volume);
	if (name->cmp(entrydoor)) return new GO_entrydoor(x,y,sfx_volume);
	if (name->cmp(exitdoor)) return new GO_exitdoor(x,y,sfx_volume);
	if (name->cmp(character)) return new GO_character(x,y,sfx_volume,*(parameters->operator [](0)));
	if (name->cmp(ropetop)) return new GO_rope(x,y,sfx_volume,0);
	if (name->cmp(rope)) return new GO_rope(x,y,sfx_volume,1);
	if (name->cmp(ropebottom)) return new GO_rope(x,y,sfx_volume,2);
	if (name->cmp(bigrock)) return new GO_bigrock(x,y,sfx_volume,0);
	if (name->cmp(bigrock_blue)) return new GO_bigrock(x,y,sfx_volume,1);
	if (name->cmp(bigrock_green)) return new GO_bigrock(x,y,sfx_volume,2);
	if (name->cmp(bigrock_yellow)) return new GO_bigrock(x,y,sfx_volume,3);
	if (name->cmp(bat)) return new GO_bat(x,y,sfx_volume);
	if (name->cmp(skeleton)) return new GO_skeleton(x,y,sfx_volume,*(parameters->operator [](0)));
	if (name->cmp(fratelli_yellow)) return new GO_fratelli(x,y,sfx_volume,0);
	if (name->cmp(fratelli_blue)) return new GO_fratelli(x,y,sfx_volume,1);
	if (name->cmp(fratelli_green)) return new GO_fratelli(x,y,sfx_volume,2);
	if (name->cmp(fratelli_red)) return new GO_fratelli(x,y,sfx_volume,3);
	if (name->cmp(fratelli_white)) return new GO_fratelli(x,y,sfx_volume,4);
	if (name->cmp(fratelli_grey)) return new GO_fratelli(x,y,sfx_volume,5);
	if (name->cmp(bullet)) return new GO_bullet(x,y,sfx_volume,*(parameters->operator [](0)));
	if (name->cmp(item)) return new GO_item(x,y,sfx_volume,*(parameters->operator [](0)));
	if (name->cmp(pipewater_left)) return new GO_pipe_water(x,y,sfx_volume,0);
	if (name->cmp(pipewater_right)) return new GO_pipe_water(x,y,sfx_volume,1);
	if (name->cmp(bone)) return new GO_bone(x,y,sfx_volume,*(parameters->operator [](0)));
	if (name->cmp(closingwall)) return new GO_closingwall(x,y,sfx_volume,0);
	if (name->cmp(closingwall_blue)) return new GO_closingwall(x,y,sfx_volume,1);
	if (name->cmp(closingwall_green)) return new GO_closingwall(x,y,sfx_volume,2);
	if (name->cmp(closingwall_yellow)) return new GO_closingwall(x,y,sfx_volume,3);
	if (name->cmp(flame)) return new GO_flame(x,y,sfx_volume);
	if (name->cmp(ghost)) return new GO_ghost(x,y,sfx_volume);
	if (name->cmp(musicalnote)) return new GO_musicalnote(x,y,sfx_volume,float(*(parameters->operator [](0))),float(*(parameters->operator [](1))));

	assert(false);

	return 0;
} /* GObject_create */ 

