/* AmigaOS4-specific code */

#ifdef __amigaos4__
char aos_window[] = "CON:0/24/500/100/Escape-output/CLOSE/AUTO";
char * __stdio_window_specification = (char *) &aos_window;
#endif

