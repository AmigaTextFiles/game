#ifndef __SYMS_H__
#define __SYMS_H__

#define NSYMS 128
#define NEVALS 10
#define NPOSEVALS 16
#define NMOVEVALS 8

extern char null[], with_idea[];       /* with_idea[] = text for 0x7f */
extern char *sym[], *eval[], *poseval[], *moveval[];
extern char cvtbuf[];

#endif                                 /* __SYMS_H__ */
