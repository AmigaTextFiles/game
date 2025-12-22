#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <string.h>
#include <assert.h>
/* int errno; */
#include <errno.h>
#include "syscall.h"

/* This is used by _sbrk.  */
register char *stack_ptr asm ("$sp");

/*
   kos return 0 when err,
   newlib fd return -1 when err
   newlib fd must >=0 and short
*/

#define	CHECKFILE(file)	if (file<3) return -1
#define	FD2KOS(fd)	fd

#define	PATH_MAX	256

static char curdir[PATH_MAX];
static int  curdir_length;

static inline int seterrno(int ret)
{
	if (ret>=0) return ret;
	errno = ret;
	return -1;
}

static char* convert_path(char* buf, const char *path)
{
	if (strchr(path,':')) return path; //full path

	memcpy(buf, curdir,curdir_length);
	strcpy(buf + curdir_length,path);
	return buf;
}

int
read (int file,
       char *ptr,
       int len)
{
  CHECKFILE(file);
  return seterrno(sceIoRead(FD2KOS(file),ptr,len));
}

int
lseek (int file,
	int ptr,
	int dir)
{
  CHECKFILE(file);
//  dbgio_printf("seek %x,%d,%d\n",FD2KOS(file),ptr,dir);
  return seterrno(sceIoLseek(FD2KOS(file),ptr,dir));
}

int
write ( int file,
	 const char *ptr,
	 int len)
{
  switch(file) {
  case 0: /* stdin */
    return -1;
  case 1: /* stdout */
  case 2: /* stderr */
    dbg_write(ptr,len);
//	pspeDebugWrite(ptr,len);
    return len;
  default:
    return seterrno(sceIoWrite(FD2KOS(file),ptr,len));
  }
}

int
close (int file)
{
  CHECKFILE(file);
  sceIoClose(FD2KOS(file));
//  fh[file]=0;
  return 0;
}

int
open (const char *path,
	int flags)
{
//  dbgio_printf(path);
#if 0
  for(fd=3;fd<MAX_OPEN && fh[fd];fd++) ;
  if (fd==MAX_OPEN) {
    return -1;
  }
  f = fs_open(path,flags);
  if (f==0) {
//	dbgio_printf("\n");
  	return -1;
  }
//  dbgio_printf(":%x\n",f);
  fh[fd] = f;
  return fd;
#endif
  char fullpath[PATH_MAX];
  char *p = convert_path(fullpath,path);
  return seterrno(sceIoOpen(p,flags));
}

int
fstat (int file,
	struct stat *st)
{
  int size,cur;
  CHECKFILE(file);

  cur = sceIoLseek(file,0,SEEK_CUR);
  size = sceIoLseek(file,0,SEEK_END);
  sceIoLseek(file,cur,SEEK_SET);

  memset(st,0,sizeof(*st));

  st->st_mode = S_IFREG;
  st->st_size = size;
  return 0;
}

int
creat (const char *path,
	int mode)
{
  return open(path,O_WRONLY|O_TRUNC|O_CREAT);
}

int
rename (const char *oldpath,const char *newpath)
{
  char fulloldpath[PATH_MAX];
  char fullnewpath[PATH_MAX];
  return seterrno(sceIoRename(convert_path(fulloldpath,oldpath),convert_path(fullnewpath,newpath)) );
}

int
unlink (const char *path)
{
  char fullpath[PATH_MAX];
  return seterrno(sceIoRemove(convert_path(fullpath,path)) );
}

int 
chdir(const char *path)
{
  if (strchr(path,':')) {
     strcpy(curdir,path);
  } else {
     return -1; //FIXME
  }
  curdir_length = strlen(curdir);
  curdir[curdir_length++]='/';
  return 0;
}

int
mkdir(const char *path,mode_t mode)
{
  char fullpath[PATH_MAX];
  return seterrno(sceIoMkdir(convert_path(fullpath,path),mode));
}

int
rmdir(const char *path)
{
  char fullpath[PATH_MAX];
  return seterrno(sceIoRmdir(convert_path(fullpath,path)));
}

static unsigned int getpad()
{
	ctrl_data_t paddata;
	sceCtrlRead(&paddata,1);
	return paddata.buttons;
}


