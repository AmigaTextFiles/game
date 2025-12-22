// INCLUDES---------------------------------------------------------------

#if defined(_lint) || defined(__VBCC__)
    #define AMIGA
#endif

#ifdef WIN32
    #include <windows.h>
    #include <fcntl.h>             // _O_TEXT
    #include <io.h>                // for _open_osfhandle()
#endif

#include <stdio.h>
#include <stdlib.h>                // EXIT_SUCCESS, EXIT_FAILURE
#include <string.h>
#include <math.h>

#ifdef WIN32
    #include "ibm.h"
#endif
#ifdef AMIGA
    #include <exec/types.h>
    #include <intuition/intuition.h>

    #include <proto/exec.h>
    #include <proto/dos.h>

    #include "amiga.h"
#endif
#include "cw.h"
#include "codewar.h"

// DEFINES----------------------------------------------------------------

#define pythagoras(X,Y)     sqrt((X)*(X)+(Y)*(Y))

// #define VERBOSE

// MODULE VARIABLES-------------------------------------------------------

MODULE TEXT                 globalstring[256 + 1];
MODULE ULONG                globalnumber;

#ifdef WIN32
MODULE int                  rw,
                            mt;
MODULE COPYDATASTRUCT       cds;
MODULE FLAG                 lame           = FALSE;
MODULE HWND                 OurWindowPtr   = NULL,
                            SimWindowPtr   = NULL,
                            RobotWindowPtr = NULL;
#endif
#ifdef AMIGA
MODULE int                  robot;
MODULE struct MsgPort      *ReplyPortPtr   = NULL,
                           *SimPortPtr     = NULL;
MODULE struct CodeWarSglMsg SglMessage;
#endif

// FUNCTIONS--------------------------------------------------------------

extern void main(void);

MODULE void write_clip(void);
MODULE ULONG dosglmessage(int kind, ULONG number);
#ifdef WIN32
    MODULE void openwindow(void);
    MODULE void api_read_clip(void);
    MODULE void api_garbled(int errornum);
    MODULE float zatof(STRPTR inputstr);

    LRESULT CALLBACK WndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam);
#endif
#ifdef AMIGA
 // MODULE void cleanexit(void);
#endif

// CODE-------------------------------------------------------------------

EXPORT int cw_register_network_program(char* name, UNUSED char* hostname)
{   return cw_register_program(name);
}

EXPORT int cw_register_program(char* name)
{
#ifdef WIN32
    DWORD         processid;
    OSVERSIONINFO Vers;

    if (!(SimWindowPtr = FindWindow(NULL, RENDEZVOUS)))
    {   return FALSE;
    }

    processid = GetCurrentProcessId();
    Vers.dwOSVersionInfoSize = sizeof(OSVERSIONINFO);
    GetVersionEx((LPOSVERSIONINFO) &Vers);
    if (Vers.dwPlatformId == VER_PLATFORM_WIN32_NT)
    {   // T1; printf("Lame OS detected!\n"); T2;
        lame = TRUE;
    } elif (Vers.dwPlatformId == VER_PLATFORM_WIN32s)
    {   ; // T1; printf("Please upgrade to Windows 9x!\n"); T2;
    } elif (Vers.dwPlatformId == VER_PLATFORM_WIN32_WINDOWS)
    {   ; // T1; printf("Windows 9x detected.\n"); T2;
    } else
    {   // T1; printf("Unknown OS!\n"); T2;
        lame = TRUE;
    }
    openwindow();
    if (!(RobotWindowPtr = (HWND) SendMessage(SimWindowPtr, MT_REGISTER_PROGRAM, (WPARAM) processid, (LPARAM) OurWindowPtr)))
    {   return FALSE;
    }
#endif

#ifdef AMIGA
    Forbid();
    SimPortPtr = FindPort(RENDEZVOUS);
    Permit();
    if (!SimPortPtr)
    {   return FALSE;
    }

    ReplyPortPtr = CreateMsgPort();
    if (!ReplyPortPtr)
    {   return FALSE;
    }

#ifdef LOGTASKS
    printf("Robot: Registering ourself at address $%X.\n", (int) FindTask(NULL));
#endif
    robot = dosglmessage(MT_REGISTER_PROGRAM, (ULONG) FindTask(NULL));
#endif

    if (strlen(name) > 254)
    {   name[254] = EOS;
    }
    globalstring[0] = '*';
    strcpy(&globalstring[1], name);
    write_clip();
    dosglmessage(MT_SET_NAME, 0);

    return TRUE;
}

