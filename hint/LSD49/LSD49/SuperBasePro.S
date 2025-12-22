

		SUPERBASE PROFESSIONAL DATABASE MANAGEMENT SYSTEMS
				SUPPLEMENT 3

				CONTENTS

1. VOLUME 1: NEW FEATURES					1-1
Keyboard Equivalents						1-1
Validation Help Dialogs						1-1
Lookup								1-3
Process Import							1-5
Process Export							1-9
Mail Merge							1-11
Using Process Comms						1-12

2. DML KEYWORDS							1-15
BLANK								1-15
ENTER								1-17
EXPORT								1-20
IMPORT								1-23
LOAD SET							1-25
OPEN FIELDS							1-26
REQUEST								1-27
SELECT FORM ROW							1-30
SET EDIT							1-31
SET HEADING							1-31
SET NOW								1-32
SET TODAY							1-32
UPDATE FORM ROW							1-33
Commd unfrt Program Control					1-34
Report Functions						1-36
COUNT								1-37
MAX								1-38
MEAN								1-38
MIN								1-39
SD								1-40
SUM								1-40
VAR								1-41

				i

3. FORMS EDITOR							1-42
Status								1-42
Listing the Directory						1-43
Changing the Directory						1-43
Field Options							1-44
Attributes							1-44
Selecting Multiple Objects					1-45
Printing Forms							1-46
Generating Reports						1-46
Transaction Handling						1-47

4. OTHER FEATURES						1-54

5. KEY CONTROLS							1-56

				ii

1. VOLUME 1: NEW FEATURES

KEYBOARD EQUIVALENTS
Superbase now provides the following keyboards equivalents for the buttons
on the control panel:

BUTTON		KEY
Pause		Space bar
Stop		Ctrl C
First		Shift left arrow (Amiga)/ Home (Atari)
Rewind		Shift up arrow (Amiga)
Previous	Left arrow
Current record	Up arrow/down arrow
Next		Right arrow
Fast Forward	Shift down arrow (Amiga)
Last		Shift right arrow (Amiga)/ Insert (Atari)
Key lookup	?
Filter		=
External file	*

NOTE: THE KEYBOARD EQUIVALENTS TO THE CONTROL PANEL BUTTONS DO NOT OPERATE
WHEN A SUPERBASE INPUT CURSOR IS ACTIVE (WHEN IT IS SHOWN ON SCREEN).

VALIDATION HELP DIALOGS
On page 2-19, Volume 1, you will find an explanation of how to create your
own Validation Help Messages. These allow you to define a single line
message which explains exactly why the data is invalid. However, there are
some circumstances in which a single line message is not very helpful. An
example would be the following validation formula which checks the data you
enter against the data in another file:

LOOKUP (Stockcode.Invline, Stockcode.Stock) ELSE "Stock code not found in
Stock file"

When you enter the code for a stock item into the Invline file, the formula
uses the LOOKUP function to check whether the code exists in the Stock
file. The trouble is that if users make a mistake, it is probably because
they are not sure what the code is for a particular stock item. Ideally,
they should be shown a list of all the stock items in the file together
with their codes.

				S-1

This is just what validation help dialogs do. They display a list of all
the acceptable data inputs, and allow the user to select an item by
clicking on it (without having to type it in). To display a help dialog,
you need to use the REQUEST command in your validation formula: For the
example above, the formula would be:

LOOKUP (Stockcode.invline, Stockcode.Stock) ELSE 
REQUEST "Stock code not found", "Select another stock code", 20, a%,
Stockcode.Invline, 40, Stockcode.Stock,  Description.Stock

When the user enters the wrong stock code, the following dialog will
appear:

Stock code not found
Select another stock code
AEG3	AEGIS Draw Plus
AMI1	XT Bridgeboard with 5.25 Diskdr
AMI2	CLI-MATE
AMI3	SUPRADRIVE 20mB Hard Disk
AMI4	SUPRADRIVE 60mB Hard Disk
AMI5	Megaboard 2
AMI6	Amiga SUPERBASE PERSONAL
--------------------------------------------------
AEG4
			OK	CLEAR	CANCEL

Provided the first field is an indexed field, type the first letter of the
stock code would bring up a set of stock codes beginning with that letter.

Alternatively, you can use the scroll bars or the cursor keys to scroll
down the list. Double clicking on any item in the list automatically places
the item into the field specified (in this example, the Stockcode.Invline
field).

Note that for validation formulas you can only use dialog type 20. A full
description of this type of dialog is given on page 27 of this supplement
under the entry for the REQUEST command. Here we will just explain how the
example formula works.

The first two parameters for the REQUEST command specify the validation
message. As with other types of dialog, you can leave these blank by
entering two empty strings: i.e., the command would start with:

REQUEST "", "", ...

The next parameter 20 defines the dialog type. The numeric variable a% is
assigned a value of 1 if the user clicks on OK, and 0 for CANCEL.

				S-2

Stockcode.Invline is the name of the field to which the formula is
attached. The item you select will be entered into this field.

40 specifies the width of the dialog in terms of the number of characters.

The remaining two parameters - Stockcode.Stock and Description.Stock -
specify the fields which are to be displayed in the dialog. The first field
is the one that will be selected for your data entry and is therefore
compulsory. As an option, you may also specify one or two extra fields to
provide the user with additional information about the data.

LOOKUP
In Chapter 2, Volume 1, there is a section which describes the two ways of
using the LOOKUP function in a file definition. The description of the
second way - using LOOKUP for cross-file calculation - is misleading and
needs to be modified. In this section, we first explain the problem and
then give a solution to it.

Cross-file calculation uses a calculation formula in combination with
LOOKUP to extract data from another file. The manual gives an example
involving two fields, Stockcode and Unit_Cost, in an Orders file. The
Stockcode field has the following validation formula attached to it:

LOOKUP (Stockcode.Orders, Stockcode.Stock)

When new data is entered in the Stockcode field, the formula checks that is
exists in the Stock file. In doing this it also makes the record (which
contains the same code) in the Stock file current. The manual suggests that
you can then use the following calculation formula to read the appropriate
unit cost from the Stock file into the Unit_Cost field in the Orders file:

Unit_Cost.Stock

This formula would be attached to the Unit_Cost field in the Orders file.

This approach works perfectly when you enter new data, but it may create
problems when you edit the existing data. Suppose the cursor is active in
the Stockcode field; if you now press the Escape key and enter a new stock
code, the LOOKUP formula will be executed and the correct record in the
Stock file (the secondary file) will be selected. And the value that is
read into the Unit_Cost.orders field without altering the contents of the
Stockcode.Orders

				S-3

field, LOOKUP is not executed and the correct record in the secondary file
is not selected. The calculation formula attached to Unit_Cost.Orders
continues to work and extracts data from the Stock file. But because the
current record in the Stock file has not changed since the previous
operation, the data it contains will probably be incorrect for the current
Orders record.

The solution to this problem is to include another LOOKUP as part of the
calculation formula using a ternary operator. For example, the formula
attached to Unit_Costl.Orders could be:

LOOKUP (Stockcode.Orders, Stockcode.Stock)?
Unit-Cost.Stockcode: 0

The effect of this formula is to force a LOOKUP on the Stock file whenever
new data is entered in the Unit_Cost.Orders field. First it checks to see
whether the stock code in the current record in the Orders file exists in
the Stock file. If it does exist, it makes the matching record in the Stock
file current. The condition expressed by the ternary operator has been
satisfied, so the first value after the question mark - i.e. the contents
of Unit_Cost.Stock - is assigned to Unit_Cost.Orders.

If the condition is not satisfied, the second value - in this case, a value
of zero - is assigned. It is up to you to decide what action is to be taken
if the LOOKUP is unsuccessful. With string fields, you may want to assign a
text string indicating that an error has occurred, as in:

LOOKUP (Stockcode.Orders, Stockcode.Stock)?
Description.Stock: "Error"

This formula would be attached to the Description field in the Orders file.
If the stock code does not exist in the Stock file, it assigns the string
"Error" to the field.

Alternatively, you could define a formula which left the contents of the
Description field unaltered when an error occurs:

LOOKUP (Stockcode.Orders, Stockcode.Stock)?
Description.Stock: Description.Orders

				S-4

PROCESS IMPORT
This option has several different applications:
As a file conversion utility it takes a file created in another program and
turns it into a Superbase file. In one step it converts files from Lotus, 
Logistix, or Dbase into Superbase's own format. From other spreadsheet
programs it will also convert files which have been stored in the DIF
format.

It allows you to read ASCII data into a Superbase file. Almost all software
packages are capable of producing ASCII files, so you will use this
facility to import files which cannot be directly converted by the first
method.

Alternatively, you can produce an ASCII file by exporting the records in a
Superbase file; so Import can also be used to transfer or add records from
one Superbase file to another.

The next four sections describe these features in more detail. Then there
are three further sections which explain how to use the Import option,
giving the exact procedure for each type of application.

FILE TYPES
Superbase recognizes the following file types:
ASCII delimited files
ASCII fixed length files
DBASE '.dbf' files
LOTUS files with extensions '.wks' or 'wk1'
LOGISTIX '.lgx' files
DIF files

In ASCII delimited format, the data is stored as ASCII characters but the
file also uses special characters (separators) to mark the end of each data
item such as a field or a record. When you export records from a Superbase
file, they are stored in this format - in an ASCII delimited file.

In ASCII fixed length files each field and record occupies a fixed amount
of space on disk and the data is stored as a continuous string of ASCII
characters.

'.dbf' files are the Dbase equivalent of Superbase's '.sbf' files; i.e.,
this is the format used in Dbase II and III for standard database files.

The Lotus and Logistix formats are used for spreadsheet data files.

				S-5

DIF is a standard format used by many software packages for exporting
files. In this respect it is similar to ASCII format but has the advantage
of allowing the file to be converted to the Superbase format in one step.

FILE CONVERSION
Files in the ASCII formats must be read into a pre-defined Superbase file
(see the next section). With the other formats, Import performs the
conversion automatically and creates new '.sbf',  'sbd' and index files in
the current Superbase directory. The new files (which together make up a
single database file) will take the same name as the file that has been
converted.

