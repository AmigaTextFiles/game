// Icon subcode - goes at end of g_cmds.c

int active_icon (edict_t *ent)
{
	int i = ent->client->pers.active;

	if (i == 0)
		return gi.imageindex ("i_fixme");
	else if (i == MORTAL)
		return gi.imageindex ("tp_mortal");
	else if (i == ROBOT)
		return gi.imageindex ("tp_robot");
	else if (i == CRIP)
		return gi.imageindex ("tp_cripple");
	else if (i == MAGE)
		return gi.imageindex ("tp_archmage");
	else if (i == FLAME)
		return gi.imageindex ("ap_flameball");
	else if (i == THROW)
		return gi.imageindex ("ap_kineticthrow");
	else if (i == FREEZE)
		return gi.imageindex ("ap_freeze");
	else if (i == BLOW)
		return gi.imageindex ("ap_deathblow");
	else if (i == TELEPORT)
		return gi.imageindex ("ap_teleport");
	else if (i == BEACON)
		return gi.imageindex ("ap_beacon");
	else if (i == CARD)
		return gi.imageindex ("ap_cards");
	else if (i == WAIL)
		return gi.imageindex ("ap_banshee");
	else if (i == GRAV)
		return gi.imageindex ("ap_gravity");
	else if (i == ANTS)
		return gi.imageindex ("ap_ants");
	else if (i == BLAST)
		return gi.imageindex ("ap_psionic");
	else if (i == OPTIC)
		return gi.imageindex ("ap_optic");
	else if (i == SABER)
		return gi.imageindex ("ap_lightsaber");
	else if (i == GRAPPLE)
		return gi.imageindex ("ap_claw");
	else
		return gi.imageindex ("i_fixme");
}
int passive_icon (edict_t *ent)
{
	int i = ent->client->pers.passive;

	if (i == 0)
		return gi.imageindex ("i_fixme");
	else if (i == MORTAL)
		return gi.imageindex ("tp_mortal");
	else if (i == ROBOT)
		return gi.imageindex ("tp_robot");
	else if (i == CRIP)
		return gi.imageindex ("tp_cripple");
	else if (i == MAGE)
		return gi.imageindex ("tp_archmage");
	else if (i == BOOT)
		return gi.imageindex ("pp_boot");
	else if (i == ELASTIC)
		return gi.imageindex ("pp_elastic");
	else if (i == REPULSE)
		return gi.imageindex ("pp_repulsion");
	else if (i == IRAD)
		return gi.imageindex ("pp_immune");
	else if (i == REGEN)
		return gi.imageindex ("pp_regen");
	else if (i == RADIO)
		return gi.imageindex ("pp_radio");
	else if (i == FORCE)
		return gi.imageindex ("pp_forcefield");
	else if (i == INVIS)
		return gi.imageindex ("pp_invis");
	else if (i == ABSORB)
		return gi.imageindex ("pp_energy");
	else if (i == BULLET)
		return gi.imageindex ("pp_bullet");
	else if (i == PRISMATIC)
		return gi.imageindex ("pp_prism");
	else if (i == LIFE)
		return gi.imageindex ("pp_lifewell");
	else if (i == ARMOR)
		return gi.imageindex ("pp_metalform");
	else if (i == SPEED)
		return gi.imageindex ("pp_superspeed");
	else if (i == FLY)
		return gi.imageindex ("pp_flying");
	else
		return gi.imageindex ("i_fixme");
}

int special_icon (edict_t *ent)
{
	int i = ent->client->pers.special;

	if (i == 0)
		return gi.imageindex ("i_fixme");
	else if (i == MORTAL)
		return gi.imageindex ("tp_mortal");
	else if (i == ROBOT)
		return gi.imageindex ("tp_robot");
	else if (i == CRIP)
		return gi.imageindex ("tp_cripple");
	else if (i == MAGE)
		return gi.imageindex ("tp_archmage");
	else if (i == HASTE)
		return gi.imageindex ("pp_haste");
	else if (i == JUMP)
		return gi.imageindex ("pp_superjump");
	else if (i == ISHOTS)
		return gi.imageindex ("pp_invisshots");
	else if (i == FSHOTS)
		return gi.imageindex ("pp_fastproj");
	else if (i == VAMP)
		return gi.imageindex ("pp_vampiric");
	else if (i == AMMO)
		return gi.imageindex ("pp_ammouse");
	else if (i == AP)
		return gi.imageindex ("pp_piercing");
	else if (i == ELEC)
		return gi.imageindex ("pp_electric");
	else if (i == SNIPER)
		return gi.imageindex ("pp_sniper");
	else if (i == AGG)
		return gi.imageindex ("pp_aggravated");
	else if (i == BERSERK)
		return gi.imageindex ("pp_rage");
	else if (i == AODEATH)
		return gi.imageindex ("pp_angeldeath");
	else if (i == AOLIFE)
		return gi.imageindex ("pp_angellife");
	else if (i == AOMERCY)
		return gi.imageindex ("pp_angelmercy");
	else
		return gi.imageindex ("i_fixme");
}

//////////////////////////////////////////////// \SH

