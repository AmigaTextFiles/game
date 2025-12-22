#include "global.h"
#include "syms.h"
#include <ctype.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

/*
 * C2L
 *
 * Convert an array of bytes into an unsigned long in big-endian format.
 */
u_long
c2l(c)
    u_char *c;
{
    register u_long ret;

    ret = (u_long) * c++ << 24;
    ret |= (u_long) * c++ << 16;
    ret |= (u_long) * c++ << 8;
    ret |= (u_long) * c;
    return ret;
}

/*
 * C2S
 *
 * Convert an array of bytes into an unsigned short in big-endian format.
 */
u_short
c2s(c)
    u_char *c;
{
    register u_short ret;

    ret = (u_short) * c++ << 8;
    ret |= (u_short) * c;
    return ret;
}
char *cblib_version = "1.0";
char *cblib_name = "ChessBase Library";
char *cblib_date = "22-Mar-1994 21:42";
int cblib_build = 6;

/*
 * CHAR_CHANGE
 *
 * Change all occurances of 'c1' to 'c2' in string 's'.
 */
void
char_change(s, c1, c2)
    char *s, c1, c2;
{
    while (*s) {
        if (*s == c1)
            *s = c2;
        s++;
    }
}

/*
 * CLOSE_DATABASE
 *
 * Close an open database.
 */
int
close_database(db)
    Database db;
{
    if (!db)
        return -1;
    if (db->cbf)
        file_close(db->cbf);
    if (db->cbi)
        file_close(db->cbi);
    free(db);
    return 0;
}

/*
 * CMP_GAME
 *
 * Compare a game according to the criteria supplied.
 */
int
cmp_game(game1, game2, order)
    register GameSort game1, game2;
    Order order[];
{
    char *player1, *player2;
    int orderi;
    int res, len;

    if (!game1 || !game2) {
        error("compare argument is NULL!");
        return 0;
    }
 /* do until no more order criteria in list */
    for (orderi = 0; order[orderi] != NOORDER && orderi < MAX_ORDER;
      orderi++) {
        res = 0;
        switch (order[orderi]) {
        case W_PLAYER:
            len = min(game1->wplayer_len, game2->wplayer_len);
            res = strncmp((char *) game1->pinfo,
              (char *) game2->pinfo, len);
            break;
        case B_PLAYER:
            player1 = (char *) game1->pinfo + game1->bplayer_off;
            player2 = (char *) game2->pinfo + game2->bplayer_off;
            if (game1->bplayer_off) {
                if (game2->bplayer_off)
                    res = strcmp(player1, player2);
                else
                    res = -1;
            } else if (game2->bplayer_off) {
                res = 1;
            } else {
                res = 0;
            }
            break;
        case SOURCE:
            res = strcmp((char *) game1->sinfo,
              (char *) game2->sinfo);
            break;
        case YEAR:
            res = game1->year - game2->year;
            break;
        case ECO:
            res = game1->eco - game2->eco;
            break;
        case NMOVES:
            res = game1->nmoves - game2->nmoves;
            break;
        case ROUND:
            res = game1->round[0] - game2->round[0];
            if (!res) {
                res = game1->round[1] - game2->round[1];
                if (!res) {
                    res = game1->round[2] - game2->round[2];
                }
            }
            break;
        case NOORDER:
        default:
            break;
        }
        if (res) {
            return res;
        }
    }
    return 0;                          /* all fields identical */
}

/*
 * COPY_BOARD
 *
 * Copy one board to another
 */
void
copy_board(source, destination)
    u_char *source, *destination;
{
    bcopy(source, destination, 64);
}

/*
 * COPY_DATABASE
 *
 * Make a copy of an existing database.
 */
Database
copy_database(db, name)
    Database db;
    char *name;
{
    Database new_db;

    new_db = create_database(name);
    if (!new_db)
        return NULL;

    if (file_copy(db->cbf, new_db->cbf) < 0) {
        delete_database(new_db);
        return NULL;
    }
    if (file_copy(db->cbi, new_db->cbi) < 0) {
        delete_database(new_db);
        return NULL;
    }
    return new_db;
}

/*
 * CREATE_DATABASE
 *
 * Create a new database
 */
Database
create_database(name)
    char *name;
{
    Database db;
    char *filename;

    db = (Database) mem_alloc(sizeof(struct database));
    if (!db)
        return NULL;

 /* open the games file (.CBF) */
    filename = derive_name(name, ".cbf");
    if (!filename)
        goto failed;
    db->cbf = file_open(filename, "w+b");
    free(filename);
    if (!db->cbf)
        goto failed;

 /* open the index file (.CBI) */
    filename = derive_name(name, ".cbi");
    if (!filename)
        goto failed;
    db->cbi = file_open(filename, "w+b");
    free(filename);
    if (!db->cbi)
        goto failed;

    db->ngames = 0L;
    write_ngames(db);
    write_index(db, 1L, 0L);

    return db;

failed:
    close_database(db);
    return NULL;
}

/*
 * CVT_EVAL
 *
 * Return the ASCII string for the given evaluation symbol.
 */
char *
cvt_eval(sym)
    int sym;
{
    if (sym > 0 && sym < NEVALS)
        return eval[sym];
    else
        return null;
}

/*
 * CVT_MOVEVAL
 *
 * Return the ASCII string for the given move evaluation symbol.
 */
char *
cvt_moveval(sym)
    int sym;
{
    if (sym > 0 && sym < NMOVEVALS)
        return moveval[sym];
    else
        return null;
}

/*
 * CVT_POSEVAL
 *
 * Return the ASCII string for the given position evaluation symbol.
 */
char *
cvt_poseval(sym)
    int sym;
{
    if (sym > 0 && sym < NPOSEVALS)
        return poseval[sym];
    else
        return null;
}

/*
 * CVT_RESULT
 *
 * Convert a result byte into its ASCII equivalent.
 */
char *
cvt_result(res)
    int res;
{
    char *ret;

    switch (res) {
    case 0:
        ret = "0-1";
        break;
    case 1:
        ret = "1/2";
        break;
    case 2:
        ret = "1-0";
        break;
    default:
        ret = poseval[(res >> 2) & 0x0f];
        break;
    }
    return ret;
}

/*
 * CVT_SYM
 *
 * Replace all symbols in a null-terminated string with their ASCII
 * equivalent.
 */
char *
cvt_sym(string)
    u_char *string;
{
    return cvt_syml(string, ustrlen(string));
}

/*
 * CVT_SYML
 *
 * Replace all symbols in a fixed-length string with their ASCII equivalent.
 */
char *
cvt_syml(string, len)
    u_char *string;
    int len;
{
    int i, c;
    char *cptr;

    cptr = cvtbuf;

    for (i = 0; i < len; i++, string++) {
        c = *string & 0xff;
        if (c == 0x7f) {
            strcpy(cptr, with_idea);
            cptr += strlen(with_idea);
        } else if (c & 0x80) {
            c &= 0x7f;
            strcpy(cptr, sym[c]);
            cptr += strlen(sym[c]);
        } else {
            *cptr++ = c;
        }
    }
    *cptr = '\0';

    return cvtbuf;
}

/*
 * DELETE_DATABASE
 *
 * Remove game and index file for database
 */
int
delete_database(db)
    Database db;
{
    int ret;

    ret = file_delete(db->cbf);
    ret += file_delete(db->cbi);
    return ret;
}

/*
 * DERIVE_NAME
 *
 * Create a pathname for a file with a specific extension.
 */
char *
derive_name(name, ext)
    char *name, *ext;
{
    register char *cptr;
    unsigned len;

 /* start searching for the .ext after the last path-seperator */
    cptr = rindex(name, PATHSEP);
    if (!cptr)
        cptr = name;

 /* look for the last '.', in case they're are dots in the filename */
    cptr = rindex(cptr, '.');
    if (cptr)
        len = (unsigned) (cptr - name);
    else
        len = strlen(name);

 /* copy everything over, except the old extension, and append the new
    extension */
    cptr = mem_alloc(len + strlen(ext) + 1);
    if (cptr) {
        strncpy(cptr, name, len);
        strcat(cptr, ext);
    }
    return cptr;
}

/*
 * DO_MOVE
 *
 * Move pieces on board according to given move.
 */
void
do_move(from, to, prom)
    int from, to, prom;
{
    int dir;
    int colour = cb_board[from] & 8;
    int ep = cb_enpassant;

    lastmove_flags = 0;
    cb_enpassant = 0;
    captured_piece = cb_board[to] & 7;
    if (!colour)
        dir = 1;
    else
        dir = -1;
    if (cb_board[to] & 7)
        lastmove_flags |= CAPTURE;
    if ((cb_board[from] & 7) == PAWN && to_file(to) != to_file(from)
      && !cb_board[to]) {
        cb_board[to - dir] = 0;        /* en passant capture */
        lastmove_flags |= ENPASSANT | CAPTURE;
    }
    cb_board[to] = cb_board[from];
    cb_board[from] = 0;
    if ((cb_board[to] & 7) == PAWN &&
      (to_rank(to) == 7 || to_rank(to) == 0)) {
        cb_board[to] = prom + colour;  /* pawn promotion */
        lastmove_flags |= PROMOTION;
    }
    if ((cb_board[to] & 7) == PAWN && abs(to - from) == 2)
        cb_enpassant = to_file(to) + 1;/* long pawn move */
    if ((cb_board[to] & 7) == KING && abs(to - from) == 16) {
        cb_enpassant = ep;             /* bug compatibility */
        if (to > from) {               /* castle kingside */
            cb_board[to - 8] = cb_board[to + 8];
            cb_board[to + 8] = 0;
            lastmove_flags |= SHORT_CASTLE;
        }
        if (to < from) {               /* castle queenside */
            cb_board[to + 8] = cb_board[to - 16];
            cb_board[to - 16] = 0;
            lastmove_flags |= LONG_CASTLE;
        }
    }
}

/*
 * DUMP_BOARD
 *
 * Dump the contents of the current board position "cb_board".
 */

void
dump_board(board, outfile)
    u_char *board;
    FILE *outfile;
{
    int file, rank, piece, idx;

    fputs("   a b c d e f g h\n +-----------------+\n", outfile);
    for (rank = 7; rank >= 0; rank--) {
        fprintf(outfile, "%d| ", rank + 1);
        for (file = 0; file < 8; file++) {
            piece = board[to_offset(file, rank)];
            if (piece == 0xff) {
                fputc('*', outfile);
            } else {
                idx = piece & 0x7;
                if (piece & 0x8 && idx)
                    fputc(piece_list[idx] + 'a' - 'A', outfile);
                else
                    fputc(piece_list[idx], outfile);
            }
            fputc(' ', outfile);
        }
        fprintf(outfile, "|%d\n", rank + 1);
    }
    fputs(" +-----------------+\n   a b c d e f g h\n", outfile);
}

char
dump_piece(piece)
    u_char piece;
{
    if (piece > 7)
        return '?';
    return piece_list[piece];
}

/*
 * ERROR
 *
 * Report error to user.
 *
 * Returns the number of characters printed.
 */