When you import spreadsheet data into a database, each row is taken as a
record, and the individual cells in a row represent fields. Any empty
columns in the spreadsheet are ignored.

Clearly, it is not practical to convert a spreadsheet file into a database
file unless the data is structured as a series of repeated rows. However,
Superbase gives you the option of converting just one block in the
spreadsheet grid by specifying a range of cells. You can also use a row of
labels to define the field names in the Superbase file. If the spreadsheet
labels are specified, the fields take the grid's column letter with an
underscore character added to it; i.e., all the cell data in the first
column would be stored in a field named "a_".

CONVERTING ASCII FILES
To convert an ASCII file you must first create a new Superbase file to hold
the data. This in turn means that you will need to know the following
information about the ASCII file's structure:

The number of fields in a record.
The number of characters in each field. For delimited ASCII files, this
will be
The maximum number of characters in a field.
The type of data each field contains: numeric, string, data, or time.

Once you have acquired this information, you must define a Superbase file
(using the New File option on the Project menu) which has the same
structure. For example, if the first field in the ASCII file contains
numeric data, the first file in the Superbase file must be numeric and it
must have the same numeric format. One way of finding out these details is
to display the file on screen.

You will then be able count the characters for the different fields and
check the way numeric data is stored. Use the List option on the System
menu to

				S-6

display ASCII delimited files. Provided there are not more than 255
characters on a line (i.e., the total number of characters in the record
must not be more than 255), you can also use List for ASCII fixed length
files. If the lines are over this limit, you may be able to check the
format by printing the ASCII file.

IMPORTING ASCII FILES: PREREQUISITES
As far as importing the ASCII data is concerned it doesn't matter how or
where the file was created. So you should take the same steps whether you
are transferring data from one Superbase file to another, or converting a
file from another program; the prerequisites are the same:

The file into which the data is to be imported is always the current file.
Make sure you have opened this file before you select Import.

The fields into which data is to be imported must be of the correct type: a
numeric field for numbers, a date field for dates, etc.

Superbase will signal an error if Import tries to store a blank field that
has Required status. Remove such status temporarily with Project Edit.

Validation checks will be made on all fields in records created by Import, 
whether they are being imported into or not. Again, you may need to
temporarily remove Validations using Project Edit.

You can specify that only certain fields are imported by selecting these
fields in the Open Fields list (select Open Fields from the Project menu).
If you are importing into just the set of open fields, Superbase will
create records with the other fields left blank. Index entries for such
fields may be created, but they too will be blank.

If you are importing data from an ASCII delimited file, you may need to
specify which characters it uses as separators (or delimiters). On the
Amiga, the default values are 44 (the comma) for the field separator and 10
(the line feed character) for the record separator. GEM has the same value
for the field separator, but uses two characters for the record separator,
13 (the carriage return character) and 10(the line feed character). If the
separators in the ASCII file are different from these, select Options on
the Set menu and alter the separator values accordingly.

				S-7

USING IMPORT
Whatever the application, the first stage in the Import procedure is always
the same. Select Import from the Process Menu. Superbase displays the
Import dialog. It shows the file type options with selection buttons to the
left of them. Click on the button corresponding to the type of file you
wish to import. After selecting one of the spreadsheet types, you have to
option of specifying the range and a label row. The first value for the
range should be the coordinates for the cell at the top left-hand corner;
the second value determines the bottom right-hand cell. Coordinates are
entered in the conventional way for spreadsheets; for example, A12 or AF30.

If the range is not specified, Superbase converts the entire spreadsheet
file. To specify that a row of labels will be used for field names, enter
the number of the row. If you leave this box blank, the field name for a
column of cells is formed by taking the column identifier and adding an
underscore character to it.

The next step depends on whether you have selected ASCII files or one of
the other types. For ASCII files there is an interim stage where you can
set a filter on the file that is to be imported.

ASCII FILES ONLY
When you click on OK in the Import files type dialog. Superbase displays
the Import Filter dialog:

This allows you to determine which records in the ASCII file are to be
imported into the Superbase file. The dialog is the same as the normal
Filter dialog. See Chapter 1, for a detailed explanation of how Filters
work. Build up your Filter Command Line in the normal way and click on OK.

SELECTING THE IMPORT FILE
You will now be presented with a file selection dialog. If you have
specified an ASCII format, it lists all the files in the current directory.
Otherwise it only shows files of a particular type; i.e., if dBase is
specified, the dialog lists files with the extension name '.dbf' (but it
doesn't show the extension name).

You may also type in a path name and file name for a file in another
directory,  leaving out the extension name if it is not an ASCII file.
Select the file you wish to import or convert and click on OK. For ASCII
files this completes the procedure. If one of the file conversion types has
been specified - dBase, 

				S-8

Lotus, Logistix and DIF - Superbase displays a new index dialog where you
can select the field or fields on which the new file is to be indexed.

Note that when you import a file under program control, this option is not
available and the file is indexed on the first field.

PROCESS EXPORT
This function allows you to convert a Superbase file to a different format
so that it can be loaded into another software package. Generally, you will
export files for use in a spreadsheet or another database program, but you
may also want to load Superbase data into a wordprocessing program or a
desktop publishing package. The only restriction is that the exported file
must be in a format that is recognized by the other program. This should
not be a problem since Export offers the same range of formats or file
types as Import including two ASCII file types. Even if the other program
does not provide any file conversion facilities, it will almost certainly
be able to accept ASCII files. In addition, Export is used to convert data
from a Superbase file into ASCII format so that it can be imported into
another Superbase file.

PREPARING TO EXPORT A FILE
Before you select Export, you can specify which fields are to be exported,
using the Open Fields option on the Project menu. In creating the new
records Superbase will only take the data from the fields in the Open
Fields list. If you intend to convert the Superbase file into an ASCII
delimited file, two further preliminary options are available:

Field and Record separators. Depending on the application, you may want to
change the default values for the field and record separators. To do this, 
select Options on the Set menu.

Quotation marks. The Options dialog in the Set menu allows you to specify
that every field exported is enclosed in quotation marks. This is necessary
if the data contains the character used as a field separator; for example,
addresses,  dates or numbers may contain commas.

				S-9

USING PROCESS EXPORT
Make sure that the file you wish to export is the current file. Then select
Export from the Process Menu. Superbase displays the Export file type
dialog. Details of the different file types are given on page 5. Here, we
only need to mention that the fields in ASCII fixed length files are
exported in the format set in the current file definition. If the data in a
field is shorter than the length set in the file definition, Superbase pads
it out with spaces.

Click on the button corresponding to the file type required. If you select
a spreadsheet file type, you also have the option of specifying that labels
are included - Superbase will export the field names as a set of labels
along the first row of the spreadsheet data.

Now click on the OK button. Superbase displays the Export filter. Use this
to determine which records are to be exported. If you wish to export the
entire file, leave the Filter Command line blank; otherwise, build up the
Command Line in the normal way.

When you click on OK, Superbase displays the Export File Name dialog. Enter
the name the file is to have when it has been converted. With ASCII files,
you should supply an extension name; we suggest that you adopt a convention
for naming exported ASCII Files, such as ending each with the extension
'.exp'. If you have specified one of the other file types, you should not
include the extension name: Superbase will add the appropriate extension
for you.

Superbase then processes the database file, checking each record to see
whether it matches the conditions set up in the Filter. If it does,
Superbase creates a copy of the data in the currently open fields and
stores it on disk.

For program applications, variables can be used in place of fields. The
fixed length option applies to variable names in the same way as to field
names.

				S-10

MAIL MERGE
Two enhancements have been made to the Mail Merge option on the Process
menu: variables can now be entered in a text document in place of fields,
and blank lines caused by empty fields are closed up. Variables will be
mainly used in conjunction with a Superbase program so this feature is
covered below in the section headed Programming Mail Merge.

BLANK LINES
One of the problems with merging a set of address fields is that in some
records one of the fields may be empty. For instance, the address may not
include a city name. If this line were left blank when the letter was
printed,  there would be an unsightly gap between the street name and the
post code. Superbase solves the problem by checking whether a field (or
variable) is empty or not. If it is empty, the field is not merged and the
fields above and below are printed on consecutive lines.

PROGRAMMING MAIL MERGE
The menu-based facility should be sufficient for most of your mailing
requirements. But for more complicated tasks, it is sometimes preferable to
bypass the menu and run Mail Merge under program control. The two features
that make program control possible are:

The use of variables in a Text Editor document.
The DML command? TEXT MERGE
Variables have the same function in a Mail Merge document as fields. When
you run Mail Merge, Superbase inserts the value of the variable in place of
its name. But any variables used must be assigned a value in a program or
from the command line before you merge a document. If they are not,
Superbase will display a 'variable not defined' error message.

As with fields, variable names must be enclosed by the ampersand character.
Any variable can be used except an array variable. Usually, your text
document will combine fields and variables; but it may also contain
variable names only.

The ? TEXT command does two things: it merges variable and field data (from
the current record) with the text file in memory; and it then sends the
text file to the current output device. If the current device is the
screen, ? TEXT MERGE is equivalent to running Mail Merge for just one
record only and displaying the result on screen.

				S-11

Superbase also provides the MERGE command but this simply duplicates the
menu option. Using ? TEXT MERGE gives you exact control over the mail merge
process since it allows you to set variables or open a different file while
the merge operation in under way. Combining this with variables in a
program greatly extends the scope of Mail Merge. It makes it possible to
create far more sophisticated applications involving multiple files,
conditional merging or even "boilerplating".

USING PROCESS COMMS
Select Comms from the Process menu. Superbase displays the communications
parameters dialog. Before a file can be transferred, both users must set up
all the parameters (except Comms port) in this dialog in the same way. For
each of the following parameters you must select an option by clicking on
its corresponding button:

BAUD RATE
This determines the speed at which the file data is transmitted. Five
different baud rates are available:

9600, 4800, 2400, 1200, or 300

PARITY
The parity options are:
None  Even  Odd

If you select even or odd parity, an additional bit will be used to check
the value of each data word transmitted. Even parity means that the total
sum of the bits in a data word will be an even number; with odd parity, the
total will be an odd number.

NUMBER OF BITS PER CHARACTER
The options are:

8  7  6  5

STOP BITS
These mark the end of a data word. There can be either 1 or 2 stop bits.

COMMS PORT
Select 1 or 2 corresponding to the serial port used for the modem or
connecting cable.

TRANSMIT/RECEIVE
Click on the Transmit button if you are sending a file, click on Receive to
receive a file.

				S-12

FILE HEADER
When this is set to On, Superbase transmits the file's name and the file is
saved under this name at the receiving end. When File Header has been set
to Off, the receiver specifies the name under which the file is to be
saved. Superbase displays a file selection dialog before transmission takes
place. If you are at the receiving end of the comms link, you must then
enter a name for the file or select an existing name from the dialog panel.
Note that when the file is transmitted, the last 128 byte block will be
padded out with zeros.

TRANSFERRING A FILE
When both users have set the parameters in the comms dialog, they should
click on OK. If you have selected Receive, the computer will then wait for
a file to be transferred from the other end of the link.

If you are transferring a file, you will be presented with a file selection
dialog for the files in the current directory. Select the file you wish to
send and click on OK. Superbase will then proceed to transmit the file.

During transmission, a further dialog appears on both machines showing the
status of the transfer. It displays the number of blocks successfully
transmitted or received, and indicates errors. Superbase uses the Xmodem
protocol for file transfer. Each block of file data is checked for errors
as it is transmitted. If errors occur, the block is transmitted again.

When the transfer is completed, the file is stored on disk (at the
receiving end) under the same name with which it was transmitted.

NOTE: If you are transmitting files over the public telephone network at a
baud rate higher than 1200, you may experience problems with file transfer.
In order to reduce the number of errors, you should select a lower baud
rate.

THE TRANSFER STATUS DIALOG
During file transfer, Superbase displays a dialog showing the status of the
transmission. The top of the dialog indicates whether the user is
transmitting or receiving and, if the File Header has been set to On, it
also gives the file name. Below this, there are three headings: Blocks,
Count, and Errors. Blocks shows the number of blocks that are still to be
transmitted, Count gives the number that have been successfully
transmitted.

				S-13

REMOTE TRANSMISSION
The procedure for sending files via modem is as follows:

1. Enter the receiver's number in the Autodial box in the comms dialog.
2. Select Transmit.
3. Set the other comms parameters for baud rate, port number, etc.
4. Click on OK.
5. Select the file or files (using wild cards) for transmission.

Notice that there is no Remote/Local option in the comms dialog. Provided
the modem is on line and the DCD line is off, Superbase detects that Remote
transmission is required and proceeds with the operation as soon as you
have selected a file.

At the receiving end, you must select Receive and then set up the other
parameters so that they have the same values as in the transmitter's comms
dialog (although the port number does not need to be the same). If your
modem has an autoanswer facility, this must be turned on. If it doesn't
have autoanswer, the ring indicator line from the modem must be connected
to the computer's RS 232 port.

The next step is to click on OK in the comms parameters dialog. If the File
Header option has been set to Off, you will first be presented with the
file selection dialog where you can enter the name under which the file is
to be saved. Superbase will then display the "busy" symbol (an hour glass
icon) and will wait to be contacted by the transmitter. If the File Header
option has been set to On, transmission will proceed as soon as the comms
link has been established.

				S-14

2 DML KEYWORDS
This part of the supplement gives the keyword entries for the following new
commands and functions:

LOAD SET
SELECT FORM ROW
SET EDIT
SET HEADING
SET NOW
SET TODAY
UPDATE FORM ROW
Comms commands
Report functions

The last two sets of keywords are covered in separate sections under the
headings Comms under Program Control, page 34, and Report Functions, page
36. Also provided here are the revised entries for keywords whose syntax
has been amended or expanded:

BLANK 
ENTER
EXPORT
IMPORT
OPEN FIELDS
REQUEST

BLANK
Purpose
Creates a blank record in memory.

SYNTAX
BLANK [FORM]/ [DUPLICATE] [FILE sbfname]

COMMENTS
When you want to create a new record under program control, issuing a BLANK
statement is the first step in the process. It sets up an empty record
ready for data entry. There are several ways in which you can then enter
data into the record's fields.

				S-15

Using BLAND with ENTER allows the user to type in the data for a new record
from the keyboard. Together these two commands have the same effect as the
RECORD NEW option in the RECORD menu. Alternatively, you can enter data
from within a program, by assigning it directly to the fields in the new
record. Typically, this would be the method you used to create new records
by reading data in from another file on disk.

The FORM parameter is used with a multi-file form; BLANK FORM creates
records for each file represented in the form. When a form is open but the
FORM parameter is not included, BLANK only creates a blank record for the
current file.

DUPLICATE is the program equivalent of Duplicate on the Record menu. It
creates a copy of the current record and allows the user to create a new
record by editing the copy. This parameter can only be used with a file,
not a form. With the FILE parameter, you can create a blank record in a
file which is open but not current.

EXAMPLES

1 BLANK
2 BLANK FILE "abc"
3 BLANK
  ENTER
  STORE
4 BLANK
  Firstname.address="John"
  Lastname.address="Smith"
  STORE
5 BLANK DUPLICATE
  ENTER
  STORE

The first example creates a new record in the current file. Example 2
creates a new record in another open file. Example 3 creates a new record
in the current file, and allows the user to enter data in the record; then
it saves the record on disk. Example 4 creates a new record, and enters
data into the fields Firstname and Lastname; then saves the record on disk.
Example 5 allows the user to create a new record by editing the current
record.

				S-16

ENTER
Purpose
Allows the user to enter data in the current file or to edit the data in a
record.

SYNTAX
ENTER [field] [ROW nexpr1]]/[nexpr2] [TO field2 [ROW nexpr3]] /[,nexpr4]

