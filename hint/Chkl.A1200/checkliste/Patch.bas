Open "Amigabasic" AS 1 LEN=1
FIELD#1,1 AS d$
i&=&HF3*256+&H87:PRINT i&
GET#1,i&:a$=HEX$(ASC(d$))
PRINT a$
IF a$="79" THEN
  LSET d$=CHR$(&H78)
  PUT #1,i&
END IF
CLOSE 1