#ifdef ANSI_C
int
error(char *fmt,...)
{
    va_list ap;
    int ret;

    if (no_error)
        return 0;

    va_start(ap, fmt);
    ret = vfprintf(stdout, fmt, ap);
    va_end(ap);
    fputc('\n', stdout);
    fflush(stdout);
    return ret;
}
#else                                  /* ANSI_C */
int
error(va_alist)
va_dcl
{
    va_list ap;
    char *fmt;
    int ret;

    if (no_error)
        return 0;

    va_start(ap);
    fmt = va_arg(ap, char *);
    ret = vfprintf(stdout, fmt, ap);
    va_end(ap);
    fputc('\n', stdout);
    fflush(stdout);
    return ret;
}
#endif                                 /* ANSI_C */
#ifdef MSDOS
#include <dos.h>
#include <errno.h>

static char *path = NULL, *dbspec = NULL, *retfile = NULL;
static int nfiles = -1;

static struct _find_t db_file;

#define DIRSPEC "\\*.cbf"              /* filespec for directories */

/*
 * FIND_DATABASE_INIT
 *
 * Initialise the find_database() variables etc.
 */
int
find_database_init(filespec)
    char *filespec;
{
    int len, is_a_dir;
    char *cptr;

    find_database_exit();

    is_a_dir = isdir(filespec) == 1 ? 1 : 0;

 /* create the path string containing just the pathname */
    if (is_a_dir) {
        len = strlen(filespec);
    } else {
        cptr = rindex(filespec, PATHSEP);
        if (cptr)
            len = cptr - filespec;
        else
            len = 0;
    }
    if (len) {
        path = mem_alloc(len + 1);
        if (!path)
            return -1;
        strncpy(path, filespec, len);
    } else {
        path = NULL;
    }

    if (is_a_dir) {
        dbspec = mem_alloc(len + sizeof(DIRSPEC) + 1);
        if (!dbspec) {
            find_database_exit();
            return -1;
        }
        strcpy(dbspec, filespec);
        strcat(dbspec, DIRSPEC);
    } else {
        kill_ext(filespec);            /* damages input file! */
        dbspec = derive_name(filespec, ".cbf");
        if (!dbspec) {
            find_database_exit();
            return -1;
        }
    }

 /* create buffer for output filename */
    retfile = mem_alloc(len + MAX_FNAMELEN + 2);
    if (!retfile) {
        find_database_exit();
        return -1;
    }
    nfiles = 0;
}

/*
 * FIND_DATABASE
 *
 * Find the next (or first) database that matches the filespec passed to
 * find_database_init().
 */
char *
find_database()
{
    int status;

    if (nfiles == -1)
        return NULL;

    if (nfiles == 0) {
        status = _dos_findfirst(dbspec, _A_NORMAL, &db_file);
        if (status)
            error("%s: %s", dbspec, strerror(errno));
    } else {
        status = _dos_findnext(&db_file);
    }

    nfiles++;

    if (status == 0) {
        if (path) {
            strcpy(retfile, path);
            strcat(retfile, "\\");
        } else {
            *retfile = '\0';
        }
        strcat(retfile, db_file.name);
        strlower(retfile);
        kill_ext(retfile);
        return retfile;
    }
    return NULL;
}

/*
 * FIND_DATABASE_EXIT
 *
 * Clearup
 */
int
find_database_exit()
{
    if (path) {
        free(path);
        path = NULL;
    }
    if (dbspec) {
        free(dbspec);
        dbspec = NULL;
    }
    if (retfile) {
        free(retfile);
        retfile = NULL;
    }
    nfiles = -1;

    return 0;
}

#else                                  /* !MSDOS */

static char *filename;
/*
 * FIND_DATABASE_INIT
 *
 * Initialise the find_database() variables etc.
 */
int
find_database_init(filespec)
    char *filespec;
{
    int len;

    /* if the filespec has a period in it, then check if the name ends with
       '.cbf' */
    len = strlen(filespec);
    if (index(filespec, '.')) {
        if (len > 4 && strcmp(filespec + (len - 4), ".cbf") == 0)
            filename = filespec;
        else
            filename = NULL;
    } else {
        /* assume OK */
        filename = filespec;
    }
    return 0;
}

/*
 * FIND_DATABASE
 *
 * Find the next (or first) database that matches the filespec passed to
 * find_database_init().
 */
char *
find_database()
{
    char *ret;

    if (filename) {
        ret = filename;
        filename = NULL;
        return ret;
    }
    return NULL;;
}

/*
 * FIND_DATABASE_EXIT
 *
 * Clearup
 */
int
find_database_exit()
{
    filename = NULL;
    return 0;
}

#endif                                 /* MSDOS */

/*
 * FIND_EXT
 *
 * Locate the extension of a pathname.
 */
char *
find_ext(path)
    char *path;
{
    register char *cptr;

    cptr = rindex(path, PATHSEP);
    if (!cptr)
        cptr = path;
    cptr = rindex(cptr, '.');
    if (!cptr)
        return NULL;
    return cptr + 1;
}

/*
 * FILE_CLOSE
 *
 * Close an open file.
 */
int
file_close(file)
    File file;
{
    int ret = 0;

    if (!file) {
        ret = -1;
    } else {
        if (file->fd >= 0 && close(file->fd) != 0) {
            error("error closing file \"%s\"", file->name);
            ret = -1;
        }
        free(file->name);
        free(file);
    }

    return ret;
}

#define COPY_BUF_SZ     8192

/*
 * FILE_COPY
 *
 * Copy the data from one file into the other
 */
int
file_copy(from, to)
    File from, to;
{
    char *buf;
    int nread;

    buf = mem_alloc(COPY_BUF_SZ);
    if (!buf)
        return -1;

    file_seek(from, 0L);
    file_seek(to, 0L);

    do {
    /* use fread() to avoid error messages */
        nread = read(from->fd, buf, COPY_BUF_SZ);
        if (file_write(to, buf, nread) != nread)
            return -1;
    } while (nread == COPY_BUF_SZ);

    free(buf);
}

/*
 * FILE_DELETE
 *
 * Close and delete an open file.
 */
int
file_delete(file)
    File file;
{
    int ret = 0;

    if (!file) {
        ret = -1;
    } else {
        if (close(file->fd) != 0) {
            error("error closing file \"%s\"", file->name);
            ret = -1;
        }
        if (unlink(file->name) < 0) {
            error("error deleting file \"%s\"", file->name);
            ret = -1;
        }
        free(file->name);
        free(file);
    }

    return ret;
}

/*
 * FILE_GETC
 *
 * Get a character from a file.
 */
int
file_getc(file)
    File file;
{
    int ret;
    char buffer;

    ret = read(file->fd, &buffer, 1);
    if (ret != 1)
        error("error reading file \"%s\" %s", file->name,
          ret == 0 ? "(EOF)" : "");
    return buffer;
}

/*
 * FILE_LENGTH
 *
 * Return the length of an open file
 */
u_long
file_length(fd)
    int fd;
{
    struct stat statbuf;

    if (fstat(fd, &statbuf) < 0)
        return 0;
    else
        return statbuf.st_size;
}

/*
 * FILE_OPEN
 *
 * Open a file
 */
File
file_open(name, mode)
    char *name, *mode;
{
    File ret;
    int fd, openmode;

    openmode = 0;

    if (*mode == 'r') {
        if (*(mode + 1) == '+') {
            openmode = O_RDWR;
            mode += 2;
        } else {
            openmode = O_RDONLY;
            mode++;
        }
    } else if (*mode == 'w') {
        if (*(mode + 1) == '+') {
            openmode = O_CREAT | O_TRUNC | O_RDWR;
            mode += 2;
        } else {
            openmode = O_CREAT | O_TRUNC | O_WRONLY;
            mode++;
        }
    } else if (*mode == 'a') {
        if (*(mode + 1) == '+') {
            openmode = O_APPEND | O_RDWR;
            mode += 2;
        } else {
            openmode = O_APPEND;
            mode++;
        }
    } else
        return NULL;

#ifdef MSDOS
    if (*mode == 't')
        openmode |= O_TEXT;
    else if (*mode == 'b')
        openmode |= O_BINARY;
#endif                                 /* MSDOS */

    fd = open(name, openmode, OPENMODE);
    if (fd < 0) {
        error("error opening file \"%s\"", name);
        return NULL;
    }
    ret = (File) mem_alloc(sizeof(struct file));
    if (!ret)
        return NULL;
    ret->name = xstrdup(name);
    if (!ret->name)
        goto fail;
    ret->mode = openmode & ~(O_APPEND | O_TRUNC | O_CREAT);
    ret->fd = fd;

    return ret;

fail:
    close(ret->fd);
    if (ret->name)
        free(ret->name);
    free(ret);
    return NULL;
}

/*
 * FILE_PUTC
 *
 * Put a character to a file.
 */
int
file_putc(file, c)
    File file;
    int c;
{
    int ret;
    char buffer;

    buffer = (char) c;
    ret = write(file->fd, &buffer, 1);
    if (ret != 1)
        error("error writing file \"%s\"", file->name);
    return ret;
}

/*
 * FILE_READ
 *
 * Read data from a file.
 */
int
file_read(file, buf, len)
    File file;
    char *buf;
    unsigned len;
{
    int nread;

    nread = read(file->fd, buf, len);
    if (nread == -1 || nread == 0)
        error("error reading file \"%s\" %s", file->name,
          nread == 0 ? "(EOF)" : "");
    return nread;
}

/*
 * FILE_RENAME
 *
 * Rename a file, maintaining the directory elements of the old name and
 * the extension.
 */
int
file_rename(file, newname)
    File file;
    char *newname;
{
    char *cptr, *newpath, *oldname;
    int len, ret;
    long offset;

 /* check that the new names doesn't have any path-seperators or dots */
    if (index(newname, PATHSEP)) {
        error("file_rename(): new name contains path seperators!");
        return -1;
    }
    if (index(newname, '.')) {
        error("file_rename(): new name contains dots!");
        return -1;
    }
    oldname = NULL;
    newpath = NULL;
    ret = 0;

    oldname = xstrdup(file->name);
    if (!oldname)
        return -1;

    cptr = rindex(oldname, PATHSEP);
    if (cptr)
        len = (cptr + 1) - oldname;
    else
        len = 0;
    newpath = mem_alloc(len + 14);
    if (!newpath)
        goto quit;
    strncpy(newpath, oldname, len);
    strcat(newpath, newname);
    cptr = find_ext(oldname);
    if (cptr) {
        strcat(newpath, ".");
        strcat(newpath, cptr);
    }
    offset = file_tell(file);
    close(file->fd);
    free(file->name);
    file->name = newpath;
    newpath = NULL;

    if (rename(oldname, file->name) == 0) {
        file->fd = open(file->name, file->mode, OPENMODE);
        if (file->fd < 0) {
            error("error re-opening file \"%s\"", file->name);
            file_close(file);
            ret = -1;
        } else {
            file_seek(file, offset);
        }
    } else {
        error("error renaming file \"%s\" to \"%s\"",
          oldname, file->name);
        ret = -1;
    }
quit:
    if (oldname)
        free(oldname);
    if (newpath)
        free(newpath);
    return ret;
}