COMMENTS
ENTER works on the current file. Used on its own, it is equivalent to the
Record menu option Edit. It displays the current record and allows you to
edit it field by field, starting with the first field that is not Read
Only. In effect,  ENTER temporarily hands over control from DML to
Superbase itself. When you press Return after the last field in a record or
when you move the cursor down to the bottom of the record, control is
transferred back to DML.

The parameters for this command can only be used with a form. When a form
is open and field1 or nexpr2 is specified without any further parameters,
Superbase restricts the editing to just one field. You can supply either a
field name or a field number where the number corresponds to the field's
position in the field order; i.e. the entry order which was set when the
form was created. After executing an ENTER command followed by field or
nexpr2, Superbase makes the editing cursor active in the field specified;
control is transferred back to DML when the user presses Return.

With TO or nexpr4, you can specify that a range of fields is available for
editing. TO must be followed by a field name and restricts editing to the
fields in the range field1 to field2. nexpr4 gives the number of fields
that can be edited - from field1 or nexpr2 onwards. As an example, suppose
you wanted to restrict data entry from four fields from Firstname through
to City. Assuming Firstname is number 2 in the form's entry order and City
is number 5,  you could use any of the following commands:

ENTER Firstname TO City
ENTER 2 TO City
ENTER 2, 4
ENTER 2 TO City
ENTER Firstname, 4

				S-17

Superbase would make the cursor active in the Firstname field and allow you
to enter data or edit Firstname and the next three fields.

You may want to specify a starting point without restricting yourself to a
given number of fields. To do this, enter 0 as the second numeric
parameter; e.g.:

ENTER 2, 0

or

ENTER Firstname, 0

Now you will be able to edit any field in the form starting from field 2.
Control will be transferred to DML when you press Return in the last field.
The ROW parameter is used for entering data in transactions. nexpr1
specifies the number of the row at which you wish to start entering data,
nexpr3 specifies the last row.

Note that ENTER can also be used to edit form calculations. But in this
case you should supply the calculation's order number, not the calculation
name. Thus suppose you wished to enter a new value in a calculation named
Calc1% which had the order number 7; the correct command to do this would
be:

ENTER 7

Because calculations on a form are treated as variables by DML, the
command:

ENTER CALC1%

would only work correctly if Calc1% happened to contain the value of 7.
When used in conjunction with BLANK, ENTER is equivalent to the Record menu
option New, and allows you to enter data into a new record.

This command does not save a record; to save a new or edited record use the
command STORE.

EXAMPLES

1 OPEN FILE "aaa"
  ASK "Record to edit"; x$
  SELECT KEY x$
  ENTER
  STORE

				S-18

2 OPEN FILE "aaa"
  BLANK
  ENTER
  STORE
3 ENTER Lastname
4 ENTER 4, 3
5 ENTER Cuscode TO Quantity
6 ENTER Cuscode ROW 3 TO Quantity ROW 5

Example 1 shows how to enter an existing record in order to edit it.
Example 2 creates a new record. Example 3 restricts editing to the Lastname
field. In example 4, fields (or calculations) 4 to 6 in the form's field
order can be edited. Example 5 restricts editing to the fields from Cuscode
to Quantity. The last example assumes there are transactions on the form
and restricts editing to the fields in rows 3, 4 and 5.

				S-19

EXPORT
Purpose
Exports to an external file from the current file.

SYNTAX
The syntax for EXPORT varies according to the type of file being exported:

ASCII files
EXPORT [FILEsbfname] [INDEXindex] [TO]filename
[WHERE conditions/ASK] [USING params]/[USING FILE]

dbase files
EXPORT [FILEsbfname] [INDEXindex] [TO]filename
[WHEREconditions/ASK] USING "2"/"3"

Spreadsheet files
EXPORT [FILEsbfname} [TO]filename
[WHEREconditions/ASK] [USING LABELS]

COMMENTS
This command is the program equivalent of the EXPORT option in the PROCESS
menu. It converts a Superbase file to a specified format and stores it on
disk. The filename parameter gives the name under which the file will be
stored after it has been exported. It is this parameter that determines the
file type. To export a file in dBase format, you must use the '.dbf'
extension name. You must also specify whether it is to take the format for
dBase II or dBase III by following the EXPORT command with the USING
parameter. USING "2" exports in dBase II format, USING "3" exports in dBase
III format. For example:

EXPORT "address.dbf" USING "3"

This converts the current Superbase database file to dBase III format. To
convert a file to a spreadsheet format, you must give it one of the
following extension names:

