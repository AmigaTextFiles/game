;batch1-relocate fonts to ram:
cd fonts:
makedir ram:diamond
makedir ram:baselcb
makedir ram:dpaint
makedir ram:Helvetica

copy diamond to ram:diamond all
copy baselcb to ram:baselcb all
copy dpaint to ram:dpaint all
copy Helvetica to ram:Helvetica all

copy diamond.font to ram:
copy baselcb.font to ram: all
copy dpaint.font to ram: all
copy Helvetica.font to ram: all
assign fonts: ram:
