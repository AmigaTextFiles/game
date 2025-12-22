#include <stdio.h> /* fopen() */
#include <string.h> /* strcmp(), strcpy() */
#include <ctype.h> /* tolower() */ 


/*
   	Copyright (C) 2002 Thomas Martinsen   

        This program is free software; you can redistribute it and/or modify
        it under the terms of the GNU General Public License as published by
        the Free Software Foundation; either version 2 of the License, or
        (at your option) any later version.

        This program is distributed in the hope that it will be useful,
        but WITHOUT ANY WARRANTY; without even the implied warranty of
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
        GNU General Public License for more details.

        You should have received a copy of the GNU General Public License
        along with this program; if not, write to the Free Software
        Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/


/* #include <stdlib.h> */
/* int system( const char *command ); */

char lang_q[100] = "english";
char lang_q_current[100] = "english";
    int counter = 0;
    int correct = 0;
    int failed = 0;
    int state = 0;


int loadcf() {

char cfline[100];
char *c;
char lang_q_test[100] = "lang_q";
char yestest[100] = "yes";
char notest[100] = "no";
char lang_q_enabled[100];

FILE *cf;
cf = fopen(".xquiz.cf","r");
if (cf == NULL) { 
cf = fopen("xquiz.cf.txt","w");
fprintf(cf,"lang\n");
fprintf(cf,"english");
}
    do {


        c = fgets(cfline,100,cf);
	if (c != NULL) {
 if (c[strlen(c)-1] == '\n') c[strlen(c)-1] = 0; // remove trailing newline

        if (strcmp(lang_q_enabled,yestest) == 0) {
	strcpy(lang_q,cfline); 
	strcpy(lang_q_enabled,"no");
       }


	if (strcmp(cfline,lang_q_test) == 0) {
	strcpy(lang_q_enabled,"yes");
	continue;
	}
	
}
}
while (c != NULL);


}

int save() {
FILE *fp;
/* counter++; */

fp = fopen("xquiz.sv","w");
if (fp == NULL) { printf("Could not write to save file, Changes isnt saved\n"); return 0; }
fprintf(fp,"%d\n",correct);
fprintf(fp,"%d\n",failed);
fprintf(fp,"%d\n",counter);
/* counter--; */
fclose(fp);
return 0;
}


