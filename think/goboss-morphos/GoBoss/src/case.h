#ifndef _CASE_H
#define _CASE_H

typedef struct {int x; int y;} Case;

static int caseNulle (Case c) {return (c.x<0) || (c.x>19) || (c.y<0) || (c.y>18);}
static Case caseAGaucheDe (Case c) { c.x --; return c; }
static Case caseADroiteDe (Case c) { c.x ++; return c; }
static Case caseAuDessusDe (Case c) { c.y --; return c; }
static Case caseAuDessousDe (Case c) { c.y ++; return c; }

#endif