.wks (for Lotus files)
.lgx (for Logistix files)
.dif (for DIF files)

				S-20

If you specify the USING LABELS option for spreadsheet files, the field
names in the Superbase file will be exported as a row of labels.

To export a file in ASCII format, choose a different extension name from
the ones listed above. Alternatively, you can omit the extension name for
ASCII files.

Details of the syntax for exporting files in ASCII format are given at the
end of this section. The next two parameters are used with all file types:

FILE sbfname specifies the Superbase file which is to be converted. If this
parameter is not given, EXPORT takes data from the current open file.

WHERE conditions allows you to creates a filter to determine which records
are copied to the export.conditions is set up in the same way as the
command string in the Filter dialog. For an explanation of how the ASK
parameter is used, see the entry for SELECT WHERE.

If INDEX indexname is not specified, the command exports records in the
order of the current index. Use INDEX to specify a different order. This
parameter is not available if you are exporting a spreadsheet file.

ASCII FILES

There are two ASCII file formats, ASCII delimited and ASCII fixed length.
To select the ASCII fixed length format, you must enter the USING FILE
parameter at the end of the command.

For ASCII delimited files, you may select the USING parameters option. This
allows you to change the Export/Import parameters as specified in the
Options dialog on the Set menu. These determine which characters Superbase
used to separate fields and records in the ASCII file. You can also specify
whether text fields are exported with or without quotation marks around
them. If you do not specify USING parameters, Superbase will use the
parameters which are set in the Options dialog.

USING takes three parameters, each enclosed by quotation marks and
separated by commas. For example:

	USING "&", "$$", "0"

The first two parameters specify the field separation characters and the
record separation characters. As in the Options dialog, you can define a
separator using one character or two characters. The third parameter must
be either 0 or 1; 0 for no quotation marks, 1 to include quotation marks.

				S-21

If you want to use a non-printing character-the carriage return character
or the line feed character, for example-as a separator, you need to enter
its ASCII code with the CHR$ function. For example:

	USING "&", CHR$(13)+CHR$(10), "0"

defines the record separator as the carriage return character followed by
the line feed character.

EXAMPLES

1 EXPORT "aaa.dbf" USING "2"
Exports the current file converting it to the dbase file "aaa.dbf" in the
format for dBase II.

2 EXPORT FILE "aaa" INDEX fielda TO "aaa.wks" WHERE
  (datefield) < DAYS ("29 Apr 87")
Exports records in the file "aaa" whose date field value is less than 29th
April 1987. Stores them in Lotus file format with the name "aaa.wks".

3 EXPORT FILE "aaa" TO "aaa.exp" USING "&", "##", "1"
Exports the data in the file "aaa" to ASCII delimited the "aaa.exp", using
the separators specified.

4 EXPORT "aaa.exp" WHERE ASK USING FILE
Exports the current file to the ASCII fixed length file "aaa.exp". When the
commands is executed, ASK brings up a filter dialog where the user can
enter the export filter conditions.

				S-22

IMPORT
Purpose
Converts dBase and spreadsheet files into Superbase files, imports an ASCII
file into an open file.

SYNTAX
The syntax for this command varies according to type of file being
converted or imported.

ASCII FILES
IMPORT filename [TO FILEsbfname] [WHEREcondition / ASK]
[USINGparameters] / [USING FILE]

dBase files
IMPORTfilename.dbf

Spreadsheet files
IMPORTfilename.lbx/.wks/.wks/.dif [USINGstrexpr1, strexpr2 [strexpr3]]

COMMENTS
The extension name given as part of the filename parameter specifies the
type of file that is to be read from disk. It also determines whether the
file will be imported into an existing or converted into a new Superbase
file.

dBase files
To convert a dBase file, you must supply the '.dbf' extension - no further
parameters are required. The file will be converted to Superbase database
file with an index on the first field.

Spreadsheet files
To convert a spreadsheet file, use one of the following extensions:

.lgx (for Logistix files)
.wks or .wk1 (for Lotus files)
.dif (for DIF files)

The first two parameters following USING specify the range of cells that is
to be converted. strexpr1 gives the address of the cell in the top
left-hand corner, strexpr2 gives the address of the bottom right-hand cell.
If the USING parameters are not entered, Superbase converts the entire
spreadsheet file.

With strexpr3, you can give the number of a row in the spreadsheet data
which contain labels. These will then be taken as the Superbase file's
field names.

				S-23

If you leave this parameter out, the field names will be formed by taking
the spreadsheet's column identifiers and adding an underscore character to
them; i.e., data in column AB will be stored in field AB_.

ASCII files
With ASCII files, the data is imported into the current file or another
open file specified with the TO FILE parameters. To indicate an ASCII file
you can use any (or no) extension name except those listed above.

Superbase can import two types of ASCII file, ASCII fixed length and ASCII
delimited. The USING FILE parameter indicates that the file to be imported
is ASCII fixed length. If this is omitted, it is assumed that the file is
ASCII delimited.

With ASCII delimited files, USING parameters can be used to change the
default Import/Export values set in the Options dialog - i.e.to indicate
which characters are used for field and record separators, and whether the
field data is enclosed in quotation marks or not. For a description of USING
and the parameters it takes, see EXPORT.

With both ASCII file types, WHERE conditions allows the user to add a
filter to the IMPORT command. condition is a set up in the same way as the
command line in the Filter dialog. For details of the ASK parameters, see
SELECT WHERE.

EXAMPLES

1 IMPORT "aaa.exp"
Imports the ASCII delimited file "aaa.exp" into the current open file.

2 IMPORT "aaa.exp" TO FILE "aaa" WHERE (datefield) > DAYS ("29Apr87") USING FILE
Imports the ASCII fixed length file "aaa.exp" into the Superbase file
"aaa",  taking only the records whose date field value is later than 29th
April 1987.

3 IMPORT "aaa.exp" WHERE ASK USING CHR$(44), CHR$(13), "0"
Imports the ASCII delimited file "aaa.exp" into the current open file, and
specifies that the file uses the comma and carriage return characters as
field and record separators. It also indicates that the field data is not
enclosed in quotation marks. The WHERE ASK parameter brings up a filter
dialog when the command is executed.

				S-24

4 IMPORT "aaa.dbf"
Converts the dBase file "aaa.dbf" into a Superbase file named "aaa.sbf".

5 IMPORT "aaa.lgx"
Converts the Logistix file "aaa.lgx" into a Superbase file named "lgx".

6 IMPORT "aaa.wks" USING "a1", k50", "1"
Converts the Lotus file "aaa.wks" into a Superbase file named "aaa.sbf".
The USING parameters specify that only the cells in the range a1 to k50 are
converted, and that the labels in row 1 are used as field names. Assuming
that every row and column within the range is occupied, the Superbase file
will have 50 records in it, with 11 fields to a record.

LOAD SET
Purpose
Loads the parameters file from current directory.

SYNTAX
LOAD SET

COMMENTS
The parameters file is called 'sb.par'. It contains details of a number of 
user-defined preferences and options governing a variety of Superbase
functions. Most of them are set in the Options dialog, but it also stores
other items such as the label settings, numeric format and date format. The
current parameters are stored on disk in the current directory (or in a
directory specified by the parameter file path) when you click on OK in the
Options dialog or with the command SAVE SET.

The parameters file for the current directory is automatically loaded when
you change to that directory. Typically LOAD SET would be used to restore a
set of parameters after some of them have been altered, for example, to
restore the previous numeric format after it has been changed using the
NUMBASE command. You may also want to create multiple 'sb.par' files for
different applications storing them under different names in a special
directory. After copying one of them to the current directory and changing
its name back to 'sb.par', you would then use the LOAD SET command to
activate its parameters.

				S-25

EXAMPLES

1 COPY "\Params\param3" TO "\GEMAPPS\SBRO\DEMO\sb.par"

  LOAD SET
Copies the file "param3" to the current directory and changes its name to
"sb.par". Then loads the file.

OPEN FIELDS
Purpose
Specifies which fields are displayed.

Syntax
OPEN FIELDS [FILEsbfname] [fieldlist] / [ADDfieldlist]

COMMENTS
This command is the program equivalent of the Open Fields option on the
Project Menu.

When used on its own or with the FILE parameter, OPEN FIELD loads the
file's field list from disk - the field list for the current file is saved
using the Save File option (i.e., it is stored with the file definition).
The field list does not take effect until the current record is
redisplayed.

To specify under program control which fields are to be open, use the
fieldlist parameter. It should consist of a list of field names separated
by commas. Use the ADD parameter to add other fields to the existing set.

To remove any restrictions on which fields are shown, use the CLOSE FIELDS
command.

EXAMPLES

1 OPEN FIELDS FILE "Address" Firstname, Lastname, Country, City
2 OPEN FIELDS: VIEW
3 OPEN FIELDS ADD Code

				S-26

REQUEST
Purpose
Displays a Superbase dialog.

SYNTAX
REQUEST text1, text2, type [nvar[strvar[len]]]

COMMENT
REQUEST allows you to select one of Superbase's dialogs and display it on
screen. To some extent you can also customize a dialog to your own
requirements. Thus you can place a title in box, and you can specify the
text string that initially appears in the dialog's command line or
selection box. For certain dialogs, it is also possible to specify the
length of the box. text1 and text2 are the first and second line of the
dialog title. They must be included although they can be "". The maximum
length for each line is 50 characters.

type is the dialog type. It defines the type of dialog according to the
table shown below.

nvar is a numeric variable. It returns a value of 1 if OK is selected and
there is an entry into the string dialog. If CANCEL is selected or there is
no entry into the string dialog, it return 0.

strvar can be used with dialogs which have a string entry box and has two
functions:

It is used to place a default value into the string box, i.e., the text
string in strvar is entered into the string box when the dialog is
displayed. It returns the string which the user enters in the box.

len specifies the length of the string box (where appropriate). This is
particularly useful for the information dialogs. For dialog type 5 to 16 it
is not needed as Superbase sets the box to the maximum file name length of
50 characters. For dialog type 4 len must be specified.

				S-27

Types of Dialogs available:

