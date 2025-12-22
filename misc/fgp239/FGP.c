/****************************************
 * Fantasy Grand Prix $Revision: 2.39 $ *
 *   © 1994 Simon Austin                *
 ****************************************/

/* $Id: FGP.c,v 2.39 1995/07/12 21:25:00 simon Exp simon $ */

/* Includes */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include "FGP.h"

/* Variables */

/* Amiga versions string. Type "version FGP" to find the current version
   of FGP in use */
const char *ver = "$VER: FGP © S Austin $Revision: 2.39 $";

/* Lines to be output as appropriate */
const char *verst = "FGP2 by S Austin, additional design by J Simpson.\n$Revision: 2.39 $ $Date: 1995/07/12 21:25:00 $.\n";

/* The "how to use FGP" error strings */
const char *errs1 = "Usage: ";
const char *errs2 = " <[-r[n]] [-t[n]] [-d[n]] [-c[n]] [-s[n]] [filename]>\n";

/* Points for positions 1-6 */
const int  points[] = { 0, 10, 6, 4, 3, 2, 1 }; 

/* File pointer for scores.fgp2 */
FILE *scores_file;

/* And the actual name (dependant on system) */
#ifndef MSDOS
char *scores_name = "scores.fgp2";
#endif

#ifdef MSDOS
char *scores_name = "scores.fgp";
#endif

/* Strings to store the teams' names and owners, the names of the drivers,
   chassis, engines and races. */
char owner[MAXTEAM][100], teamname[MAXTEAM][100], name[DRIVERS][100],
     first[DRIVERS][100], chassisn[CHASSIS][100], enginen[ENGINES][100];

/* Costs for chassis, engines and drivers */
int  chassisc[CHASSIS], enginec[ENGINES], namec[DRIVERS];

/* Team details */
int  driver1[MAXTEAM], driver2[MAXTEAM], driver3[MAXTEAM], 
     chassis[MAXTEAM], engine[MAXTEAM], scores[MAXTEAM], thisrce[MAXTEAM]; 

/* Race details */
int  grid[DRIVERS], position[DRIVERS], status[DRIVERS], warmup[DRIVERS]; 

/* Scores */
int  topsixpts[DRIVERS], awardpts[DRIVERS], incgridpts[DRIVERS],
     warmuppts[DRIVERS], racesc[DRIVERS], retirepts[DRIVERS],
     noqualpts[DRIVERS], carscr[CHASSIS], engscr[ENGINES],
     carpts[DRIVERS], engpts[DRIVERS]; 

/* Used to keep track of whose driving what */
int  drcar[DRIVERS], dreng[DRIVERS];

/* The current number of teams, drivers and races */
int  nteams, ndrivers, nraces;

/* The total number of competing drivers, chassis and engines */
int  maxdrivers, maxchassis, maxengines;

/* The line we are currently reading in any particular file */
int  line_no;

/* Used to store what the user has called FGP */
char *ranwith;

/* File pointers for the files to be used */
FILE *data_file, *teams_file, *drivers_file, *old_scores,
     *chassis_file, *engine_file; 

/* String to store the name of the data file */
char data_name[256];

/* Flags */
int  eflags[ENGINES], cflags[CHASSIS];
  
/* Used in producing and re-reading scores files */
int  exists_flag, racedrivers, old_grid, old_car, old_eng;

/* Used in calculating scores */
int  pos, point, totwarm, filled, end, warm;

/* The finishing state and whether a driver was nominated */
char state, nom;

/* Flags for which output the user wants */
int  teams, normal, drive, cars, spread;

/* Flag used in testing a team's legality */
int  team_legal;

/* Used in sorting the results */
int  whichcar[DRIVERS], whicheng[DRIVERS]; 
int  nominated, last; 

int  cartot[CHASSIS], engtot[ENGINES];  
int  sflags[MAXTEAM];
int  totalsc[DRIVERS];
int  sp_pos[MAXTEAM][MAXRACE]; 
int  teamscores[MAXTEAM][MAXRACE];
int  driverscore[DRIVERS][MAXRACE], drivertotal[DRIVERS];
int  carrun[CHASSIS][MAXRACE], engrun[ENGINES][MAXRACE];
char racenames[MAXRACE][100];

/* Depending on which system is in use, the hard coded filenames to use */
#ifndef MSDOS
char *teams_name = "teams.fgp2", *drivers_name = "drivers.fgp2", 
     *chassis_name = "chassis.fgp2", *engine_name = "engine.fgp2", 
     *temp_name = ".tempscores";
#endif

#ifdef MSDOS
char *teams_name = "teams.fgp", *drivers_name = "drivers.fgp", 
     *chassis_name = "chassis.fgp", *engine_name = "engine.fgp", 
     *temp_name = "fgpscore.tmp";
#endif

void disperr(char *);
void errorinfile(char *, char *, int);
void doubleerror(char *, char *, char *, int);
int strcasencmp(char *, char *, int);
int driver2no(char *);
int chassis2no(char *);
int engine2no(char *);
void capitalise(char *);
unsigned int readline(char *, int, FILE *);
void cleararrays(void);
FILE *openfile(char *, char *);
int checkinput(char *, int);
int teamcost(int, int, int, int, int);
void raceoutput(void);
void teamoutput(void);
void drivoutput(void);
void carsoutput(void);
void sprdoutput(void);
  