MODULE ULONG dosglmessage(int kind, ULONG number)
{   globalnumber = number;

#ifdef WIN32
    return SendMessage(SimWindowPtr, kind, (WPARAM) RobotWindowPtr, (LPARAM) globalnumber);
#endif
#ifdef AMIGA
    SglMessage.cw_Msg.mn_Node.ln_Type = NT_MESSAGE;
    SglMessage.cw_Msg.mn_Length       = sizeof(struct CodeWarSglMsg);
    SglMessage.cw_Msg.mn_ReplyPort    = ReplyPortPtr;
    SglMessage.cw_Robot               = robot;
    SglMessage.cw_Operation           = kind;
    SglMessage.cw_String              = globalstring;
    SglMessage.cw_Number              = globalnumber;
    Forbid();
    SimPortPtr = FindPort(RENDEZVOUS);
    if (!SimPortPtr)
    {   Permit();
#ifdef LOGTASKS
        printf("Robot #%d: Can't find the port.\n", robot);
#endif
        for (;;); // wait to be killed
    }
    PutMsg(SimPortPtr, (struct Message*) &SglMessage);
    Permit();
    Delay(1);
    WaitPort(ReplyPortPtr);
    DISCARD GetMsg(ReplyPortPtr);
    return SglMessage.cw_Result;
#endif
}

EXPORT void cw_boost_shields(int energy)
{   dosglmessage(MT_BOOST_SHIELDS, energy);
}

EXPORT void cw_print_buffer(char* buffer)
{   if (strlen(buffer) > 254)
    {   buffer[254] = EOS;
    }
    globalstring[0] = '~';
    strcpy(&globalstring[1], buffer);
    write_clip();

    dosglmessage(MT_PRINT_BUFFER, 0);
}

EXPORT void cw_power(float acceleration, float direction)
{
#ifdef WIN32
    sprintf(globalstring, "%d %d %f %f", RobotWindowPtr, MT_POWER, acceleration, direction);
    write_clip();
#endif
#ifdef AMIGA
    SglMessage.cw_Single1 = acceleration;
    SglMessage.cw_Single2 = direction;
#endif

    dosglmessage(MT_POWER, 0);
}
EXPORT void cw_power_d(double acceleration, double direction)
{   cw_power((float) acceleration, (float) direction);
}

EXPORT float cw_scan(float direction, float precision)
{
#ifdef WIN32
    float result;
    TEXT  strfloat[20 + 1];

    sprintf(globalstring, "%d %d %f %f", RobotWindowPtr, MT_SCAN, direction, precision);
    write_clip();
#endif
#ifdef AMIGA
    SglMessage.cw_Single1 = direction;
    SglMessage.cw_Single2 = precision;
#endif

    dosglmessage(MT_SCAN, 0);

#ifdef WIN32
    api_read_clip();
    sscanf(globalstring, "%d %d %s", &rw, &mt, strfloat);
    result = zatof(strfloat);
    if (rw != (int) RobotWindowPtr || mt != MT_SCAN)
    {   api_garbled(1);
    }
    return result;
#endif
#ifdef AMIGA
    return SglMessage.cw_ResultSgl1;
#endif
}
EXPORT double cw_scan_d(double direction, double precision)
{   return (double) cw_scan((float) direction, (float) precision);
}

EXPORT void cw_atomic(float acceleration, float direction, float detonate)
{
#ifdef WIN32
    sprintf(globalstring, "%d %d %f %f %f", RobotWindowPtr, MT_ATOMIC, acceleration, direction, detonate);
    write_clip();
#endif
#ifdef AMIGA
    SglMessage.cw_Single1 = acceleration;
    SglMessage.cw_Single2 = direction;
    SglMessage.cw_Single3 = detonate;
#endif

    dosglmessage(MT_ATOMIC, 0);
}
EXPORT void cw_atomic_d(double acceleration, double direction, double detonate)
{   cw_atomic((float) acceleration, (float) direction, (float) detonate);
}

