/*
 * Amiga serial driver includes
 *
 * $Revision: 1.1 $
 * $State: Exp $
 * $Author: hfrieden $
 * $Date: 1998/04/11 22:13:56 $
 *
 * $Log: amiga_serial.h,v $
 * Revision 1.1  1998/04/11 22:13:56  hfrieden
 * Amiga Serial driver defines and prototypes
 *
*/
#ifndef __AMIGA_SERIAL_H
#define __AMIGA_SERIAL_H

typedef struct  {
	int status;
	int count;
	
} PORT;

#define COM1    0
#define COM2    1
#define COM3    2
#define COM4    3

#define IRQ2    2
#define IRQ3    3
#define IRQ4    4
#define IRQ7    7
#define IRQ15   15

#define ASSUCCESS   1
#define ASBUFREMPTY -1
#define TRIGGER_04  4

#define ON  1
#define OFF 0

void com_send_ptr(char *ptr, int len);
int com_receive_ptr(char *ptr, int *len);

#endif