TYPE	DIALOG			BUTTONS
0	string			OK
1	string			OK CANCEL
2	string			OK
3	string			OK CANCEL
4	string			OK CLEAR CANCEL
5	Current file fields	OK CLEAR CANCEL
6	Open Fields list	OK CLEAR CANCEL
7	Indexed fields		OK CLEAR CANCEL
8	Non indexed fields	OK CLEAR CANCEL
9	Field Info		OK CLEAR CANCEL
10	Open Database Files	OK CLEAR CANCEL
11	Database Files		OK CLEAR CANCEL
12	Program Files		OK CLEAR CANCEL
13	Text Files		OK CLEAR CANCEL
14	Query Files		OK CLEAR CANCEL
15	Update Files		OK CLEAR CANCEL
16	Function Key Files	OK CLEAR CANCEL
17	Directory Listing	OK CLEAR CANCEL
18	Subdirectory Listing	OK CLEAR CANCEL
19	Form Files		OK CLEAR CANCEL
20	Record Selection	OK CLEAR CANCEL
21	Same as dialog 1 but accepts Return key for OK
22	Same as dialog 2 but accepts Return key for Cancel
23	Same as dialog 4 but does not echo keyboard input

Note that a database file must be open before dialogs 5 to 9 can be
selected.

Dialog type 20 has a different syntax to the other types:
REQUEST text1, text2, type, nvar, field1/var, len, field2, [field3[field4]]
The first two parameters have the same function as with other dialog types:
they give the first and second lines of the dialog title.type can be any
numeric expression with a value of 20.nvar is a numeric variable which
returns 1 if OK is clicked, 0 for Cancel.

The next parameter - field1/var - may be a field or a variable. If a field,
it will usually be the name of a field in the current file but it can also
be a field in another open file. Whatever is entered in the dialog is
stored in the field or variable. The fields specified with field parameters
2 to 4 can also belong to any open file but it must be the same file.len
specifies the width of the dialog in number of characters.

				S-28

When you execute this command, it list the contents of field2 for each
record in the file. If field3 and field4 are specified, the contents of
these fields will also be displayed in the dialog to the right of field2.

Superbase retrieves the field2 data using the current value of field1 or
var as an index key or a 'seed'. Provided field2 is an indexed field, the
list of fields in the dialog will start with the field before the one that
matches this key. If it is not indexed, the field data is listed in the
order of the current index.

When you select one of the field2 values from the dialog and click on OK, 
Superbase stores it in the field or variable specified with the field1 /var
parameter.

EXAMPLES
1 REQUEST "", "", 2, a%
2 a%=0: a$="": REM initialize nvar and strvar
  REQUEST "Select a program", "", 5, a%, a$, 32
  IF a%=0 then ? "OK so you do not want to run a program": END
  CHAIN a$
3 REQUEST "Select a customer code", "", 20, a%, Cuscode.Invhdr, 40, 
  Cuscode.Customer, Firstname.Customer, Lastname.Customer.

NOTES
Example 1 puts an OK dialog up for 2 seconds. Example 2 allows the user to
select a program to run. Example 3 illustrates the use of dialog type 20.
Taking data from the Customer file, the dialog lists the names and customer
codes of the individuals in the file. When the user selects a customer code
from the dialog, it is stored in the Cuscode field in current record from
the Invhdr file.

				S-29

SELECT FORM ROW
Purpose
Selects the current transaction row.

SYNTAX
SELECT FORM ROW nexpr

COMMENTS
This command is used with transaction forms to select one from a number of
transaction lines. Transaction data on the form is held independently of
record data. Consequently, it is necessary to select the transaction you
wish to deal with in order to ensure that the record data reflects the
transaction data. Once you have identified a transaction with SELECT FORM
ROW, any reference to a field involved in transactions will refer to the
instance of that field in that transaction. See UPDATE FORM, ENTER, FORM.

Note that in selecting a transaction you also select the record which holds
the data for the fields in the transaction; in other words, you make it the
current record.

EXAMPLES

1 x%=COUNT quantity.invline
  FOR n%-1 to x%
  SELECT FORM ROW n%
  ? quantity.invline
  NEXT

NOTES
The example displays all the quantity entries in the current form.

				S-30

SET EDIT
Purpose
Sets auto-entry to the Program Editor on or off.

SYNTAX
SET EDIT ON/OFF

COMMENTS
Normally when a program is interrupted - when CTRL C or the Stop button has
been clicked, or when an error has occurred - Superbase opens the Program
Editor window and makes the cursor active. SET EDIT OFF switches this
feature off; if the window has been closed beforehand, it will remain
closed when the program is stopped.

SET HEADING 
Purpose
Sets the title for the Superbase window.

SYNTAX
SET HEADING strexpr

COMMENTS
The title bar for the Superbase window normally shows the name of the
current open file. SET HEADING allows you to replace this with your own
heading. To restore the original heading, use SET HEADING "".

EXAMPLES

1 SET HEADING "Invoice Form"
2 SET HEADING ""

				S-31

SET NOW
Purpose
Sets the time held in the system variable NOW.

SYNTAX
SET NOW strexpr

COMMENTS
strexpr must contain a time in the current time format as set with Date
format in the Set menu or with the DATABASE command.

EXAMPLES

1 SET NOW "14:35:08"
2 DATABASE "hh:mm:ss.s"
  SET NOW "23:59:59.9"

SET TODAY
Purpose
Sets the date held in the system variable TODAY.

SYNTAX
SET TODAY strexpr

COMMENTS
strexpr must contain a date in the current date format as set with DATABASE
or with Date format in the Options menu.

EXAMPLES

1 SET TODAY "15May1988"
2 DATABASE "mm-dd-yy"
  SET TODAY "12-31-87"

				S-32

UPDATE FORM ROW
Purpose
Copies data from the current record or records to a specified transaction
line.

SYNTAX
UPDATE FORM ROW nexpr

COMMENTS
This command is only used transaction forms. It updates the fields in the
transaction line specified with nexpr taking the data from the current
record. To redisplay use the FORM command.

See SELECT FORM, ENTER, FORM.

EXAMPLES

1 BLANK FORM
  SELECT FIRST
  FOR n%=1 TO 10
  UPDATE FORM ROW A n%
  SELECT NEXT
  NEXT
  FORM

NOTES
The example program fills the first ten lines in the transaction form with
data from the first ten records in the current file - it assumes that the
fields in the file are the same as those on the form.

				S-33

COMMS UNDER PROGRAM CONTROL
DML provides seven commands for handling communications under program
control. The first five can be used for transmitting and receiving text
strings rather than entire files. To see how these commands allow you to
communicate with another Superbase user in 'chat' mode, you are recommended
to look at the Comms program supplied on the demonstration data disk.

The last two comms commands are the program equivalents of the Comms menu
option and used for file transfer under the XMODEM protocol.

1. OPEN COMMS [USING parameters]
This command opens the communications channel must be executed before
attempting file or text transfer. USING can take up to eight parameters,
each separated by a comma. The parameters correspond to the ones in comms
dialog, as follows:

	param1: Port number (either 0 or 1)
	param2: Baud Rate (9600/2400/1200/300)
	param3: Parity (0/1/2)
	param4: Stop Bit (either 1 or 2)
	param5: Word Length (5/6/7/8)
	param6: Transmit/Receive (1 for Transmit, 0 for Receive)
	param7: File Header (0 for Off, 1 for On)
	param8:Autodial Number

The Autodial number must be supplied as a text string; the other parameters
must be numeric values.

If you do not supply these parameters, Superbase uses the values currently
shown in the comms dialog. These default values are stored in the sb.par
file when you click on OK in the dialog.

An example of the use of the OPEN COMMS command would be:

	OPEN COMMS USING 1, 1200, 0, 1, 8, 1, 1, "0932751594"

Here the command opens a channel for remote transmission to a modem on the
telephone number 0932 751594

2. CLOSE COMMS

This closes the communications channel and should be executed at the end of
any operation involving data transfer.

				S-34

3.COMMS[TEXT]GET stringvar
This works in a similar way to GET when it is used as a keyboard input
command. Instead of reading a character from the keyboard, COMMS GET reads
a character from the comms buffer and stores it in the string variable
specified. If the buffer is empty it returns a null character. As with GET,
it doesn't wait for a character to be transmitted, and when the buffer is
empty it returns a null character. If you want COMMS GET to wait for
transmission, you need to place it in a loop, as in:

	lab1: COMMS GET a$: IF a$="" THEN GOTO lab1

The TEXT parameter limits the range of characters that are returned to
those with ASCII codes less than 128. Characters whose codes are greater
than 127 are converted to this range (i.e., Superbase strips off the
highest bit); for example,  ASCII character 180 would be returned as
character 52.

4. COMMS[TEXT]INPUT stringvar
This command reads up to 255 characters at a time from the comms buffer
into the string variable specified. If it finds a line feed character
(ASCII 10) it only takes the characters up to and including the line feed.
Otherwise, within the limit of 255, it returns as many characters as there
are in the buffer. The optional TEXT parameters operates in the same way as
it does with COMMS GET. It maps characters over 127 onto their ASCII
equivalents in the range 0 to 127.

5. COMMS ? strexpr
This outputs the characters in the string expression (either a string
variable or a text string enclosed in quotation marks) through the comms
channel. For example:

	COMMS ? "Hello"

sends the word Hello to the computer at the receiving end.

6. COMMS FILE GET strexpr
Use this command to receive a file under program control. The string
expression should specify the name under which the file is to be saved.
However, if the File Header option is On, it will be saved using the name
under which it was transmitted; so you do not need to supply the file name
and can just give the empty string. For example:

	OPEN COMMS 9.9600, 0, 1, 8, 0, 1
	COMMS FILE GET ""
	CLOSE COMMS

				S-35

7. COMMS FILE[?]strexpr
This command is the program equivalent of transmitting a file using the
Comms menu option. The string expression should specify the file or files
that are to be transmitted. For example, to transmit the Address database
files, you could enter:

	a$="Address"
	COMMS FILE ? a$ + ".*"

