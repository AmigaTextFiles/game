#!/bin/sh
pngtopnm sshot44x44.png | ppmtobmp > aif/icon_44x44.bmp
pngtopnm -alpha sshot44x44.png | pnminvert | ppmtobmp > aif/icon_44x44_mask.bmp
pngtopnm sshot42x29.png | ppmtobmp > aif/icon_42x29.bmp
pngtopnm -alpha sshot42x29.png | pnminvert | ppmtobmp > aif/icon_42x29_mask.bmp
pngtopnm sshot64x64.png | ppmtobmp > aif/icon_64x64.bmp
pngtopnm -alpha sshot64x64.png | ppmtobmp > aif/icon_64x64_mask.bmp
pngtopnm sshot40x40.png | ppmtobmp > aif/icon_40x40.bmp
pngtopnm -alpha sshot40x40.png | ppmtobmp > aif/icon_40x40_mask.bmp
pngtopnm sshot18x18.png | ppmtobmp > aif/icon_18x18.bmp
pngtopnm -alpha sshot18x18.png | ppmtobmp > aif/icon_18x18_mask.bmp
