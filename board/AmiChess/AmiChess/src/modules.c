void InitModules()
{
INIT_3_Libs();
INIT_6_MUI_Chess_Class();
INIT_6_MUI_Board_Class();
INIT_6_MUI_Field_Class();
}

void CleanupModules()
{
EXIT_6_MUI_Chess_Class();
EXIT_6_MUI_Board_Class();
EXIT_6_MUI_Field_Class();
EXIT_3_Libs();
}