int main(int argc, char *argv[])
{ 
  /* store is a temporary input buffer and racename the name of the race
     as given in the data file  */
  char store[100], racename[100];

  /* racecheck is used when overwriting a previous scores file */
  char racecheck[100];
  
  /* Loop variables */
  register int i, j, k;

  ranwith = argv[0];

  if(argc < 2 || argc > 7)
  { 
    /* Incorrect command line, display message and quit */
    fputs(verst, stderr);
    fputs(errs1, stderr);
    fputs(argv[0], stderr);
    fputs(errs2, stderr);
    exit(0);
  }
  else
  {   
    /* clear output flags */
    normal = 255;
    teams = 255;
    drive = 255;
    cars = 255;
    spread = 255;
    
    strcpy(data_name, "no_name");
    
    for(i = 1; i < argc; i+=1)
    {
      if(!strcasencmp(argv[i], "-r", 2))
        normal = checkinput(argv[i], normal);
      else if(!strcasencmp(argv[i], "-t", 2))
        teams = checkinput(argv[i], teams);
      else if(!strcasencmp(argv[i], "-d", 2))
        drive = checkinput(argv[i], drive);
      else if(!strcasencmp(argv[i], "-c", 2))
        cars = checkinput(argv[i], cars);
      else if(!strcasencmp(argv[i], "-s", 2))
        spread = checkinput(argv[i], spread);
      else
      {
        if(!strcmp(data_name, "no_name"))
        {
          /* Set data filename */
          strcpy(data_name, argv[i]);
        }
        else
        {
          /* Incorrect command line, display message and quit */
          fputs(verst, stderr);
          fputs(errs1, stderr);
          fputs(ranwith, stderr);
          fputs(errs2, stderr);
          exit(0);
        }
      }
    }  
  }

  cleararrays();

  for(i = 0; i <= MAXTEAM; i+=1)
  {
    scores[i] = 0;
  }

  /* Read in chassis names */
  chassis_file = openfile(chassis_name, "r");
  line_no = 0;
  
  i=1;
  readline(store, INLEN, chassis_file);
  while(i < CHASSIS && !feof(chassis_file))
  {
    strcpy(chassisn[i], store);
    readline(store, INLEN, chassis_file);
    chassisc[i] = atoi(store);
    readline(store, INLEN, chassis_file);
    i+=1;
  }
  maxchassis = i-1;
  
  fclose(chassis_file);
  
  /* Read in engines names */
  engine_file = openfile(engine_name, "r");
  line_no = 0;
  
  i=1;
  readline(store, INLEN, engine_file);
  while(i < ENGINES && !feof(engine_file))
  {
    strcpy(enginen[i], store);
    readline(store, INLEN, engine_file);
    enginec[i] = atoi(store);
    readline(store, INLEN, engine_file);
    i+=1;
  }
  maxengines = i-1;

  fclose(engine_file);

  /* Read in driver details */
  drivers_file = openfile(drivers_name, "r");
  line_no = 0;
  
  i=1;
  readline(store, INLEN, drivers_file);
  while(i <= DRIVERS && !feof(drivers_file))
  {
    strcpy(name[i], store);
    readline(store, INLEN, drivers_file);
    strcpy(first[i], store);
    readline(store, INLEN, drivers_file);
    whichcar[i] = chassis2no(store);
    if(whichcar[i] == 0)
    {
      doubleerror(drivers_name, "Unknown chassis", store, line_no);
      fclose(drivers_file);
      exit(0);
    }
    readline(store, INLEN, drivers_file);
    whicheng[i] = engine2no(store);
    if(whicheng[i] == 0)
    {
      doubleerror(drivers_name, "Unknown engine", store, line_no);
      fclose(drivers_file);
      exit(0);
    }
    readline(store, INLEN, drivers_file);
    namec[i] = atoi(store);
    readline(store, INLEN, drivers_file);
    i+=1;
  }
  maxdrivers = i-1;
  
  fclose(drivers_file);
    
  /* Open teams.fgp2 */
  teams_file = openfile(teams_name, "r");
  line_no = 0;

  /* Get the number of teams competing */
  readline(store, INLEN, teams_file);
  nteams = atoi(store);

  for(i = 1; i < nteams + 1; i+=1)
  {
    readline(store, INLEN, teams_file); 
    strcpy(owner[i], store);
    readline(store, INLEN, teams_file);
    strcpy(teamname[i], store);
    readline(store, INLEN, teams_file);
    driver1[i] = driver2no(store);
    if(driver1[i] == 0)
    {
      doubleerror(teams_name, "Unknown driver", store, line_no);
      fclose(teams_file);
      exit(0);
    }
    readline(store, INLEN, teams_file);
    driver2[i] = driver2no(store);
    if(driver2[i] == 0)
    {
      doubleerror(teams_name, "Unknown driver", store, line_no);
      fclose(teams_file);
      exit(0);
    }
    readline(store, INLEN, teams_file);
    driver3[i] = driver2no(store);
    if(driver3[i] == 0)
    {
      doubleerror(teams_name, "Unknown driver", store, line_no);
      fclose(teams_file);
      exit(0);
    }
    readline(store, INLEN, teams_file);
    chassis[i] = chassis2no(store);
    if(chassis[i] == 0)
    {
      doubleerror(teams_name, "Unknown chassis", store, line_no);
      fclose(teams_file);
      exit(0);
    }
    readline(store, INLEN, teams_file);
    engine[i] = engine2no(store);
    if(engine[i] == 0)
    {
      doubleerror(teams_name, "Unknown engine", store, line_no);
      fclose(teams_file);
      exit(0);
    }
  }

  fclose(teams_file);

  /* Check that all teams are legal... */
  team_legal = 0;
  for(i = 1; i <= nteams; i+=1)
  {
    if(teamcost(driver1[i], driver2[i], driver3[i], chassis[i], engine[i]) > 30)
    {
      printf("%s owned by %s costs over œ30m.\n", teamname[i], owner[i]);
      team_legal = 1;
    }
    if(namec[driver3[i]] != 1)
    {
      printf("%s owned by %s has an illegal test driver.\n", teamname[i], owner[i]);
      team_legal = 1;
    }
  }
  
  if(team_legal > 0)
  {
    exit(0);
  }

  if(strcmp(data_name, "no_name") != 0)
  {
    /* Get details from data file */
    data_file = openfile(data_name, "r");
    line_no = 0;
    /* read in name of race */
    readline(racename, INLEN, data_file);

    i = 0;
    totwarm = 0;
    nominated = 0;
    readline(store, INLEN, data_file);
    
    if(driver2no(racename) != 0 && driver2no(store) == 0)
    {
      errorinfile(data_name, "The race's name is missing", line_no-1);
      exit(0);
    }

    do
    {
      i+=1;
      grid[i] = driver2no(store);
      if(grid[i] == 0)
      {
        doubleerror(data_name, "Unknown driver", store, line_no);
        exit(0);
      }
      drcar[i] = whichcar[grid[i]];
      dreng[i] = whicheng[grid[i]];
     
      /* Check finished/retired/DNQ/dis-qualified flag */
      readline(store, INLEN, data_file);
      sscanf(store, "%c %d %d %c", &state, &end, &warm, &nom);
     
      state = tolower(state);
      status[i] = 5;
      if(state == 'd')
        status[i] = 0;
      if(state == 'f')
        status[i] = 1;
      if(state == 'r')
        status[i] = 2;
      if(state == 'n')
        status[i] = 3;
      if(state == 't')
        status[i] = 4;
      if(status[i] == 5)
      {
        errorinfile(data_name, "Flag not one of FRDNT", line_no);
        exit(0);
      }
  
      /* Get final position */
      if(end < 0 || end > 26)
      {
        errorinfile(data_name, "Illegal finishing position", line_no);
        exit(0);
      }
      position[i] = end;
      if(status[i] >= 0 && status[i] <= 2 && position[i] == 0)
      {
        errorinfile(data_name, "Illegal finishing position", line_no);
        exit(0);
      }
      if(i > 1)
        for(k = 1; k < i; k+=1)
          if(position[k] == end && end != 0)
          {
            errorinfile(data_name, "Final position already allocated", line_no);
            exit(0);
          }
  
      /* Warmup positions */
      if(warm < 0 || warm > 26)
      {
        errorinfile(data_name, "Illegal warmup position", line_no);
        exit(0);
      }
      warmup[i] = warm;
      if(warm != 0 && status[i] != 0)
        totwarm+=1;
              
      if(nom == '+')
      {
        if(nom == '+' && nominated == 0)
          nominated = grid[i];
        else
        {
          errorinfile(data_name, "Too many nominated drivers", line_no);
          exit(0);
        }
        nom = '-';
      }
      
      readline(store, INLEN, data_file);
      
    }
    while(!feof(data_file));
  
    ndrivers = i;
    fclose(data_file);

    /* find position of last driver (usually 26) */
    last = 0;
    for(i = 1; i < ndrivers+1; i+=1)
      if(status[i] == 2)       /* if a driver retired */
        if(position[i] > last) /* and has the highest position number */
          last = position[i];  /* then he was in last place */
    
    filled = 0;
    for(i = 1; i < ndrivers+1; i+=1)
    {
      if(position[i] <= last && (status[i] >= 0 && status[i] <= 2))
        filled+=1;
    }
    if(filled != last)
    {
      fputs(verst, stderr);
      fputs("Error in file \"", stderr);
      fputs(data_name, stderr);
      fputs("\". Unallocated result.\n", stderr);
      exit(0);
    }
     
    /* make sure that a maximum of six drivers score in the warmup */
    if(totwarm > 6)
      totwarm = 6;
  
    /* clear scores */
    for(i = 0; i < DRIVERS; i+=1)
    {
      topsixpts[i] = 0;
      awardpts[i] = 0;
      incgridpts[i] = 0;
      warmuppts[i] = 0;
      retirepts[i] = 0;
      noqualpts[i] = 0;
      racesc[i] = 0;
    }
  
    /* points for finishing in top six */
    k = 1;
    pos = 1;
    point = 1;
    do
    {
      while(position[k] != point)
        k = k + 1;
      if(status[k] == 1)
      {
        topsixpts[grid[k]] = 10 + points[pos];
        pos+=1;
      }
      point+=1;
      k = 1;
    }
    while(pos < 7 && point <= ndrivers);

    /* points for increasing on grid position */
    for(i = 1; i < ndrivers+1; i+=1) /* look through grid... */
      if(status[i] == 1)             /* ...for drivers who finish... */
        if(position[i] < i)          /* ...and beat their grid position */
          incgridpts[grid[i]] = (i-position[i]);

    /* adjust grid position increase due to disqualifications */
    for(i = 1; i < ndrivers+1; i+=1)    /* check all drivers for... */
      if(status[i] == 0)                /* ...disqualification and... */
        for(j = 1; j <ndrivers+1; j+=1) /* ...adjust the scores of... */
          if(position[j] > position[i] && status[j] == 1 && position[j] <= j)
            incgridpts[grid[j]]+=1;     /* ...those who finish after them */
  
    /* nominated driver points */
    awardpts[nominated] = 5;

    /* points for first 6 places in Sunday warmup */
    pos = 1;
    point = 1;
    i = 1;
    do
    {
      while(warmup[i] != point) 
        i+=1; /* if a driver came at position 'point' in the warmup */
      if(status[i] == 1 || status[i] == 2 || status[i] == 4) /* and was not disqualified */
      {
        warmuppts[grid[i]] = 7 - pos;
        pos+=1;
      }
      point+=1;
      i = 1;
    }
    while(pos < totwarm+1 && point <= ndrivers);
 
    /* points for first 5 to retire */
    for(i = 1; i < ndrivers+1; i+=1)
    {
      if(status[i] == 2)
      {
        if(position[i] == last)
          retirepts[grid[i]] = 5;
        if(position[i] == last-1)
          retirepts[grid[i]] = 4;
        if(position[i] == last-2)
          retirepts[grid[i]] = 3;
        if(position[i] == last-3)
          retirepts[grid[i]] = 2;
        if(position[i] == last-4)
          retirepts[grid[i]] = 1;
      }
    }

    /* points for non-qualification */
    for(i = 1; i < ndrivers+1; i+=1)
      if(status[i] == 3)
        noqualpts[grid[i]] = 5;
      
    /* move non-starters & non-qualifiers to end of results */
    pos = last+1;
    for(i = 1; i < ndrivers+1; i+=1)
    {
      if(status[i] == 3 || status[i] == 4)
      {
        position[i] = pos;
        pos+=1;
      }
    }
  
    /* reset chassis/engine flags/scores */
    for(i = 0; i < ENGINES; i+=1)
    {
      eflags[i] = 0;  
      engscr[i] = 0;
    }

    for(i = 0; i < CHASSIS; i+=1)
    {
      cflags[i] = 0;
      carscr[i] = 0;  
    }
  
    for(i = 0; i < DRIVERS; i+=1)
    {
      carpts[i] = 0;
      engpts[i] = 0;
    }
  
    pos = 1;
    point = 1;
    i = 1;
    do
    {
      while(position[i] != point)
        i+=1; /* find driver who finished in position 'point' */
      if(cflags[drcar[i]] == 0 && status[i] == 1)
      {
        /* if car hasn't already scored and driver did finish award points */
        carpts[i] = points[pos]+10;            /* Version 2 rules */
        carscr[drcar[i]] += points[pos]+10;    /* Version 2 rules */
        cflags[drcar[i]] = 1;
        pos+=1;
      }
    point+=1;
      i = 1;
    }
    while( pos < 7 && point <= ndrivers);

    pos = 1;
    point = 1;
    i = 1;
    do
    {
      while(position[i] != point)
        i+=1;
      if(eflags[dreng[i]] == 0 && status[i] == 1)
      {
        engpts[i] = points[pos]+10;            /* Version 2 rules */
        engscr[dreng[i]] += points[pos]+10;    /* Version 2 rules */
        eflags[dreng[i]] = 1;
        pos+=1;
      }
      point+=1;
      i = 1;
    }
    while( pos < 7 && point <= ndrivers);

    /* reset chassis flags */
    for(i = 0; i < CHASSIS; i+=1)
    {  
      cflags[i] = 0;
    }

    pos = last;
    point = last;
    i = 1;
    do
    {
      while(position[i] != point)
        i+=1;
      if(cflags[drcar[i]] == 0 && status[i] == 2)
      {
        carpts[i] = -(pos-(last-5));
        carscr[drcar[i]] -= (pos-(last-5));
        cflags[drcar[i]] = 1;
        pos-=1;
      }
      point-=1;
      i = 1;
    }
    while(pos > last-5 && point > 0);

    scores_file = fopen(scores_name, "r");
    if(scores_file == 0)
    {
      /* No scores file: assume start of season and */
      /* create the scores file for writing */
      scores_file = openfile(scores_name, "w");
      exists_flag = 0;
    } 
    else 
    {
      /* if it does exists, open a temporary file to move the scores to */
      fclose(scores_file);
      scores_file = openfile(temp_name, "w");
      exists_flag = 1;
      old_scores = openfile(scores_name, "r");
    
      /* get the original scores and move them to the temp file until we
         find a race with the same name or the end of the file */
      readline(racecheck, INLEN, old_scores);
    
      while(strcasencmp(racecheck, racename, 6) && !feof(old_scores))
      {
        readline(store, INLEN, old_scores);
        racedrivers = atoi(store);
        fprintf(scores_file, "%s\n", racecheck);
        fprintf(scores_file, "%d\n", racedrivers);
        for(i = 1; i <= racedrivers; i+=1)
        {
          fgets(store, INLEN, old_scores);
          fputs(store, scores_file);
        }
        readline(racecheck, INLEN, old_scores);
      }
    
      if(!feof(old_scores))
      {
        /* If we haven't reached the end-of-file compare the old results
           with the new results */
        readline(store, INLEN, old_scores);
        racedrivers = atoi(store);
        for(i = 1; i <= racedrivers; i+=1)
        {
          fscanf(old_scores, "%d %d %d", &old_grid, &old_car, &old_eng);
          readline(store, INLEN, old_scores);
          if(old_car != whichcar[old_grid])
          {
            /* a driver had a different car before - send a non-fatal
               message explaining this */
            printf("** %s's car has changed from %s to %s.\n", 
              name[old_grid], chassisn[old_car], 
              chassisn[whichcar[old_grid]]);
          }
          if(old_eng != whicheng[old_grid])
          {
            printf("** %s's engine has changed from %s to %s.\n", 
              name[old_grid], enginen[old_eng], 
              enginen[whicheng[old_grid]]);
          }
        }
      }
    }
  
    /* put the new scores in the correct file */
    fprintf(scores_file, "%s\n", racename);
    fprintf(scores_file, "%d\n", ndrivers);
    for(i = 1; i <= ndrivers; i+=1)
    {
      fprintf(scores_file, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\n",
        grid[i], drcar[i], dreng[i], position[i], status[i], 
        topsixpts[grid[i]], awardpts[grid[i]], incgridpts[grid[i]],
        warmuppts[grid[i]], retirepts[grid[i]], noqualpts[grid[i]],
        carpts[i], carscr[drcar[i]], engpts[i], engscr[dreng[i]]);
    }

    if(exists_flag == 1)
    {
      readline(racecheck, INLEN, old_scores);
      while(!feof(old_scores))
      {
        fprintf(scores_file, "%s\n", racecheck);
        readline(store, INLEN, old_scores);
        racedrivers = atoi(store);
        fprintf(scores_file, "%d\n", racedrivers);
        for(i = 1; i <= racedrivers; i+=1)
        {
          fgets(store, INLEN, old_scores);
          fputs(store, scores_file);
        }
        readline(racecheck, INLEN, old_scores);
      }
      fclose(old_scores);
      if(unlink(scores_name) == -1)
      {
        fputs("Unable to delete \"",stderr);
        fputs(scores_name, stderr);
        fputs("\".\n", stderr);
        exit(0);
      }
    }
  
    fclose(scores_file);
  
    if(exists_flag == 1)
      if(rename(temp_name, scores_name) == -1)
      {
        fputs("Unable to rename \"", stderr);
        fputs(temp_name, stderr);
        fputs("\".\n", stderr);
        exit(0);
      }
  }
 
  if(normal != 255)
    raceoutput();

  if(teams != 255)
    teamoutput();

  if(drive != 255)
    drivoutput();

  if(cars != 255)
    carsoutput();

  if(spread != 255)
    sprdoutput();
  
  return(0);
}

