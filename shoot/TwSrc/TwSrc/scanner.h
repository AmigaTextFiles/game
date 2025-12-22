#define	SCANNER_UNIT                   32
#define	SCANNER_RANGE                  100
#define	SCANNER_UPDATE_FREQ            1
#define	PIC_SCANNER_TAG                "scanner/scanner"
#define	PIC_DOT_TAG                    "scanner/dot"
#define	PIC_ACIDDOT_TAG                "scanner/aciddot"
#define	PIC_INVDOT_TAG                 "scanner/invdot"
#define	PIC_QUADDOT_TAG                "scanner/quaddot"
#define	PIC_DOWN_TAG                   "scanner/down"
#define	PIC_UP_TAG                     "scanner/up"
#define	PIC_SCANNER_ICON_TAG           "scanner/scanicon"
#define PIC_SCANNER                "scanner/scanner"
#define PIC_DOT                    "scanner/dot"
#define PIC_ACIDDOT                "scanner/aciddot"
#define PIC_INVDOT                 "scanner/invdot"
#define PIC_QUADDOT                "scanner/quaddot"
#define PIC_DOWN                   "scanner/down"
#define PIC_UP                     "scanner/up"
#define PIC_SCANNER_ICON           "scanner/scanicon"
#define	SAFE_STRCAT(org,add,maxlen)    if ((strlen(org) + strlen(add)) < maxlen)    strcat(org,add);
#define	LAYOUT_MAX_LENGTH              1400

void		Toggle_Scanner (edict_t *ent);
void		ShowScanner(edict_t *ent,char *layout);
void		ClearScanner(gclient_t *client);
qboolean	Pickup_Scanner (edict_t *ent, edict_t *other);

