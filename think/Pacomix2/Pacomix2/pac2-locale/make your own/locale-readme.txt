
How to make your own locale
~~~~~~~~~~~~~~~~~~~~~~~~~~~

In the Pacomix2 game there are currently only two locales - english and cestina.
If you want to make your own locale, read this. It's simply.

Locale fonts:
- Pacomix2 is absolutely non-system program => it doesn't use locale.library.
- you must make your own font derived from smallfont.iff
- convert it to raw format, cut brush 256x56 and save as gfx/smallfont.256x56x1.raw
- menu and outro font is too difficult to modify, so it'd be better leave them as they are
   (ie. you'd have to use english characters or characters in KOI8-CS encoding - see smallfont.iff)

Locale texts:
- used locale is set in tooltype or command line argument called LOCALE
   (if no locale is specified, default internal english is used)
- editor has no locales and it is english only
- before translation of the locale text file read up internal notes at the bottom of it

