
/* Written by Peter Ekberg, peda@lysator.liu.se */

#ifndef OPTIONS_H
#define OPTIONS_H

#define OPTC "vhdec:j"
#define OPTS \
      { "version",        no_argument,       0, 'v' }, \
      { "help",           no_argument,       0, 'h' }, \
      { "nodemo",         no_argument,       0, 'd' }, \
      { "nosoundeffects", no_argument,       0, 'e' }, \
      { "gamma",          required_argument, 0, 'c' }, \
      { "step",           no_argument,       0, 'j' }

#define SVGA_OPTC "s:"
#define SVGA_OPTS \
      { "svgamode",       required_argument, 0, 's' }

#define X_OPTC "mX:g:2"
#define X_OPTS \
      { "noshm",          no_argument,       0, 'm' }, \
      { "display",        required_argument, 0, 'X' }, \
      { "geometry",       required_argument, 0, 'g' }, \
      { "double",         no_argument,       0, '2' } 

#endif /* OPTIONS_H */
