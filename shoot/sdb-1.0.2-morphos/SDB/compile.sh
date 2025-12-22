#!/bin/bash

cd src
make clean all
mv sdb ../
echo -e "\n --- Type './sdb' to play Shotgun Debugger. ---\n"
echo -e "To run Shotgun Debugger from any directory,
create a symbolic link in /usr/bin to the sdb executable
in this directory. (You must be root to do this.)\n"
