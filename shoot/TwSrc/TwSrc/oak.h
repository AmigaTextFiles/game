void oak_stand(edict_t *self);
void oak_run(edict_t *self);
void oak_pain (edict_t *self, edict_t *other, float kick, int damage);
void oak_painthink(edict_t *self);
void oak_die (edict_t *self, edict_t *inflictor, edict_t *attacker, int damage, vec3_t point);
void OakAI_FaceEnemy(edict_t *self);
void oak_standclose(edict_t *self);
void OakAI_RunFrames(edict_t *self, int start, int end);
void OakAI_Finger(edict_t *self);
void OakAI_Taunt(edict_t *self);
void OakAI_Wave(edict_t *self);
void OakAI_Salute(edict_t *self);
void OakAI_Point(edict_t *self);
void SP_Oak(void);

#define OAK_FIND_RANGE 200
#define OAK_RUN 50