/*
 * FILE_WRITE
 *
 * Write data to a file.
 */
int 
file_write(file, buf, len)
    File file;
    char *buf;
    unsigned len;
{
    unsigned nwrote;

    nwrote = write(file->fd, buf, len);
    if (nwrote != len)
        error("error writing file \"%s\"", file->name);
    return nwrote;
}

/*
 * FORMAT_INFO
 *
 * Format the information about a game into a string.
 */
char *
format_info(game, brief)
    Game game;
    int brief;
{
    register int i;
    char pinfo[26], sinfo[24], year[5], eco[8];
    static char line[80];

    for (i = 0; i < 25; i++) {
        pinfo[i] = game->pinfo[i];
        if (pinfo[i] == '\0')
            break;
    }
    for (; i < 25; i++)
        pinfo[i] = ' ';
    pinfo[25] = '\0';

    for (i = 0; i < 23; i++) {
        sinfo[i] = game->sinfo[i];
        if (sinfo[i] == '\0')
            break;
    }
    for (; i < 23; i++)
        sinfo[i] = ' ';
    sinfo[23] = '\0';

    if (brief) {
        sprintf(line, "%-5lu %s %s", game->num, pinfo, sinfo);
        return line;
    }
    if (game->year)
        sprintf(year, "%d", game->year);
    else
        strcpy(year, "    ");

    if (game->eco_letter)
        sprintf(eco, "%c%02d", game->eco_letter, game->eco_main);
    else
        strcpy(eco, "   ");

    sprintf(line, "%-5lu %s %s %s %s %4s %3d %c", game->num, pinfo, sinfo,
      eco, year, cvt_result(get_result(game->header)), game->nmoves,
      is_partial(game->header) ? 'p' : ' ');

    return line;
}

static char *prom_list = "QRBN";

/*
 * FORMAT_MOVE
 *
 * Return a string contains the text of a move.
 */
char *
format_move(move)
    Move move;
{
    static char movetxt[8];

    movetxt[0] = to_file(move->from) + 'a';
    movetxt[1] = to_rank(move->from) + '1';
    movetxt[2] = to_file(move->to) + 'a';
    movetxt[3] = to_rank(move->to) + '1';
    if (move->prom) {
        movetxt[4] = '=';
        movetxt[5] = prom_list[move->prom];
        movetxt[6] = '\0';
    } else
        movetxt[4] = '\0';
    return movetxt;
}

/*
 * FORMAT_MOVENUM
 *
 * Return text in the form "XX." or "XX..." depending on the move number.
 */
char *
format_movenum(halfmove)
    unsigned halfmove;
{
    static char buf[8];

    sprintf(buf, "%d%s ", to_move(halfmove),
      to_colour(halfmove) ? "..." : ".");
    return buf;
}

u_char gamebuf[128] = "";              /* read/write workspace */
int ignore_chksum_err = 0;             /* ignore checksum errors */
int chksum_err = 0;                    /* non-zero if a checksum error
                                          occurred */

/*
 * GAME_FREE
 *
 * Free a game structure
 */
void
game_free(game)
    Game game;
{
    game_tidy(game);
    free(game);
}

/*
 * GAME_TIDY
 *
 * Tidy up a game structure
 */
void
game_tidy(game)
    Game game;
{
    if (game->moves)
        free(game->moves);
    if (game->comments)
        free(game->comments);
    bzero((char *) game, sizeof(struct game));
}

/*
 * get option letter from argument vector
 */
int opterr = 1,                        /* if error message should be printed */
 optind = 1,                           /* index into parent argv vector */
 optopt;                               /* character checked for validity */
char *optarg;                          /* argument associated with option */

#define BADCH   (int)'?'
#define EMSG    ""

int
getopt(nargc, nargv, ostr)
    int nargc;
    char **nargv;
    char *ostr;
{
    static char *place = EMSG;         /* option letter processing */
    register char *oli;                /* option letter list index */
    char *p;

    if (!*place) {                     /* update scanning pointer */
        if (optind >= nargc || *(place = nargv[optind]) != '-') {
            place = EMSG;
            return (EOF);
        }
        if (place[1] && *++place == '-') {      /* found "--" */
            ++optind;
            place = EMSG;
            return (EOF);
        }
    }                                  /* option letter okay? */
    if ((optopt = (int) *place++) == (int) ':' ||
      !(oli = index(ostr, optopt))) {
    /* if the user didn't specify '-' as an option, assume it means EOF. */
        if (optopt == (int) '-')
            return (EOF);
        if (!*place)
            ++optind;
        if (opterr) {
            if (!(p = rindex(*nargv, '/')))
                p = *nargv;
            else
                ++p;
            (void) fprintf(stdout, "%s: illegal option -- %c\n",
              p, optopt);
        }
        return (BADCH);
    }
    if (*++oli != ':') {               /* don't need argument */
        optarg = NULL;
        if (!*place)
            ++optind;
    } else {                           /* need an argument */
        if (*place)                    /* no white space */
            optarg = place;
        else if (nargc <= ++optind) {  /* no arg */
            place = EMSG;
            if (!(p = rindex(*nargv, '/')))
                p = *nargv;
            else
                ++p;
            if (opterr)
                (void) fprintf(stdout,
                  "%s: option requires an argument -- %c\n",
                  p, optopt);
            return (BADCH);
        } else                         /* white space */
            optarg = nargv[optind];
        place = EMSG;
        ++optind;
    }
    return (optopt);                   /* dump back option letter */
}

/*
 * GET_WORD
 *
 * Locate the next word in a string and return a pointer to it, and it's
 * size.
 */
char *
get_word(s, len)
    char *s;
    int *len;
{
    int wlen;
    char *ret;

    wlen = 0;
    while (*s && isspace(*s))
        s++;
    ret = s;
    while (*s && !isspace(*s)) {
        s++;
        wlen++;
    }
    if (len)
        *len = wlen;
    if (!wlen)
        ret = NULL;
    return ret;
}

/*
 * HIT_RETURN
 *
 * Ask user to hit return to continue;
 */
int
hit_return()
{
    int quit, c;

    printf("[Hit <CR> to continue, or Q<CR> to quit]");
    quit = 0;
    for (;;) {
        c = getchar();
        if (c == 'q')
            quit = 1;
        else if (c == '\n')
            break;
        else
            quit = 0;
    }
    return quit;
}

static char first[8] = {
    ROOK, KNIGHT, BISHOP, QUEEN, KING, BISHOP, KNIGHT, ROOK
};

/*
 * INIT_BOARD
 *
 * Initialise pieces on board.
 */
void
init_board(board)
    u_char *board;
{
    int i;

    for (i = 0; i < 8; i++) {
        board[0 + i * 8] = first[i];
        board[7 + i * 8] = first[i] + 8;
        board[1 + i * 8] = PAWN;
        board[6 + i * 8] = PAWN + 8;
        board[2 + i * 8] = 0;
        board[3 + i * 8] = 0;
        board[4 + i * 8] = 0;
        board[5 + i * 8] = 0;
    }
}

/*
 * ISDIR
 *
 * Return 1 if the named file is a directory, 0 if the named file is some
 * other form of object, and -1 if an error occurs determining its type.
 */
int
isdir(dir)
    char *dir;
{
    struct stat statbuf;

    if (stat(dir, &statbuf) < 0)
        return -1;
    if (statbuf.st_mode & S_IFDIR)
        return 1;
    return 0;
}

/*
 * ISFILE
 *
 * Return 1 if the named file is a plain file, 0 if the named file is some
 * other form of object, and -1 if an error occurs determining its type.
 */
int
isfile(file)
    char *file;
{
    struct stat statbuf;

    if (stat(file, &statbuf) < 0)
        return -1;
    if (statbuf.st_mode & S_IFREG)
        return 1;
    return 0;
}

/*
 * IS_MATE
 *
 * Returns 1 if the current position is mate.
 *
 * "colour" is the side that has just made a move.
 */
int
is_mate(colour)
    int colour;
{
    u_char orig_board[64];
    int orig_ep, i;
    Move moveptr;
    struct move saved_lastmove;
    int saved_lastmove_num;
    u_short saved_lastmove_flags;

    copy_board(cb_board, orig_board);
    orig_ep = cb_enpassant;
    saved_lastmove = lastmove;
    saved_lastmove_num = lastmove_num;
    saved_lastmove_flags = lastmove_flags;

 /* generate a list of posible moves available to the opponent */
    gen_movelist(colour ? 0 : 1);

 /* do each move and check if check; if one is not check then it's not
    checkmate */
    for (i = 0; i < moveidx; i++) {
        copy_board(orig_board, cb_board);
        cb_enpassant = orig_ep;
        moveptr = &movelist[i];
        do_move(moveptr->from, moveptr->to, moveptr->prom);
        if (!is_check(colour))
            break;
    }
    copy_board(orig_board, cb_board);
    cb_enpassant = orig_ep;
    lastmove = saved_lastmove;
    lastmove_num = saved_lastmove_num;
    lastmove_flags = saved_lastmove_flags;

    if (i == moveidx)
        return 1;                      /* mate */
    return 0;
}

/*
 * KILL_EXT
 *
 * Remove the extension of a pathname.
 */
char *
kill_ext(path)
    char *path;
{
    register char *cptr;

    cptr = find_ext(path);
    if (!cptr)
        return NULL;
    *(cptr - 1) = '\0';
    return cptr;
}

/*
 * KR_GETENTRY
 *
 * Convert an external (3-byte) entry into an unsigned long word.
 */
u_long
kr_getentry(xe)
    u_char *xe;
{
    u_long ret = 0L;

    ret = (u_long) * xe++ << 16;
    ret |= (u_long) * xe++ << 8;
    ret |= (u_long) * xe++;

    return ret;
}

/*
 * KR_PUTENTRY
 *
 * Convert an unsigned long word into an external (3-byte) entry.
 */
void
kr_putentry(value, xe)
    u_long value;
    u_char *xe;
{

    *xe++ = (u_char) (value >> 16);
    *xe++ = (u_char) (value >> 8);
    *xe = (u_char) value;
}

/*
 * KR_READ
 *
 * Read a key record from a file.
 *
 * Returns -1 upon error.
 */
