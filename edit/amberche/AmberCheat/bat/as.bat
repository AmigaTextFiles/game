assign Amberstar_A: HD4:ROLE/AMBER/Amberfiles
assign Amberstar_B: HD4:ROLE/AMBER/Amberfiles
assign Amberstar_C: HD4:ROLE/AMBER/Amberfiles

cpu >NIL: nocache noburst nocopyback
c:noaga -d Amberload

assign Amberstar_A: remove
assign Amberstar_B: remove
assign Amberstar_C: remove
cpu >NIL: cache burst copyback

