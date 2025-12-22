/* Prototypes for functions defined in
cyber_order.c
 */

int DoUnitActions(int , int );

void ExecuteStandingOrder(struct Unit * );

void CommandGoto(struct Unit * );

void CommandRandom(struct Unit * );

void CommandHunt(struct Unit * );

struct MapIcon * FindClosestEnemyIcon(struct Unit * , int );

void CommandRecon(struct Unit * );

void CommandWalkCoastline(struct Unit * );

void ComputerGiveOrders(struct Unit * , int , short , short , short , short , int );

void AIAddLib(struct Unit * );

void MoveUnitDir(struct Unit * , enum Direction );

