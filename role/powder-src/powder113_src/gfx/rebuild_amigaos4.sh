#!/bin/bash

echo "Rebuilding Graphics Files"

	echo "Building tiles..."
	echo "Building Adambolt"
	cd adambolt
	../../support/tile2c/tile2c
	cd ..
	echo "Building Akoimeexx..."
	cd akoimeexx/
	../../support/tile2c/tile2c
	cd ..
	echo "Building ASCII..."
	cd ascii/
	../../support/tile2c/tile2c
	cd ..
	echo "Building Classic..."
	cd classic/
	../../support/tile2c/tile2c
	cd ..
	echo "Building Distorted..."
	cd distorted/
	../../support/tile2c/tile2c
	cd ..
	echo "Building IBSOnGrey..."
	cd ibsongrey/
	../../support/tile2c/tile2c
	cd ..

	echo "Building Nethack..."
	cd nethack/
	../../support/tile2c/tile2c
	cd ..

	echo "Building Lomaka..."
	cd lomaka/
	../../support/tile2c/tile2c
	cd ..

	echo "Building akoi12..."
	cd akoi12/
	../../support/tile2c/tile2c
	cd ..

	echo "Building akoi10..."
	cd akoi10/
	../../support/tile2c/tile2c
	cd ..

	echo "Building akoi3x..."
	cd akoi3x/
	gzip -d -c sprite16_3x.bmp.gz > sprite16_3x.bmp
	../../support/bmp2c/bmp2c sprite16_3x.bmp
	../../support/tile2c/tile2c
	cd ..

echo "Building Background images..."
../support/bmp2c/bmp2c tridude_goodbye.bmp
../support/bmp2c/bmp2c tridude_goodbye_hires.bmp
../support/bmp2c/bmp2c icon_sdl.bmp

echo "Dirtying build..."
rm -f all_bitmaps.o
