IFF2RAW Small Tool
------------------

 IFF2RAW.src: BlitzBasicII Source code in ASCII
 IFF2RAW.bb2: BlitzBasicII Source code in bb2 format
 IFF2RAW.exe: Executable


Usage:
------

 Just launch IFF2RAW.exe and enter the name of the source IFF File and the
 Destination RAW File .

 Ex.: if you enter "Sprites" as destination name, IFF2RAW will produce
 two files called "Sprites.RAW" and "Sprites.PAL".

 Notes: This tool will only save 320x200 files... If your input file is bigger,
        only the first 200 lines will be saved.

        IFF2RAW will open a 640x512x8Bit screenmode and display the picture
        here. Then, the conversion starts.

        The palette is also saved (in 8BIT format) for compatibility with
        the PC/DOS version of FlashNG.

        Please also note that the header is ignored by FlashNG.

