#!/bin/sh

g=""
for f in *.scm
do
  g="$g (load "\""$f"\"")"
done

g="gimp --no-data --no-interface --batch '(begin $g ($1 "\""./"\""))' '(gimp-quit 0)'"

eval $g
