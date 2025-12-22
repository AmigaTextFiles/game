#!/bin/bash

cvs commit -m "changes for building release" .

make up_revision

VERSION=`awk '/^#define DIAMOND_GIRL_VERSION /{print $3}' < src/version.h`
REVISION=`awk '/^#define DIAMOND_GIRL_REVISION /{print $3}' < src/version.h`

echo "Building release for Diamond Girl v$VERSION.$REVISION"

echo "" >> Changelog
echo "Release $VERSION.$REVISION on `date --utc`" >> Changelog
if [ -f "new_changes" ]; then cat new_changes >> Changelog ; fi
echo "" > new_changes
touch Changelog
cvs commit -m "Changelog update." Changelog new_changes

cvs tag -c -R release-$VERSION-$REVISION || exit 1


TMPDIR=diamond_girl-$VERSION.$REVISION
cvs export -R -r release-$VERSION-$REVISION -d /tmp/$TMPDIR diamond_girl &&
    tar -cj -f html/diamond_girl-$VERSION.$REVISION.tar.bz -C /tmp $TMPDIR
rm -rf /tmp/$TMPDIR

ls -l html/diamond_girl-$VERSION.$REVISION.tar.bz

echo "Building HTML files."
cat html/index-1.html > html/index.html
echo "bi" > html/files.ftp
echo "prompt" >> html/files.ftp
echo "cd diamond_girl" >> html/files.ftp
echo "mdele *" >> html/files.ftp
echo "put index.html" >> html/files.ftp
echo "<p>Current version is $VERSION.$REVISION." >> html/index.html
echo "You can download sources for it from here: <a href=\"diamond_girl-$VERSION.$REVISION.tar.bz\">diamond_girl-$VERSION.$REVISION.tar.bz</a>.</p>" >> html/index.html
echo "put diamond_girl-$VERSION.$REVISION.tar.bz" >> html/files.ftp
echo "<h4>Screenshots</h4>" >> html/index.html
echo "<ul>" >> html/index.html
for i in html/screenshot-*.png ; do \
    fn=`basename $i`
    echo "<li><a href=\"$fn\">$fn</a></li>" >> html/index.html ; \
    echo "put $fn" >> html/files.ftp ; \
    done
echo "</ul>" >> html/index.html
echo "<h3>Changes</h3>" >> html/index.html
echo "<p>Changes that affect players can be found here: <a href=\"Changelog\">Changelog</a></p>" >> html/index.html
cp Changelog html/
echo "put ../Changelog Changelog" >> html/files.ftp
echo "<p>Last update on `date --utc`.</p>" >> html/index.html
cat html/index-2.html >> html/index.html


echo "Done."
