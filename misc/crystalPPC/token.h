#ifndef TOKEN_H
#define TOKEN_H

extern char* spaces;
extern char* get_token (char** buf);
extern float get_token_float (char** buf);
extern int get_token_int (char** buf);
#ifdef COMP_WCC
extern void skip_token (char** buf, char* tok);
extern void skip_token (char** buf, char* tok, char* msg);
#else
extern void skip_token (char** buf, char* tok, char* msg = NULL);
#endif

#endif /*TOKEN_H*/