REPORT FUNCTIONS
These functions can only be used with repeated fields occurring in reports
and transactions (a group of repeated fields in a form), and array
variables. When a report or a form displays multiple instances of the same
type of data - for example, the deposits made to a bank in a single month -
you will usually want to derive totals from the data or to analyze it in
certain ways. Report functions allow you to do this with a single command.
Within a program you can use them to total or analyze a range of values
which have previously been assigned to an array.

The report functions are:

SUM
COUNT
MIN
MAX
MEAN
VAR
SD

Apart from COUNT, which returns the number of instances of the same field
or the number of array elements, these functions only operate on numeric
values: the function's argument must be a numeric field or a numeric array.

There is an important difference between the way the report functions work
with arrays and with the fields in a transaction form. With arrays, they
act on all the elements whether they have been assigned a value or not. But
with transaction forms they only operate on the lines which contain data;
i.e., COUNT shows the number of transaction lines that are filled and
ignores blank lines.

				S-36

Parentheses are optional with report functions. To show the total of all
the occurrences in a transaction form of the field Amoung, you could enter:

	? SUM Amount
or
	? SUM (Amount)

With array variables, you enter the array name of its, own, as in:

	? MEAN a%

If the array has more than one dimension, the function operates on the
first dimension.

COUNT
Purpose
Returns the number of repeated fields in a report or transaction form. Also
returns the number of elements in an array.

SYNTAX
COUNT (fieldname/array)

COMMENTS
As a report function, COUNT can only be used with repeated instances of a
field or a variable such as occur in reports and transactions or in an
array. Unlike the other report functions, COUNT works with string, date and
time fields as well as numeric fields.

When a calculation variable is replicated as part of a transaction line, it
is converted into an array. Unlike the other report functions, COUNT works
with string, date and time fields as well as numeric fields.

When a calculation variable is replicated as part of a transaction line, it
is converted into an array variable. In most cases COUNT will be used with
these types of variables - the arrays that occur in a transaction form
rather than normal program arrays. If you supply a program array with more
than one dimension as an argument, COUNT operates on the first dimension.

When it used to count the fields in a block of transactions, COUNT only
operates on the lines that contain data. With arrays, however, it gives the
total number of elements irrespective of whether they have been assigned a
value.

				S-37

EXAMPLES

1 x%=COUNT trans%
2 IF COUNT Lastname.Address > 20 THEN...

MAX
Purpose
Returns the maximum value from a range of values.

SYNTAX
MAX (fieldname/numarray)

COMMENTS
fieldname must be the name of a numeric field which is repeated in a report
or in a transaction form.numarray much be a numeric array which has been
defined in a program or as calculation variable in a transaction line. The
parentheses are optional. See COUNT.

EXAMPLES

1 ? MAX range%
2 a%=MAX Score.Results

MEAN
Purpose
Returns the average from a range of numeric values.

SYNTAX
MEAN (fieldname/numarray)

COMMENTS
fieldname must be the name of a numeric field which is repeated in a report
or a transaction form.numarray must be a numeric array which has been
defined in a program or as a calculation variable in a transaction line.
The parentheses are optional.

				S-38

EXAMPLES

1 a%=MEAN age
2 DIM m%(10)
  FOR n%=0 to 10
  m%(n%)=n%
  NEXT
  ? MEAN m%

MIN
Purpose
Returns the minimum value from a range of numeric values.

SYNTAX
MIN (fieldname/numarray)

COMMENTS
fieldname must be the name of a numeric field which is repeated in a report
or in a transaction form.numarray must be a numeric array which has been
defined in a program or as calculation variable in a transaction line. The
parentheses are optional. See COUNT.

EXAMPLES

1 IF MIN range% < 15 THEN...
2 min%=MIN Score.Results

				S-39

SD
Purpose
Returns the standard deviation for a range of values.

SYNTAX
SD (fieldname/numarray)
This function provides a measure of the spread of a range of numeric values
from its mean. It only operates with repeated instances of a numeric field
or numeric variable such as occur in reports and transaction forms. It can
also be used with numeric arrays that are defined within a program. See
COUNT.

EXAMPLES

1 ?SD(n%)
2 Deviance%=SD Scores.Results

SUM
Purpose
Returns the total for a range of values.

SYNTAX
SUM (fieldname/numarray)

COMMENTS
This function can only be used with numeric fields in reports and
transaction forms, and with numeric arrays defined in programs or
transactions. See COUNT.

EXAMPLES

1 ? SUM Line_Value
2 IF SUM tot% 250 THEN...

NOTES
The parentheses are optional.

				S-40

VAR
Purpose
Returns the variance from the mean of a range of values.

SYNTAX
VAR (fieldname/numarray)

COMMENTS
fieldname must be a numeric field whose data is repeated in a report or a
field in a transaction line.numarray can be a numeric calculation variable
that occurs in a transaction line or a numeric array in a program. The
parentheses are optional.

EXAMPLES

1 IF VAR Score.Results > v% THEN...
2 x%=VAR scores%

				S-41

3. FORMS EDITOR
The Forms Editor has been substantially enhanced for this version of
Superbase and some of the sections in the Forms Editor User Guide and are
incorrect. In addition, there are a number of new menu options and new
attributes which are not covered in the User Guide.

The new menu options are: Status, Directory Change and Directory List on
the Project menu; and Field names on the Edit menu.

In the Attributes window, the Pen selector and the Pen and Paper selector
have been replaced by a single selector, and there are three new selectors
for Border, Border Colour, and Currency Format.

STATUS
The Status option on the Project menu provides two types of information.
First it gives information about various aspects of the system. Then if
there is a form in memory, it displays the details of the form's fields and
calculation. When you select Status, a dialog appears giving you the choice
of outputting to the printer or the screen. Click on OK for the printer,
Cancel for the screen. At the top of the screen, Status shows the following
details:

The Superbase files that have been opened
The current directory
The number of pages in the current form
The amount of space remaining on the current disk
The amount of free memory

Below this (if there is a form in memory) Status gives the details of the
form's field and calculation objects. For each object it shows the type
(either FLD for field or CLS for calculation), the name, and the object's
attributes. The attributes are listed in four columns. From left to right,
they are:

ORDER.
The object's order entry number.

JUSTIFICATION
This can be L, C, or R for left, centre and right justification.

				S-42

READ ONLY.
If the object has been given the read only attribute, it is indicated by
the letter R. Otherwise this column is left blank.

PRINT STATUS.
If the object's print status is 'on', it is indicated by the letter P.

If a calculation has a formula attached to it, this is shown in the line
below.

LISTING THE DIRECTORY
The Dir List option lists all the files in the current directory. When you
select it from the menu, a dialog appears giving you the choice of
outputting the directory list to the printer or to the screen. For a screen
display of the directory, click on the Cancel button.

CHANGING THE DIRECTORY
Within the Forms Editor you can change the current directory and the
current drive using the Dir Change option on the Project menu. Directory
displays a dialog which lists all the directories below the current level;
i.e. if you are already at the bottom of the directory tree, the dialog
will be empty.