EXPORT void cw_bomb(float detonate)
{
#ifdef WIN32
    sprintf(globalstring, "%d %d %f", RobotWindowPtr, MT_BOMB, detonate);
    write_clip();
#endif
#ifdef AMIGA
    SglMessage.cw_Single1 = detonate;
#endif

    dosglmessage(MT_BOMB, 0);
}
EXPORT void cw_bomb_d(double detonate)
{   cw_bomb((float) detonate);
}

EXPORT void cw_cannon(float acceleration, float direction, float detonate)
{
#ifdef WIN32
    sprintf(globalstring, "%d %d %f %f %f", RobotWindowPtr, MT_CANNON, acceleration, direction, detonate);
    write_clip();
#endif
#ifdef AMIGA
    SglMessage.cw_Single1 = acceleration;
    SglMessage.cw_Single2 = direction;
    SglMessage.cw_Single3 = detonate;
#endif

    dosglmessage(MT_CANNON, 0);
}
EXPORT void cw_cannon_d(double acceleration, double direction, double detonate)
{   cw_cannon_d((float) acceleration, (float) direction, (float) detonate);
}

EXPORT void cw_missile(float acceleration, float direction, float detonate)
{
#ifdef WIN32
    sprintf(globalstring, "%d %d %f %f %f", RobotWindowPtr, MT_MISSILE, acceleration, direction, detonate);
    write_clip();
#endif
#ifdef AMIGA
    SglMessage.cw_Single1 = acceleration;
    SglMessage.cw_Single2 = direction;
    SglMessage.cw_Single3 = detonate;
#endif

    dosglmessage(MT_MISSILE, 0);
}
EXPORT void cw_missile_d(double acceleration, double direction, double detonate)
{   cw_missile((float) acceleration, (float) direction, (float) detonate);
}

EXPORT float cw_get_acceleration(float* x, float* y)
{
#ifdef WIN32
    TEXT strfloat1[20 + 1],
         strfloat2[20 + 1];
#endif

    dosglmessage(MT_GET_ACCELERATION, 0);

#ifdef WIN32
    api_read_clip();
    sscanf(globalstring, "%d %d %s %s", &rw, &mt, strfloat1, strfloat2);
    *x = zatof(strfloat1);
    *y = zatof(strfloat2);
    if (rw != (int) RobotWindowPtr || mt != MT_GET_ACCELERATION)
    {   api_garbled(2);
    }
#endif
#ifdef AMIGA
    *x = SglMessage.cw_ResultSgl1;
    *y = SglMessage.cw_ResultSgl2;
#endif

    return (float) (pythagoras((double) (*x), (double) (*y)));
}
EXPORT double cw_get_acceleration_d(double* x, double* y)
{   float result,
          xx, yy;

    result = cw_get_acceleration(&xx, &yy);
    *x = (double) xx;
    *y = (double) yy;

    return (double) result;
}

EXPORT float cw_get_acceleration_setting(float* x, float* y)
{   return cw_get_acceleration(x, y);
}
EXPORT double cw_get_acceleration_setting_d(double* x, double* y)
{   return cw_get_acceleration_d(x, y);
}

EXPORT int cw_get_atomics(void)
{   return (int) dosglmessage(MT_GET_ATOMICS, 0);
}

EXPORT int cw_get_bombs(void)
{   return (int) dosglmessage(MT_GET_BOMBS, 0);
}

EXPORT int cw_get_boundary_type(void)
{   return (int) dosglmessage(MT_GET_BOUNDARYTYPE, 0);
}

EXPORT int cw_get_cannons(void)
{   return (int) dosglmessage(MT_GET_CANNONS, 0);
}

EXPORT int cw_get_channel_bandwidth(void)
{   return 1; // returning 0 can cause divide by zero errors
}

EXPORT unsigned char cw_channel_receive(UNUSED int ch)
{   return 0;
}

EXPORT void cw_channel_transmit(UNUSED int channel, UNUSED unsigned char data)
{   ;
}

EXPORT int cw_get_damage(void)
{   return (int) dosglmessage(MT_GET_DAMAGE, 0);
}

EXPORT int cw_get_damage_max(void)
{   return (int) dosglmessage(MT_GET_DAMAGE_MAX, 0);
}

