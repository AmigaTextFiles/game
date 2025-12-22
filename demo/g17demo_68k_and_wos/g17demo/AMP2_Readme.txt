
                       .--------.  .--.  .--.  .--------.
                       | .----. |  |   \/   |  | .----. |
                       | |    | |  | .    . |  | |    | |
                       | '----' |  | |\  /| |  | '----' |
                       | .----. |  | | \/ | |  | .------'
                       | |    | |  | |    | |  | |
                       | |    | |  | |    | |  | |
                       '-'    '-'  '-'    '-'  '-'

                         AmiDog's Movie Player 2 - BETA

(I know the logo must be the worlds ugliest ASCII art, so please don't remind me)


IMPORTANT: Always make a fresh install for each beta and make sure you do NOT have
any old plugins laying around. This is a common reason why AMP fail to work!


LICENSE: Some parts of AMP are based on other peoples work, some of which is
released under the GNU General Public License Version 2. All sources of AMP are
distributed along with the binaries. A copy of the the GNU General Public License
can be found in the source-directory of the distribution.


040716 - NOTES:

This release should've been made more than a year ago, but now it's finally here!


040716 - HISTORY:

 * Fixed bug where one process would free resources allocated by another process.
 * Should no longer touch Paula filter register when using AHI.
 * Bumped plugin version, older plugins should now be ignored by AMP.
 * Hopefully fixed 15/16bit little endian graphics modes, added BGRA32 mode support.
 * Uses some new audio code I've had on my HD for too long, hope it works.


040705 - NOTES/HISTORY:

OS4 version only, all improvements made was ported back to the OS3.x version. See
the releasenotes above for more information.


030331 - NOTES:

There were a number of bugs in the new audio code. The AHI buffers became smaller
than requested, but most importantly, there was a severe sync-bug in the paula code
which would make the video halt completely when playback was too slow.


030331 - HISTORY:

 * Bugfixed the AHI/PAULA audio routines.


030326 - NOTES:

This is just a minor maintenance release, just to show that I'm still alive. I've
finally taken care of the awfully inaccurate slider, it should be much better now
although not perfect (it may stop a little before the end). Also, for some streams,
you will have to close the window yourself, AMP no longer quit automagically. This
release uses some new audio routines I've developed. I hope they will work good
in all cases, and if that's the case, there will be new releases of most of the
emulators I'm porting using these audio routines.


030326 - HISTORY:

 * Fixed the slider to be much more accurate.
 * New AHI/PAULA audio routines.
 * Several instances of AMP can now be run at once.


020904 - NOTES:

Well, this is a release that has been delayed for much too long. Most of the
work was done in june/july, but it wasn't until now that I finally got things
to a somewhat usable state again. Most new features are experimental and will
most likely have a bug or two. This release add support for the Sorenson Video 1
codec as well as a couple of XANIM and RealMovie ones, see below. To use these
codecs, place them in the AMP plugin directory. I'm not able to supply you with
these codecs, you need to get them from their respective creators. The XANIM
ones are available from the XANIM homepage and should be easy to get, but to get
the RealMovie ones, you need to install RealPlayer using LinuxPPC.

 The following XANIM codecs are supported:

 * vid_iv50_1.0_linuxELFppc.xa - Intel Indeo v5.x
 * vid_iv41_1.1_linuxELFppc.xa - Intel Indeo v4.1
 * vid_iv32_2.1_linuxELFppc.xa - Intel Indeo v3.x

 The following RealMovie codecs are supported:

 * drv2.so.6.0 - G2
 * drv3.so.6.0 - RV8


020904 - HISTORY:

 * Experimental support for DVD menus, navigate with arrow keys, enter to select.
 * Fixed UV alpha support for OSD display.
 * Seeking in AVIs now work if the AVI has an index.
 * Optimized A52 (AC3) decoder, 16% faster.
 * Minor MPEGV decoder optimizations, 2% faster.
 * Experimental ELF loader with support for XANIM Intel Indeo codecs as well as
   RealMovie RV8 and G2 video codecs.
 * Improved the RealMovie parser to handle new RM files.
 * Added SVQ1 (Sorenson Video 1) decoder.


020523 - NOTES:

It's been a long while since the last beta was released, much longer than I had
hoped for. Anyway, here it is, the new beta. The main changes are subtitle support
and the new audio.device routines (I hope they work better than the old ones). To
use a subtitle, just select a MicroDVD (must have .sub extension) or SubRip (must
have a .srt extension) subtitle and enable OSD. AMP will then open a font requester,
just choose the font you like best (a size of 12-18 pixel is usually good for VCD
sized movies). Colorfonts has not been tested and most likely wont work properly.

Subtitles should work with any input video media and any output display. Support
for more subtitle formats will be added in the future. Currently SubRip is the
prefered format since it is based on absolut times rather than frames like MicroDVD.
MicroDVD subtitles will be converted internally to a SubRip like format which
requires that the framerate used by the subtitle and the movie are identical, this
is not the case for SubRip files which will work well even if the movie is converted
to another format and another framerate.


020523 - HISTORY:

 * Bugfixed the MPEGV decoders (removing green stripes problem).
 * Gray display on 8bit screens was broken, fixed.
 * Added renderers for 8/32bit input (required by Microsoft Video 1 decoder).
 * Added MSVC (Microsoft Video 1) decoder.
 * Fixed a very old bug in the YUV conversion routines which did generate
   pictures with too much luminance (too light) and increased the precision.
 * Optimized 15/16bit YUV to RGB converters, they are now 12% faster.
 * Fixed a bug in the AVI parser which probably broke many AVIs.
 * Added support for subtitles, only MicroDVD and SubRip (recommended) formats.
 * Seeking in QT/MOV has been added.
 * Rewritten the audio.device code twice, first adding 68k interrupt to get rid
   of audio drifting, and then to add 14bit (calibrated) support.
 * The PCM decoder sometimes decoded too little data generating bad audio, fixed.
 * Updated the GUI according to the latest additions.
 * Several other bugs has been fixed, and a new bunch has probably been added.


020118 - NOTES:

Not much to say really, just a small number of fixes and changes. If you have a
gfxboard that uses RGB15PC or RGB16PC modes, please let me know if the gfx looks
as it should, thanks!


020118 - HISTORY:

 * A few changes to the plugin interface, all plugins have been recompiled.
 * Fixed a problem where AMP wasn't able to find its plugins if AMP wasn't
   started from its own directory.
 * Fixed "slow quit when playing MPEG" problem.
 * Added RGB16PC and RGB15PC renderers, but my hardware doesn't support this,
   please let me know if it looks as it should!


020115 - NOTES:

The number of changes in this release makes it a much bigger step than the step
from AMP1 to AMP2 really. As you problably have noticed by now, AMP is no longer
a onefile program but uses plugins instead. The choice to go this way was made
of mainly two reasons. The first one being performance, the changes made to the
MPEGV decoder to support LORES decoding reduced the performance by almost 10%, this
is no longer a problem since the LORES decoder is a separate plugin, so if you
don't want it, just delete it, but then playback will fail if you choose the LORES
option. The second reason was that after adding AVI and QT support, it will be
much easier for me to work with the different codecs separately. If a bug is found
and fixed, an optimization is made or a new codec plugin is written, I can just
release that one file, you place it in the "Plugin" directory and you get instant
access to it. This makes it easier for me to work on both the decoders and the AMP
core at once without the need to finish all things I'm working on before making an
optimized or bugfixed release.

There are a few things to remember with this release. The entire AMP core has been
rewritten, AMP now uses plugins and most parsers have been rewritten. It's only the
old, slow and ugly MPEG file parser that's still somewhat similar to before. This
ofcourse means that some bugs might still be in there somewhere. Also, the (S)VCD,
CD-I and DVD parsers now assumes the media to actually be COMPLIANT to what it
claims to be, this made it possible to make some BIG optimizations to the demuxer
code. As a result, playback of all these types should be faster.

Also, as you can se below, AVI, QT and RM parsers have been added. All these should
work in most cases, especially the QT one which has support for compressed headers,
something AMP1 never handled. I've tested the QT parser with old movies from my
collection as well as newly created movies using QT5.02, all movies worked fine.

The RM parser, while handling new streams, is not very usefull since it only support
RV10 video and AC3 (aka 28.8) audio. This basically means movies encoded using
Real Encoder v5.1 or earlier, movies encoded using Real Producer will NOT work.
You can still find Real Encoder on the Internet (but not on the real player
homepage) in case you are interested.

The AVI parser is the least advanced of the new parsers. I really should've added
index support but decided it was time to get something released. Hopefully not many
AVIs will be created in such a way that the index parser is required. But don't
worry, it'll be added ASAP!

Finally, only MPEG support seeking currently, this will get fixed. And remember,
this is a BETA and it's called BETA for a reason. Please don't use it with the GUI
(although it should work fine) and ALWAYS use the DEBUG option and send me ALL
output if you have a problem, thanks!


AMP2 currently support the following parsers:

 * MPEG audio and video
 * A52 (aka AC3) audio
 * (S)VCD and CD-I (partially, no menus or subtitles)
 * DVD (not in a very usable state currently, subtitles are currently disabled)
 * AVI (only one audio and video stream, and no index support yet)
 * QT (pretty complete including compressed header, only one audio and video stream currently)
 * RM, Real Movie (only Real Video 1.0 codec and AC3 audio)


AMP2 current support the following codecs:

 * MPEGVX, MPEG1 and MPEG2 video
 * MPEGVX-LO, MPEG1 and MPEG2 video, LORES version
 * MPEGAX, MPEG1 and MPEG2 audio
 * CVID, Radius CinePak
 * H263, DivX 3.11 alpha, OpenDIVX, JPEG, RV10 and untested: MJPEG, H263, I263 (QT/AVI/RM)
 * IMA4, IMAADPCM4, (QT)
 * MACE, MAC3 and MAC6, (QT)
 * PCM, Uncompressed 8/16bit audio, (QT/AVI)
 * TWOS, Uncompressed 8/16bit audio, (QT)
 * A52, A52 (aka AC3) audio.


020115 - HISTORY:

 * Made some final MC (Motion Compensation) optimizations to the MPEGV decoder.
 * Designed plugin interface and converted the AMP decoders to plugins.
 * A52 decoder is about 11% faster than before thanks to upgrading the compiler.
 * Converted many AMP1 decoders to plugins (look above).
 * Rewritten the buffer handling code, it's now much more flexible than before.
 * Rewritten the AMP core completely, hope it didn't introduce any bugs.
 * Added AVI, QT and RM parsers.
 * Fixed a possible "crash on exit" issue with the MPEGV LORES decoder.


< TWO OFFICIAL RELEASES, 010826 and 010927 >


010630 - NOTES:

A few bugs have been fixed and I've written a DVD.txt file where I've tested all
DVDs I've got, and as you can see, some work, some don't. I'll try to add a hack
which could make more DVDs work and I hope to have something working soon.


010630 - HISTORY:

 * Small MPEGV decoder optimization, 2% faster.
 * Fixed bug with BestMode and AGA only systems.
 * Fixed ASL bug. ASL of some reason report the wrong width/height if one uses
   the OK button rather than doubleclicking on a screenmode.
 * Replaced the CGFX BestMode with my own implementation, AMP should no longer
   choose a PC mode or too small screen.
 * Fixed the bug giving a gray border around the image using >8bit CGFX.
 * Fixed gray not working on CGFX when using the GUI.
 * Added OK buttons to the DVD requesters making them somewhat more intuitive.


010618 - NOTES:

This is the first release in quite a while and contains a lot of changes. All
renderers have been completely rewritten and optimized and are somewhat faster.
I've also droped all Cybergraphics fallback code, this means that AMP will fail
if you choose a screen with an unsupported pixelformat. Please let me know which
pixelformats you need support for and I'll try to add them.

The main addition to this release has to be the experimental and preliminary DVD
support, basically all you need to do is to put a DVD in your DVD drive, supply
AMP with the device and unit and use any of the reserved names VCD, CDI or DVD.
AMP will autodetect the CD/DVD you have inserted and act properly. You will first
be presented with the worlds ugliest atempt of a GUI where you will have to select
which title on the DVD to play, AMP will select the largest by default which
usually is the main title. Just close the window when you are done. Then you'll
get another window where you can select audio and subtitle. Again just close the
window when you are done and AMP will start playing. I hope to replace the ugly
GUIs with proper DVD menus at some point, but until I figure out how to do that,
these GUIs will atleast give the most basic functionality.

Please note that there are a lot of things which are unknown (to me) about the
format of the IFO files where the supported audio and subtitle information (among
others) are stored. Thus AMP may not work as expected. Please report any strange
behavior to me and I'll see what I can do. Also note that you need not only a
fast PPC to even bother trying to play a DVD, but also a fast device to connect
the DVD-ROM to. The internal IDE port of the A1200 is NOT recommended since it's
so slow that AMP will use most of its time just reading the data from the DVD.
With a fast 604e and a SCSI DVD-ROM, DVD playback might be possible.

With my 603e and DVD-ROM connected to the internal IDE port, I can not play
DVDs at a descent speed, although I can watch SVCDs (480x480 pixels) in either
gray or 8bit color with synced audio. Ofcourse things will improve with future
optimizations.

Please use the DEBUG option and include the output with every bug report!


010618 - HISTORY (This is a short version of my rather large history file):

 * MPEGV decoder optimizations, 13% faster for color and 45% faster for gray.
 * New more general and faster C2P routines for AGA playback.
 * UDF parsing, DVD authentication, CSS key extraction and CSS decryption added.
 * Added autodetection of DVD, CD-i and VCD disks.
 * Rewritten and optimized all renderers, small difference for gray, 4-5% for
   15/16/32bit and 103% for 8bit (CGFX). 8bit playback on AGA is 34% faster for
   fullscreen and 140% faster for half height. All HAM modes are 10%+ faster.
 * DVD subtitle decoding has been added and appears to be working correctly.
 * Removed FLIC decoder and NOSPEEDHACK option. Renamed SLORES to HALF and added
   HIPAL, Hires PAL option.
 * Added experimental (non-working) Picasso PiP support (PIP), need to fix this one.
 * An unlimited number of AMPs can now be run simultaneous (instead of just one).
 * Changed the 15/16/32bit/HAM renderers to use the same fixed point format as with
   AMP1 and the AMP2 previews, should give better quality (I hope).





12345678901234567890123456789012345678901234567890123456789012345678901234567890