void disperr(char *file_name)
{
  fputs(verst, stderr);
  fputs("Unable to open \"", stderr);
  fputs(file_name, stderr);
  fputs("\".\n", stderr);
  return;
}

void errorinfile(char *file_name, char *error, int line)
{
  fputs(verst, stderr);
  fputs("Error in file \"", stderr);
  fputs(file_name, stderr);
  fputs("\" on line ", stderr);
  fprintf(stderr, "%d", line);
  fputs(". ", stderr);
  fputs(error, stderr);
  fputs(".\n", stderr);
  return;
}  

void doubleerror(char *file_name, char *error, char *problem, int line)
{
  fputs(verst, stderr);
  fputs("Error in file \"", stderr);
  fputs(file_name, stderr);
  fputs("\" on line ", stderr);
  fprintf(stderr, "%d", line);
  fputs(". ", stderr);
  fputs(error, stderr);
  fputs(" \"", stderr);
  fputs(problem, stderr);
  fputs("\".\n", stderr);
  return;
}  

int strcasencmp(char *stringa, char *stringb, int testnum)
{
  register unsigned int n;
  char string1[100], string2[100];
  
  strcpy(string1, stringa);
  strcpy(string2, stringb);
  
  for(n = 0; n <= strlen(string1); n+=1)
    string1[n] = tolower(string1[n]);
  for(n = 0; n <= strlen(string2); n+=1)
    string2[n] = tolower(string2[n]);
    
  return(strncmp(string1, string2, testnum));
}

