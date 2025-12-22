#!/bin/sh

VERSION="$2"
DMGNAME="Bantumi GL $VERSION"
APP="BantumiGL.app"
APPNAME="Bantumi GL"
BIN="bantumi-gl"
DMG="$1"
shift 1

rm -rf "$DMGNAME" || exit 1
mkdir -p "$DMGNAME" || exit 1
cd "$DMGNAME" || exit 1
cp -R ../$APP . || exit 1
find $APP -name CVS -type d | xargs rm -rf
find $APP -name .svn -type d | xargs rm -rf
strip $APP/Contents/MacOS/$BIN || exit 1
mkdir -p $APP/Contents/Frameworks || exit 1

cp -R ~/sdlmain/SDL.framework $APP/Contents/Frameworks || exit 1
cp -R ~/sdlmain/SDL_ttf.framework $APP/Contents/Frameworks || exit 1

cp ../../COPYING COPYING.txt
cp ../../COPYING.BITSTREAM COPYING-BITSTREAM.txt
cp ../../README-SDL.txt .

mv $APP "$APPNAME.app" || exit 1
cd .. || exit 1
rm -f $DMG || exit 1
hdiutil create -srcfolder "$DMGNAME" tmp.dmg || exit 1
hdiutil convert -format UDZO -imagekey zlib-level=9 tmp.dmg -o $DMG || exit 1
rm -f tmp.dmg || exit 1
rm -rf "$DMGNAME" || exit 1

