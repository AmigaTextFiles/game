
MUIMine: MUIMine.o MFStrings.o MFWindow.o BTWindow.o LEWindow.o LevelData.o MineField.o FaceButton.o Digits.o
    sc link MUIMine.o MFStrings.o MFWindow.o BTWindow.o LEWindow.o LevelData.o MineField.o FaceButton.o Digits.o to MUIMine

MUIMineLocale.h: MUIMine.cd
    catcomp MUIMine.cd CFILE MUIMineLocale.h NOBLOCK NOCODE

BTWindow.o: BTWindow.c BTWindow.h MUIMine.h MFStrings.h LevelData.h
    sc BTWindow.c

FaceButton.o: FaceButton.c FaceButton.h MUIMine.h
    sc FaceButton.c

LevelData.o: LevelData.c LevelData.h MUIMine.h MFStrings.h
    sc LevelData.c

LEWindow.o: LEWindow.c LEWindow.h MUIMine.h MFStrings.h LevelData.h
    sc LEWindow.c

MFStrings.o: MFStrings.c MFStrings.h MUIMineLocale.h MUIMine.h
    sc MFStrings.c

MFWindow.o: MFWindow.c MFWindow.h MUIMine.h MFStrings.h LevelData.h BTWindow.h LEWindow.h MineField.h FaceButton.h Digits.h
    sc MFWindow.c

MineField.o: MineField.c MineField.h MUIMine.h
    sc MineField.c

MUIMine.o: MUIMine.c MUIMine.h MFWindow.h MFStrings.h
    sc MUIMine.c

Gigits.o: Digits.c Digits.h MUIMine.h
    sc Digits.c