EXPORT float cw_get_elapsed_time(void)
{
#ifdef WIN32
    float result;
    TEXT  strfloat[20 + 1];
#endif

    dosglmessage(MT_GET_ELAPSEDTIME, 0);

#ifdef WIN32
    api_read_clip();
    sscanf(globalstring, "%d %d %s", &rw, &mt, strfloat);
    result = zatof(strfloat);
    if (rw != (int) RobotWindowPtr || mt != MT_GET_ELAPSEDTIME)
    {   api_garbled(4);
    }
    return result;
#endif
#ifdef AMIGA
    return SglMessage.cw_ResultSgl1;
#endif
}
EXPORT double cw_get_elapsed_time_d(void)
{   return (double) cw_get_elapsed_time();
}

EXPORT int cw_get_energy(void)
{   return (int) dosglmessage(MT_GET_ENERGY, 0);
}

EXPORT void cw_get_field_limits(float* x_axis, float* y_axis)
{
#ifdef WIN32
    TEXT  strfloat1[20 + 1],
          strfloat2[20 + 1];
    float xx, yy;

    dosglmessage(MT_GET_FIELDLIMITS, 0);
    api_read_clip();
    sscanf(globalstring, "%d %d %s %s", &rw, &mt, strfloat1, strfloat2);
    xx = zatof(strfloat1);
    yy = zatof(strfloat2);
    *x_axis = xx;
    *y_axis = yy;

    if (rw != (int) RobotWindowPtr || mt != MT_GET_FIELDLIMITS)
    {   api_garbled(5);
    }
#endif
#ifdef AMIGA
    dosglmessage(MT_GET_FIELDLIMITS, 0);

    *x_axis = SglMessage.cw_ResultSgl1;
    *y_axis = SglMessage.cw_ResultSgl2;
#endif
}
EXPORT void cw_get_field_limits_d(double* x_axis, double* y_axis)
{   float xx, yy;

    cw_get_field_limits(&xx, &yy);
    *x_axis = (double) xx;
    *y_axis = (double) yy;
}

EXPORT int cw_get_mass(void)
{   return (int) dosglmessage(MT_GET_MASS, 0);
}

EXPORT int cw_get_missiles(void)
{   return (int) dosglmessage(MT_GET_MISSILES, 0);
}

EXPORT void cw_get_position(float* x, float* y)
{
#ifdef WIN32
    TEXT strfloat1[20 + 1],
         strfloat2[20 + 1];
#endif

    dosglmessage(MT_GET_POSITION, 0);

#ifdef WIN32
    api_read_clip();
    sscanf(globalstring, "%d %d %s %s", &rw, &mt, strfloat1, strfloat2);
    *x = zatof(strfloat1);
    *y = zatof(strfloat2);
    if (rw != (int) RobotWindowPtr || mt != MT_GET_POSITION)
    {   api_garbled(6);
    }
#endif
#ifdef AMIGA
    *x = SglMessage.cw_ResultSgl1;
    *y = SglMessage.cw_ResultSgl2;
#endif
}
EXPORT void cw_get_position_d(double* x, double* y)
{   float xx, yy;

    cw_get_position(&xx, &yy);
    *x = (double) xx;
    *y = (double) yy;
}

EXPORT int cw_get_shields(void)
{   return (int) dosglmessage(MT_GET_SHIELDS, 0);
}

EXPORT float cw_get_time_interval(void)
{   return (float) dosglmessage(MT_GET_TIMEINTERVAL, 0);
}
EXPORT double cw_get_time_interval_d(void)
{   return (double) cw_get_time_interval();
}

EXPORT float cw_get_velocity(float* x, float* y)
{
#ifdef WIN32
    TEXT strfloat1[20 + 1],
         strfloat2[20 + 1];
#endif

    dosglmessage(MT_GET_VELOCITY, 0);

#ifdef WIN32
    api_read_clip();
    sscanf(globalstring, "%d %d %s %s", &rw, &mt, strfloat1, strfloat2);
    *x = zatof(strfloat1);
    *y = zatof(strfloat2);
    if (rw != (int) RobotWindowPtr || mt != MT_GET_VELOCITY)
    {   api_garbled(7);
    }
#endif
#ifdef AMIGA
    *x = SglMessage.cw_ResultSgl1;
    *y = SglMessage.cw_ResultSgl2;
#endif

    return (float) (pythagoras((double) (*x), (double) (*y)));
}
EXPORT double cw_get_velocity_d(double* x, double* y)
{   float result,
          xx, yy;

    result = cw_get_velocity(&xx, &yy);
    *x = (double) xx;
    *y = (double) yy;

    return (double) result;
}

