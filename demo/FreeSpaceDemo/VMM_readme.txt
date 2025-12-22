Configuration of VMM V3.3 for Descent:Freespace
===============================================

* Note that this ONLY works for the 68k Version of Freespace !!! *

(Works with Mediator1200 in mmu and nommu mode - and of course also on
Hardware without a Mediator)


- First, do a fresh install of the VMM 3.3 package

- Doubleclick the VMM icon

Follow these steps and dont press [Save] until you are done - otherwise your system might lock.


Tasks/Programs menu:

- highlight [----- D E F A U L T -----]
- set Code gadget to [Don't use VM]
- set Data gadget to [Advanced options]
- set Min. PUBLIC alloc. to [-1]
- set Min non-Public alloc. to 4096

Memory menu:

- set Paging memory gadget to [Dymanic] (default)
- set Memory type to [FAST] (default)
- set Write buffer between 100 and 200 KByte (default)
- set VM Priority to 40 (default)
- set gadget in upper right corner to File
- edit the field below to set a pagefile dir
  example: games:swap/page_file
- set File size to 40 Mbyte (should be enough)

Miscellaneous menu:

- Deselect the following:
  Cache Zorro II RAM
  Show VM in WB title
  Memory tracking
  FastRom

- set Min. VM allocation to 32000
click Save gadget so prefs will be stored.


Now make a small script that starts up VMM:

example:

delete games:swap/page_file >nil:
stack 200000
games:vmm/vmm quiet >nil:

(I am not not sure if the stack command is needed but better safe than sorry :)

Now run this script before starting Freespace and click save when the VMM GUI pops up.



Freespace configuration:
========================
Setup menu:

Audio submenu:
- Deselect Audio streaming

Memory submenu:
- set Sound cache to 3 MB
- set Graphics cache to 20 MB
- set Textures cache to 8 MB

