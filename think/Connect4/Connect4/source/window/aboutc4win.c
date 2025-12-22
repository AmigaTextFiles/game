SubWindow, aboutc4win = WindowObject,
    MUIA_Window_Title, "About Connect 4",
    MUIA_Window_ID   , MAKE_ID('A','B','C','4'),
    MUIA_Window_Width , MUIV_Window_Width_Default,
    MUIA_Window_Height, MUIV_Window_Height_Default,
    MUIA_Window_ScreenTitle, "Connect 4",
    MUIA_Window_CloseGadget, FALSE,

    WindowContents,
        VGroup,
            Child, ScrollgroupObject,
                MUIA_Frame, MUIV_Frame_Virtual,
                MUIA_Background, MUII_TextBack,
                MUIA_Scrollgroup_FreeHoriz, FALSE,
                MUIA_Scrollgroup_Contents, VirtgroupObject,
                    Child, TextObject,
                        MUIA_Background, MUII_TextBack,
                        MUIA_Text_SetMax, TRUE,
                        MUIA_Text_Contents, MUIX_C"\nMUI Connect 4 by Giles Burdett\n"
                                            MUIX_B"layabouts@the-giant-sofa.demon.co.uk\n"
                                            MUIX_N"http://www.the-giant-sofa.demon.co.uk\n\n\n"
                                                  "This application uses MUI - MagicUserInterface\n"
                                                  "(c) Copyright 1992-97 by Stefan Stuntz\n\n"
                                                  " Support and online registration is available at http://www.sasg.com \n\n\n"
                                                  "Lamp.mcc/Lamp.mcp and all according files are Copyright © 1997\n"
                                                  "by Maik Schreiber/IQ Computing.\n\n"
                                                  "Updates are always available at\n"
                                                  "http://home.pages.de/~bZ/projekte/mcc_lamp\n\n\n"
                                            MUIX_B"Thanks to\n\n"
                                            MUIX_N"Pete Ross\n"
                                                  "for beta testing, breaking things, additional graphics and\n"
                                                  "his continued support from the first Aminet release!\n\n",
                    End,
                End,
            End,
            Child, HGroup,
                Child, RectangleObject,
                    MUIA_HorizWeight, 200,
                End,
                Child, ac4w_ok=TextObject,
                    MUIA_Text_Contents, MUIX_C"OK",
                    MUIA_Frame, MUIV_Frame_Button,
                    MUIA_InputMode, MUIV_InputMode_RelVerify,
                    MUIA_Background, MUII_ButtonBack,
                    MUIA_CycleChain, 1,
                End,
                Child, RectangleObject,
                    MUIA_HorizWeight, 200,
                End,
            End,
        End,
End,

