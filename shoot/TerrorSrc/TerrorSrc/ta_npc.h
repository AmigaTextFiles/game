

void NPC_Respawn(edict_t *self);
void npc_die (edict_t *self, edict_t *inflictor, edict_t *attacker, int damage, vec3_t point);
void NPCAI_RunFrames(edict_t *self, int start, int end);
void npc_pain (edict_t *self, edict_t *other, float kick, int damage);

void SelectSpawnPoint (edict_t *ent, vec3_t origin, vec3_t angles);
