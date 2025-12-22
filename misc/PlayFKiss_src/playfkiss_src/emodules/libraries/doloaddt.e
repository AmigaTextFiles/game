OPT MODULE

MODULE	'utility/tagitem'
MODULE	'intuition/screens'
MODULE	'graphics/text'

EXPORT OBJECT sizestruct
	font:LONG
	x:INT
	y:INT
	type:CHAR
ENDOBJECT

EXPORT OBJECT statwindow
	scr:PTR TO screen
	centerx:INT
	centery:INT
	textfont:PTR TO textfont
	textattr:PTR TO textattr
	textstyle:LONG
	load_string:LONG
	scale_string:LONG
	histogram_string:LONG
	quant_string:LONG
	render_string:LONG
	cancel_string:LONG
	title_string:LONG
	status_string:LONG
ENDOBJECT

EXPORT OBJECT imageinfo
	source_w:LONG
	source_h:LONG
	destination_x:LONG
	destination_y:LONG
	destination_w:LONG
	destination_h:LONG
	depth:LONG
	highest_pen:LONG
	statwindowx:LONG
	statwindowy:LONG
	reserved3:LONG
	reserved4:LONG
	reserved5:LONG
	reserved6:LONG
	reserved7:LONG
	reserved8:LONG
	blackpen:LONG
	whitepen:LONG
	greypen:LONG
ENDOBJECT

EXPORT ENUM DITH_NONE,DITH_ERRORDIFF,DITH_FLOYD,DITH_STUCKI,DITH_BURKES
EXPORT ENUM QUANT_VERBATIM,QUANT_POPULARITY,QUANT_MEDIANCUT,QUANT_MEDIANCUT2,QUANT_MEDIANCUT3,QUANT_MEDIANCUT4,QUANT_MEDIANCUT5,QUANT_MEDIANCUT6,QUANT_MEDIANCUT7,QUANT_END
EXPORT ENUM TEXT_NORMAL,TEXT_SHADOW,TEXT_OUTLINE

EXPORT ENUM DLDT_CENTER=TAG_USER,			->Centers image in w/h
						DLDT_REMAP,								->Use FindColor to remap pens?
						DLDT_ASPECTX,							->x aspect value as in x:y
						DLDT_ASPECTY,							->y aspect value
						DLDT_SCALE,								->Should we scale, or crop? if=false then crop.
						DLDT_USEASPECT,						->Should we use the aspect values, or do 1:1 to 1:1?
						DLDT_CLEAR,								->Clears from x->y, w->h
						DLDT_CLIGAUGE,						->A ptr to a STRING with an imbedded "%s" code.
						DLDT_INFO,								->A ptr to a imageinfo struct to be filled in.
						DLDT_HIGHPEN,							->Highest pen to use, -1 for all available. (default)
						DLDT_FILLCMAP,						->Use DT cmap, and fill-in given cmap! no faint-hearts!!!
						DLDT_GREYSCALE,						->create greyscale icon
						DLDT_QUANTIZE,						->quantize to x number of colors
						DLDT_RENDERHAM,						->if =6 then HAM6, if =8 then HAM8, else normal
						DLDT_HAMTHRESHOLD,				->specifies when to use base-4 colors
						DLDT_FULLHAMBASE,
						DLDT_DISCARDERROR,
						DLDT_STRETCHTOFIT,
						DLDT_NORENDER,
						DLDT_STATWINDOW,
						DLDT_ACTIVATESTATWINDOW,
						DLDT_DITHERTYPE,
						DLDT_QUANTTYPE,
						DLDT_SHOWSIZE
