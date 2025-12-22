This archive copyright Egon Bech Madsen, Denmark:               4/8-98
-------------------------------------------------------------------------

PIGbase4q:
        The 68020 version of PIGbase4 v2.8 (main program only)

Brushes (IFF files used while developing PIGbase4)

ho (PIGbase4 source coded in M2Amiga Modula-2 v4.2):
        SkakData#       Contains the inline graphic used by PIGbase4
        SkakBase        The base variable/constants/types
        SkakGo          The start-entry for compilation
        SkakBrain(X)    The chess-engine
        SkakBrainEval   Evaluation for the chess-engine
        SkakFil         The File in/out for PGN file format
        Skak20Fil       The File in/out for PIG file format
        SkakScreen      The Screen updater
        Skak*           The main program/event-monitors
        SkakSprog       The localization module
        SkakKey         Opening-key generator (ECO/NIC)

m2 (Source for modules/libraries used by PIGbase4):
        ILBMread:       used for easy read of iff-ilbm files
        QuickIntuition: used for easy intuition access
        QISupport:      used for easy windows
        req,optReq      req.library interface
        RequestFile     Advanced filerequester
        W               easy testing (writes to console)
        RandomBetter    Advanced random-generator
        StrSupport      Advanced search-patterns for strings,,,
        PointerSprites  Change the Sprites. PIGbase4 sprites included
        DateSupport     Calculates the weekday out of a date.
        ****** this m2 directory hereby placed in the Public Domaine ******

ILBMtoINLINE3:
        The program used to create inline graphic (SkakData#)

Speaker2:
        The program used to give concurrent speak

NICtoPGN: 
        Can convert games printed to file from NICbase3 into PGN format  

