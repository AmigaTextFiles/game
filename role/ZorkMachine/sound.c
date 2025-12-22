#include <graphics/gfxbase.h>
#include <devices/audio.h>
#include <dos/dosextens.h>
#include <dos/dostags.h>
#include <exec/memory.h>

#include <clib/exec_protos.h>
#include <clib/dos_protos.h>

#include <stdlib.h>
#include <string.h>

#define SIG_SOUND	(1 << SoundPort -> mp_SigBit)
#define SIG_AUDIO	(1 << AudioPort -> mp_SigBit)
#define SIG_KILL	SIGBREAKF_CTRL_C
#define SIG_HANDSHAKE	SIGBREAKF_CTRL_D

extern struct GfxBase	*GfxBase;
extern struct Process	*ThisProcess;

STATIC struct Process	*SoundProcess;
STATIC struct MsgPort	*SoundPort;

#ifdef AZTEC_C

#define __saveds

#endif	/* AZTEC_C */

struct SoundHeader
{
	UBYTE	Reserved0[2];
	BYTE	Times;
	UBYTE	Rate[2];	/* Note: little endian */
	UBYTE	Reserved1[3];
	UWORD	PlayLength;
};

struct SoundMessage
{
	struct Message	VanillaMsg;
	LONG		ID,
			Volume;
};