int driver2no(char *driname)
{
  register int n;

  n = 1; 
  while((strcasencmp(name[n], driname, 6)) && n <= maxdrivers)
    n+=1;
    
  if(n > maxdrivers)
    n = 0;
  
  return(n);
}

int chassis2no(char *chaname)
{
  register int n;
  
  n = 1;
  while((strcasencmp(chassisn[n], chaname, 6)) && n <= maxchassis)
    n+=1;
  
  if(n > maxchassis)
  {
    n=0;
    if(!strcasencmp("<None>", chaname, 6) || !strcasencmp("None", chaname, 4))
      n = -1;
  }
    
  return(n);
}
  
int engine2no(char *engname)
{
  register int n;
  
  n = 1;
  while((strcasencmp(enginen[n], engname, 6)) && n <= maxengines)
    n+=1;
  
  if(n > maxengines)
  {
    n=0;
    if(!strcasencmp("<None>", engname, 6) || !strcasencmp("None", engname, 4))
      n = -1;
  }
    
  return(n);
}
  
void capitalise(char *word)
{
  word[0] = toupper(word[0]);
  return;
}

unsigned int readline(char *in_string, int chars_2_read, FILE *file_pointer)
{
  char temp[100];
  
  fgets(temp, chars_2_read, file_pointer);
  line_no += 1;
  
  while((strlen(temp) == 1 || (temp[0] == '#' && temp[1] == '#')) && !feof(file_pointer))
  {
    fgets(temp, chars_2_read, file_pointer);
    line_no +=1;
  }
  
  strcpy(in_string, temp);
  in_string[strlen(in_string)-1] = 0;
  
  return(strlen(temp)-1);
}

