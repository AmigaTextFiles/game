# APH = aph
AAPH = aaph

default : register.aph upload.aph rate.aph fixup.aph admin.aph adminone.aph newcol.aph modone.aph modsubdir.aph addsubdir.aph rmsubdir.aph copyone.aph delete.aph ping.aph comment.aph comments.aph recent.aph domodsubdir.aph level.aph recentrss.aph best.aph verify.aph delcomment.aph upsol.aph allsols.aph adminsols.aph showspeedruns.aph makescreenshots.aph

# %.aph : %.a escape.ah escape.db
# 	$(APH) $@ < $<

%.aph : %.aa escape.aah escape.db
	${AAPH} -I /home/httpd/aph/ $< -o $@