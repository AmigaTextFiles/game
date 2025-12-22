;********************************

		include "ram:makros_2"

start:
		sys_init			;Screen oeffnen + Plane Adressen
						;sichern

		sort_b #8,#tabelle_b		;8 Bytes sortieren
		sort_w #8,#tabelle_w		;8 Worte sortieren
		sort_l #8,#tabelle_l		;8 Langworte sortieren

		sys_exit
		rts


tabelle_l:	dc.l 213,23,33,11223,333,123,323,2323
tabelle_w:	dc.w 2,773,93,3243,823,321,383,8787
tabelle_b:	dc.b 1,7,44,32,222,2,23,22

		even

		include "ram:befehle"
