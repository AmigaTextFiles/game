#!/bin/bash
#

aclocal
automake --foreign
autoconf

./configure $*