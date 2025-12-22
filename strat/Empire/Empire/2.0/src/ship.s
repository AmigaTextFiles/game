stack 100000
cd server

draco empflush.d
blink with empflush.w
copy EmpFlush //Game/
delete EmpFlush
draco empshut.d
blink with empshut.w
copy EmpShut //Game/
delete EmpShut
draco servermain.d fileio.d
blink with empserv.w
copy EmpServ //Game/
delete EmpServ
draco empcre.d
blink with empcre.w
copy EmpCre //Game/
delete EmpCre
delete #?.r

cd /library

draco cmd_general1 commands parse messages startup cmd_map scan util update cmd_edit cmd_move cmd_general2 interface cmd_general3 cmd_general4 cmd_naval cmd_fight
blink with library.w
copy Empire.library libs:
;delete Empire.library
fdcompile -lL Empire_lib.fd ;case sensitive!
delete Empire.lib
rename Empire.o Empire.lib
copy Empire.lib drlib:
;delete Empire.lib
delete #?.r

cd /client

draco seremp.d serial.d
blink with seremp.w
copy SerEmp //Game/
delete SerEmp
draco empire.d
blink with empire.w
copy Empire //Game/
delete Empire
delete #?.r

;cd /empmap

;draco empmap.d
;draco parse.d
;blink with empmap.w
;copy EmpMap //Game/
;delete EmpMap
;delete #?.r

cd //Game
delete telegrams.#?
delete empire.country
delete empire.fleet
delete empire.offer
delete empire.loan
delete empire.log
delete empire.sector
delete empire.ship
delete empire.world

cd //2.2w/Game
delete telegrams.#?
delete empire.country
delete empire.fleet
delete empire.offer
delete empire.loan
delete empire.log
delete empire.sector
delete empire.ship
delete empire.world

cd //2.3w/Game
delete telegrams.#?
delete empire.country
delete empire.fleet
delete empire.offer
delete empire.loan
delete empire.log
delete empire.sector
delete empire.ship
delete empire.world

cd //2.0/src