EXPORT float cw_get_version(void)
{
#ifdef WIN32
    TEXT  strfloat[20 + 1];
    float result;
#endif

    dosglmessage(MT_GET_VERSION, 0);

#ifdef WIN32
    api_read_clip();
    sscanf(globalstring, "%d %d %s", &rw, &mt, strfloat);
    result = zatof(strfloat);
    if (rw != (int) RobotWindowPtr || mt != MT_GET_VERSION)
    {   api_garbled(8);
    }
    return result;
#endif
#ifdef AMIGA
    return SglMessage.cw_ResultSgl1;
#endif
}
EXPORT double cw_get_version_d(void)
{   return (double) cw_get_version();
}

EXPORT void cw_turn(float direction)
{
#ifdef WIN32
    sprintf(globalstring, "%d %d %f", RobotWindowPtr, MT_TURN, direction);
    write_clip();
#endif
#ifdef AMIGA
    SglMessage.cw_Single1 = direction;
#endif

    dosglmessage(MT_TURN, 0);
}
EXPORT void cw_turn_d(double direction)
{   cw_turn((float) direction);
}

EXPORT void cw_teleport(float x, float y)
{
#ifdef WIN32
    sprintf(globalstring, "%d %d %f %f", RobotWindowPtr, MT_TELEPORT, x, y);
    write_clip();
#endif
#ifdef AMIGA
    SglMessage.cw_Single1 = x;
    SglMessage.cw_Single2 = y;
#endif

    dosglmessage(MT_TELEPORT, 0);
}
EXPORT void cw_teleport_d(double x, double y)
{   cw_teleport((float) x, (float) y);
}

EXPORT int cw_get_xcraft_force(void)
{   return (int) dosglmessage(MT_GET_FORCE, 0);
}

#ifdef WIN32
MODULE void api_read_clip(void)
{   Sleep(1); // important for WinXP!
#ifdef VERBOSE
    printf("String is %s!\n", globalstring);
#endif
}
#endif

MODULE void write_clip(void)
{
#ifdef WIN32
    cds.dwData = (DWORD) RobotWindowPtr;
    cds.cbData = strlen(globalstring) + 1;
    cds.lpData = (void *) globalstring;
    SendMessage(SimWindowPtr, WM_COPYDATA, (DWORD) RobotWindowPtr, (LPARAM) &cds);
#endif
#ifdef AMIGA
    ;
#endif
}

#ifdef WIN32
MODULE void api_garbled(int errornum)
{   PERSIST TEXT extrastring[256];

    sprintf(extrastring, "Robot: Error %d", errornum);

    MessageBox
    (   NULL,
        globalstring,
        extrastring,
        MB_ICONEXCLAMATION | MB_OK
    );

    exit(EXIT_FAILURE);
}

EXPORT void openconsole(void)
{   int     hScrn, hKybd;
    FILE*   hf;
    PERSIST FLAG consoleopen = FALSE;

    if (consoleopen)
    {   return;
    }

    // assert(!consoleopen);

    AllocConsole(); // might need freeing at program exit
    consoleopen = TRUE;
    hScrn = _open_osfhandle((long) GetStdHandle(STD_OUTPUT_HANDLE), _O_TEXT); // might need freeing at program exit
    hKybd = _open_osfhandle((long) GetStdHandle(STD_INPUT_HANDLE ), _O_TEXT); // might need freeing at program exit
    hf = _fdopen(hScrn, "w"); // might need freeing at program exit
    *stdout = *hf;
    hf = _fdopen(hKybd, "r"); // might need freeing at program exit
    *stdin = *hf;
    DISCARD setvbuf(stdout, NULL, _IONBF, 0);
    DISCARD setvbuf(stdin , NULL, _IONBF, 0);

    DISCARD SetConsoleTitle("Robot Console");
    // Sleep(40); // to ensure the window title was updated
    // ConsoleWindowPtr = FindWindow(NULL, "Robot Console");
}

