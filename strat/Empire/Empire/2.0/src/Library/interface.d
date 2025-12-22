/*
 * Amiga Empire
 *
 * Copyright (c) 1990 by Chris Gray
 *
 * Feel free to modify and use these sources however you wish, so long
 * as you preserve this copyright notice.
 */

/*
 * Empire - the external entry to the Empire library. Save and restore the
 *	register that the rest of the library uses as a global register
 *	variable, and access the passed parameter.
 */

proc Empire(/* *EmpireState_t es (A0) */)void:
    extern internalEmpire(*EmpireState_t es)void;
    uint
	R_A0 = 0,
	R_FP = 6,
	OP_MOVEL = 0x2000,
	M_ADIR = 1,
	M_DISP = 5;
    register *char saveTheGlobalRegister;
    *EmpireState_t es;

    code(OP_MOVEL | R_FP << 9 | M_DISP << 6 | M_ADIR << 3 | R_A0, es);
    internalEmpire(es);
corp;
