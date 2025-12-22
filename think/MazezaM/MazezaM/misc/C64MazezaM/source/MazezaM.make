echo ««««««««««««««««««« Compiling characters convertor »»»»»»»»»»»»»»»»»»»
;vc is available from http://wuarchive.wustl.edu/pub/aminet/dev/c/vbcc.lha
vc ilbm2asm.c -o ilbm2asm
echo «««««««««««««««««««« Converting characters »»»»»»»»»»»»»»»»»»»»»»»»»»»»
ilbm2asm MazezaMCharset.ilbm >MazezaMCharset.asm
echo ««««««««««««««««««« Assembling main program »»»»»»»»»»»»»»»»»»»»»»»»»»»
;dasm is available from http://wuarchive.wustl.edu/pub/aminet/dev/cross/dasm202.lha
dasm MazezaM.s -oMazezaM.c64 -DBLAZON=0
join MazezaM.c64 MazezaM.msx as MazezaM.prg
delete MazezaMCharset.asm ilbm2asm
echo ««««««««««««««««««« MazazaM release created »»»»»»»»»»»»»»»»»»»»»»»»»»»