You can select a directory from the list in the usual way by clicking on OK
or double clicking. Selecting '..' (on the Amiga, type '\') takes you to
the next level up the directory tree.

If you want to change to a directory in another branch of the tree, you
will need to type in its name and pathname. For example, if you had a
directory called images, which was a subdirectory of sbforms, typing

	\sbforms\images
	/sbforms/images

would make Images the current directory.

To change to another drive, type in the drive name - a:, b:, c:, or d:.
(DF0:, DF1:,  DH0: or DJ0:)

After typing in a directory name or a drive name, click on OK or press
Return.

				S-43

FIELD OPTIONS
There are two options governing the way a field is added to a page: Field
names on the Edit menu and Field borders which is available from the
Attributes window.

If you set the Field names option, the name of the field is added to the
page as a text object in the standard system font. It is placed at the left
of the field box at the same time as the field is added to the page.

Field borders are treated as an attribute of a field and are represented in
the Attributes window by the picture frame symbol (see next section). If
this attribute is set, the Forms Editor draws the border of the field box
with a solid line. By default, this attribute is not set, and the field box
is drawn with a dotted line. If you print a form or load a form from within
Superbase,  the field will be shown with its border; the dotted lines
around a field box only appear in the Forms Editor itself.

Like the other attributes, Field borders can be altered at any time - you
can assign a border or remove it from a field by selecting the field and
then clicking in picture frame symbol.

ATTRIBUTES
COLOUR MODES
In the current version of the Forms Editor, the Pen selector and the Pen
and Paper selector in the Attributes window have been merged. There is now
just one box to control both colour modes. By default, the Pen colour mode
is selected; when you highlight the box, Pen and Paper is selected.

CURRENCY FORMAT
Another new feature in the Attributes window is the currency format
selector,  represented by the dollar sign. Assigning this attribute to
numeric calculations ensures that they take the following format when their
results are displayed in Superbase: numbers are right aligned and expressed
to two decimals places; any leading zeros are removed.

				S-44

BORDER
This attribute is represented by the picture frame icon. When it is set,
areas and fields are drawn with a border. With areas, the border can be
treated as a box. Although you can't detach it from the area, you can set
its thickness and pattern in the same way as for boxes and lines. Field
borders are always drawn with a thin solid line and cannot be altered.

BORDER COLOUR
The box to the right of the picture frame icon controls the colour of a
border. To set the colour, first click in this box, then click in one of
the boxes in the colour panel.

You can set the border colour for both areas and fields.

SELECTING MULTIPLE OBJECTS
There are two ways of selecting a group of objects. With the first, you
hold the Shift key down and click once on each object in turn. Click on an
object again to deselect it from the group.

The second way involves drawing a box around the objects that are to be
selected. Start by pressing the Ctrl key, the click in an empty space just
above and to the left of the group. Now drag the dotted outline of a box so
that it encloses the group. Click once to select all the objects in the
box.

In order to deselect an object or a group of objects double click on part
of the page that is not occupied by any object.

				S-45

PRINTING FORMS
COPIES
This allows you to print up to 99 copies of a form. Click in the Copies box
to activate the cursor and enter the number of copies required.

FIELD NAMES
This option determines whether the field names on a form are printed or
not. If you turn the Field name button off - by clicking in it - the Field
character box will become active. Use this to specify the character that
will be printed in the field boxes in place of the field names. Initially,
the character shown is the letter X. To specify another character (the
space character, for example) click in the box to activate its cursor,
delete the letter X, and enter the character required.

GENERATING REPORTS
FORMATTING REPORT OUTPUT
Calculations are especially useful for formatting text and numbers in the
report output. Thus to format a numeric field, you can use the function
STR$. The field should be included in a calculation formula instead of
being added to the form as a separate object. For example, the calculation
Balance$ could be used to format the numeric field Balance, using a formula
like this:

	STR$(Balance, "$999999.99")

Another example, which shows how text can be formatted, would be a formula
such as:

	Firstname + " " + Lastname

Here the formula ensures that first and last names are correctly spaced in
the report output.

PAGE NUMBER
You can enter page numbers on the report using the system variable PG. When
you print the report, Superbase assigns a value of one to this variable and
then updates it by one every time a page is printed.

Typically, PG would be entered in a calculation formula, and the
calculation would be placed in the Heading box. For example, the formula
could be:

	RIGHT$(STR$(PG, 2))

				S-46

TRANSACTION HANDLING
The simplest way of describing transactions is as a set of repeated fields
in a form. Transactions allow the user to display data from multiple
records in the same file and at the same time. Typically, each transaction
would be a row of data drawn from several fields in a single record.

The other key feature of transactions is that each set must be linked to a
single record in another file. A form which is designed to process
transactions - referred to here as a transaction form - must be based on at
least two files,  with one acting as the master file. The relation between
a record in the master file and the records in a set of transactions is
always 'one to many'.

A TRANSACTION FORM EXAMPLE
Let's consider an example of a database application for cataloging a book
collection. It uses two files, Authors and Titles. The Authors file stores
the name and other details of all the authors represented in the
collection, using one record for each author. The records in the Titles
file store the details of each book, such as its title, subject matter, and
publisher. In addition, the records in both files contain an alphanumeric
code (the author code) which links the books to their authors.

This way of organizing the data is far more flexible than a system which
uses a single file to catalogue the books. It makes it easy to design a
form which displays the authors and a list of their books on screen at the
same time. The data would be structured as follows:

	Author's name, Author code
		Title, Subject, Publisher
		Title, Subject, Publisher
		Title, Subject, Publisher

If you clicked on the next record button, Superbase would read in the next
author in alphabetical order followed by a variable number of lines, one
for each of the author's books. The fields from a record in the Titles file
are treated as a single transaction; a set of transactions represents all
the books written by a particular author.

There is an important point to made about this example which applies to
transactions in general. All the records in a set of transactions have one
thing in common: the author's code number. Although it is not part of the
transaction line, it is this field that defines a number of records as a
set of transactions and links them to the record in the Author file.

				S-47

Provided a transaction form establishes this link, it is also possible to
include fields from other files in the transaction line; in this example,
each transaction line could show the publisher's address by looking it up
in an address file.

SETTING UP A TRANSACTION FORM
When you are creating a transaction form, Replicate is the option you use
to define a number of fields and calculations as a set of transactions. As
a prerequisite, you need to select these elements of a transaction as a
multiple group. Then select Replicate from the Edit menu.

The Forms Editor displays the Replicate dialog. You will see four input
boxes and below them two buttons. In the boxes, you should enter numeric
values for the following features:

Transaction lines
Line spacing
Transaction columns
Column spacing

The number of transaction lines specifies how many times the selected group
of fields and calculations will be replicated down the page; i.e., the
number of transactions that will appear on the form.

Line spacing determines the number of empty lines between transactions down
the page. Enter a value of 0, if you wish the transactions to be placed one
on top of the other.

The transaction columns box allows you to specify whether the transactions
are to be arranged in a single column or across the screen in two or more
columns. The total number of transactions on the form will the number in
this box times the number in the transaction lines box. If you want the
form to have just one column of transactions, enter a value of 1.

Column spacing only needs to be specified if you are using more than one
transaction column. The number in this box determines how many spaces will
be placed between each transaction across the page when there are more than
one to a line.

DOWN/ACROSS. These buttons determine the entry order for transactions. If
the form has only one column of transactions, they will automatically be
numbered from top to bottom. With multiple columns, you have the option of
setting the entry order from top to bottom (DOWN) or left to right
(ACROSS).

				S-48

Suppose, for example, the form has 8 transactions which are arranged like
this:

	Trans				Trans
	Trans				Trans
	Trans				Trans
	Trans				Trans

If you click on the DOWN button, the entry order will be:

	1				5
	2				6
	3				7
	4				8

Clicking on the ACROSS button would ensure the entry order was as follows:

	1				2
	3				4
	5				6
	7				8

Note that this option only determines the entry order for the transaction
line as a whole. It doesn't affect the order of the fields within a
transaction (see the next section).

CALCULATIONS
A transaction line may also contain form calculations. These must be tied
to the fields in the line; in other words, the calculation formulas must
include a reference to one or more transaction fields.

Calculations are replicated at the same time as the fields. You simply
select them as part of the multiple group.

The Forms Editor turns repeated calculations into an array. Remember that a
form calculation can be treated as a program variable. When you replicate a
calculation it becomes an array variable; for example, replicating the
calculation tot% five times creates an array with five elements, tot%(0)to
tot%(4).

NOTE: IF THE CALCULATION SENDS ITS RESULT TO A FIELD, THE FIELD MUST BE ONE
THAT OCCURS IN THE TRANSACTION LINE. IT SHOULD NOT POST DATA TO FIELDS IN
OTHER FILES.

				S-49

SETTING LINKS
For a transaction form to work, you must establish a link between a field
in the master file and a field in the transaction line using the Link
option on Set menu. Thereafter, you can set other links, but these must
always be between fields in a 'one to one' relation. In other words, you
cannot set up forms where a transaction has further transactions of its
own.

COPYING FIELDS AND CALCULATIONS
Transactions are created by repeating fields (and calculations) with the
Replicate option. If you repeat a field using some other technique - by
copying it or by adding it to the page a second time - it will only show
the data for the current record and the current transaction line.

Usually, this field would be marked as Read Only and would be used to
display a full description of data which is truncated in the transaction
line.

USING REPORT FUNCTIONS
The report functions can be applied to the fields and calculations that
occur in transactions. They are used in formulas which are attached to
calculations outside the transaction block. An example, would be the
formula:

	SUM Annual_interest

This returns the total value of the field Annual_interest in all the
transaction lines that contain data. Note that the report function do not
operate on empty transaction lines.

Other examples are:

	COUNT Stockcode
	MEAN
	MAX
	MIN

Apart from COUNT, the report functions can only be used with numeric fields
and calculation variables.

Report functions can also be used in DML programs. As well as working with
transaction items, they can be applied to the arrays which are defined
within a program. See the entries for these functions in Chapter 5, DML
User Guide.

				S-50

PROGRAMMING TRANSACTIONS
One of the advantages of using a form to process transactions is that it
does not require any programming. However, transaction forms on their own
will only take you so far. For more complex applications, you will need to
combine the form's built-in processing facility with a program. Superbase
provides the following commands for handling transactions:

	SELECT FORM ROW
	UPDATE FORM ROW
	ENTER

When they are used with the ROW keyword, these commands give the programmer
control over input and output to the individual lines in a set of
transactions. For more details, see the entries for these commands in the
section headed DML Keywords.

SINGLE FILE APPLICATIONS
By definition, transactions can only be defined in a multi-file form.
However, if you replicate fields on a form which uses just one file, they
still share some of the features of transactions.

A form like this will display multiple records from one file in a similar
way to Superbase's form view option. But it is has the advantage of
allowing you to click on any of the lines on screen. The line then becomes
the current record. You can use this feature for two purposes: as a way of
selecting a record from a list, and as a way of entering data from multiple
records at the same time.

SETTING THE ENTRY ORDER FOR TRANSACTIONS
The Order option on the Set menu allows you to define the entry order for
the fields and calculations in a transaction in the same way as for
non-transactional fields. However, there are a number of restrictions that
apply when you are setting the entry order for the elements of a
transaction. The entry order sequence within a transaction is the same for
all the transactions on the form; i.e., if you specify for one transaction
that data is entered from left to right, this will also be the case for the
other transactions. This means that when you are setting the entry order,
you should concentrate only on the first transaction. Any changes you make
will then be automatically repeated in the rest of the transactions.

				S-51

The entry order for the transactions treated as units is set in the
Replicate dialog and cannot be altered. In other words, the order numbers
of the elements in one transaction will always remain the same relative to
the elements in the other transaction.

If you alter the order of a transaction element with respect to other
fields on the form, all the transaction order numbers will be altered at
the same time (although they remain the same relative to each other).

To illustrate these points, let's consider an example involving a form with
four transactions each containing three fields. In addition to the
transactions,  there is one non-transaction field on the form above the
transaction block. The fields are arranged like this:

				Field_a
	Field_b			Field_c			Field_d
	Field_b			Field_c			Field_d
	Field_b			Field_c			Field_d
	Field_b			Field_c			Field_d

Field_a stands on its own; the other fields are elements in the four
transaction lines. Initially, the entry order is as follows:

				1
	2			3			4
	5			6			7
	8			9			10
	11			12			13

Suppose you wanted to change this order so that the user was required to
enter data in the second field (Field_c) in each transaction line before
the first field. To do this you would click once in Field_c on the first
transaction line, and then again on Field_b. The entry order would now be:

				1
	3			2			4
	6			5			7
	9			8			10
	12			11			13

				S-52

You might also want to ensure that data was entered in the transactions
before Field_a. In this case you would need to select the Order option
again, and then click twice on Field_c in the first transaction. The entry
order would then be:

				13
	2			1			3
	5			4			6
	8			7			9
	11			10			12

EDITING TRANSACTION FORMS
Despite their greater complexity, transactions can be edited in the Forms
Editor in the same way as other objects on the form. Editing a transaction
line includes deleting fields, adding new fields, and redefining the
arrangement of a transaction block by selecting Replicate again.

Before editing a transaction, you need to select the item or items you wish
to change. This has the effect of selecting all the items of the same type
in the transaction block; i.e., selecting a filed in the first line
automatically selects the same field in the other lines.

To add a field, first place it on the form, select it in the usual way, and
then select Replicate. It is not necessary to select the fields that are
already defined as transaction elements; after you have redefined the
transaction block using Replicate, the new field will be incorporated in
the transactions.

EDITING TRANSACTION ENTRIES
Superbase provides three editing controls for use when you are entering
data in a new transaction form.

Ctrl D deletes the transaction line at the cursor, and closes up any line
above and below. Ctrl N inserts a new blank line on the line above the
cursor. Pressing the Escape key clears the field where the cursor is
currently positioned. Pressing it a second time, then clears all the fields
in the transaction line.

Note that these controls also have an effect on existing data, but it is
confined to the screen display. If you use Ctrol D to delete a line in a
set of transactions and then save the form, the data in the corresponding
fields will not be deleted at the record and file level.

				S-53

4. OTHER FEATURES
Program identification. The program editor now allows you to indent lines
in order to improve legibility or to exhibit the structure of the program
more clearly.

Outputting to the screen. In earlier versions of Superbase, placing a
semicolon at the end of an expression list with the ? command had the
effect of suppressing output to the screen; the expressions were not
displayed on screen until a new line was entered. In this version, the
screen is updated immediately irrespective of how the output is formatted.
For example:

	? "one", "two", "three";

would display the expressions "one" "two" "three" straight away. The &
output format parameter. This parameter has now been modified to allow you
to specify the number of decimal places in the format when you are
outputting the results of calculations in a query or from a program. As
before,  & followed by an integer sets the maximum length for the text
strings or text fields. When it is followed by a decimal number, the &
parameter specifies the number of digits that will be displayed before and
after the decimal point. For example:

	? &4.3 (Numfield/3)

ensures that the result of the calculation (Numfield/3) will be displayed
to three decimal places and with four digits before the decimal point.

The close gadget is disabled while a program is running Query Language
Commands. In the Keyword Reference Guide under the entry for SELECT, the
description given of the way the TO device options works is misleading. If
used, this option must be entered at the end of a query section,  and it
takes the place of the END SELECT statement. The correct syntax for the
SELECT command is:

	SELECT[params]fields: [statements]: END SELECT/TO
	device

An example would be:

	SELECT Firstname, Lastname, City
	WHERE Lastname LIKE["a-e"*]
	TO "aaa.asc"

				S-54

The last line in this query section ensures that output is sent to
"aaa.asc",  an ASCII file on disk.

Date Format I. You can now specify a date format in which single digit days
and months are given a leading zero. This is done by replacing the first
'd' in the format string with '0'; for example, instead of:

	DATEBASE "dd mmmm yyyy"

you would enter:

	DATEBASE "Od mmmm yyyy"

Date Format II. Any of the existing date formats that make use of spaces as
separators are now also available without spaces. For example:

	DATEBASE "dd mm yy"

which formate the date as 6 10 87, can also be entered as:

	DATEBASE "ddmmyy"

This would format the date as 61087.

Note that these new formats cannot be set from the date format dialog. If
you wish to set a date field to one these formats, use the MODIFY command
or edit the field definition in the '.sbd' file.

Time Format. Unlike the date format, the time format is not saved in the
SB.par file. If you alter the default time format in the date/time format
dialog (selecting it from the Set menu), the your new setting will only
apply for the current session. To set the time format so that it also
applies the next time you load Superbase, you should use the DATEBASE
command in conjunction with the Start program - define the format you
require with DATEBASE and insert the command in the Start program.

Draft Printing in the Forms Editor. In Draft mode, the Forms Editor now
prints boxes and lines as well as text.

Atari versions of Superbase now accept '.gem' image files in addition to
the other file formats listed in the Atari appendix.

				S-55

5. KEY CONTROLS

MENU SELECTION
The '^' character represents the Ctrol key. Thus ^B indicates that you
should press Ctrl and the letter B at the same time. On the Amiga, the
right Amiga key is the equivalent of the Alt key used in GEM versions of
Superbase.

KEY COMBINATION		MENU OPTION

Alt/Amiga O		Project Open File
Alt/Amiga I		Project Open Index
Alt/Amiga C		Project Close Fields
Alt/Amiga N		Record New
Alt/Amiga E		Record Edit
Alt/Amiga B		Record Batch
Alt/Amiga S		Record Save
Alt/Amiga T		Set Table View
Alt/Amiga R		Set Record View
Alt/Amiga F		Set Form View
Alt/Amiga D		System Directory List
Alt/Amiga X		System Directory Change
Alt/Amiga Y		System Status File
Alt/Amiga Z		System Status System
Alt/Amiga L		System List
Alt/Amiga A		Program Command

RECORD SELECTION
These keys are the equivalents of the record selection buttons on the
control panel. They do not operate when a cursor for data or text input is
on screen.

KEY				RECORD SELECTION BUTTON

Cursor right arrow		Next record
Cursor left arrow		Previous record
Cursor up arrow			Current record/previous page in a form
Cursor down arrow		Current record/next page in a form
Shift up arrow (Amiga)		Rewind
Shift down arrow (Amiga)	Fast Forward
Space bar			Pause
Shift left arrow (Amiga)	First Record
Insert (Atari)			First Record
Shift right arrow (Amiga)	Last Record

				S-56

Clr Home (Atari)		Last Record
^C				Stop
?				Key Lookup
=				Filter
*				Camera

DATA ENTRY
These controls are used for editing the data you enter in fields and the
lines you enter in dialogs; e.g., filters, query command lines, formulas,
file and field names.

KEY/KEY COMBINATION		FUNCTION

Escape (Atari)		Clear line.
^X (Amiga)		Clears line.
Alt/Amiga U		Undoes last deletion.
Cursor right arrow	Moves the cursor one character to the right.
Cursor left arrow	Moves the cursor one character to the left.
Home (Atari)		Moves the cursor to the start of the line.
Shift left arrow (Amiga)Moves the cursor to the start of the line.
Insert (Atari)		Moves the cursor to the end of the line.
Shift right arrow (Amiga)
			Moves the cursor to the end of the line.
Del			Deletes character to the right of the cursor.
Backspace		Deletes character to the left of the cursor.
Tab			Moves the cursor eight characters to the right.
Shift Tab		Moves the cursor eight character to the left.
Return			Moves the cursor to the next field down or, on
			a form, to the next field in entry order.
Shift Return		Moves the cursor to the field above or, on a
			form, to the previous field in entry order.

TEXT AND PROGRAM EDITING

KEY/KEY COMBINATION		FUNCTION

Shift up arrow (Amiga)	Scrolls window up text or program by one full
			screen.
Shift down arrow (Amiga)Scrolls window down text or program by one
			full screen.
Cursor left arrow	Moves cursor to next character to the left.
Cursor right arrow	Moves cursor to next character to the right.
Cursor up arrow		Moves cursor to the character in the same
			column on the line above.

				S-57

Cursor down arrow	Moves the cursor to the character in the same
			column on the line below.
^B			Takes the cursor to the first line in the
			text/program.
^G			Takes the cursor to the last line in the
			text/program.
Shift left arrow (Amiga)
			Moves the cursor to the beginning of the
			current line.
Home (Atari)		Moves the cursor to the beginning of the
			current line.
Shift right cursor (Amiga)
			Moves the cursor to the end of the current line
Insert (Atari)		Moves the cursor to the end of the current line
Tab			Moves the cursor eight characters to the right.
Return			In Overwrite mode moves the cursor to the
			start of the next line.
Shift Tab		Moves the cursor eight characters to the left.
Backspace		Deletes the character to the left of the cursor
Del			Deletes the character to the right of the
			cursor.
^D			Deletes the current line.
^E			Deletes text from the cursor to the end of the
			line.
^X			Deletes all the text on the line leaving a
			blank line.
^U			Undoes the last deletion or insertion.
^N			Creates a new line below the cursor.
^S			Splits line at the point where the cursor is.
Return			Has same effect as ^S but in Insert mode only.
			Text Editor only.
^A			Closes up a line after it has been split.
^V			Toggles Insert and Overwrite modes on and off.
			Text Editor Only.
^L			Marks the current line for copying.
^R			Copies the line that has been marked by ^L, 
			inserting it below the cursor.
^F			Reformats paragraph to the current ruler 
			settings. Text Editor only.
Alt/Amiga P		Toggles the Plain type style on and off. Text
			Editor only.
Alt/Amiga B		Toggles Bold on and off. Text Editor only.
Alt/Amiga U		Toggles Underline on and off. Text Editor only.
Alt/Amiga I		Toggles Italic on and off. Text Editor only.
Alt/Amiga H		Displays the Help window.

				S-58

INDEX

& 1-54					E
					Editing Transactions 1-53
A					ENTER 1-17
ASCII delimited files			Export 1-9, 1-20
  Importing 1-5				   File types 1-9
Attributes 1-44
  Colour modes 1-44			F
  Border 1-45				Field borders 1-44
  Border Colour 1-45			Field names 1-44
  Currency format 1-44			Field options 1-44
					Field separators 1-7
B					File Conversion 1-6
BLANK 1-15				Formatting report output 1-46
Border 1-45
Border Colour 1-45			I
					Import 1-5, 1-23
C					  File Formats 1-5
CLOSE COMMS 1-34			Import file types 1-5
Colour modes 1-44
Comms 1-12				K
COMMS? 1-35				Key controls 1-56
COMMS COMMANDS 1-34			Keyboard equivalents 1-1, 1-56
COMMS FILE 1-36				
COMMS GET 1-35				L
COMMS INPUT 1-35			LOAD SET 1-25
COUNT 1-37				Logistix files 1-6
Currency format 1-44			Lookup 1-3
					Lotus files 1-6
D
Date format 1-55			M
dBase conversion 1-20			Mail Merge 1-11
Dbase files 1-5				  Blank lines 1-11
DIF files 1-6				  Program commands 1-11
Dir Change 1-43				  Programming 1-11
Dir List 1-43				  Variables 1-11
Draft printing 1-55

				INDEX-1

============================================================================
     DOCS PROVIDED BY RAP AND -+*+-THE SOUTHERN STAR-+*+- for M.A.A.D.                                                               
============================================================================

