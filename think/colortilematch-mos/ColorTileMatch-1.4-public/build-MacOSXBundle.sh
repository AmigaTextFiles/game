gcc MacOSX/SDLmain.m src/*.c -framework SDL -framework Cocoa -o bin/ColorTileMatch
mkdir -p bin/ColorTileMatch.app
mkdir -p bin/ColorTileMatch.app/Contents
mkdir -p bin/ColorTileMatch.app/Contents/MacOS
mkdir -p bin/ColorTileMatch.app/Contents/Resources
echo APPL???? > bin/ColorTileMatch.app/Contents/PkgInfo
cp bin/ColorTileMatch bin/ColorTileMatch.app/Contents/MacOS/ColorTileMatch
rm bin/ColorTileMatch
cp MacOSX-Resources/Info.plist bin/ColorTileMatch.app/Contents/Info.plist
cp MacOSX-Resources/main.icns bin/ColorTileMatch.app/Contents/Resources/main.icns