void _exit (int n)
{
  while(1) {
    sceDisplayWaitVblankStart();
    int buttons = getpad();
    if (buttons & CTRL_START) break;
  }

  sceKernelExitGame();
}

#include <sys/dirent.h>

struct dir_t
{
	int handle;
	struct dirent ent;
};

#define MAXOPENDIR 16
DIR dirs[MAXOPENDIR];

static inline DIR* dir_alloc()
{
	int i;
	for(i=0;i<MAXOPENDIR;i++)
		if (dirs[i].handle==0) return &dirs[i];
	return NULL;
}

static inline void dir_free(DIR* dir)
{
	dir->handle = 0;
}

DIR* opendir(const char *path)
{
	DIR* dir;
	int handle = seterrno(sceIoDopen(path));
	if (handle<0) {
		return NULL;
	}
	dir = dir_alloc();
	if (dir==NULL) {
		sceIoDclose(handle);
		return NULL;
	}
	dir->handle = handle;
	return dir;
}

struct dirent *readdir (DIR *dir)
{
	int res = seterrno(sceIoDread(dir->handle,&dir->ent));
	if (res<0) return NULL;
	return &dir->ent;
}

int closedir(DIR *dir)
{
	sceIoDclose(dir->handle);
	dir_free(dir);
	return 0;
}

static char alloc_buffer[16*1024*1024];

caddr_t
_sbrk (int incr)
{
  extern char end;		/* Defined by the linker */
  static char *heap_end = alloc_buffer; //&end;
  static int total;
  char *prev_heap_end;

  prev_heap_end = heap_end;
#if 0
  if (heap_end + incr > stack_ptr)
    {
//      _write (1, "Heap and stack collision\n", 25);
      abort ();
    }
#endif
  heap_end += incr;
  total += incr;
//  dbgio_("total:%d\n",total);
  return (caddr_t) prev_heap_end;
}

caddr_t sbrk (int incr) { return _sbrk(incr); }


#include <time.h>
#include <sys/time.h>
#include <sys/times.h>

clock_t clock(void)
{
	return sceKernelLibcClock();
}

time_t time(time_t *tm)
{
	return sceKernelLibcTime(tm);
}

int gettimeofday(struct timeval *__p, struct timezone *__z)
{
	return sceKernelLibcGettimeofday(__p,__z);
}

int
isatty (int fd)
{
//  if (fd<3) return 1;
  return 0;
}

int
link (char *old, char *new)
{
  return -1;
}

int kill (int n, int m)
{
  return -1;
}

int getpid (int n)
{
  return 1;
}

_raise ()
{
}

#if 0

/*
int
_stat (const char *path, struct stat *st)

{
  return __trap34 (SYS_stat, path, st, 0);
}
*/

int
_chmod (const char *path, short mode)
{
  return -1;
}

int
_chown (const char *path, short owner, short group)
{
  return -1;
}

int
_utime (path, times)
     const char *path;
     char *times;
{
  return -1;
}

int
_fork ()
{
  return -1;
}

int
_wait (statusp)
     int *statusp;
{
  return -1;
}

int
_execve (const char *path, char *const argv[], char *const envp[])
{
  return -1;
}

int
_execv (const char *path, char *const argv[])
{
  return -1;
}

int
_pipe (int *fd)
{
  return -1;
}

/* This is only provided because _gettimeofday_r and _times_r are
   defined in the same module, so we avoid a link error.  */
clock_t
_times (struct tms *tp)
{
  return -1;
}

int
_gettimeofday (struct timeval *tv, struct timezone *tz)
{
  tv->tv_usec = 0;
  tv->tv_sec = __trap34 (SYS_time);
  return 0;
}

static inline int
__setup_argv_for_main (int argc)
{
  char **argv;
  int i = argc;

  argv = __builtin_alloca ((1 + argc) * sizeof (*argv));

  argv[i] = NULL;
  while (i--) {
    argv[i] = __builtin_alloca (1 + __trap34 (SYS_argnlen, i));
    __trap34 (SYS_argn, i, argv[i]);
  }

  return main (argc, argv);
}

int
__setup_argv_and_call_main ()
{
  int argc = __trap34 (SYS_argc);

  if (argc <= 0)
    return main (argc, NULL);
  else
    return __setup_argv_for_main (argc);
}

#endif
