/* pragmas for MEDPlayer.library V1.11, for Lattice/SAS C V5.xx */
#ifndef NO_PRAGMAS
#pragma libcall MEDPlayerBase GetPlayer 1e 1
#pragma libcall MEDPlayerBase FreePlayer 24 0
#pragma libcall MEDPlayerBase PlayModule 2a 801
#pragma libcall MEDPlayerBase ContModule 30 801
#pragma libcall MEDPlayerBase StopPlayer 36 0
#pragma libcall MEDPlayerBase DimOffPlayer 3c 1
#pragma libcall MEDPlayerBase SetTempo 42 1
#pragma libcall MEDPlayerBase LoadModule 48 801
#pragma libcall MEDPlayerBase UnLoadModule 4e 801
#pragma libcall MEDPlayerBase GetCurrentModule 54 0
#pragma libcall MEDPlayerBase ResetMIDI 5a 0
#endif
/* prototypes */
LONG GetPlayer(UWORD midi);
void FreePlayer(void);
void PlayModule(struct MMD0 *module);
void ContModule(struct MMD0 *module);
void StopPlayer(void);
void DimOffPlayer(UWORD length);
void SetTempo(UWORD tempo);
struct MMD0 *LoadModule(char *name);
void UnLoadModule(struct MMD0 *module);
struct MMD0 *GetCurrentModule(void);
void ResetMIDI(void);