void cleararrays(void)
{
  register int n;
  
  for(n = 1; n < DRIVERS; n+=1)
  {
    grid[n] = 0;
    position[n] = 0;
    status[n] = 0;
    drcar[n] = 0;
    dreng[n] = 0;
    warmup[n] = 0;
    topsixpts[n] = 0;
    awardpts[n] = 0;
    incgridpts[n] = 0;
    warmuppts[n] = 0;
    retirepts[n] = 0;
    noqualpts[n] = 0;
    carpts[n] = 0;
    engpts[n] = 0;
    racesc[n] = 0;
  }
      
  for(n = 0; n < CHASSIS; n+=1)
  {
    carscr[n] = 0;
  }
      
  for(n = 0; n < ENGINES; n+=1)
  {
    engscr[n] = 0;
  }
  
  return;
}

FILE *openfile(char *filename, char *mode)
{
  FILE *filepointer;
  
  filepointer = fopen(filename, mode);
  if(filepointer == 0)
  {
    disperr(filename);
    exit(0);
  }
  
  return(filepointer);
}

int checkinput(char *argument, int check)
{
  if(check != 255)
  {
    /* Incorrect command line, display message and quit */
    fputs(verst, stderr);
    fputs(errs1, stderr);
    fputs(ranwith, stderr);
    fputs(errs2, stderr);
    exit(0);
  }
  
  strncpy(argument, "00", 2);
  return(atoi(argument));
}

int teamcost(int dr1, int dr2, int dr3, int cha, int eng)
{
  return(namec[dr1]+namec[dr2]+namec[dr3]+chassisc[cha]+enginec[eng]);
}

int readscores(char *racename, char *store)
{
  register int i;

  strcpy(racename, store);
  readline(store, INLEN, scores_file);
  ndrivers = atoi(store);
     
  for(i = 1; i <= ndrivers; i+=1)
  {
    fscanf(scores_file, "%d %d %d", &grid[i], &drcar[i], &dreng[i]);
    fscanf(scores_file, " %d %d %d %d %d %d %d %d %d %d %d %d",
      &position[i], &status[i], &topsixpts[grid[i]], 
      &awardpts[grid[i]], &incgridpts[grid[i]], &warmuppts[grid[i]], 
      &retirepts[grid[i]], &noqualpts[grid[i]], &carpts[i], 
      &carscr[drcar[i]], &engpts[i], &engscr[dreng[i]]);
    fgets(store, INLEN, scores_file);
  }
  
  return(ndrivers);
}

