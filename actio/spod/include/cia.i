
	IFND	CIA_I
CIA_I	SET	1

;bases

CIAA		equ	$bfe001
CIAB		equ	$bfd000

;
; CIA A
;
;-------------------------------------------------------------------
; Register                  Data bits
;   Name     7     6     5     4     3     2     1    0
;-------------------------------------------------------------------
;pra     /FIR1 /FIR0  /RDY /TK0  /WPRO /CHNG /LED  OVL
;prb     Parallel port
;ddra    Direction for port A (BFE001);1=output (set to 0x03)
;ddrb    Direction for port B (BFE101);1=output (can be in or out)
;talo    CIAA timer A low byte (.715909 Mhz NTSC; .709379 Mhz PAL)
;tahi    CIAA timer A high byte
;tblo    CIAA timer B low byte (.715909 Mhz NTSC; .709379 Mhz PAL)
;tbhi    CIAA timer B high byte
;todlo   50/60 Hz event counter bits 7-0 (VSync or line tick)
;todmid  50/60 Hz event counter bits 15-8
;todhi   50/60 Hz event counter bits 23-16
;        not used
;sdr     CIAA serial data register (connected to keyboard)
;icr     CIAA interrupt control register
;cra     CIAA control register A
;crb     CIAA control register B

;
; CIA B
;
;-------------------------------------------------------------------
; Register                  Data bits
;   Name     7     6     5     4     3     2     1    0
;-------------------------------------------------------------------
;pra     /DTR  /RTS  /CD   /CTS  /DSR   SEL   POUT  BUSY
;prb     /MTR  /SEL3 /SEL2 /SEL1 /SEL0 /SIDE  DIR  /STEP
;ddra    Direction for Port A (BFD000);1 = output (set to 0xFF)
;ddrb    Direction for Port B (BFD100);1 = output (set to 0xFF)
;talo    CIAB timer A low byte (.715909 Mhz NTSC; .709379 Mhz PAL)
;tahi    CIAB timer A high byte
;tblo    CIAB timer B low byte (.715909 Mhz NTSC; .709379 Mhz PAL)
;tbhi    CIAB timer B high byte
;todlo   Horizontal sync event counter bits 7-0
;todmid  Horizontal sync event counter bits 15-8
;todhi   Horizontal sync event counter bits 23-16
;        not used
;sdr     CIAB serial data register (unused)
;icr     CIAB interrupt control register
;cra     CIAB Control register A
;crb     CIAB Control register B

; register offset

CIAPRA		equ	$000
CIAPRB		equ	$100
CIADDRA		equ	$200
CIADDRB		equ	$300
CIATALO		equ	$400
CIATAHI		equ	$500
CIATBLO		equ	$600
CIATBHI		equ	$700
CIATODLO	equ	$800
CIATODMID	equ	$900
CIATODHI	equ	$a00
CIASDR		equ	$c00
CIAICR		equ	$d00
CIACRA		equ	$e00
CIACRB		equ	$f00

	ENDC