int
kr_read(file, recnum)
    File file;
    u_long recnum;
{
    KR kr_addr;
    u_char xkr[80];
    u_short type;
    int i;

    kr_addr = (KR) mps_getblk(recnum);
    if (!kr_addr)
        return -1;

    if (file_read(file, (char *) xkr, sizeof(xkr)) != sizeof(xkr))
        return -1;

    type = (u_short) (xkr[0] << 8);
    type |= (u_short) xkr[1];

    switch (type) {
    case KR_EMPTY_TYPE:
        bzero(kr_addr, sizeof(struct kr));
        break;
    case KR_MASTER_TYPE:
        kr_addr->data.m.nkeys = kr_getentry(&xkr[8]);
        kr_addr->data.m.nrecs = kr_getentry(&xkr[11]);
        kr_addr->data.m.lastgame = kr_getentry(&xkr[14]);
        break;
    case KR_KEY_TYPE:
        kr_addr->data.k.index = kr_getentry(&xkr[8]);
        bcopy(&xkr[11], kr_addr->data.k.name, KEY_NAME_LEN);
        break;
    case KR_INDEX_TYPE:
        for (i = 0; i < KR_ENTRY_MAX; i++)
            kr_addr->data.i.entry[i] = kr_getentry(&xkr[(i * 3) + 8]);
        break;
    default:
        break;
    }

    kr_addr->type = type;
    kr_addr->next = kr_getentry(&xkr[2]);
    kr_addr->prev = kr_getentry(&xkr[5]);

    return 0;
}

/*
 * KR_READ_ALL
 *
 * Read a whole key file.
 */
int
kr_read_all(file)
    File file;
{
    register u_long i;
    u_long nrecs;
    KR kr_addr;

    file_seek(file, 0L);

    if (mps_addblk(0L) < 0)
        return -1;
    if (kr_read(file, 0L) < 0)
        return -1;
    kr_addr = (KR) mps_getblk(0L);
    if (!kr_addr)
        return -1;
    if (kr_addr->type != KR_MASTER_TYPE) {
        error("master key record not first record in file!");
        return -1;
    }
    nrecs = kr_addr->data.m.nrecs;
    for (i = 1; i < nrecs; i++) {
        if (mps_addblk(i) < 0)
            return -1;
        if (kr_read(file, i) < 0)
            return -1;
    }
    return 0;
}

/*
 * KR_WRITE
 *
 * Write a key record to a file.
 *
 * Returns -1 upon error.
 */
int
kr_write(file, recnum)
    File file;
    u_long recnum;
{
    KR kr_addr;
    u_char xkr[80];
    u_short type;
    int i;

    kr_addr = (KR) mps_getblk(recnum);
    if (!kr_addr)
        return -1;

    type = kr_addr->type;

    switch (type) {
    case KR_MASTER_TYPE:
        kr_putentry(kr_addr->data.m.nkeys, &xkr[8]);
        kr_putentry(kr_addr->data.m.nrecs, &xkr[11]);
        kr_putentry(kr_addr->data.m.lastgame, &xkr[14]);
        bcopy(kr_addr->data.m.title, &xkr[17], MASTER_TITLE_LEN);
        break;
    case KR_KEY_TYPE:
        kr_putentry(kr_addr->data.k.index, &xkr[8]);
        bcopy(kr_addr->data.k.name, &xkr[11], KEY_NAME_LEN);
        break;
    case KR_INDEX_TYPE:
        for (i = 0; i < KR_ENTRY_MAX; i++)
            kr_putentry(kr_addr->data.i.entry[i], &xkr[(i * 3) + 8]);
        break;
    default:
        bzero(xkr, 80);
        break;
    }

    xkr[0] = (u_char) (type >> 8);
    xkr[1] = (u_char) type;
    kr_putentry(kr_addr->next, &xkr[2]);
    kr_putentry(kr_addr->prev, &xkr[5]);

    if (file_write(file, (char *) xkr, 80) != 80)
        return -1;
    return 0;
}

/*
 * L2C
 *
 * Convert an unsigned long to an array of bytes in big-endian format
 */
void
l2c(c, value)
    u_char *c;
    u_long value;
{
    *c++ = (u_char) (value >> 24);
    *c++ = (u_char) (value >> 16);
    *c++ = (u_char) (value >> 8);
    *c = (u_char) (value);
}

static u_char get_move P__((u_char ** mpptr, int *lenptr));

/*
 * MATCH_MOVES
 *
 * Test two lists of moves to see if they match, regardless of variations
 * and annotations.
 */
int
match_moves(mptr1, len1, mptr2, len2)
    u_char *mptr1, *mptr2;
    int len1, len2;
{
    do
        if (get_move(&mptr1, &len1) != get_move(&mptr2, &len2))
            return 0;
    while (len1 > 0 && len2 > 0);
    return 1;
}

/*
 * GET_MOVE
 *
 * Get the next main-line move from a list, and update the pointer.
 */
static u_char
get_move(mpptr, lenptr)
    u_char **mpptr;
    int *lenptr;
{
    int level, mlen;
    u_char *mptr, move;

    level = 0;
    mptr = *mpptr;
    mlen = *lenptr;
    move = *mptr++;
    mlen--;
    if (move == 0xff) {
        level++;
        while (level && mlen) {
            move = *mptr++;
            mlen--;
            if (move == 0xff)
                level++;
            else if (move == 0x80)
                level--;
        }
        move = *mptr++;
        mlen--;
    }
    *mpptr = mptr;
    *lenptr = mlen;
    return move & 0x7f;
}

/*
 * MEM_ALLOC
 *
 * Allocate memory with error-checking.
 */
char *
mem_alloc(len)
    unsigned len;
{
    register char *ret;

    ret = malloc(len);
    if (!ret) {
        error("memory exhausted");
        return NULL;
    }
    bzero(ret, len);
    return ret;
}
/*
 * Memory Paging System (emulator for non-MSDOS machines)
 */

#define PAGE_SZ         32768          /* size of a page */
#define NPAGES          288            /* number of pages */

#define FREE    0                      /* unallocated page */
#define ALLOC   1                      /* allocated page */

static u_short blksize;                /* size of a block */
static int bpp;                        /* blocks per page */
static char **page_index = NULL;       /* page index table */
static int *page_offset = NULL;        /* page offset table */
static char *tmp_block = NULL;         /* used during copy */
static int page, blocknum;             /* page and block calculated by
                                          get_blk() */

static PTR get_blk P__((u_long block));
/*
 * MPS_INIT
 *
 * Allocates memory for the page index and initilises the MemPage system.
 *
 * Returns: 0 upon success, else -1.
 */
int
mps_init(blocksize)
    u_short blocksize;
{
    register int i;
    int offset;

    mps_cleanup();
    blksize = blocksize;

    page_index = (char **) malloc(NPAGES * sizeof(char *));
    if (!page_index)
        goto init_error;

    bpp = PAGE_SZ / blocksize;

    page_offset = (int *) malloc(bpp * sizeof(int));
    if (!page_offset) {
        mps_cleanup();
        goto init_error;
    }
    for (i = offset = 0; i < bpp; i++) {
        page_offset[i] = offset;
        offset += blocksize;
    }

    tmp_block = malloc(blocksize);
    if (!tmp_block) {
        mps_cleanup();
        goto init_error;
    }
    bzero((char *) page_index, NPAGES * sizeof(char *));

    return 0;

init_error:
    error("memory init error");
    return -1;
}

/*
 * MPS_CLEANUP
 *
 * Free memory used by the MemPage System.
 */
int
mps_cleanup()
{
    register int i;

    if (page_index) {
        for (i = 0; i < NPAGES; i++)
            if (page_index[i])
                free(page_index[i]);
        free((char *) page_index);
        page_index = NULL;
    }
    if (page_offset) {
        free((char *) page_offset);
        page_offset = NULL;
    }
    if (tmp_block) {
        free(tmp_block);
        tmp_block = NULL;
    }
    return 0;
}

/*
 * MPS_ADDBLK
 *
 * Add a block, allocating memory pages as required.
 */
PTR
mps_addblk(block)
    u_long block;
{
    PTR ptr;

    ptr = get_blk(block);
    if (ptr)
        return ptr;
    page_index[page] = malloc(PAGE_SZ);
    if (!page_index[page]) {
        error("memory exhausted");
        return NULL;
    }
    return page_index[page] + page_offset[blocknum];
}

/*
 * MPS_GETBLK
 *
 * Get the address of a block, or NULL if not allocated.
 */
PTR
mps_getblk(block)
    u_long block;
{
    PTR ptr;

    ptr = get_blk(block);
    if (ptr)
        return ptr;
    error("memory error");
    return NULL;
}

/*
 * GET_BLK
 *
 * Get the address of a block, or NULL if not allocated.
 */
static PTR
get_blk(block)
    u_long block;
{
    page = block / (u_long) bpp;
    blocknum = block % (u_long) bpp;
    if (page_index[page])
        return page_index[page] + page_offset[blocknum];
    return NULL;
}

/*
 * MPS_SWAPBLK
 *
 * Swap the contents of two blocks.
 */
int
mps_swapblk(block1, block2)
    u_long block1, block2;
{
    PTR ptr1, ptr2;

    ptr1 = mps_getblk(block1);
    if (!ptr1)
        return -1;
    ptr2 = mps_getblk(block2);
    if (!ptr2)
        return -2;

    bcopy((char *) ptr1, tmp_block, blksize);
    bcopy((char *) ptr2, (char *) ptr1, blksize);
    bcopy(tmp_block, (char *) ptr2, blksize);
    return 0;
}

/*
 * MPS_COPYBLK
 *
 * Copy the contents of one block to another.
 */
int
mps_copyblk(block1, block2)
    u_long block1, block2;
{
    PTR ptr1, ptr2;

    ptr1 = mps_getblk(block1);
    if (!ptr1)
        return -1;
    ptr2 = mps_getblk(block2);
    if (!ptr2)
        return -1;

    bcopy((char *) ptr1, (char *) ptr2, blksize);
    return 0;
}

/*
 * MPS_TOBLK
 *
 * Copy data from external memory into a block.
 */
int
mps_toblk(block, mem)
    u_long block;
    PTR mem;
{
    PTR ptr;

    ptr = mps_getblk(block);
    if (!ptr)
        return -1;
    bcopy((char *) mem, (char *) ptr, blksize);
    return 0;
}
/*
 * MPS_FROMBLK
 *
 * Copy data to external memory into a block.
 */
int
mps_fromblk(block, mem)
    u_long block;
    PTR mem;
{
    PTR ptr;

    ptr = mps_getblk(block);
    if (!ptr)
        return -1;
    bcopy((char *) ptr, (char *) mem, blksize);
    return 0;
}

u_char cb_board[64] = "";              /* board position */
int cb_enpassant;                      /* en-passant mask */
int comment;                           /* comment available from last move */
struct move lastmove;                  /* last move made */
int lastmove_num;                      /* index of last move in movelist */
u_short lastmove_flags;                /* interesting move flags (castle,
                                          etc.) */
struct move movelist[NMOVELIST] = {{0, 0, 0}};  /* list of legal moves
                                                   available */
int moveidx;                           /* end of movelist marker */
int var_level;                         /* variation level */
u_char captured_piece;                 /* piece just captured */

static int king_offset = 0xff;         /* set if checking for check */
static int in_check;                   /* set if found check */
static Move moveptr;                   /* used by movelist_add() */

#define on_board(o,y,x) (((unsigned)(y + to_rank(o)) < 8) && ((unsigned)(x + to_file(o)) < 8))

static void movelist_add P__((int from, int to, int prom));
static void move_piece P__((int offset, int colour, int y, int x, int multi));
static void promote P__((int from, int to));

