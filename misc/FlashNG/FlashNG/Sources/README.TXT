                     Instructions for compiling FlashNG 1.15
                     ---------------------------------------



 Requirements
 ------------

  In order to compile FlashNG on your computer, you need:

   .One of the following compilers:

      + VBCC
      + SAS/C 6.5x
      + GCC

   .The GTLayout includes which can be found on Aminet



  Getting started
  ---------------

   o First, copy the contents of the includes/ dir into your include: dir
     and the contents of the lib/ dir to your lib: dir
     ie. open a shell and type:
     copy includes/#? include: all
     copy lib/#? lib:

   o If you are using SAS/C, type "smake"

   o If you're using VBCC, use the Makefile.VBCC

   o If you're using GCC, use the Makefile.GCC



   IFF2RAW
   -------

    From version 1.15, I have included a Small tool written in BlitzBasic 2
    that allows to convert IFF files inot RAW chunky format used by FlashNG.

    See IFF2RAW/Readme.txt for more info...