void raceoutput(void)
{
  register int i,j,k;
  char code[4], fullname[100], racename[100], store[100];
  char equalsign[2];
  int  display_pos, pos;
  int  highest, highscore; 
  int  d1, d2, d3, ch, en, best_score, best_team[5];
  int  top_score, top_team[5];
  int  bot_score, bot_team[5];
  int  wrst_score, wrst_team[5];
  int  first_race;
  
  j = 0;
  if(normal == 0)
    normal = 255;
    
  scores_file = openfile(scores_name, "r");
    
  for(i = 0; i < CHASSIS; i+=1)
  {
    cartot[i] = 0;
  }
      
  for(i = 0; i < ENGINES; i+=1)
  {
    engtot[i] = 0;
  }

  for(i = 0; i <= MAXTEAM; i+=1)
  {
    scores[i] = 0;
  }
  
  for(i = 0; i <= DRIVERS; i+=1)
  {
    totalsc[i] = 0;
  }

  readline(store, INLEN, scores_file);
  while(j != normal && !feof(scores_file))
  {
    cleararrays();
     
    ndrivers = readscores(racename, store); 

    /* total up scores */
    for(k = 0; k < DRIVERS; k+=1)
    {
      racesc[k]=topsixpts[k]+awardpts[k]+incgridpts[k]+warmuppts[k]-
        retirepts[k]-noqualpts[k];
      totalsc[k]+=racesc[k];
    }

    for(k = 1; k <= maxchassis; k+=1)
      cartot[k] += carscr[k];
    
    for(k = 1; k <= maxengines; k+=1)
      engtot[k] += engscr[k];

    /* Calculate teams' scores */
    for(k = 1; k <= nteams; k+=1)
    {
      thisrce[k]=(racesc[driver1[k]]+racesc[driver2[k]]+
        racesc[driver3[k]]+carscr[chassis[k]]+engscr[engine[k]]);
      scores[k]+=thisrce[k];
    }
     
    j+=1;
    readline(store, INLEN, scores_file);
  }
  
  first_race = j;
  fclose(scores_file);

  best_score = -500;
  wrst_score = 500;
  top_score = -500;
  bot_score = 500;
  for(d1 = 1; d1 < maxdrivers+1; d1+=1)
    for(d2 = 1; d2 < maxdrivers+1; d2+=1)
      for(d3 = 1; d3 < maxdrivers+1; d3+=1)
        for(ch = 1; ch < maxchassis+1; ch+=1)
          for(en = 1; en < maxengines+1; en+=1)
            if(d1 != d2 && d1 != d3 && d2 != d3 && namec[d3] == 1)
              if(teamcost(d1, d2, d3, ch, en) <= 30)
              {
                if(racesc[d1]+racesc[d2]+racesc[d3]+carscr[ch]+engscr[en]
                  > best_score)
                {
                  best_score = racesc[d1]+racesc[d2]+racesc[d3]+carscr[ch]+engscr[en];
                  best_team[0] = d1;
                  best_team[1] = d2;
                  best_team[2] = d3;
                  best_team[3] = ch;
                  best_team[4] = en;
                }
                if(racesc[d1]+racesc[d2]+racesc[d3]+carscr[ch]+engscr[en]
                  < wrst_score)
                {
                  wrst_score = racesc[d1]+racesc[d2]+racesc[d3]+carscr[ch]+engscr[en];
                  wrst_team[0] = d1;
                  wrst_team[1] = d2;
                  wrst_team[2] = d3;
                  wrst_team[3] = ch;
                  wrst_team[4] = en;
                }
                if(totalsc[d1]+totalsc[d2]+totalsc[d3]+cartot[ch]+engtot[en]
                  > top_score)
                {
                  top_score = totalsc[d1]+totalsc[d2]+totalsc[d3]+cartot[ch]+engtot[en];
                  top_team[0] = d1;
                  top_team[1] = d2;
                  top_team[2] = d3;
                  top_team[3] = ch;
                  top_team[4] = en;
                }
                if(totalsc[d1]+totalsc[d2]+totalsc[d3]+cartot[ch]+engtot[en]
                  < bot_score)
                {
                  bot_score = totalsc[d1]+totalsc[d2]+totalsc[d3]+cartot[ch]+engtot[en];
                  bot_team[0] = d1;
                  bot_team[1] = d2;
                  bot_team[2] = d3;
                  bot_team[3] = ch;
                  bot_team[4] = en;
                }
              }

  printf("%s\n", verst);
  capitalise(racename);
  printf("%s Starting Grid\n\n", racename);
  for(i = 1; i < ndrivers+1; i+=1) 
  {
    if(status[i] != 3)
    {
      sprintf(fullname, "%s %s", first[grid[i]], name[grid[i]]);
      printf("%2d : %-30s", i, fullname);
      printf(" %s-", chassisn[drcar[i]]);
      printf("%s\n", enginen[dreng[i]]);
    } 
  }
  printf("\n%s Results\n\n", racename);
  printf("    NAME      POINTS BREAKDOWN       CHASSIS    POINTS ENGINE");
  printf("        POINTS\n");
  printf("                      Top Six\n");
  printf("                      |  Award                Driver's          ");
  printf("   Driver's\n");
  printf("                      |  | Grid Increase       Chassis          ");
  printf("     Engine\n");
  printf("                      |  | |  Warm-up               |           ");
  printf("         |\n");
  printf("                      |  | |  | Retirement          |           ");
  printf("         |\n");
  printf("                      |  | |  | | Non-qualification |           ");
  printf("         |\n");
  printf("                      |  | |  | | |                 |           ");
  printf("         |\n");

  pos = 1;
  j = 1;
  do
  {
    while(position[j] != pos)
      j+=1;
    if(status[j] == 0)
      strcpy(code, "DIS");
    if(status[j] == 1)
      sprintf(code, "%-3d", pos);
    if(status[j] == 2)
      strcpy(code, "rtd");
    if(status[j] == 3)
      strcpy(code, "DNQ");
    if(status[j] == 4)
      strcpy(code, "DNS");
        
    printf("%s %-13s %2d (%02d+%1d+%02d+%1d-%1d-%1d) ", code, name[grid[j]],
      racesc[grid[j]], topsixpts[grid[j]], awardpts[grid[j]], 
      incgridpts[grid[j]], warmuppts[grid[j]], retirepts[grid[j]],
      noqualpts[grid[j]]);
    printf("%-9s %2d [%2d]", 
      chassisn[drcar[j]], carscr[drcar[j]], carpts[j]);
    printf(" %-12s %2d [%2d]\n", 
      enginen[dreng[j]], engscr[dreng[j]], engpts[j]);
    pos+=1;
    j = 1;
  }
  while(pos < ndrivers+1); 

  for(i = 1; i < MAXTEAM; i+=1)
    sflags[i] = 0;

  printf("\n%s Scores Table\n\n", racename);
  for(i = 1; i < nteams+1; i+=1)
  {
    display_pos = 1;
    strcpy(equalsign, " ");
    highest = 0;
    highscore = -500;
    for(j = 1; j < nteams+1; j+=1)
      if(sflags[j] == 0)
        if(thisrce[j] > highscore)
        {
          highscore = thisrce[j];
          highest = j;
        }
    sflags[highest] = 1;
    for(j = 1; j < nteams+1; j+=1)
    {
      if(thisrce[j] > thisrce[highest])
        display_pos+=1;
      if(thisrce[j] == thisrce[highest] && j != highest)
        strcpy(equalsign, "=");
    }
    printf("%s%-3d %-25s %d\n", equalsign, display_pos, teamname[highest], thisrce[highest]); 
  }


  for(i = 1; i < MAXTEAM; i+=1)
    sflags[i] = 0;

  printf("\n%s Team Scores\n\n", racename);
  for(i = 1; i < nteams+1; i+=1)
  {
    display_pos = 1;
    strcpy(equalsign, " ");
    highest = 0;
    highscore = -500;
    for(j = 1; j < nteams+1; j+=1)
      if(sflags[j] == 0)
        if(scores[j] > highscore)
        {
          highscore = scores[j];
          highest = j;
        }
    sflags[highest] = 1;
    for(j = 1; j < nteams+1; j+=1)
    {
      if(scores[j] > scores[highest])
        display_pos+=1;
      if(scores[j] == scores[highest] && j != highest)
        strcpy(equalsign, "=");
    }  
    printf("Team Owner   : %s\nTeam Name    : %s\n", owner[highest],
      teamname[highest]);
    printf("Position     : %2d%s\n", display_pos, equalsign);
    printf("Series Score : %3d\n", scores[highest]); 
    printf("Race Score   : %3d\n", thisrce[highest]);
    printf("Race Details : Driver one    - %-13s = %2d\n", name[driver1[highest]], 
      racesc[driver1[highest]]);
    printf("               Driver two    - %-13s = %2d\n", name[driver2[highest]], 
      racesc[driver2[highest]]);
    printf("               Test driver   - %-13s = %2d\n", name[driver3[highest]], 
      racesc[driver3[highest]]);
    printf("               Car's chassis - %-13s = %2d\n", 
      chassisn[chassis[highest]], carscr[chassis[highest]]);
    printf("               Car's engine  - %-13s = %2d\n\n", 
      enginen[engine[highest]], engscr[engine[highest]]);
  }
  
  printf("\n\nThe highest possible score from this race was %d points by:\n", best_score);
  printf("Driver one  : %-13s %2d (œ%dm)\n", name[best_team[0]],
    racesc[best_team[0]], namec[best_team[0]]);
  printf("Driver two  : %-13s %2d (œ%dm)\n", name[best_team[1]],
    racesc[best_team[1]], namec[best_team[1]]);
  printf("Test driver : %-13s %2d (œ%dm)\n", name[best_team[2]],
    racesc[best_team[2]], namec[best_team[2]]);
  printf("Chassis     : %-13s %2d (œ%dm)\n", chassisn[best_team[3]],
    carscr[best_team[3]], chassisc[best_team[3]]);
  printf("Engine      : %-13s %2d (œ%dm)\n", enginen[best_team[4]],
    engscr[best_team[4]], enginec[best_team[4]]);
  printf("This team cost œ%dm.\n", teamcost(best_team[0], best_team[1],
    best_team[2], best_team[3], best_team[4]));
    
  printf("\nThe lowest possible score from this race was %d points by:\n", wrst_score);
  printf("Driver one  : %-13s %2d (œ%dm)\n", name[wrst_team[0]],
    racesc[wrst_team[0]], namec[wrst_team[0]]);
  printf("Driver two  : %-13s %2d (œ%dm)\n", name[wrst_team[1]],
    racesc[wrst_team[1]], namec[wrst_team[1]]);
  printf("Test driver : %-13s %2d (œ%dm)\n", name[wrst_team[2]],
    racesc[wrst_team[2]], namec[wrst_team[2]]);
  printf("Chassis     : %-13s %2d (œ%dm)\n", chassisn[wrst_team[3]],
    carscr[wrst_team[3]], chassisc[wrst_team[3]]);
  printf("Engine      : %-13s %2d (œ%dm)\n", enginen[wrst_team[4]],
    engscr[wrst_team[4]], enginec[wrst_team[4]]);
  printf("This team cost œ%dm.\n", teamcost(wrst_team[0], wrst_team[1],
    wrst_team[2], wrst_team[3], wrst_team[4]));
  
  if(first_race != 1)
  {
    printf("\nThe highest possible score so far is %d points by:\n", top_score);
    printf("Driver one  : %-13s %2d (œ%dm)\n", name[top_team[0]],
      totalsc[top_team[0]], namec[top_team[0]]);
    printf("Driver two  : %-13s %2d (œ%dm)\n", name[top_team[1]],
      totalsc[top_team[1]], namec[top_team[1]]);
    printf("Test driver : %-13s %2d (œ%dm)\n", name[top_team[2]],
      totalsc[top_team[2]], namec[top_team[2]]);
    printf("Chassis     : %-13s %2d (œ%dm)\n", chassisn[top_team[3]],
      cartot[top_team[3]], chassisc[top_team[3]]);
    printf("Engine      : %-13s %2d (œ%dm)\n", enginen[top_team[4]],
      engtot[top_team[4]], enginec[top_team[4]]);
    printf("This team cost œ%dm.\n", teamcost(top_team[0], top_team[1],
      top_team[2], top_team[3], top_team[4]));
    
    printf("\nThe lowest possible score so far is %d points by:\n", bot_score);
    printf("Driver one  : %-13s %2d (œ%dm)\n", name[bot_team[0]],
      totalsc[bot_team[0]], namec[bot_team[0]]);
    printf("Driver two  : %-13s %2d (œ%dm)\n", name[bot_team[1]],
      totalsc[bot_team[1]], namec[bot_team[1]]);
    printf("Test driver : %-13s %2d (œ%dm)\n", name[bot_team[2]],
      totalsc[bot_team[2]], namec[bot_team[2]]);
    printf("Chassis     : %-13s %2d (œ%dm)\n", chassisn[bot_team[3]],
      cartot[bot_team[3]], chassisc[bot_team[3]]);
    printf("Engine      : %-13s %2d (œ%dm)\n", enginen[bot_team[4]],
      engtot[bot_team[4]], enginec[bot_team[4]]);
    printf("This team cost œ%dm.\n\n", teamcost(bot_team[0], bot_team[1],
      bot_team[2], bot_team[3], bot_team[4]));
  }
  
  return;
}

