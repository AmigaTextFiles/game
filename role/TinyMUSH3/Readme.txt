

	This is TinyMUSH v3 server for Amiga.You can run both TinyMUSH and
	TinyMUX databases. Since the database that comes in this package
	is empty, you have to create your own world.
	You can find how by visiting web pages like
	http://www.mudconnect.com or http://www.godlike.com
	To run the server, do these simple steps:

* Notice that due to RAM's diskname contains a space character, 
  decompressing and testing in RAM: can fail. To avoid this,
  put this line into S:STARTUP-SEQUENCE :

                       relabel "Ram Disk:" RamDisk

  This is useful for other apps that don't work correctly when
  the space character is present in pathnames.

	- Enter the directory TinyMUSH3
	- Put the contents of SYS into the appropiate directories
	- Execute 'gg-startup'
	- Run 'bin/netmush' from TinyMUSH3 directory

	You can use telnet to connect at port 6250 , but specific MUD
	clients like Tintin++ and TinyFugue are recommended (both
	available at Aminet)
	To connect as GOD (the 'root' user of the MUD) you must type:
	connect #1 potrzebie ,you can change the password afterwards.
	To shutdown the server, and save the changes, use @shutdown
	Remember that netmush.conf uses the file "data/netmush.db.new"
	to store the database when you do a shutdown. Copy it over
	"data/netmush.db" to load it next time (it's not recommended
	to use the same file for input and output, it could become corrupt)



                             Email me if you have probs:      Fr3dY
                                                         fr3dy@retemail.es