static void
movelist_add(from, to, prom)
    int from, to, prom;
{
    if (king_offset != 0xff) {
        if (to == king_offset)
            in_check++;
        return;
    }
    if (moveidx >= NMOVELIST) {
        error("movelist overflow!");
        return;
    }
    moveptr->from = from;
    moveptr->to = to;
    moveptr->prom = prom;
    moveptr++;
    moveidx++;
}

static void
move_piece(offset, colour, y, x, multi)
    int offset, colour, y, x, multi;
{
    int to, delta;

    to = offset;
    delta = (x * 8) + y;

    if (!on_board(to, y, x))
        return;
    do {
        to += delta;
        if (!cb_board[to])
            movelist_add(offset, to, 0);
        else if ((cb_board[to] ^ colour) > 8) {
            movelist_add(offset, to, 0);
            return;
        } else
            return;
    } while (multi && on_board(to, y, x));
}

static void
promote(from, to)
    int from, to;
{
    movelist_add(from, to, QUEEN);
    movelist_add(from, to, ROOK);
    movelist_add(from, to, BISHOP);
    movelist_add(from, to, KNIGHT);
}

/*
 * IS_CHECK
 *
 * Test whether a side is in check.
 *
 * "colour" is the side which has just made a move.
 */
int
is_check(colour)
    int colour;
{
    register int i;
    int moveidx_orig;
    u_char enemy_king;

 /* generate the enemy king bits */
    enemy_king = KING;
    if (!colour)
        enemy_king |= 8;

    king_offset = 0xff;
    moveidx_orig = moveidx;
    for (i = 0; i < 64; i++) {
        if (cb_board[i] == enemy_king) {
            king_offset = i;
            break;
        }
    }
    if (king_offset == 0xff)
        return 0;                      /* No enemy king, so it can't be in
                                          check */

    in_check = 0;

    gen_movelist(colour);

    king_offset = 0xff;                /* reset */
    moveidx = moveidx_orig;

    return in_check;
}

/*
 * GEN_MOVELIST
 *
 * Create a list of all possible moves for a particular colour.
 *
 * Arguments:
 *      colour: non-zero for black moves, else white.
 */
int
gen_movelist(colour)
    int colour;
{
    register int offset;

    moveidx = 0;
    moveptr = &movelist[0];

    if (colour)
        colour = 8;                    /* convert to "colour bit" */
    for (offset = 0; offset < 64; offset++) {
        switch ((cb_board[offset] & 0xf) ^ colour) {
        case KING:{
                int to;

                move_piece(offset, colour, -1, -1, 0);
                move_piece(offset, colour, 0, -1, 0);
                move_piece(offset, colour, 1, -1, 0);
                move_piece(offset, colour, -1, 0, 0);
                move_piece(offset, colour, 1, 0, 0);
                move_piece(offset, colour, -1, 1, 0);
                move_piece(offset, colour, 0, 1, 0);
                move_piece(offset, colour, 1, 1, 0);
                if ((!colour && (offset == 32)) || (colour && (offset == 39))) {
                    to = offset + 16;
                    if (cb_board[offset + 24] == (u_char) (ROOK + colour) &&
                      !cb_board[to] && !cb_board[offset + 8])
                        movelist_add(offset, to, 0);
                    to = offset - 16;
                    if (cb_board[offset - 32] == (u_char) (ROOK + colour) &&
                      !cb_board[offset - 24] && !cb_board[to] &&
                      !cb_board[offset - 8])
                        movelist_add(offset, to, 0);
                }
            }
            break;
        case QUEEN:
            move_piece(offset, colour, -1, -1, 1);
            move_piece(offset, colour, -1, 1, 1);
            move_piece(offset, colour, 1, 1, 1);
            move_piece(offset, colour, 1, -1, 1);
            move_piece(offset, colour, 0, -1, 1);
            move_piece(offset, colour, -1, 0, 1);
            move_piece(offset, colour, 0, 1, 1);
            move_piece(offset, colour, 1, 0, 1);
            break;
        case KNIGHT:
            move_piece(offset, colour, -1, -2, 0);
            move_piece(offset, colour, 1, -2, 0);
            move_piece(offset, colour, -1, 2, 0);
            move_piece(offset, colour, 1, 2, 0);
            move_piece(offset, colour, -2, -1, 0);
            move_piece(offset, colour, 2, -1, 0);
            move_piece(offset, colour, -2, 1, 0);
            move_piece(offset, colour, 2, 1, 0);
            break;
        case BISHOP:
            move_piece(offset, colour, -1, -1, 1);
            move_piece(offset, colour, -1, 1, 1);
            move_piece(offset, colour, 1, 1, 1);
            move_piece(offset, colour, 1, -1, 1);
            break;
        case ROOK:
            move_piece(offset, colour, 0, -1, 1);
            move_piece(offset, colour, -1, 0, 1);
            move_piece(offset, colour, 0, 1, 1);
            move_piece(offset, colour, 1, 0, 1);
            break;
        case PAWN:{
                int h, to, dir, pl;

                if (colour) {
                    dir = -1;          /* black */
                    pl = 6;
                } else {
                    dir = 1;           /* white */
                    pl = 1;
                }
                to = offset + dir;
                if (!cb_board[to]) {
                    to += dir;
                    if (to_rank(offset) == pl && !cb_board[to])
                        movelist_add(offset, to, 0);
                    to -= dir;
                    if (to_rank(to) == 7 - pl + dir)
                        promote(offset, to);
                    else
                        movelist_add(offset, to, 0);
                }
                to = offset - 8 + dir;
                if (offset & 0x38 && (cb_board[to] ^ colour) > 8)
                    if (to_rank(to) == 7 - pl + dir)
                        promote(offset, to);
                    else
                        movelist_add(offset, to, 0);
                to = offset + 8 + dir;
                if ((offset & 0x38) != 0x38 && (cb_board[to] ^ colour) > 8)
                    if (to_rank(to) == 7 - pl + dir)
                        promote(offset, to);
                    else
                        movelist_add(offset, to, 0);
                if (to_rank(offset) == pl + 3 * dir) {
                    h = to_file(offset) - cb_enpassant;
                    to = offset - 8 + dir;
                    if (!h)
                        movelist_add(offset, to, 0);
                    to = offset + 8 + dir;
                    if (h == -2)
                        movelist_add(offset, to, 0);
                }
            }
            break;
        }
    }

    return moveidx;
}

/*
 * NEWLINE
 *
 * Print a newline character
 */
int
newline()
{
    putchar('\n');
    return 0;
}

/*
 * ALGEBRAIC
 *
 * Return the algebraic notation for the move just made.
 */
char *
algebraic(colour)
    int colour;
{
    register int i;
    Move tmove;
    u_char cpiece, piece;
    char ambig_file, ambig_rank;
    static char notation[16];

    ambig_file = 0;
    ambig_rank = 0;

    if (colour)
        colour = 8;
    if (lastmove_flags == SHORT_CASTLE) {
        strcpy(notation, "O-O");
        i = 3;
    } else if (lastmove_flags == LONG_CASTLE) {
        strcpy(notation, "O-O-O");
        i = 5;
    } else {
    /* normal move */
        if (lastmove.prom) {
            cpiece = PAWN | colour;
            piece = PAWN;
        } else {
            cpiece = cb_board[lastmove.to];
            piece = cpiece & 7;
        }

    /* find any other pieces that could move into the same square */
        if (piece != PAWN) {
            for (i = 0; i < moveidx; i++) {
                if (i == lastmove_num)
                    continue;
                tmove = &movelist[i];
                if ((tmove->to == lastmove.to) &&
                  (cb_board[tmove->from] == cpiece)) {
                /* ambiguity (may be file, rank or both) */
                    if (to_rank(lastmove.from) == to_rank(tmove->from))
                        ambig_file = to_file(lastmove.from) + 'a';
                    if (to_file(lastmove.from) == to_file(tmove->from))
                        ambig_rank = to_rank(lastmove.from) + '1';
                    if (!ambig_file && !ambig_rank)
                        ambig_file = to_file(lastmove.from) + 'a';
                }
            }
        }
        i = 0;

        if (piece == PAWN) {
            if (lastmove_flags & CAPTURE)
                notation[i++] = to_file(lastmove.from) + 'a';
        } else {
            notation[i++] = piece_list[piece];
        }
        if (ambig_file)
            notation[i++] = ambig_file;
        if (ambig_rank)
            notation[i++] = ambig_rank;
        if (lastmove_flags & CAPTURE)
            notation[i++] = 'x';
        notation[i++] = to_file(lastmove.to) + 'a';
        notation[i++] = to_rank(lastmove.to) + '1';
        if (lastmove.prom) {
            notation[i++] = '=';
            notation[i++] = piece_list[lastmove.prom];
        }
    }

    if (is_check(colour)) {
        if (is_mate(colour))
            notation[i++] = '#';
        else
            notation[i++] = '+';
    }
    notation[i] = '\0';
    return notation;
}

int no_error = 0;

/*
 * OPEN_DATABASE
 *
 * Open a ChessBase database.
 */
Database
open_database(name)
    char *name;
{
    Database db;
    char *filename;

    db = (Database) mem_alloc(sizeof(struct database));
    if (!db)
        return NULL;

 /* open the games file (.CBF) */
    filename = derive_name(name, ".cbf");
    if (!filename)
        goto failed;
    db->cbf = file_open(filename, "r+b");
    free(filename);
    if (!db->cbf)
        goto failed;

 /* open the index file (.CBI) */
    filename = derive_name(name, ".cbi");
    if (!filename)
        goto failed;
    db->cbi = file_open(filename, "r+b");
    free(filename);
    if (!db->cbi)
        goto failed;

 /* read the "number of games" value from the index file */
    read_ngames(db);

    return db;

failed:
    close_database(db);
    return NULL;
};

/*
 * OUTPUT
 *
 * Write a message to the screen
 *
 * Returns the number of characters printed.
 */

#ifdef ANSI_C
int
output(char *fmt,...)
{
    va_list ap;
    int ret;

    va_start(ap, fmt);
    ret = vfprintf(stdout, fmt, ap);
    va_end(ap);
    fflush(stdout);
    return ret;
}
#else                                  /* ANSI_C */
int
output(va_alist)
va_dcl
{
    va_list ap;
    char *fmt;
    int ret;

    va_start(ap);
    fmt = va_arg(ap, char *);
    ret = vfprintf(stdout, fmt, ap);
    va_end(ap);
    fflush(stdout);
    return ret;
}
#endif                                 /* ANSI_C */
char *piece_list = "-KQNBRP*";


static Game dgm_game;
static int dgm_movepos, maxmove;
static int (*dgm_func) P__((int halfmove));
static int ret;
/* renamed moveptr to moveptr1 for Amiga use!!!  OP */

static u_char *moveptr1;

static int do_game_move P__((int halfmove));

/*
 * PROCESS_MOVES
 *
 * Extract every move from a game, generate the movelist and board for each
 * move and call a user-defined function for each move.  If the user-defined
 * function returns non-zero, then processing stops and that value is
 * returned to the caller.
 */