void teamoutput(void)
{
  register int i,j,k;
  char store[100], dispname[21];

  j = 0;
  if(teams == 0)
    teams = 255;
  
  scores_file = openfile(scores_name, "r");
   
  for(i = 0; i <= MAXTEAM; i+=1)
  {
    scores[i] = 0;
  }

  readline(store, INLEN, scores_file);
  while(j != teams && !feof(scores_file))
  {
    cleararrays();
      
    ndrivers = readscores(racenames[j], store); 

    /* total up scores */
    for(k = 0; k < DRIVERS; k+=1)
      racesc[k]=topsixpts[k]+awardpts[k]+incgridpts[k]+warmuppts[k]-
        retirepts[k]-noqualpts[k];

    /* Calculate teams' scores */
    for(k = 1; k <= nteams; k+=1)
    {
      teamscores[k][j]=(racesc[driver1[k]]+racesc[driver2[k]]+
        racesc[driver3[k]]+carscr[chassis[k]]+engscr[engine[k]]);
      scores[k]+=teamscores[k][j];
    }
    
    j+=1;
    readline(store, INLEN, scores_file);
  }
  nraces = j-1;
   
  fclose(scores_file);

  printf("%s\n", verst);
  printf("Team scores table\n");
    
  for(i = 0; i <= nraces; i+=1)
  {
    printf("                        ");
    if(i > 0)
      for(j = 0; j < i; j+=1)
        printf(" |  ");
    printf("%s\n", racenames[i]);
  }
    
  printf("+----------------------+");
  for(i = 0; i <= nraces; i+=1)
    printf("---+");
  printf("-----+\n");
    
  for(i = 1; i <= nteams; i+=1)
  {
    strncpy(dispname, teamname[i], 20);
    dispname[20] = 0;
    printf("| %-20s |", dispname);
    for(j = 0; j <= nraces; j+=1)
      printf("%3d|", teamscores[i][j]);
    printf("%5d|\n", scores[i]);
   
    printf("+----------------------+");
    for(k = 0; k <= nraces; k+=1)
      printf("---+");
    printf("-----+\n");
  }
  printf("\n");

  return;
}

