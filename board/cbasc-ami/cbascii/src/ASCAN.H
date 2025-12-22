#ifndef __ASCAN_H__
#define __ASCAN_H__

/*
 * defines used by the lexically scanner when parsing PGN games
 */

extern unsigned linenum;
extern FILE *yyin;
extern char *yytext;
extern int yylex P__((void));

/* PGN header entries */
#define A_PGN_HEADER_S  300
#define A_PGN_EVENT     300
#define A_PGN_SITE      301
#define A_PGN_DATE      302
#define A_PGN_ROUND     303
#define A_PGN_WHITE     304
#define A_PGN_BLACK     305
#define A_PGN_RESULT    306
#define A_PGN_WHITETITLE        307
#define A_PGN_BLACKTITLE        308
#define A_PGN_WHITEELO          309
#define A_PGN_BLACKELO          310
#define A_PGN_WHITEUSCF 311
#define A_PGN_BLACKUSCF 312
#define A_PGN_WHITENA           313
#define A_PGN_BLACKNA           314
#define A_PGN_WHITETYPE 315
#define A_PGN_BLACKTYPE 316
#define A_PGN_EVENTDATE 317
#define A_PGN_EVENTSPONSOR      318
#define A_PGN_SECTION           319
#define A_PGN_STAGE             320
#define A_PGN_BOARD             321
#define A_PGN_OPENING           322
#define A_PGN_VARIATION 323
#define A_PGN_SUBVARIATION      324
#define A_PGN_ECO               325
#define A_PGN_NIC               326
#define A_PGN_TIME              327
#define A_PGN_UTCTIME           328
#define A_PGN_UTCDATE           329
#define A_PGN_TIMECONTROL       330
#define A_PGN_SETUP             331
#define A_PGN_FEN               332
#define A_PGN_TERMINATION       333
#define A_PGN_ANNOTATOR 334
#define A_PGN_MODE              335
#define A_PGN_HEADER_E          335

/* move numbers */

#define A_MOVENUM_S     350
#define A_WHITE_MOVENUM 350
#define A_BLACK_MOVENUM 351
#define A_MOVENUM_E     351

/* moves */

#define A_MOVE_S        355
#define A_PAWN_MOVE     355
#define A_PAWN_MOVE_P   356
#define A_PAWN_CAPTURE  357
#define A_PAWN_CAPTURE_P        358
#define A_PIECE_MOVE    359
#define A_PIECE_MOVE_F  360
#define A_PIECE_MOVE_R  361
#define A_PIECE_MOVE_FR 362
#define A_PIECE_CAPTURE 363
#define A_PIECE_CAPTURE_F       364
#define A_PIECE_CAPTURE_R       365
#define A_PIECE_CAPTURE_FR      366
#define A_SHORT_CASTLE  367
#define A_LONG_CASTLE   368
#define A_MOVE_E        368

/* move evaluation */
#define A_EVAL_S        380
#define A_CHECK 380
#define A_MATE          381
#define A_GOOD_MOVE     382
#define A_BAD_MOVE      383
#define A_INTERESTING_MOVE      384
#define A_DUBIOUS_MOVE  385
#define A_BRILLIANT_MOVE        386
#define A_BLUNDER_MOVE  387
#define A_NAG           388
#define A_EVAL_E        388

/* results */
#define A_RESULT_S      400
#define A_WHITE_WINS    400
#define A_BLACK_WINS    401
#define A_UNFINISHED    402
#define A_DRAW          403
#define A_RESULT_E      404

/* miscellaneous */
#define A_COMMENT       420
#define A_VARSTART      421
#define A_VAREND        422

#endif                                 /* __ASCAN_H__ */