int
process_moves(game, func)
    Game game;
    int (*func) P__((int halfmove));
{
    dgm_game = game;
    dgm_movepos = 0;
    dgm_func = func;
    var_level = 0;
    ret = 0;
    maxmove = game->mlen;
    moveptr1 = game->moves;
    copy_board(game->board, cb_board);
    cb_enpassant = game->ep;
    return do_game_move(game->halfmove);
}

/*
 * DO_GAME_MOVE
 *
 * Process a single line (recursive).
 */
static int
do_game_move(halfmove)
    int halfmove;
{
    register int movenum;
    u_char saved_board[64], prev_board[64];
    int saved_enpassant, prev_enpassant;

    copy_board(cb_board, prev_board);
    prev_enpassant = cb_enpassant;

    while (dgm_movepos < maxmove) {

        movenum = *moveptr1++;
        dgm_movepos++;

        if (movenum == 0x80) {         /* end of variation */

            if (!var_level) {
                error("game %lu (h=%d, v=%d): spurious variation-end marker",
                  dgm_game->num, halfmove, var_level);
                return -1;
            }
            if (dgm_func) {
                ret = dgm_func(END_VAR_SIGNAL);
                if (ret)
                    return ret;
            }
            var_level--;
            return 0;

        } else if (movenum == 0xff) {  /* start of variation */

            if (dgm_func) {
                ret = dgm_func(START_VAR_SIGNAL);
                if (ret)
                    return ret;
            }
        /* save current (main line) board and ep mask and copy in previous
           board and ep mask */
            copy_board(cb_board, saved_board);
            saved_enpassant = cb_enpassant;
            copy_board(prev_board, cb_board);
            cb_enpassant = prev_enpassant;
            var_level++;
            ret = do_game_move(halfmove - 1);
            if (ret)
                return ret;
        /* restore main line board and ep mask */
            copy_board(saved_board, cb_board);
            cb_enpassant = saved_enpassant;

        } else {                       /* ordinary move */

        /* save a copy of the previous board and ep mask for any future
           variations */
            copy_board(cb_board, prev_board);
            prev_enpassant = cb_enpassant;

            comment = movenum & 0x80;
            movenum = (movenum & 0x7f) - 1;     /* base zero for move list */

            gen_movelist(to_colour(halfmove));

            if (movenum >= moveidx) {
                error("game %lu (h=%d, v=%d): move number (%d) out of range",
                  dgm_game->num, halfmove, var_level, movenum);
                return -1;
            }
            lastmove = movelist[movenum];
            lastmove_num = movenum;

            do_move(lastmove.from, lastmove.to, lastmove.prom);

#if 0
            printf("%c %d v=%d movenum=%d move=%s\n", to_colour(halfmove) ? 'B' : 'W',
              to_move(halfmove), var_level, movenum, format_move(&lastmove));
#endif

            if (dgm_func) {
                ret = dgm_func(halfmove);
                if (ret)
                    return ret;
            }
            halfmove++;
        }
    }

    return 0;
}

/*
 * READ_GAME
 *
 * Read a ChessBase game.
 */
int
read_game(db, game)
    Database db;
    Game game;
{
    register int i, j;
    int status, len, xor_mask;
    u_char piece;

    if ((status = read_info(db, game)) < 0)
        return status;

 /* read and decode the moves */
    if (game->mlen) {
        len = game->mlen;
        game->moves = (u_char *) mem_alloc(len);
        if (!game->moves)
            return -1;
        if (file_read(db->cbf, (char *) game->moves, len) != len)
            return -1;

        len++;                         /* un-adjust */
        for (i = len - 2, xor_mask = len * 49; i > 0; i--) {
            game->moves[i] ^= xor_mask;
            xor_mask *= 7;
        }
    }
 /* read comments */
    if (game->clen) {
        len = game->clen;
        game->comments = (u_char *) mem_alloc(len);
        if (!game->comments)
            return -1;
        if (file_read(db->cbf, (char *) game->comments, len) != len)
            return -1;
    }
 /* read partial board */
    if (is_partial(game->header)) {
        if (file_read(db->cbf, (char *) gamebuf, 32) != 32)
            return -1;

        for (i = 0; i < 8; i++) {      /* rank */
            for (j = 0; j < 8; j += 2) {        /* file */
                piece = gamebuf[i * 4 + j / 2];
                game->board[to_offset(j, i)] = piece >> 4;
                game->board[to_offset(j + 1, i)] = piece & 0xf;
            }
        }

        game->ep = get_ep(game->header);
        i = file_getc(db->cbf) + 1;    /* initial move number */
        j = get_tomove(game->header);  /* 0 for white, 1 for black */
        game->halfmove = to_halfmove(i, j);
    } else {                           /* full game */
        game->ep = 0;
        game->halfmove = 1;
        init_board(game->board);
    }

    return 0;
}

static int extract_round_number P__((GameSort game, char *s));
static int remove_annotator P__((char *s));

/*
 * READ_GAME_SORT
 *
 * Read a game from the database for sorting.
 */
int
read_game_sort(db, num, game)
    Database db;
    u_long num;
    register GameSort game;
{
    register int i;
    int xor_mask, plen, slen, len;
    u_char hdr[14], *cptr;

    bzero((char *) game, sizeof(struct game_sort));

    game->index = read_index(db, num);
    file_seek(db->cbf, game->index);

    if (file_read(db->cbf, (char *) hdr, 14) != 14)
        return -1;

    for (i = 13, xor_mask = 101; i >= 0; i--) {
        hdr[i] ^= xor_mask;
        xor_mask *= 3;
    }
    hdr[11] ^= 14 + (hdr[4] & 0x3f) + (hdr[5] & 0x3f);

 /* check checksum */
    if ((int) ((hdr[0] * 0x25 + hdr[5] + hdr[9]) & 0xff) != (int) hdr[13]
      && (int) ((hdr[3] * 0x1ec1 * (hdr[8] + 1) * hdr[0]) & 0xff)
      != (int) hdr[13]) {
        chksum_err = 1;
        if (!ignore_chksum_err) {
            error("game %lu: checksum error", num);
            return -2;
        }
    }
    chksum_err = 0;

    if (hdr[0] != 127)
        game->year = 1900 + (char) hdr[0];

    if (is_full(hdr))
        game->eco = get_eco1(hdr);

    game->nmoves = get_nmoves(hdr);

    plen = get_plen(hdr);
    slen = get_slen(hdr);
    len = plen + slen;
    if (len) {
        if (file_read(db->cbf, (char *) gamebuf, len) != len)
            return -1;

        for (i = len - 1, xor_mask = len * 3; i >= 0; i--) {
            gamebuf[i] ^= xor_mask;
            xor_mask *= 3;
        }

        bcopy((char *) gamebuf, (char *) game->pinfo, plen);
        game->pinfo[plen] = '\0';
        bcopy((char *) gamebuf + plen, (char *) game->sinfo, slen);
        game->sinfo[slen] = '\0';

        cptr = (u_char *) index((char *) game->pinfo, '-');
        if (cptr) {
            game->wplayer_len = cptr - game->pinfo;
            game->bplayer_off = game->wplayer_len + 1;
        } else {
            game->wplayer_len = ustrlen(game->pinfo);
        }
    }
 /* look for round number in players field then source field. */
    if (plen && !extract_round_number(game, (char *) game->pinfo))
        if (slen)
            extract_round_number(game, (char *) game->sinfo);

 /* remove the annotator from the sinfo field */
    remove_annotator((char *) game->sinfo);

 /* tidy the strings to make sorting "more correct" */
    tidy_string((char *) game->pinfo);
    tidy_string((char *) game->sinfo);

#if 0
    printf("pinfo=\"%s\" sinfo=\"%s\" round[0]=%d round[1]=%d round[2]=%d\n",
      game->pinfo, game->sinfo, game->round[0], game->round[1], game->round[2]);
#endif

    return 0;
}

/*
 * EXTRACT_ROUND_NUMBER
 *
 * Find the round number (digits/periods/slashes in brackets) in a string
 * remove it from the string.
 *
 * Returns 1 if a round number was found.
 */
static int
extract_round_number(game, s)
    GameSort game;
    char *s;
{
    char *anchor, *end, c;
    int i, valid, mslash;

    game->round[0] = 0;
    game->round[1] = 0;
    game->round[2] = 0;

    while (*s) {
        if (*s == '(') {
            anchor = s++;
            valid = 1;
        /* allow "(m/X)" */
            if (*s == 'm' && *(s + 1) == '/') {
                s += 2;
                mslash = 1;
            } else {
                mslash = 0;
            }
            while (*s && *s != ')') {
                c = *s++;
                if (!isdigit(c) && c != '.' && c != '/'
                  && c != '\\') {
                    valid = 0;
                    break;
                }
            }
            if (valid && *s == ')') {
                end = s + 1;

            /* remove the round numbers from between the parathesis and
               seperators */
                i = 0;
                s = anchor;
                if (mslash)
                    s += 2;
                while (s < end && i < 3) {
                    if (isdigit(*s)) {
                        char *new_s;
                        game->round[i] =
                          (u_short) strtol(s, &new_s, 10);
                        s = new_s;
                        i++;
                    }
                    s++;
                }

            /* remove the round text from the string */
                while (*anchor++ = *end++);

                return 1;
            }
        }
        s++;
    }
    return 0;
}

/*
 * REMOVE_ANNOTATOR
 *
 * Remove the annotator (within square brackets) name from a field.
 */
static int
remove_annotator(s)
    char *s;
{
    char *anchor;

    while (*s) {
        if (*s == '[') {
            anchor = s;
            while (*s && *s != ']')
                s++;
            if (*s == ']') {
                s++;
            /* remove the text */
                while (*anchor++ = *s++);
                return 1;
            }
        }
        s++;
    }
    return 0;
}

/*
 * READ_HEADER
 *
 * Read game header.
 *
 * Returns: 0 if no error, -1 if read error, -2 if checksum incorrect.
 */
int
read_header(db, game)
    Database db;
    Game game;
{
    register int i;
    u_char *buf;
    int xor_mask;

    seek_game(db, game);

    buf = game->header;

    if (file_read(db->cbf, (char *) buf, 14) != 14)
        return -1;

    for (i = 13, xor_mask = 101; i >= 0; i--) {
        buf[i] ^= xor_mask;
        xor_mask *= 3;
    }
    buf[11] ^= 14 + (buf[4] & 0x3f) + (buf[5] & 0x3f);

 /* check checksum */
    if ((int) ((buf[0] * 0x25 + buf[5] + buf[9]) & 0xff) != (int) buf[13]
      && (int) ((buf[3] * 0x1ec1 * (buf[8] + 1) * buf[0]) & 0xff)
      != (int) buf[13]) {
        chksum_err = 1;
        if (!ignore_chksum_err) {
            error("game %lu: checksum error", game->num);
            return -2;
        }
    }
    chksum_err = 0;

    return 0;
}