void drivoutput(void)
{
  register int i,j,k; 
  char store[100];

  j = 0;
  if(drive == 0)
    drive = 255;
  
  scores_file = openfile(scores_name, "r");

  readline(store, INLEN, scores_file);
  while(j != drive && !feof(scores_file))
  {
    cleararrays();
      
    ndrivers = readscores(racenames[j], store); 

    /* total up scores */
    for(k = 0; k < DRIVERS; k+=1)
    {
      driverscore[k][j]=topsixpts[k]+awardpts[k]+incgridpts[k]
        +warmuppts[k]-retirepts[k]-noqualpts[k];
      drivertotal[k]+=driverscore[k][j];
    }
      
    j+=1;
    readline(store, INLEN, scores_file);
  }
  nraces = j-1;
    
  fclose(scores_file);

  printf("%s\n", verst);
  printf("Driver scores table\n");
     
  for(i = 0; i <= nraces; i+=1)
  {
    printf("                        ");
    if(i > 0)
      for(j = 0; j < i; j+=1)
        printf(" |  ");
    printf("%s\n", racenames[i]);
  }
    
  printf("+----------------------+");
  for(i = 0; i <= nraces; i+=1)
    printf("---+");
  printf("-----+\n");
    
  for(i = 1; i <= maxdrivers; i+=1)
  {
    printf("| %-20s |", name[i]);
    for(j = 0; j <= nraces; j+=1)
      printf("%3d|", driverscore[i][j]);
    printf("%5d|\n", drivertotal[i]);
  
    printf("+----------------------+");
    for(k = 0; k <= nraces; k+=1)
      printf("---+");
    printf("-----+\n");
  }
  printf("\n");

  return;
}

void carsoutput(void)
{
  register int i,j,k;
  char store[100];

  j = 0;
  if(cars == 0)
    cars = 255;
    
  for(i = 0; i < CHASSIS; i+=1)
  {
    cartot[i] = 0;
  }
      
  for(i = 0; i < ENGINES; i+=1)
  {
    engtot[i] = 0;
  }
    
  scores_file = openfile(scores_name, "r");

  readline(store, INLEN, scores_file);
  while(j != cars && !feof(scores_file))
  {
    cleararrays();
      
    ndrivers = readscores(racenames[j], store); 

    for(k = 1; k <= maxchassis; k+=1)
    {
      carrun[k][j] = carscr[k];
      cartot[k] += carscr[k];
    }
    
    for(k = 1; k <= maxengines; k+=1)
    {
      engrun[k][j] = engscr[k];
      engtot[k] += engscr[k];
    }
      
    j+=1;
    readline(store, INLEN, scores_file);
  }
  nraces = j-1;
    
  fclose(scores_file);

  printf("%s\n", verst);
  printf("Chassis scores table\n");
     
  for(i = 0; i <= nraces; i+=1)
  {
    printf("                        ");
    if(i > 0)
      for(j = 0; j < i; j+=1)
        printf(" |  ");
    printf("%s\n", racenames[i]);
  }
    
  printf("+----------------------+");
  for(i = 0; i <= nraces; i+=1)
    printf("---+");
  printf("-----+\n");
   
  for(i = 1; i <= maxchassis; i+=1)
  {
    printf("| %-20s |", chassisn[i]);
    for(j = 0; j <= nraces; j+=1)
      printf("%3d|", carrun[i][j]);
    printf("%5d|\n", cartot[i]);
    
    printf("+----------------------+");
    for(k = 0; k <= nraces; k+=1)
      printf("---+");
    printf("-----+\n");
  }
  printf("\n");

  printf("Engine scores table\n");
     
  for(i = 0; i <= nraces; i+=1)
  {
    printf("                        ");
    if(i > 0)
      for(j = 0; j < i; j+=1)
        printf(" |  ");
    printf("%s\n", racenames[i]);
  }
   
  printf("+----------------------+");
  for(i = 0; i <= nraces; i+=1)
    printf("---+");
  printf("-----+\n");
   
  for(i = 1; i <= maxengines; i+=1)
  {
    printf("| %-20s |", enginen[i]);
    for(j = 0; j <= nraces; j+=1)
      printf("%3d|", engrun[i][j]);
    printf("%5d|\n", engtot[i]);
  
    printf("+----------------------+");
    for(k = 0; k <= nraces; k+=1)
      printf("---+");
    printf("-----+\n");
  }
  printf("\n");
  
  return;
}

void sprdoutput(void)
{
  register int i,j,k;
  char store[100];

  j = 0;
  if(spread == 0)
    spread = 255;
   
  scores_file = openfile(scores_name, "r");
    
  for(i = 0; i <= MAXTEAM; i+=1)
  {
    scores[i] = 0;
  }

  readline(store, INLEN, scores_file);
  while(j != spread && !feof(scores_file))
  {
    cleararrays();
     
    ndrivers = readscores(racenames[j], store); 

    /* total up scores */
    for(k = 0; k < DRIVERS; k+=1)
      racesc[k]=topsixpts[k]+awardpts[k]+incgridpts[k]+warmuppts[k]-
        retirepts[k]-noqualpts[k];

    /* Calculate teams' scores */
    for(k = 1; k <= nteams; k+=1)
    {
      teamscores[k][j]=(racesc[driver1[k]]+racesc[driver2[k]]+
        racesc[driver3[k]]+carscr[chassis[k]]+engscr[engine[k]]);
      if(j != 0)
        teamscores[k][j] = teamscores[k][j] + teamscores[k][j-1];
      scores[k]+=teamscores[k][j];
    }
     
    j+=1;
    readline(store, INLEN, scores_file);
  }
  nraces = j-1;
    
  fclose(scores_file);

  for(i = 0; i <= nraces; i+=1)
    printf(",%s", racenames[i]);
  printf("\n");
       
  for(i = 1; i <= nteams; i+=1)
  {
    printf("%s", teamname[i]);
    for(j = 0; j <= nraces; j+=1)
      printf(",%d", teamscores[i][j]);
    printf("\n"); 
  }
  printf("\n");

  for(i = 0; i <= MAXTEAM; i+=1)
    for(j = 0; j <= MAXRACE; j+=1)
      sp_pos[i][j] = 1;

  for(i = 0; i <= nraces; i+=1)
    printf(",%s", racenames[i]);
  printf("\n");

  for(i = 0; i <= nraces; i+=1)
    for(j = 1; j <= nteams; j+=1)
      for(k = 1; k <= nteams; k+=1)
        if(teamscores[k][i] > teamscores[j][i])
          sp_pos[j][i] = sp_pos[j][i] + 1;
    
  for(i = 1; i <= nteams; i+=1)
  {
    printf("%s", teamname[i]);
    for(j = 0; j <= nraces; j+=1)
      printf(",%d", sp_pos[i][j]);
    printf("\n");
  }
  
  return;
}

