#ifndef __NAG_H__
#define __NAG_H__

struct nag {
    u_char value, var;
};

/* defines for "var" element of "struct nag" */
#define VAR_EVAL        1
#define VAR_POSEVAL     2
#define VAR_MOVEVAL     3

extern struct nag nags[];

#define MAX_NAG 139

#endif                                 /* __NAG_H__ */