VOID __saveds
SoundServer()
{
#ifdef AZTEC_C
	geta4();
#endif	/* AZTEC_C */

	if(SoundPort = CreateMsgPort())
	{
		struct SoundMessage	*Msg;
		APTR			 Data	= NULL;
		ULONG			 SignalSet;
		BYTE			 Terminated = FALSE;
		struct MsgPort		*AudioPort	= NULL;
		struct IOAudio		*AudioRequest	= NULL,
					*AudioControl;
		LONG			 Volume = -1;

		if(AudioControl = (struct IOAudio *)AllocVec(sizeof(struct IOAudio),MEMF_PUBLIC | MEMF_ANY))
		{
			Signal((struct Task *)ThisProcess,SIG_HANDSHAKE);

			while(!Terminated)
			{
				SignalSet = Wait(SIG_SOUND | SIG_KILL);

				if(SignalSet & SIG_KILL)
				{
					if(AudioPort)
					{
						if(!CheckIO((struct IORequest *)AudioRequest))
							AbortIO((struct IORequest *)AudioRequest);

						WaitIO((struct IORequest *)AudioRequest);

						CloseDevice((struct IORequest *)AudioRequest);

						DeleteIORequest(AudioRequest);

						DeleteMsgPort(AudioPort);

						FreeVec(Data);
					}

					break;
				}

				if(SignalSet & SIG_SOUND)
				{
					while(Msg = (struct SoundMessage *)GetMsg(SoundPort))
					{
						if(Msg -> Volume != Volume && AudioPort)
						{
							if(!Msg -> Volume)
							{
								if(!CheckIO((struct IORequest *)AudioRequest))
									AbortIO((struct IORequest *)AudioRequest);

								WaitIO((struct IORequest *)AudioRequest);

								CloseDevice((struct IORequest *)AudioRequest);

								DeleteIORequest(AudioRequest);

								DeleteMsgPort(AudioPort);

								FreeVec(Data);

								AudioRequest	= NULL;
								AudioPort	= NULL;
								Data		= NULL;
								Volume		= 0;
							}
							else
							{
								Volume = Msg -> Volume * 8;

								AudioControl -> ioa_Request . io_Command	= ADCMD_PERVOL;
								AudioControl -> ioa_Request . io_Flags		= ADIOF_NOWAIT | ADIOF_PERVOL;
								AudioControl -> ioa_Volume			= Volume;

								BeginIO((struct IORequest *)AudioControl);
								WaitIO((struct IORequest *)AudioControl);
							}
						}
						else
						{
							if(AudioPort)
							{
								AudioRequest -> ioa_Request . io_Command = ADCMD_FINISH;

								DoIO((struct IORequest *)AudioRequest);

								CloseDevice((struct IORequest *)AudioRequest);

								DeleteIORequest(AudioRequest);

								DeleteMsgPort(AudioPort);

								FreeVec(Data);

								AudioRequest	= NULL;
								AudioPort	= NULL;
								Data		= NULL;
							}

							if(Msg -> ID)
							{
								struct SoundHeader	Header;
								BPTR			File;
								UBYTE			Buffer[100];

								sprintf(Buffer,"Sound/s%ld.dat",Msg -> ID);

								if(File = Open(Buffer,MODE_OLDFILE))
								{
									if(Read(File,&Header,sizeof(Header)) == sizeof(Header))
									{
										if(Data = AllocVec(Header . PlayLength,MEMF_CHIP))
										{
											if(Read(File,Data,Header . PlayLength) == Header . PlayLength)
											{
												if(AudioPort = CreateMsgPort())
												{
													if(AudioRequest = (struct IOAudio *)CreateIORequest(AudioPort,sizeof(struct IOAudio)))
													{
														STATIC UBYTE Allocation[4] = { 1,2,4,8 };

														AudioRequest -> ioa_Request . io_Message . mn_Node . ln_Pri	= 127;
														AudioRequest -> ioa_Request . io_Command			= ADCMD_ALLOCATE;
														AudioRequest -> ioa_Request . io_Flags				= ADIOF_NOWAIT | ADIOF_PERVOL;
														AudioRequest -> ioa_Data					= Allocation;
														AudioRequest -> ioa_Length					= 4;

														if(!OpenDevice(AUDIONAME,0,(struct IORequest *)AudioRequest,0))
														{
															ULONG Rate = (Header . Rate[1] << 8) | Header . Rate[0];

															Volume = Msg -> Volume * 8;

															AudioRequest -> ioa_Request . io_Command	= CMD_WRITE;
															AudioRequest -> ioa_Request . io_Flags		= ADIOF_PERVOL;
															AudioRequest -> ioa_Period			= (GfxBase -> DisplayFlags & PAL ? 3546895 : 3579545) / Rate;
															AudioRequest -> ioa_Volume			= Volume;
															AudioRequest -> ioa_Cycles			= Header . Times;
															AudioRequest -> ioa_Data			= Data;
															AudioRequest -> ioa_Length			= Header . PlayLength;

															CopyMem(AudioRequest,AudioControl,sizeof(struct IOAudio));

															if(Header . Times)
															{
																BeginIO((struct IORequest *)AudioRequest);

																for(;;)
																{
																	SignalSet = Wait(SIG_KILL | SIG_SOUND | SIG_AUDIO);

																	if(SignalSet & SIG_KILL)
																	{
																		if(!CheckIO((struct IORequest *)AudioRequest))
																			AbortIO((struct IORequest *)AudioRequest);

																		WaitIO((struct IORequest *)AudioRequest);

																		CloseDevice((struct IORequest *)AudioRequest);

																		DeleteIORequest(AudioRequest);

																		DeleteMsgPort(AudioPort);

																		FreeVec(Data);

																		Terminated = TRUE;

																		break;
																	}

																	if(SignalSet & SIG_SOUND)
																	{
																		if(!CheckIO((struct IORequest *)AudioRequest))
																			AbortIO((struct IORequest *)AudioRequest);

																		WaitIO((struct IORequest *)AudioRequest);

																		CloseDevice((struct IORequest *)AudioRequest);

																		DeleteIORequest(AudioRequest);

																		DeleteMsgPort(AudioPort);

																		FreeVec(Data);

																		AudioRequest	= NULL;
																		AudioPort	= NULL;
																		Data		= NULL;

																		break;
																	}

																	if(SignalSet & SIG_AUDIO)
																	{
																		WaitIO((struct IORequest *)AudioRequest);

																		CloseDevice((struct IORequest *)AudioRequest);

																		DeleteIORequest(AudioRequest);

																		DeleteMsgPort(AudioPort);

																		FreeVec(Data);

																		AudioRequest	= NULL;
																		AudioPort	= NULL;
																		Data		= NULL;

																		break;
																	}
																}
															}
															else
																BeginIO((struct IORequest *)AudioRequest);
														}
														else
														{
															DeleteIORequest(AudioRequest);

															AudioRequest = NULL;

															DeleteMsgPort(AudioPort);

															AudioPort = NULL;

															FreeVec(Data);

															Data = NULL;
														}
													}
													else
													{
														DeleteMsgPort(AudioPort);

														AudioPort = NULL;

														FreeVec(Data);

														Data = NULL;
													}
												}
												else
												{
													FreeVec(Data);

													Data = NULL;
												}
											}
											else
											{
												FreeVec(Data);

												Data = NULL;
											}
										}
									}

									Close(File);
								}
							}
						}

						FreeVec(Msg);

						if(Terminated)
							break;
					}
				}
			}

			FreeVec(AudioControl);
		}

		while(Msg = (struct SoundMessage *)GetMsg(SoundPort))
			FreeVec(Msg);

		DeleteMsgPort(SoundPort);

		SoundPort = NULL;
	}

	Forbid();

	Signal((struct Task *)ThisProcess,SIG_HANDSHAKE);

	SoundProcess = NULL;
}

VOID
SoundCleanup()
{
	if(SoundProcess)
	{
		Signal((struct Task *)SoundProcess,SIG_KILL);

		Wait(SIG_HANDSHAKE);
	}
}

VOID
PlaySound(int ID,int Volume)
{
	if(!SoundProcess)
	{
		if(SoundProcess = CreateNewProcTags(
			NP_Name,	"Zorkmachine Sound",
			NP_StackSize,	8192,
			NP_Priority,	5,
			NP_WindowPtr,	-1,
			NP_Entry,	SoundServer,
		TAG_DONE))
		{
			Wait(SIG_HANDSHAKE);
		}
	}

	if(SoundProcess)
	{
		struct SoundMessage *Msg;

		if(Msg = (struct SoundMessage *)AllocVec(sizeof(struct SoundMessage),MEMF_ANY | MEMF_PUBLIC | MEMF_CLEAR))
		{
			Msg -> ID	= ID;
			Msg -> Volume	= Volume;

			PutMsg(SoundPort,(struct Message *)Msg);
		}
	}
}
