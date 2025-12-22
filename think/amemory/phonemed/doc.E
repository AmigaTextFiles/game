                        phonemed  by  Tis Veugen

 Program 'phonemed' is a phoneme editor.  The program is a tool to
translate normal text into phonetic text, which can then be prenounced by
the Amiga.  A phoneme, being a basic speech element, is represented by a
short string.  In [1] all possible phonemes are summed up.  Each word can
be parsed into a sequence of phonemes.  The phonetic text of a word is a
string of concatenated phonemes, which can be sent to the so called
"narrator.device".
 Sometimes it is difficult to construct a phonetic text, such that the
Amiga's prenounciation resembles natural speech.  The translation of a word
into phonetic text can be done with the aid of function "Translate()" of
the so called "translator.library" .  Unfortunately, this function is only
able to translate English words.  As a consequence, the "narrator.device"
produces only English sounds.  Translating words of other languages
( Dutch, German, etc. ) must be done by hand.  Some practice is required,
because these words must be prenounced with the limited English sounds.
Program 'phonemed' is a valuable tool thanks to its user-interface.

 Program 'phonemed' is controlled by the mouse.  The upper part of the
screen contains an overview of the available phonemes, each with an
example.  When clicking on a phoneme, it is prenounced as long as the left
mouse button is pressed.  However, don't select "RX" and "LX" because it
produces a Guru.

 The upper string gadget contains the normal text.  The lower string gadget
contains the phonetic text.  Using the gadgets LOAD and SAVE, the
corresponding texts will be loaded or saved.  A straightforward file
requester appears.  The gadget TRANSLATE is used to call the translate
function for translating the input text.  This gadget is always handy for a
first trial translation.  The phonetic text is prenounced when clicking
gadget SAY.  The text is prenounced repeatedly when clicking gadget LOOP,
until the gadget is clicked a second time.

 The remaining gadgets at the bottom of the screen are meant to configure
the compuer "voice" :
 rate   = speaking rate in words/minute;
 pitch  = pitch in Hertz;
 volume = output volume;
 freq   = audio frequency in bytes/second.
By clicking the text "rate", etc.  the default value is restored.  The two
icons at the bottom right can be used to toggle between a human and a
(monotonous) robotic voice, and to toggle between a male and a female
voice.

[1] "AMIGA ROM Kernel Reference Manual:  Libraries and Devices", Commodore
    Business Machines Inc, Addison Wesley, 1986, ISBN 0-201-11078-4
[2] M&T Amiga MAGAZIN, 10/1992, p. 75
[3] "Amiga Maschinensprache", Data Becker, 1987, ISBN 3-89011-076-2
