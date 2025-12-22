#! /bin/sh

if test ! -e ChangeLog ; then
       touch ChangeLog
fi

aclocal -I .
autoheader
automake -a -c --foreign
#if test ! -e config.guess ; then
#       cp /usr/share/automake/config.guess .
#fi
#if test ! -e config.sub ; then
#       cp /usr/share/automake/config.sub .
#fi
autoconf
echo
echo "Now you probably want to run"
echo "  ./configure"
echo "or"
echo "  ./configure --enable-maintainer-mode"
echo "or"
echo "  ./configure --enable-maintainer-mode --enable-datasrc-maintainer-mode"
echo "or something like this. (See README.maintainer)"
