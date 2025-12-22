#!/bin/bash
# Feed in an old-format octet from the code for
# graphicsPrepareMappng, this will give the new form
# with the (anti?)clockwise mapping. Does one line, then
# exits and displays.
./addto.pl|bc bcrules.bc |./remap.pl
