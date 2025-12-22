/* Prototypes for functions defined in
Gadgets.C
 */

void ZapGadget(struct Gadget * , struct RastPort * );

void ZapGList(struct Gadget * , struct Window * , int );

int selected(struct Gadget * );

void select(struct Gadget * );

void unselect(struct Gadget * );

int disabled(struct Gadget * );

void enable(struct Gadget * );

void disable(struct Gadget * );

void EnableGList(struct Gadget * , int );

void DisableGList(struct Gadget * , int );

void setselect(struct Gadget * , int );

void show_depress(struct Gadget * , struct RastPort * );

