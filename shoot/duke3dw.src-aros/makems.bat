@echo off
del obj_win\*.o
del eobj_win\*.o
del eobj_win\*.a
make -f Makefile
pause
strip duke3dw.exe