/*
 * READ_INDEX
 *
 * Read the index number for a game
 */
u_long
read_index(db, num)
    Database db;
    u_long num;
{
    file_seek(db->cbi, num * 4);
    return read_long(db->cbi) - (num + 1);
}

/*
 * READ_INFO
 *
 * Read game header, player and source info.
 */
int
read_info(db, game)
    Database db;
    Game game;
{
    register int i;
    u_char *hdr;
    int status;
    int len, xor_mask;
    int eco1;

    if ((status = read_header(db, game)) < 0)
        return status;

    hdr = game->header;

 /* decode year */
    if (hdr[0] == 127)
        game->year = 0;
    else
        game->year = 1900 + (char) hdr[0];

 /* decode ELO values */
    if (hdr[8])
        game->w_elo = ((int) hdr[8] * 5) + 1600;
    else
        game->w_elo = 0;

    if (hdr[9])
        game->b_elo = ((int) hdr[9] * 5) + 1600;
    else
        game->b_elo = 0;

 /* decode ECO */
    game->eco_letter = 0;
    game->eco_main = 0;
    game->eco_sub = 0;
    if (is_full(hdr)) {
        eco1 = get_eco1(hdr);
        if (eco1) {
            game->eco_letter = ((eco1 - 1) / 100) + 'A';
            game->eco_main = (eco1 - 1) % 100;
            game->eco_sub = get_eco2(hdr);
        }
    }
 /* decode lengths */
    game->plen = get_plen(hdr);
    game->slen = get_slen(hdr);
    game->mlen = c2s(&hdr[2]) - 1;
    game->clen = c2s(&hdr[6]);

    game->pinfo[0] = '\0';
    game->sinfo[0] = '\0';
    game->nmoves = get_nmoves(hdr);

 /* read and decode player and source info */
    len = game->plen + game->slen;
    if (len) {
        if (file_read(db->cbf, (char *) gamebuf, len) != len)
            return -1;

        for (i = len - 1, xor_mask = 3 * len; i >= 0; i--) {
            gamebuf[i] ^= xor_mask;
            xor_mask *= 3;
        }
        bcopy((char *) gamebuf, (char *) game->pinfo, game->plen);
        game->pinfo[game->plen] = '\0';
        bcopy((char *) gamebuf + game->plen, (char *) game->sinfo,
          game->slen);
        game->sinfo[game->slen] = '\0';
    }
    return 0;
}

/*
 * READ_LISTFILE
 *
 * Read a list of databases from a listfile
 */
char *
read_listfile(fp)
    FILE *fp;
{
    static char buffer[128];
    int c, i;

    i = 0;
    while ((c = fgetc(fp)) != EOF) {
        if (isspace(c))
            continue;
        if (c == '#') {
            while ((c = fgetc(fp)) != EOF)
                if (c == '\n')
                    break;
            if (c == EOF)
                return NULL;
            continue;
        }
        buffer[0] = c;
        for (i = 1; i < sizeof(buffer) - 1; i++) {
            if ((c = fgetc(fp)) == EOF)
                break;
            if (!isspace(c) && c != '#')
                buffer[i] = c;
            else
                break;
        }
        buffer[i] = '\0';
        if (c == '#')
            ungetc(c, fp);
        if (i) {
            kill_ext(buffer);
            strlower(buffer);
            return buffer;
        } else {
            return NULL;
        }
    }
    return NULL;
}

/*
 * READ_LONG
 *
 * Read a 4-byte value and convert it to local byte-sex.
 */
u_long
read_long(file)
    File file;
{
    u_char buf[4];

    if (file_read(file, (char *) buf, 4) != 4)
        return 0;
    return c2l(buf);
}

/*
 * READ_NGAMES
 *
 * Read the "number of games" value from the start of the index file.
 */
int
read_ngames(db)
    Database db;
{
    file_seek(db->cbi, 0L);
    db->ngames = read_long(db->cbi) - 1;
    return 0;
}

/*
 * RENAME_DATABASE
 *
 * Rename the files associated with a database (.CBF and .CBI files).
 */
int
rename_database(db, newname)
    Database db;
    char *newname;
{
    if (file_rename(db->cbf, newname) < 0)
        return -1;
    if (file_rename(db->cbi, newname) < 0)
        return -1;
    return 0;
}

u_long
range_first(string)
    char *string;
{
    char *endptr;
    u_long ret;

    if (isdigit(*string)) {
        ret = (u_long) strtol(string, &endptr, 10);
        if (*endptr != '-' && *endptr != '\0')
            return 0L;
        return ret;
    } else if (*string == '-')
        return 1L;
    return 0L;
}

u_long
range_last(string)
    char *string;
{
    char *cptr, *endptr;
    u_long ret;

    cptr = index(string, '-');
    if (cptr) {
        cptr++;
        if (index(cptr, '-'))
            return 0L;
    } else {
        cptr = string;
    }
    if (isdigit(*cptr)) {
        ret = (u_long) strtol(cptr, &endptr, 10);
        if (*endptr != '\0')
            return 0L;
        return ret;
    } else if (*cptr == '\0')
        return 0xfffffffL;
    return 0L;
}

/*
 * S2C
 *
 * Convert an unsigned short to an array of bytes in big-endian format
 */
void
s2c(c, value)
    u_char *c;
    u_short value;
{
    *c++ = (u_char) (value >> 8);
    *c = (u_char) (value);
}

/*
 * SEEK_GAME
 *
 * Seek game file pointer to correct location for a game.
 */
void
seek_game(db, game)
    Database db;
    Game game;
{
    long offset;

    offset = read_index(db, game->num);
    file_seek(db->cbf, offset);
}

/*
 * SPACES
 *
 * Print a number of spaces.
 */
int
spaces(num)
    int num;
{
    int i;
    for (i = 0; i < num; i++)
        putchar(' ');
    return num;
}

/*
 * STRLOWER
 *
 * Convert a string to lowercase
 */
void
strlower(s)
    register char *s;
{
    if (s) {
        while (*s) {
            *s = tolower(*s);
            s++;
        }
    }
}
/* general symbols */
char null[] = "";
static char a[] = "a";
static char e[] = "e";
static char i[] = "i";
static char o[] = "o";
static char u[] = "u";
static char kside[] = ">> ";
static char qside[] = "<< ";
static char w_advantage[] = "+- ";
static char w_winning[] = "+/- ";
static char w_better[] = "+/= ";
static char equality[] = "= ";
static char unclear[] = "& ";
static char b_better[] = "=/+ ";
static char b_winning[] = "-/+ ";
static char b_advantage[] = "-+ ";
static char w_compensation[] = "&/= ";
static char b_compensation[] = "=/& ";
static char counter_play[] = "<-/-> ";
static char initiative[] = "^ ";
static char attack[] = "-> ";
static char time_trouble[] = "(+) ";
static char forced[] = "[] ";
static char zugzwang[] = "(.) ";
static char develop_adv[] = "<dev.adv.> ";
static char worse_is[] = ">= ";
static char better_is[] = "<= ";
char with_idea[] = "/\\ ";
static char editor_comment[] = "RR ";
static char dot[] = ".";

char *sym[NSYMS] = {
    "C",                               /* 128 - Cedille C */
    "ue",                              /* 129 - Umlaut u */
    e,                                 /* 130 - Acute e */
    a,                                 /* 131 - Circumflex a */
    "ae",                              /* 132 - Umlaut a */
    a,                                 /* 133 - Grave a */
    a,                                 /* 134 - Dot a */
    "c",                               /* 135 - Cedille c */
    e,                                 /* 136 - Circumflex e */
    e,                                 /* 137 - Umlaut e */
    e,                                 /* 138 - Grave e */
    i,                                 /* 139 - Umlaut i */
    i,                                 /* 140 - Circumflex i */
    i,                                 /* 141 - Grave i */
    "Ae",                              /* 142 - Umlaut A */
    "A",                               /* 143 - Dot A */
    "E",                               /* 144 - Acute E */
    "ae",                              /* 145 - Scandi. ae */
    "AE",                              /* 146 - Scandi. AE */
    o,                                 /* 147 - Circumflex o */
    "oe",                              /* 148 - Umlaut o */
    o,                                 /* 149 - Grave o */
    u,                                 /* 150 - Circumflex u */
    u,                                 /* 151 - Grave u */
    "y",                               /* 152 - Umlaut y */
    "Oe",                              /* 153 - Umlaut O */
    "Ue",                              /* 154 - Umlaut U */
    null,                              /* 155 - */
    "#",                               /* 156 - */
    null,                              /* 157 - */
    "ss",                              /* 158 - German S */
    null,                              /* 159 - */
    a,                                 /* 160 - Acute a */
    i,                                 /* 161 - Acute i */
    o,                                 /* 162 - Acute o */
    u,                                 /* 163 - Acute u */
    "n",                               /* 164 - Tilde n */
    "N",                               /* 165 - Tilde N */
    null,                              /* 166 - */
    null,                              /* 167 - */
    null,                              /* 168 - */
    null,                              /* 169 - */
    null,                              /* 170 - */
    "1/2",                             /* 171 - */
    "1/4",                             /* 172 - */
    null,                              /* 173 - */
    "<< ",                             /* 174 - */
    ">> ",                             /* 175 - */
    "|| ",                             /* 176 - Etc */
    "K",                               /* 177 - King */
    "Q",                               /* 178 - Queen */
    "N",                               /* 179 - Knight */
    "B",                               /* 180 - Bishop */
    "R",                               /* 181 - Rook */
    "P",                               /* 182 - Pawn */
    "1/4",                             /* 183 - Quarter */
    "1/2",                             /* 184 - Half */
    "3/4",                             /* 185 - Three Quarters */
    null,                              /* 186 - */
    w_winning,                         /* 187 - White is winning */
    w_better,                          /* 188 - White is slightly better */
    w_compensation,                    /* 189 - White has compensation */
    unclear,                           /* 190 - Unclear */
    b_compensation,                    /* 191 - Black has compensation */
    b_better,                          /* 192 - Black is slightly better */
    b_winning,                         /* 193 - Black is winning */
    "<pair-B> ",                       /* 194 - Bishop Pair */
    "<opp-B> ",                        /* 195 - Opposite Bishops */
    "<same-B> ",                       /* 196 - Same Bishops */
    worse_is,                          /* 197 - Worse Is */
    better_is,                         /* 198 - Better Is */
    better_is,                         /* 199 - Better Is */
    "<spc.adv.> ",                     /* 200 - Space Advantage */
    forced,                            /* 201 - Forced (Only move) */
    with_idea,                         /* 202 - With Idea */
    qside,                             /* 203 - Queenside */
    kside,                             /* 204 - Kingside */
    kside,                             /* 205 - Kingside */
    qside,                             /* 206 - Queenside */
    initiative,                        /* 207 - With Initiative */
    attack,                            /* 208 - With Attack */
    counter_play,                      /* 209 - With Counterplay */
    "/ ",                              /* 210 - Diagonal */
    "[+] ",                            /* 211 - Centre */
    "<=> ",                            /* 212 - File */
    "_|_ ",                            /* 213 - Endgame */
    "X ",                              /* 214 - Weak Point */
    zugzwang,                          /* 215 - Zugzwang */
    time_trouble,                      /* 216 - Time Trouble */
    "o",                               /* 217 - Pawn Evaluation */
    "..",                              /* 218 - United pawns */
    "<dbl-P>",                         /* 219 - Doubled Pawn */
    "<pass-P>",                        /* 220 - Passed Pawn */
    "with ",                           /* 221 - with */
    "without ",                        /* 222 - without */
    develop_adv,                       /* 223 - Development Advantage */
    null,                              /* 224 - */
    "ss",                              /* 225 - German S */
    null,                              /* 226 - */
    null,                              /* 227 - */
    null,                              /* 228 - */
    null,                              /* 229 - */
    null,                              /* 230 - */
    null,                              /* 231 - */
    null,                              /* 232 - */
    null,                              /* 233 - */
    null,                              /* 234 - */
    null,                              /* 235 - */
    unclear,                           /* 236 - Unclear */
    null,                              /* 237 - */
    null,                              /* 238 - */
    null,                              /* 239 - */
    null,                              /* 240 - */
    w_winning,                         /* 241 - White is winning */
    worse_is,                          /* 242 - Worse is */
    better_is,                         /* 243 - Better is */
    null,                              /* 244 - */
    null,                              /* 245 - */
    null,                              /* 246 - */
    null,                              /* 247 - */
    dot,                               /* 248 - */
    dot,                               /* 249 - */
    dot,                               /* 250 - */
    null,                              /* 251 - */
    null,                              /* 252 - */
    null,                              /* 253 - */
    " ",                               /* 254 - Next Line */
    null                               /* 255 - */
};

