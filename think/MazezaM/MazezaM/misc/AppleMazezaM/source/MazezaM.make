echo ««««««««««««««««««« Compiling characters convertor »»»»»»»»»»»»»»»»»»»
;vc is available from http://wuarchive.wustl.edu/pub/aminet/dev/c/vbcc.lha
vc ilbm2asm.c -o ilbm2asm
echo «««««««««««««««««««« Converting characters »»»»»»»»»»»»»»»»»»»»»»»»»»»»
ilbm2asm MazezaMCharset.ilbm >MazezaMCharset.asm
echo ««««««««««««««««««« Assembling main program »»»»»»»»»»»»»»»»»»»»»»»»»»»
;dasm is available from http://wuarchive.wustl.edu/pub/aminet/dev/cross/dasm202.lha
dasm MazezaM.s -oMazezaM.prog -f3 -DPACKED=1
echo «««««««««««««««««««« Packing main program »»»»»»»»»»»»»»»»»»»»»»»»»»»»»
;C64PACK.EXE is available from http://wuarchive.wustl.edu/pub/aminet/dev/cross/cmdline.lha
C64PACK.EXE MazezaM.prog MazezaM.prog.pak /r
echo «««««««««««««««««« Assembling depack program »»»»»»»»»»»»»»»»»»»»»»»»»»
dasm AppleDepack.s -oAppleDepack.prog -f3
echo «««««««««« Linking depack program and packed program »»»»»»»»»»»»»»»»»»
join AppleDepack.prog MazezaM.prog.pak as MazezaM.prog
delete AppleDepack.prog MazezaM.prog.pak MazezaMCharset.asm ilbm2asm
echo ««««««««««««««««««« MazazaM release created »»»»»»»»»»»»»»»»»»»»»»»»»»»
