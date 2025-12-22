#include <exec/types.h>
#include <proto/exec.h>
#include <devices/audio.h>

UBYTE *LoadLump(ULONG lumpn);

UBYTE Channel_Map[]={3,5,10,12};

void PlaySample(ULONG selected)
{
	UBYTE *buffer;
	UBYTE *chipbuf;
	int l,i;
	struct MsgPort *audiomsgport;
	struct IOAudio *audioioreq;
	buffer=LoadLump(selected);
	l=buffer[4]+(buffer[5]<<8);
	chipbuf=AllocVec(l,MEMF_CHIP);
	for(i=0;i<l;i++)
		chipbuf[i]=buffer[8+i]-128;
	audiomsgport=CreateMsgPort();
	audioioreq=CreateIORequest(audiomsgport,sizeof(struct IOAudio));
	audioioreq->ioa_Data=Channel_Map;
	audioioreq->ioa_Length=sizeof(Channel_Map);
	audioioreq->ioa_Request.io_Message.mn_Node.ln_Pri=0;
	audioioreq->ioa_Request.io_Flags=ADIOF_NOWAIT;
	audioioreq->ioa_Request.io_Command=ADCMD_ALLOCATE;
	OpenDevice("audio.device",0,(struct IORequest *)audioioreq,0);
	audioioreq->ioa_Data=chipbuf;
	audioioreq->ioa_Length=l&(0xfffffffe);
	audioioreq->ioa_Cycles=1;
	audioioreq->ioa_Request.io_Flags=ADIOF_PERVOL;
	audioioreq->ioa_Period=100000000UL/28/(buffer[2]+(buffer[3]<<8));
	audioioreq->ioa_Volume=64;
	audioioreq->ioa_Request.io_Command=CMD_WRITE;
	BeginIO((struct IORequest *)audioioreq);
	Wait(1 << audiomsgport->mp_SigBit);
	GetMsg(audiomsgport);
	CloseDevice((struct IORequest *)audioioreq);
	DeleteIORequest(audioioreq);
	DeleteMsgPort(audiomsgport);
	FreeVec(chipbuf);
	FreeVec(buffer);
}
