
	.text

	.global	SocketBase
	.global	PPCCallOS

	.global	accept
	.type accept,@function
	.align	3
accept:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	4,68(1)
	stw	5,72(1)
	stw	3,36(1)
	li	11,-48
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	bind
	.type bind,@function
	.align	3
bind:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	4,68(1)
	stw	3,36(1)
	stw	5,40(1)
	li	11,-36
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	CloseSocket
	.type CloseSocket,@function
	.align	3
CloseSocket:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	3,36(1)
	li	11,-120
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	connect
	.type connect,@function
	.align	3
connect:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	4,68(1)
	stw	3,36(1)
	stw	5,40(1)
	li	11,-54
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	Dup2Socket
	.type Dup2Socket,@function
	.align	3
Dup2Socket:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	3,36(1)
	stw	4,40(1)
	li	11,-264
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	Errno
	.type Errno,@function
	.align	3
Errno:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	li	11,-162
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	getdtablesize
	.type getdtablesize,@function
	.align	3
getdtablesize:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	li	11,-138
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	gethostbyaddr
	.type gethostbyaddr,@function
	.align	3
gethostbyaddr:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	3,68(1)
	stw	4,36(1)
	stw	5,40(1)
	li	11,-216
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	gethostbyname
	.type gethostbyname,@function
	.align	3
gethostbyname:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	3,68(1)
	li	11,-210
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	gethostid
	.type gethostid,@function
	.align	3
gethostid:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	li	11,-288
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	gethostname
	.type gethostname,@function
	.align	3
gethostname:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	3,68(1)
	stw	4,36(1)
	li	11,-282
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	getnetbyaddr
	.type getnetbyaddr,@function
	.align	3
getnetbyaddr:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	3,36(1)
	stw	4,40(1)
	li	11,-228
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	getnetbyname
	.type getnetbyname,@function
	.align	3
getnetbyname:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	3,68(1)
	li	11,-222
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	getpeername
	.type getpeername,@function
	.align	3
getpeername:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	4,68(1)
	stw	5,72(1)
	stw	3,36(1)
	li	11,-108
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	getprotobyname
	.type getprotobyname,@function
	.align	3
getprotobyname:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	3,68(1)
	li	11,-246
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	getprotobynumber
	.type getprotobynumber,@function
	.align	3
getprotobynumber:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	3,36(1)
	li	11,-252
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	getservbyname
	.type getservbyname,@function
	.align	3
getservbyname:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	3,68(1)
	stw	4,72(1)
	li	11,-234
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	getservbyport
	.type getservbyport,@function
	.align	3
getservbyport:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	4,68(1)
	stw	3,36(1)
	li	11,-240
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	GetSocketEvents
	.type GetSocketEvents,@function
	.align	3
GetSocketEvents:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	3,68(1)
	li	11,-300
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	getsockname
	.type getsockname,@function
	.align	3
getsockname:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	4,68(1)
	stw	5,72(1)
	stw	3,36(1)
	li	11,-102
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	getsockopt
	.type getsockopt,@function
	.align	3
getsockopt:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	6,68(1)
	stw	7,72(1)
	stw	3,36(1)
	stw	4,40(1)
	stw	5,44(1)
	li	11,-96
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	inet_addr
	.type inet_addr,@function
	.align	3
inet_addr:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	3,68(1)
	li	11,-180
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	Inet_LnaOf
	.type Inet_LnaOf,@function
	.align	3
Inet_LnaOf:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	3,36(1)
	li	11,-186
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	Inet_MakeAddr
	.type Inet_MakeAddr,@function
	.align	3
Inet_MakeAddr:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	3,36(1)
	stw	4,40(1)
	li	11,-198
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	Inet_NetOf
	.type Inet_NetOf,@function
	.align	3
Inet_NetOf:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	3,36(1)
	li	11,-192
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	inet_network
	.type inet_network,@function
	.align	3
inet_network:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	3,68(1)
	li	11,-204
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	Inet_Nto
	.type Inet_Nto,@function
	.align	3
Inet_Nto:
	stwu	1,-128(1)
	mflr	11
	stw	11,100(1)
	lwz	11,128(1)
	stw	11,96(1)
	stw	3,104(1)
	stw	4,108(1)
	stw	5,112(1)
	stw	6,116(1)
	stw	7,120(1)
	stw	8,124(1)
	stw	9,128(1)
	stw	10,132(1)
	addi	11,1,104
	stw	11,36(1)
	li	11,-174
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,96(1)
	stw	11,128(1)
	lwz	11,100(1)
	mtlr	11
	addi	1,1,128
	blr

	.global	Inet_NtoA
	.type Inet_NtoA,@function
	.align	3
Inet_NtoA:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	3,36(1)
	li	11,-174
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	IoctlSocket
	.type IoctlSocket,@function
	.align	3