int main(int argc,char **argv) {

char question[100];
char answer[100];
char correctanswer[100];
char youranswer[100];
char lastanswer[100] = "nope";
char questiontest[100] = "question";
char answertest[100] = "answer";
char lastanswertest[100] = "lastanswer";
char correctanswertest[100] = "correctanswer";
char disableanswers[100];
char disableanswersno[100] = "no";
char lang_test[100] = "lang";
char lang_q_enabled[100];
char lang_q_yes[100];

char *ptr11;
char *ptr12;
char *ptr21;
char *ptr22;
char *ptr31;
char *ptr32;
char *curcwd;
char oneword[1000];
char *c;

FILE *fp1;
FILE *readf;
FILE *svreset;





loadcf();

printf("XQuiz 1.2, Copyright (C) 2002 Thomas Martinsen\n");
printf("XQuiz comes with ABSOLUTELY NO WARRANTY,\n");
printf("This is free software, and you are welcome\n");
printf("to redistribute it under certain conditions.\n");
printf("Read LICENSE for details.\n"); 
printf("http://xquiz.cjb.net\n");
printf("tech@navn.no\n\n");


readf = fopen("xquiz.sv","r");
if (readf == NULL) {  }
else fscanf(readf, "%d\n%d\n%d", &correct, &failed, &state);


    /* list the lines in the question file */

    
   if(argc>1) { fp1 = fopen(argv[1],"r"); } 
    else fp1 = fopen("xquiz.db.txt","r");
    if (fp1 == NULL) { printf("Couldnt read the database file (xquiz.db), remember this shall be in your current directory.\n"); return 0; }
    do {
 

        c = fgets(oneword,100,fp1);
        if (c != NULL) {
	if (counter++ < state) { continue; }

			if (c[strlen(c)-1] == '\n') c[strlen(c)-1] = 0; // remove trailing newline
	 

            /* check if the line contains "lang", wich mean the next line is a answer */
            if (strcmp(oneword,lang_test) == 0) {
        strcpy(lang_q_enabled,lang_q_yes);
        continue;
        }


	if(strcmp(lang_q_enabled,lang_q_yes) == 0) {
	strcpy(lang_q_current,oneword);
 	strcpy(lang_q_enabled,"no");
	continue;
	}

	if (strcmp(lang_q_current,lang_q) != 0) { continue; }

		/* check if the line contains lastanswercheck, wich its the last answer */
            cont: if (strcmp(lastanswer,lastanswertest) == 0) {
                /*  if (lastanswer == lastanswercheck) { */



              /* remove variables */
		strcpy(question,"nope");
                strcpy(answer,"nope");
                strcpy(lastanswer,"nope");


                if (strcmp(correctanswer,correctanswertest) == 0) {

                    continue;
                }

                /* if the users answer match with this line, do this */


                for(ptr11 = youranswer; *ptr11; ptr11++) *ptr11 = tolower(*ptr11);
                for(ptr12 = oneword; *ptr12; ptr12++) *ptr12 = tolower(*ptr12);

                if (strcmp(oneword,youranswer) == 0) {

                    /* correctanswer[100] = correctanswercheck[100]; */
                    printf("Correct!\n");
                    correct ++;
                    printf("Correct Answers: %d | Failed: %d\n\n", correct, failed);
                    /*
                    ofstream savewrite("quizzie.save");
                    savewrite << correct << "\n";
                    savewrite << failed << "\n";
                    savewrite.close();
                    */
		    save();
                }


                /* if not the user has failed, since this is the _last answer_ */

                for(ptr21 = youranswer; *ptr21; ptr21++) *ptr21 = tolower(*ptr21);
                for(ptr22 = oneword; *ptr22; ptr22++) *ptr22 = tolower(*ptr22);

                if (strcmp(oneword,youranswer) != 0) {

                    printf("You failed!\n");
                    failed ++;
                    printf("Correct Answers: %d | Failed: %d\n\n", correct, failed);
                    /*
                    ofstream savewrite("quizzie.save");
                    savewrite << correct << "\n";
                    savewrite << failed << "\n";
                    savewrite.close();
                    */
		    save();
                }

               /* remove all variables */
                strcpy(question,"nope");
                strcpy(answer,"nope");
                strcpy(lastanswer,"nope");


                /* goto next line */
                continue;

            }


            /* check if its a question */
            if (strcmp(question,questiontest) == 0) {



                /* if (question == "question") { */

                /* remove variables */

                strcpy(question,"nope");
                strcpy(answer,"nope");
                strcpy(lastanswer,"nope");
		strcpy(correctanswer,"nope");


                /*question[100] = disable[100];
                answer[100] = disable[100];
                lastanswer[100] = disable[100];
                correctanswer[100] = disable[100];*/

                /* print out question */
                printf("%s\n", oneword);

                /* asks for answer */
                printf("Enter answer: ");
		fgets(youranswer,100,stdin);
		if (youranswer[strlen(youranswer)-1] == '\n') youranswer[strlen(youranswer)-1] = 0;
                /* goto next line */
                continue;
            }

            /* check if its a answer */
            if (strcmp(answer,answertest) == 0) {



                /*  if (answer == answercheck) { */

                /* remove all variables */
                strcpy(question,"nope");
                strcpy(answer,"nope");
                strcpy(lastanswer,"nope");

                /* if the user has already answered corect, goto next line */
                if (strcmp(correctanswer,correctanswertest) == 0) {

                    /*	if (correctanswer == correctanswercheck) { */
                    continue;
                }

                /* if the users answer match with this line, do this */

                for(ptr31 = youranswer; *ptr31; ptr31++) *ptr31 = tolower(*ptr31);
                for(ptr32 = oneword; *ptr32; ptr32++) *ptr32 = tolower(*ptr32);

                if (strcmp(oneword,youranswer) == 0) {
		strcpy(correctanswer,"correctanswer");
                    /* correctanswer[100] = correctanswercheck[100]; */
                    printf("Correct!\n");
                    correct ++;
                    printf("Correct Answers: %d | Failed: %d\n\n", correct, failed);
                    /*
                    ofstream savewrite("quizzie.save");
                    savewrite << correct << "\n";
                    savewrite << failed << "\n";
                    savewrite.close();
                    */
		    save();
                }

                /* remove some variables */
                strcpy(question,"nope");
                strcpy(answer,"nope");
                strcpy(lastanswer,"nope");


                /* then goto next line */
                continue;
            }

            /* check if the line contains "question", wich mean the next line is a question */
		if(strcmp(oneword, questiontest) == 0) {
		strcpy(question,"question");
                /* question[100] = questioncheck[100]; */

                /* goto next line */
                continue;
            }



            /* check if the line contains "answer", wich mean the next line is a answer */
            if (strcmp(oneword,answertest) == 0) {

                /*	if (oneword == answercheck) { */
		strcpy(answer,"answer");
                /* answer[100] = answercheck[100]; */

                /* goto next line */
                continue;
            }

            /* check if the line contains lastanswercheck[100], wich mean the next line is the _last answer_ */
            if (strcmp(oneword,lastanswertest) == 0) {

                /* if (oneword == lastanswercheck) { */
		strcpy(lastanswer,"lastanswer");
            }

        }

    }

    while (c != NULL);

svreset = fopen("xquiz.sv","w");
if (svreset == NULL) { printf("Could not save save file, Changes isnt saved"); return 0; }
fprintf(svreset,"%d\n%d\n0\n", counter, failed);
fclose(svreset);

    fclose(fp1);


return 0;
}