/* evaluation symbols */
char *eval[NEVALS] = {
    null,
    "!",                               /* Good move */
    "?",                               /* Bad move */
    "!?",                              /* Interesting move */
    "?!",                              /* Dubious move */
    "!!",                              /* Brilliant move */
    "??",                              /* Blunder */
    "#",                               /* Mate */
    zugzwang,                          /* Zugzwang */
    develop_adv                        /* Development advantage */
};

/* position evaluation symbols */
char *poseval[NPOSEVALS] = {
    null,
    w_advantage,                       /* White has advantage */
    w_winning,                         /* White is winning */
    w_better,                          /* White is slightly better */
    equality,                          /* Equality */
    unclear,                           /* unclear */
    b_better,                          /* Black is slightly better */
    b_winning,                         /* Black is winning */
    b_advantage,                       /* Black has advantage */
    "N",                               /* Novelty */
    b_compensation,                    /* Black has compensation */
    counter_play,                      /* With counter play */
    initiative,                        /* With initiative */
    attack,                            /* With attack */
    time_trouble,                      /* Time trouble */
    forced                             /* Forced (only move) */
};

char *moveval[NMOVEVALS] = {
    null,
    editor_comment,                    /* Editorial comment */
    better_is,                         /* Better is */
    with_idea,                         /* With the idea */
    "~=",                              /* Roughly equal */
    worse_is,                          /* Worse is */
    better_is,                         /* Better is */
    "<H>"                              /* ? */
};

char cvtbuf[1024];

/*
 * TIDY_STRING
 *
 * Remove excess spaces from a string.
 */
void
tidy_string(s)
    char *s;
{
    char *t, *cptr;
    int len;

    t = s;
    while (cptr = get_word(s, &len)) {
        if (cptr > t)
            strncpy(t, cptr, len);
        s = cptr + len;
        t += len;
        if (get_word(s, NULL))
            *t++ = ' ';
        else
            break;
    }
    *t = '\0';
}

/*
 * TEXT2PIECE
 *
 * convert an ASCII piece name into binary form
 */
u_char
text2piece(c)
    char c;
{
    register int i;
    int is_black;

    if (c >= 'a' && c <= 'z') {
        is_black = 1;
        c -= 'a' - 'A';
    } else {
        is_black = 0;
    }

    for (i = 0; i < 8; i++) {
        if (c == piece_list[i])
            return is_black ? i | 8 : i;
    }

    return 0xff;
}

/*
 * USTRLEN
 *
 * Return the length of a string of unsigned characters
 */
unsigned
ustrlen(us)
    u_char *us;
{
    unsigned ret = 0;

    while (*us++)
        ret++;
    return ret;
}

/*
 * WRITE_GAME
 *
 * Write a ChessBase game
 */
int
write_game(db, game)
    Database db;
    Game game;
{
    register int i, j;
    int xor_mask, len;
    u_char piece, *tmp;

    if (write_info(db, game) < 0)
        return 0;

 /* encode and write moves */
    if (game->mlen) {
        len = game->mlen;
        tmp = (u_char *) mem_alloc(len);
        if (!tmp)
            return -1;
        bcopy((char *) game->moves, (char *) tmp, len);
        len++;
        for (i = len - 2, xor_mask = len * 49; i > 0; i--) {
            tmp[i] ^= xor_mask;
            xor_mask *= 7;
        }
        len--;
        if (file_write(db->cbf, (char *) tmp, len) != len) {
            free(tmp);
            return -1;
        }
        free(tmp);
    }
 /* write comments */
    if (game->clen) {
        len = game->clen;
        if (file_write(db->cbf, (char *) game->comments, len) != len)
            return -1;
    }
 /* write partial board */
    if (is_partial(game->header)) {
        for (i = 0; i < 8; i++) {      /* rank */
            for (j = 0; j < 8; j += 2) {        /* file */
                piece = game->board[to_offset(j, i)] << 4;
                piece |= game->board[to_offset(j + 1, i)] & 0xf;
                gamebuf[i * 4 + j / 2] = piece;
            }
        }
        if (file_write(db->cbf, (char *) gamebuf, 32) != 32) {
            return -1;
        }
        file_putc(db->cbf, to_move(game->halfmove) - 1);
    }
 /* write the index entry for the next game */
    write_index(db, game->num + 1L, file_tell(db->cbf));
}

/*
 * WRITE_HEADER
 *
 * Write game header.
 */
int
write_header(db, game)
    Database db;
    Game game;
{
    register int i;
    u_char buf[14];
    int xor_mask;

    bcopy((char *) game->header, (char *) buf, 14);

    buf[11] |= 0x40;                   /* set version bit */

 /* calculate checksum */
    buf[13] = (buf[3] * 0x1ec1 * (buf[8] + 1) * buf[0]) & 0xff;

 /* encode data */
    buf[11] ^= 14 + (buf[4] & 0x3f) + (buf[5] & 0x3f);
    for (i = 13, xor_mask = 101; i >= 0; i--) {
        buf[i] ^= xor_mask;
        xor_mask *= 3;
    }

    if (file_write(db->cbf, (char *) buf, 14) != 14)
        return -1;
    return 0;
}

/*
 * WRITE_INDEX
 *
 * Write the index number for a game
 */
int
write_index(db, num, offset)
    Database db;
    u_long num, offset;
{
    file_seek(db->cbi, num * 4);
    offset += (num + 1);
    return write_long(db->cbi, offset);
}

/*
 * WRITE_INFO
 *
 * Write game header, player and source info.
 */
int
write_info(db, game)
    Database db;
    Game game;
{
    register int i;
    u_char *hdr;
    int len, xor_mask, eco1, eco2;

    hdr = game->header;

 /* encode year */
    if (game->year)
        hdr[0] = (char) (game->year - 1900);
    else
        hdr[0] = 127;

 /* encode ELO */
    if (game->w_elo)
        hdr[8] = (u_char) ((game->w_elo - 1600) / 5);
    else
        hdr[8] = 0;

    if (game->b_elo)
        hdr[9] = (u_char) ((game->b_elo - 1600) / 5);
    else
        hdr[9] = 0;

 /* encode ECO */
    if (is_full(hdr)) {
        if (game->eco_letter) {
            eco1 = ((game->eco_letter - 'A') * 100) +
              game->eco_main + 1;
            eco2 = game->eco_sub;
        } else {
            eco1 = 0;
            eco2 = 0;
        }
        set_eco1(hdr, eco1);
        set_eco2(hdr, eco2);
    }
 /* encode lengths */
    if (game->plen > 47)
        game->plen = 47;
    set_plen(hdr, game->plen);
    if (game->slen > 47)
        game->slen = 47;
    set_slen(hdr, game->slen);
    s2c(&hdr[2], game->mlen + 1);
    s2c(&hdr[6], game->clen);

 /* encode miscellaneous */
    set_nmoves(hdr, game->nmoves);
    if (is_partial(hdr)) {
        set_tomove(hdr, to_colour(game->halfmove));
        set_ep(hdr, game->ep);
    }
    if (write_header(db, game) < 0)
        return -1;

 /* encode and write player and source info */
    len = game->plen + game->slen;
    if (len) {
        bcopy((char *) game->pinfo, (char *) gamebuf, game->plen);
        bcopy((char *) game->sinfo, (char *) gamebuf + game->plen,
          game->slen);
        for (i = len - 1, xor_mask = 3 * len; i >= 0; i--) {
            gamebuf[i] ^= xor_mask;
            xor_mask *= 3;
        }
        if (file_write(db->cbf, (char *) gamebuf, len) != len) {
            return -1;
        }
    }
    return 0;
}

/*
 * WRITE_LONG
 *
 * Write a 4-byte value converted from local byte-sex.
 */
int
write_long(file, value)
    File file;
    u_long value;
{
    u_char buf[4];

    l2c(buf, value);
    return file_write(file, (char *) buf, 4);
}

/*
 * WRITE_NGAMES
 *
 * Write the "number of games" value to the start of the index file.
 */
int
write_ngames(db)
    Database db;
{
    file_seek(db->cbi, 0L);
    return write_long(db->cbi, db->ngames + 1);
}

int xatol_err = 0;
char *xatol_ptr = NULL;

/*
 * XATOL
 *
 * Convert ASCII to long.  If a non-decimal digit is found the flag
 * "xatol_err" is set to 1, and the pointer "xatol_ptr" is set the address
 * of the offending character.  The value parsed upto the time of an error
 * is returned anyway.
 */
long
xatol(s)
    char *s;
{
    long ret;
    int minus;

    ret = 0L;
    minus = 0;
    xatol_err = 0;
    xatol_ptr = NULL;

    if (!*s) {
        xatol_err = 1;
        xatol_ptr = s;
        return 0L;
    }
    if (*s == '-') {
        minus++;
        s++;
    } else if (*s == '+') {
        minus = 0;
        s++;
    }
    while (*s && isdigit(*s)) {
        ret *= 10L;
        ret += *s - '0';
        s++;
    }

    if (*s) {
        xatol_err = 1;
        xatol_ptr = s;
    }
    return ret;
}

/*
 * XSTRDUP
 *
 * Duplicate strings.
 */
char *
xstrdup(s)
    char *s;
{
    char *ret;

    ret = mem_alloc(strlen(s) + 1);
    if (!ret)
        return NULL;
    strcpy(ret, s);
    return ret;
}
