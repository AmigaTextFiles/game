
.globl _HookEntry
_HookEntry:     movel                  a1,sp@-
								movel                  a2,sp@-
								movel                  a0,sp@-
								movel                  a0@(12),a0
								jsr                    a0@
								addw                   #12,sp
								rts

.globl _hookEntry
_hookEntry:     movel                  a2,sp@-
								movel                  a0@(12),a0
								jsr                    a0@
								addqw                  #4,sp
								rts

