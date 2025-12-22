SGU
===

This is SGU, the Simple Graphic Utility,
written by Stephane Magnenat
(nct@ysagoon.com)

SGU is a light lib staying on top of SDL
and providing general purprose graphic
functions as well as a GUI.

SGU has been used in SnakeMe

SGU is in LGPL

How to compile
==============

On win32 :

Use the MSDEV project.
SDL version > 1.1 must be installed in any standard path.
Then use the produced SGU.lib for your project.

On Linux :

Use the Makefile in the /src directory: simply type make to compile
if any problem occurs, first check all the path in the Makefile,
then write me an email.
Than you have libSGU.so that you can put in your standard library
directory (like /usr/lib). Don't forget to do a ldconfig in root
to register the new lib.

Note on MacOS :

This code compile on MacOS, but there is no project.
So, if you wanna test, just try :-)
Success compilation has been reported with Codewarrior on system 8.5
with SDL 1.1.4


Have fun,

Stephane Magnenat
