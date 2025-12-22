WarpHeretic Debug version
=========================

Hi!

Some people had crashes with the 1.3 executable. There are some
possible reasons:

1. I used a "be careful when you use it" Beta-Version of StormC
   (and i was NOT careful... the Debugversion is now compiled
   with the normal Version of StormC 4 Beta... not the "be careful"
   version :)
2. On some machines 60 ns setting did cause problems, especially
   if you have RAM-Chips of different manufacturers. If you
   experienced crashes with other programs also you might want
   to try 70 ns Settings. I had this problem once, but after
   i exchanged my Non-EDO for EDO RAM the problem disappeared.
3. One of the ASM-Optimizations might be buggy. But after
   i recompiled i did not get any more crashes, so i let it in... :)

How to use the debug-version:

1. Start the tool segtracker first thing in your startup-sequence
2. When you get a WarpUP Crashrequester indicating for example
   the address 0x08c9999b as the crash address, type:

   memowner 0x08c9999b

   This should output hunk and offset number. Then you should tell
   me these numbers (if it does not output hunk/offset you do not
   have segtracker installed in your startup).

Using this data i can calculate the source-code line which caused
the crash. But i think with this version no crashes (unless your
system has 70 ns problems...) should happen anymore anyways...

Mail me at MagicSN@Birdland.es.bawue.de

Note: As this is a debug-version, the fps-rate goes down a bit. When
we are sure there are no bugs left i will go back to the non-debug
version...

Steffen Haeuser

