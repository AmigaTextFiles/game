_rot_loop3:

  MOVE.b (a2)+,d1
  BEQ _rot_loop3a

  MOVE.l (a0),d1     ;d1=ox(n)
  CLR.w d1
  SWAP d1

  MOVE.w d1,d2          ;d2=x
  MULS.w d6,d1          ;x*csa

  MULS.w d7,d2          ;x*sna


  MOVE.l (a1),d3        ;oy(n)
  CLR.w d3
  SWAP d3

  MOVE.w d3,d4          ;y
  MULS.w d7,d3          ;y*sna

  SUB.l d3,d1           ;x*csa-y*sna

  MULS.w d6,d4          ;y*csa

  ADD.l d2,d4           ;y*csa+x*sna

_rot_loop3a:
  MOVE.l d4,(a1)+       ;y(n)=y*csa+x*sna
  MOVE.l d1,(a0)+       ;x(n)=x*csa-y*sna
  SUBQ.l #1,d0          ;n=n-1
  BGE _rot_loop3
