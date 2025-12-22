#define AIM_TOGGLE      0
#define AIM_MOMENTARY   1

enum
{
    GF_Move_Forward,
    GF_Move_Backward,
    GF_Turn_Left,
    GF_Turn_Right,
    GF_Strafe,
    GF_Fire,
    GF_Open,
    GF_Run,
    GF_AutoRun,
    GF_Jump,
    GF_Crouch,
    GF_Look_Up,
    GF_Look_Down,
    GF_Look_Left,
    GF_Look_Right,
    GF_Strafe_Left,
    GF_Strafe_Right,
    GF_Aim_Up,
    GF_Aim_Down,
    GF_Weapon_1,
    GF_Weapon_2,
    GF_Weapon_3,
    GF_Weapon_4,
    GF_Weapon_5,
    GF_Weapon_6,
    GF_Weapon_7,
    GF_Weapon_8,
    GF_Weapon_9,
    GF_Weapon_10,
    GF_Inventory,
    GF_Inventory_Left,
    GF_Inventory_Right,
    GF_Holo_Duke,
    GF_Jetpack,
    GF_NightVision,
    GF_MedKit,
    GF_TurnAround,
    GF_SendMessage,
    GF_Map,
    GF_Shrink_Screen,
    GF_Enlarge_Screen,
    GF_Center_View,
    GF_Holster_Weapon,
    GF_Show_Opponents_Weapon,
    GF_Map_Follow_Mode,
    GF_See_Coop_View,
    GF_Mouse_Aiming,
    GF_Toggle_Crosshair,
    GF_Steroids,
    GF_Quick_Kick,
    GF_Next_Weapon,
    GF_Previous_Weapon,
    GF_none,
};

void MouseSetup(MouseData *theMouseData);
WORD GetMouseAction(void);
void MakeDefaultMouseData(MouseData *md);
void SetMouseGadgets(MouseData *md);
void SetMouseActionGadgets(MouseData *md);