int PASCAL WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow)
{ /* int        argc;
    char**     argv;

    argc = __argc;
    argv = __argv;

    main(argc, argv); */

    main();

    return 0;
}

MODULE void openwindow(void)
{   WNDCLASSEX wc;
    HINSTANCE  InstancePtr = GetModuleHandle(NULL);

    wc.cbSize        = sizeof(WNDCLASSEX);
    wc.style         = 0;
    wc.lpfnWndProc   = WndProc;
    wc.cbClsExtra    = 0;
    wc.cbWndExtra    = 0;
    wc.hInstance     = InstancePtr;
    wc.hIcon         = NULL;
    wc.hCursor       = LoadCursor(NULL, IDC_ARROW);
    wc.hbrBackground = (HBRUSH)(COLOR_GRAYTEXT+1); // was (HBRUSH)(COLOR_WINDOW+1);
    wc.lpszMenuName  = NULL;
    wc.lpszClassName = "Robot";
    wc.hIconSm       = NULL;

    if (!RegisterClassEx(&wc))
    {   MessageBox
        (   NULL,
            "Window registration failed!",
            "Robot: Error",
            MB_ICONEXCLAMATION | MB_OK
        );
        exit(EXIT_FAILURE);
    }

    if (!(OurWindowPtr = CreateWindowEx
    (   0,
        "Robot",
        NULL,
        WS_POPUP,
        1, 1,
        0, 0,
        NULL,
        NULL,
        InstancePtr,
        NULL
    )))
    {   MessageBox
        (   NULL,
            "Window creation failed!",
            "Robot: Error",
            MB_ICONEXCLAMATION | MB_OK
        );
        exit(EXIT_FAILURE);
    }

//  ShowWindow(OurWindowPtr, SW_SHOW);
    UpdateWindow(OurWindowPtr);
}

LRESULT CALLBACK WndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam)
{   PAINTSTRUCT     ps;
    COPYDATASTRUCT* pcds;

    /* "When a window procedure processes a message, it should return 0 from the window
       procedure. All messages that a window procedure chooses not to process must be
       passed to a Windows function named DefWindowProc(). The value returned from
       DefWindowProc() must be returned from the window procedure. */

    switch (msg)
    {
    case WM_CREATE:
        return 0;
    acase WM_CLOSE:
        exit(EXIT_SUCCESS); // destroy window(s), etc.?
    acase WM_COPYDATA:
        pcds = (COPYDATASTRUCT*) lParam;
        strcpy(globalstring, pcds->lpData);
    acase WM_PAINT:
        BeginPaint(hwnd, &ps);
        EndPaint(hwnd, &ps);
    adefault:
        return DefWindowProc(hwnd, msg, wParam, lParam);
    }
    return 0;
}
#endif

/*
#ifdef AMIGA
MODULE void cleanexit(void)
{   if (ReplyPortPtr)
    {   DeleteMsgPort(ReplyPortPtr);
        ReplyPortPtr = NULL;
    }

    exit(EXIT_SUCCESS);
}
#endif
*/

EXPORT void cw_halt(void)
{
#ifdef WIN32
    sprintf(globalstring, "%d %d", RobotWindowPtr, MT_HALT);
    write_clip();
#endif

    dosglmessage(MT_HALT, 0);
}

#ifdef WIN32
MODULE float zatof(STRPTR inputstr)
{   int   decpoint = 0,
          i, j,
          length,
          start,
          temp;
    float result   = 0.0;

    if (inputstr[0] == '-')
    {   start = 1;
    } else
    {   start = 0;
    }

    length = strlen(inputstr);
    for (i = start; i < length; i++)
    {   if (inputstr[i] == '.')
        {   decpoint = i;
            break; // for speed
    }   }

    j = 1;
    for (i = decpoint - 1; i >= start; i--)
    {   temp = inputstr[i] - '0';
        result += (float) (temp * j);
        j *= 10;
    }

    j = 10;
    for (i = decpoint + 1; i < length; i++)
    {   temp = inputstr[i] - '0';
        result += (float) (temp / j);
        j *= 10;
    }

    if (start == 1)
    {   result = -result;
    }

    return result;
}
#endif
