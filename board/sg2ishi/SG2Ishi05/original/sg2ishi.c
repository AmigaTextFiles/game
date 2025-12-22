/**********************************************************************/
/*   Copyright  John  Unger,  all  rights  reserved.  Permission  is  */
/*   given  to  modify  and  distribute  this source code as long as  */
/*   proper  credit  is  given.  In using this software you agree to  */
/*   spirit   of  this  copyright.  No  guarantee  is  made  of  the  */
/*   correctness of this software, and it is used at your own risk.	 */
/**********************************************************************/

/*
sg2ishi, Version 0.5, 12/17/92
 ported to Amiga by Fabrizio "Lanch^DarkAge" Bartoloni
 added version string.
program to convert SmartGo (mgt) go files to Many Faces of Go files
*/
static char verstr[] = "$VER: sg2ishi 0.5 (16.10.99";
  
#include <stdio.h>
#include <ctype.h>
  
#define TRUE 1
#define FALSE 0
  
void main(argc, argv)
int argc;
char **argv;
{
    FILE *in_file, *out_file;
    int k;
    int j=1, i=1;
    int first=FALSE;
    int setboard=FALSE;
    char ch;
    char tok1, tok2;
    if (argc != 3)
    {
        fprintf(stderr,"\t\tTo use the program type:\n");
        fprintf(stderr,"\t\tsg2ishi in_file out_file\n");
        exit(0);
    }
  
    if ((in_file = fopen(argv[1], "rt")) == NULL)
    {
        fprintf(stderr,"%s is unable to open %s for input\n", argv[0], argv[1]);
        exit(0);
    }
    if ((out_file = fopen(argv[2], "wt")) == NULL)
    {
        fprintf(stderr, "%s is unable to open %s for output\n", argv[0], argv[2]);
        exit(0);
    }
  
    while((ch = fgetc(in_file)) != EOF)
    {
    	if (ch == '(')
    		fprintf(out_file,"EVENT %d\n", j++);
    		
        if (isupper(ch))
        {
            tok2 = ' ';
            if (first == TRUE)
            {
                tok2 = ch;
                first = FALSE;
                continue;
            }
            tok1 = ch;
            first = TRUE;
            continue;
        }
  
        if (ch == '[')
        {
            switch (tok1)
            {
                case 'A':
                {
                    if ((tok2 == 'B'))
                    {
                        fputs("SETUP B ", out_file);
                        
                        while((ch = fgetc(in_file)) != '\n')
                        {
                            if ((ch == '[') || (ch == ']'))
                                continue;
                            if (ch >= 'i')
                                ch++;
                            fputc(ch, out_file);
                            fprintf(out_file,"%d ",116-fgetc(in_file));
                        }
                        fputc('\n', out_file);
                    }
                    
                    else if ((tok2 == 'W'))
                    {
                        fputs("SETUP W ", out_file);
                        
                        while((ch = fgetc(in_file)) != '\n')
                        {
                            if ((ch == '[') || (ch == ']'))
                                continue;
                            if (ch >= 'i')
                                ch++;
                            fputc(ch, out_file);
                            fprintf(out_file,"%d ",116-fgetc(in_file));
                        }
                        fputc('\n', out_file);
                    }
                    break;
                }
  
                case 'B':
                {
                    if (tok2 == 'R')
                    {
                        fputs("COM Black's rank is ", out_file);
                        while((ch = fgetc(in_file)) != ']')
                            fputc(ch, out_file);
                        fputc('\n', out_file);
                        fputs("ENDCOM\n", out_file);
                        break;
                    }
                    
                    else if (tok2 == 'L')
                        continue;
                    
                    else
                    {
                        fprintf(out_file,"B %d ", i);
                        while((ch = fgetc(in_file)) != ']')
                        {
                            if (ch >= 'i')
                                ch++;
                            fputc(ch, out_file);
                            fprintf(out_file,"%d\n",116-fgetc(in_file));
                        }
                        i++;  /* increment move number */
                        break;
                    }
                }
  
                case 'C':
                {
                    fputs("COM\n", out_file);
                    while((ch = fgetc(in_file)) != ']')
                        fputc(ch, out_file);
                    fputc('\n', out_file);
                    fputs("ENDCOM\n", out_file);
                    break;
                }
  
                case 'D':
                {
                    if ((tok2 == 'T'))
                    {
                        fputs("DATE ", out_file);
                        while((ch = fgetc(in_file)) != ']')
                            fputc(ch, out_file);
                        fputc('\n', out_file);
                    }
                    break;
                }
  
                case 'E':
                {
                    fputs("COM\n", out_file);
                    while((ch = fgetc(in_file)) != ']')
                        fputc(ch, out_file);
                    fputc('\n', out_file);
                    fputs("ENDCOM\n", out_file);
                    break;
                }
  
                case 'K':
                {
                    if ((tok2 == 'M'))
                    {
                        fputs("KOMI ", out_file);
                        while((ch = fgetc(in_file)) != ']')
                            fputc(ch, out_file);
                        fputc('\n', out_file);
                    }
                    break;
                }
  
                case 'G':
                {
                    if (tok2 == 'N')
                    {
                        fputs("COM\n", out_file);
                        while((ch = fgetc(in_file)) != ']')
                            fputc(ch, out_file);
                        fputc('\n', out_file);
                        fputs("ENDCOM\n", out_file);
                        break;
                    }
                    else
                        break;
                }
  
                case 'L':
                {
                    fputs("MARK ", out_file);
                    k = 0;
                    
                    while((ch = fgetc(in_file)) != '\n')
                    {
                        if ((ch == '[') || (ch == ']'))
                            continue;
                        if (ch >= 'i')
                            ch++;
                        fputc(k+97, out_file);
                        fputc('@', out_file);
                        fputc(ch, out_file);
                        fprintf(out_file,"%d ",116-fgetc(in_file));
                        k++;
                    }
                    fputc('\n', out_file);
                    break;
                }
                    
                case 'M':
                {
                    fputs("MARK ", out_file);
                    
                    while((ch = fgetc(in_file)) != '\n')
                    {
                        if ((ch == '[') || (ch == ']'))
                            continue;
                        if (ch >= 'i')
                            ch++;
                        fputc('x', out_file);
                        fputc('@', out_file);
                        fputc(ch, out_file);
                        fprintf(out_file,"%d ",116-fgetc(in_file));
                    }
                    fputc('\n', out_file);
                    break;
                }
                    
                case 'N':
                {
                    fputs("COM\n", out_file);
                    while((ch = fgetc(in_file)) != ']')
                        fputc(ch, out_file);
                    fputc('\n', out_file);
                    fputs("ENDCOM\n", out_file);
                    break;
                }
  
                case 'P':
                {
                    switch (tok2)
                    {
                        case 'B':
                        {
                            fputs("BLACK ", out_file);
                            while((ch = fgetc(in_file)) != ']')
                                fputc(ch, out_file);
                            fputc('\n', out_file);
                            break;
                        }
  
                        case 'C':
                        {
                            fputs("PLACE ", out_file);
                            while((ch = fgetc(in_file)) != ']')
                                fputc(ch, out_file);
                            fputc('\n', out_file);
                            break;
                        }
  
                        case 'W':
                        {
                            fputs("WHITE ", out_file);
                            while((ch = fgetc(in_file)) != ']')
                                fputc(ch, out_file);
                            fputc('\n', out_file);
                            break;
                        }
                        default:
                            break;
                    } /* end switch */
                    break;
                }
  
                case 'R':
                {
                    if ((tok2 == 'E'))
                    {
                        fputs("RESULT ", out_file);
                        while((ch = fgetc(in_file)) != ']')
                            fputc(ch, out_file);
                        fputc('\n', out_file);
                    }
                    break;
                }
  
                case 'S':
                {
                    if ((tok2 == 'Z'))
                    {
                        fputs("BOARDSIZE ", out_file);
                        while((ch = fgetc(in_file)) != ']')
                            fputc(ch, out_file);
                        fputc('\n', out_file);
                        setboard = TRUE;
                    }
                    break;
                }
  
                case 'U':
                {
                    fputs("COM\n", out_file);
						  fputs("Game entered by: ", out_file);
                    while((ch = fgetc(in_file)) != ']')
                        fputc(ch, out_file);
                    fputc('\n', out_file);
                    fputs("ENDCOM\n", out_file);
                    break;
                }
  
                case 'W':
                {
                    if (tok2 == 'R')
                    {
                        fputs("COM White's rank is ", out_file);
                        while((ch = fgetc(in_file)) != ']')
                            fputc(ch, out_file);
                        fputc('\n', out_file);
                        fputs("ENDCOM\n", out_file);
                        break;
                    }
                    
                    else if (tok2 == 'L')
                        break;
                    
                    else
                    {
                        fprintf(out_file,"W %d ", i);
                        while((ch = fgetc(in_file)) != ']')
                        {
                            if (ch >= 'i')
                                ch++;
                            fputc(ch, out_file);
                            fprintf(out_file,"%d\n",116-fgetc(in_file));
                        }
                        i++; /* increment move number */
                        break;
                    }
                }
                default:
                    break;
                    
            } /* end switch */
  
            first = FALSE;
  
        } /* end if */
  
    } /* end while */
  
    if (!setboard)
    {
        fprintf(stderr,"The size of the board was not found in the input file\n");
        fprintf(stderr,"I am assuming that the game was played on a 19 x 19 board.\n\n");
    }
    fprintf(stderr,"I have successfully translated %s from Smart-Go format\n",argv[1]);
    fprintf(stderr,"to %s in Ishi Stardard format.\n", argv[2]);
    fclose(in_file);
	fclose(out_file);
}