IoctlSocket:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	5,68(1)
	stw	3,36(1)
	stw	4,40(1)
	li	11,-114
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	listen
	.type listen,@function
	.align	3
listen:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	3,36(1)
	stw	4,40(1)
	li	11,-42
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	ObtainSocket
	.type ObtainSocket,@function
	.align	3
ObtainSocket:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	3,36(1)
	stw	4,40(1)
	stw	5,44(1)
	stw	6,48(1)
	li	11,-144
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	recv
	.type recv,@function
	.align	3
recv:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	4,68(1)
	stw	3,36(1)
	stw	5,40(1)
	stw	6,44(1)
	li	11,-78
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	recvfrom
	.type recvfrom,@function
	.align	3
recvfrom:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	4,68(1)
	stw	7,72(1)
	stw	8,76(1)
	stw	3,36(1)
	stw	5,40(1)
	stw	6,44(1)
	li	11,-72
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	recvmsg
	.type recvmsg,@function
	.align	3
recvmsg:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	4,68(1)
	stw	3,36(1)
	stw	5,40(1)
	li	11,-276
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	ReleaseCopyOfSocket
	.type ReleaseCopyOfSocket,@function
	.align	3
ReleaseCopyOfSocket:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	3,36(1)
	stw	4,40(1)
	li	11,-156
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	ReleaseSocket
	.type ReleaseSocket,@function
	.align	3
ReleaseSocket:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	3,36(1)
	stw	4,40(1)
	li	11,-150
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	send
	.type send,@function
	.align	3
send:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	4,68(1)
	stw	3,36(1)
	stw	5,40(1)
	stw	6,44(1)
	li	11,-66
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	sendmsg
	.type sendmsg,@function
	.align	3
sendmsg:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	4,68(1)
	stw	3,36(1)
	stw	5,40(1)
	li	11,-270
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	sendto
	.type sendto,@function
	.align	3
sendto:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	4,68(1)
	stw	7,72(1)
	stw	3,36(1)
	stw	5,40(1)
	stw	6,44(1)
	stw	8,48(1)
	li	11,-60
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	SetErrnoPtr
	.type SetErrnoPtr,@function
	.align	3
SetErrnoPtr:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	3,68(1)
	stw	4,36(1)
	li	11,-168
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	SetSocketSignals
	.type SetSocketSignals,@function
	.align	3
SetSocketSignals:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	3,36(1)
	stw	4,40(1)
	stw	5,44(1)
	li	11,-132
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	setsockopt
	.type setsockopt,@function
	.align	3
setsockopt:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	6,68(1)
	stw	3,36(1)
	stw	4,40(1)
	stw	5,44(1)
	stw	7,48(1)
	li	11,-90
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	shutdown
	.type shutdown,@function
	.align	3
shutdown:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	3,36(1)
	stw	4,40(1)
	li	11,-84
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	socket
	.type socket,@function
	.align	3
socket:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	3,36(1)
	stw	4,40(1)
	stw	5,44(1)
	li	11,-30
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	SocketBaseTagList
	.type SocketBaseTagList,@function
	.align	3
SocketBaseTagList:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	3,68(1)
	li	11,-294
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	SocketBaseTags
	.type SocketBaseTags,@function
	.align	3
SocketBaseTags:
	stwu	1,-128(1)
	mflr	11
	stw	11,100(1)
	lwz	11,128(1)
	stw	11,96(1)
	stw	3,104(1)
	stw	4,108(1)
	stw	5,112(1)
	stw	6,116(1)
	stw	7,120(1)
	stw	8,124(1)
	stw	9,128(1)
	stw	10,132(1)
	addi	11,1,104
	stw	11,68(1)
	li	11,-294
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,96(1)
	stw	11,128(1)
	lwz	11,100(1)
	mtlr	11
	addi	1,1,128
	blr

	.global	vsyslog
	.type vsyslog,@function
	.align	3
vsyslog:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	4,68(1)
	stw	5,72(1)
	stw	3,36(1)
	li	11,-258
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr

	.global	WaitSelect
	.type WaitSelect,@function
	.align	3
WaitSelect:
	stwu	1,-96(1)
	mflr	11
	stw	11,100(1)
	stw	4,68(1)
	stw	5,72(1)
	stw	6,76(1)
	stw	7,80(1)
	stw	3,36(1)
	stw	8,40(1)
	li	11,-126
	stw	11,8(1)
	li	11,1
	stw	11,12(1)
	stw	11,24(1)
	lis	11,SocketBase@ha
	lwz	11,SocketBase@l(11)
	stw	11,92(1)
	addi	3,1,8
	bl	PPCCallOS
	lwz	11,100(1)
	mtlr	11
	addi	1,1,96
	blr
