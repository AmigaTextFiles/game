
                RiSE OF THE ROBOTS -AGA- HD-INSTALLER PATCH

	Well,  since  a  few  friends asked me to release it, here is a new
version of my hd installer for Rise of the Robots.

Just  put  the  file called "Install" on the HD-Install disk of Rise of the
Robots AGA version.

There were 2 problems for people using the 1st version:

1.  Some people tried to install the game in a subdirectory without reading
the  warning text asking to use shortest path possible..ie.  the game didnt
worked  installed in DH1:games/Rise/ but worked when installed in DH1:Rise/
The  reason  for  that  is  that the path for the game is stored inside the
mainfile  and  theres  little  place for it.  This new version will now ask
only  for  device  name  instead of full path with directory.  This way the
game  will  create  directory called "Rise" in a root directory of selected
device ie.  "DH0:Rise/".

2.   This problem occurs on PLENTY of 1200 out there.  After installing and
trying  to  run  the  file  "Rise" the system returned with error "Bad load
hunk"  or  something  similar.   This problem is caused by badly configured
hard  drive.   I  don't  know why, but many of the hard drives connected to
a1200 have problems when trying to save big files in one try.  I mean, if I
want  to  save 300kb file with 1 call to dos.library _Write() function, the
file  gets corrupted.  I have no idea why some drives have this problem and
some not.  There are 2 ways of solving it:

a)  either  saving all bigger files in little chunks.  (This installer from
now  on  will save in 32kb chunks).  But it will solve the problem only for
this  game  and not for other installers/programs that might save big files
directly with 1 pass.

b)  If  you  are  experienced enough, you might try to fix this problem for
good.   You  have  to  run program used to format/partition your hard drive
from  Commodore's  HD-Install  disk for a600/1200 (ie.  HD Toolbox).  There
you  have  to  use  edit  option  on  each  partition  of your HD and go to
"Advanced"  options  gadget.   Here  should be gadget called something like
"Max  Transfer  Mask"  that  is by default set to something like $7FFFFFFF.
This  value  you  should  change  to  $0001FFFF or even $0000FFFF.  This is
maximum  length  of data the controller will send to hd at one time...Don't
forget to save yout changes after modifications.
I take no responsibility for unexperienced users :-)

That's all...Hope you'll enjoy the game...
						Mok/Prestige

