#! /bin/sh

# Gibt alle Leveldateinamen aus, die in summary.in erwähnt werden.

echo `sed -e '/^ *file/{' \
          -e ' s/^ *file *//' \
	  -e ' P' -e '}' \
	  -e 'd' \
        summary.in`
