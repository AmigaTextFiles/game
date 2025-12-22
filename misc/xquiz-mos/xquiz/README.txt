XQuiz 1.2 README

- News: -
You can specify question database,
like this:
./xquiz yourdb.db
You can specify what language to use! See longer down.
Important bugfix, you couldnt type more than one word in 1.1 (1.1, not 1.1 cvs).

- How to compile, install, and run: -
Thanks for downloading this nice program.
Just run make.
and run ./xquiz.
If you want xquiz global, run make install,
but remember, xquiz will still look after xquiz.db in the CURRENT directory.
And put the questions in xquiz.db.

- The syntax of the database file: -
As you may have seen, this is a quiz game.
And you can add your own questions.
This should be in the following syntax:
lang
english
question
What kind of game is this?
answer
Quiz
lastanswer XQuiz
question
Who am i?
lastanswer me

In this example the program will ask "What kind of game is this?",
and correct answers is "Quiz" (not case sensitive) and "XQuiz".
Then it will ask "Who am i?" and the correct answer is "me".
And it will only print the question if english is specified in .xquiz.cf.
(You dont need lang)

I know its bit difficuilt to understand this syntax,
if you dont please mail me and ill try to explain.

The example database is included.

- Language: -
In .xquiz.cf (home directory) put what langauge you want to use, like:
lang_q
english

In the database file (xquiz.db) put what langauge the question is, like:
lang english

Questions will only be asked if the language in the config file and question database
match.

- Thanks to: -
psychoid@ircnet, for helping me.
edison@efnet, for fixing an bug for me.
justice_@efnet, for finding an bug for me.
#c@efnet, for a lot of help
Steven@ircnet, for helping me.
perry@efnet, for the idea about multilanguage support.

- Help: -
If you need help please mail or contact me at IRC.
Join #NetCafe @ EFnet for help, ask on the chan,
if no one answers you, ask later, or mail me.


-------


Please mail me if you have any comment to this.

Thomas Martinsen aka tech
http://home.no/tch/projects/
tech@navn.no

Copyright (C) 2002 Thomas Martinsen
Read LICENSE for details.
