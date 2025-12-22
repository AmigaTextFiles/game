*==========================================
*
* File:        ExtGfx.i
* Version:     6
* Revision:    0
* Created:     ??/??/????
* By:          FNC Slothouber
* Last Update: 25-Aug-1995
* By:          FNC Slothouber
* 
*
*==========================================


***** Display Structure *********

		rsreset
		rs.b	LN_SIZE
		rs.w	1
dsp_View	rs.l	1
		rs.l	1
dsp_ViewPort	rs.l	1
		rs.l	1
dsp_RasInfo	rs.l	1
		rs.l	1
dsp_sizeof	rs.l	0

		rsreset
new_dsp_width	rs.w	1
new_dsp_height	rs.w	1
new_dsp_modes	rs.w	1
new_dsp_sizeof	rs.l	0

