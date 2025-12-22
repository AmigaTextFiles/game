#include "main.h"

#define OK 0
#define NOTOK 1

#define MIN_DECODE_BUFFER (6 << 10)

#include "riff-wave.h"

sound *LoadSnd_WAV (char *name) {
	BPTR file;
	sound *snd;

	snd = AllocMem(sizeof(*snd), MEMF_PUBLIC|MEMF_CLEAR);
	if (!snd) return NULL;

	file = Open(name, MODE_OLDFILE);
	if (file) {
		int32 stat, err = OK;

		{
			struct { uint32 id, size, type; } hdr;

			stat = Read(file, &hdr, sizeof(hdr));
			if (stat != sizeof(hdr) || hdr.id != ID_RIFF || hdr.type != ID_WAVE)
				err = NOTOK;
		}

		{
			struct { uint32 id, size; } ch;
			struct WaveFormatEx *fmt = NULL;
			int32 totFrames = 0, blockFrames;
			int32 decBlocks, decFrames;
			int32 decBSize, samBSize;
			int32 samSize;
			uint8 *decB;
			int done = FALSE;

			while (!done && !err && Read(file, &ch, sizeof(ch)) == sizeof(ch)) {
				ch.size = read_le32(&ch.size);
				switch (ch.id) {

					case ID_fmt:
						if (ch.size < sizeof(struct WaveFormat)) {
							err = NOTOK;
							break;
						}
						fmt = AllocVec((ch.size >= 18) ? ch.size : 18, MEMF_ANY);
						if (!fmt) {
							err = NOTOK;
							break;
						}
						stat = Read(file, fmt, ch.size);
						if (stat != ch.size) {
							err = NOTOK;
							break;
						}

						/* Convert to proper endianness */
						fmt->numChannels = read_le16(&fmt->numChannels);
						fmt->samplesPerSec = read_le32(&fmt->samplesPerSec);
						fmt->blockAlign = read_le16(&fmt->blockAlign);
						fmt->bitsPerSample = read_le16(&fmt->bitsPerSample);

						if (ch.size == 16) {
							fmt->extraSize = 0;
						} else if (ch.size >= 18) {
							fmt->extraSize = ch.size - 18;
						} else {
							err = NOTOK;
							break;
						}

						switch (fmt->formatTag) {

							case WAVE_FORMAT_PCM:
								if (fmt->bitsPerSample < 1) {
									err = NOTOK;
									break;
								}
								fmt->blockAlign = ((fmt->bitsPerSample+7)>>3) * fmt->numChannels;
								blockFrames = 1;
								switch ((fmt->bitsPerSample+7)>>3) {
									case 0:
										err = NOTOK;
										break;
									case 1:
										samSize = 1;
										break;
									case 2:
										samSize = 2;
										break;
									default:
										samSize = 4;
										break;
								}
								break;

							default:
								err = NOTOK;
								break;

						}
						if (err) break;

						decBlocks = MIN_DECODE_BUFFER / fmt->blockAlign;
						if (!decBlocks || (MIN_DECODE_BUFFER % fmt->blockAlign)) decBlocks++;

						/* only mono/stereo supported */
						if (fmt->numChannels != 1 && fmt->numChannels != 2) {
							err = NOTOK;
							break;
						}

						decBSize = decBlocks * fmt->blockAlign;
						decFrames = decBlocks * blockFrames;
						break;

					case ID_fact:
						if (ch.size != 4) {
							err = NOTOK;
							break;
						}
						stat = Read(file, &totFrames, 4);
						if (stat != 4) {
							err = NOTOK;
							break;
						}
						totFrames = read_le32(&totFrames);
						break;

					case ID_data:
						if (!fmt) {
							err = NOTOK;
							break;
						}
						/* Do we have enough information to calculate a "theoretical" maximum
						    value for totalFrames to check with? */
						if (fmt->blockAlign && blockFrames) {
							int32 totFramesMax = (ch.size / fmt->blockAlign) * blockFrames;
							/* check if totalFrames is within "reasonable bounds */
							if (totFrames <= 0 || totFramesMax > (totFrames + blockFrames)
								|| totFrames > totFramesMax)
							{
								totFrames = totFramesMax; /* it wasn't, so we assume it to be faulty/corrupt */
							}
						}
						samBSize = totFrames*samSize*fmt->numChannels;
						decB = AllocVec(decBSize, MEMF_ANY);
						if (!decB) {
							err = NOTOK;
							break;
						}
						snd->samples = AllocVec(samBSize, MEMF_PUBLIC);
						if (!snd->samples) {
							err = NOTOK;
							break;
						} else {
							int32 remFrames;
							int32 frames, decSize;
							uint8 *samB;

							remFrames = totFrames;
							decSize = fmt->blockAlign;
							samB = snd->samples;

							while (remFrames > 0) {
								frames = (remFrames > decFrames) ? decFrames : remFrames;
								stat = Read(file, decB, frames*decSize);
								if (stat != frames*decSize) {
									err = NOTOK;
									break;
								} else {
									uint8 *src = decB;
									int32 fr, ch;
									switch (decSize) {

										case 1:
											for (fr = 0; fr < frames; fr++) {
												for (ch = 0; ch < fmt->numChannels; ch++) {
													*samB = *src+128;
													samB++; src++;
												}
											}
											break;

										case 2:
											for (fr = 0; fr < frames; fr++) {
												for (ch = 0; ch < fmt->numChannels; ch++) {
													*(uint16 *)samB = read_le16(src);
													samB += 2; src += 2;
												}
											}
											break;

										case 3:
											for (fr = 0; fr < frames; fr++) {
												for (ch = 0; ch < fmt->numChannels; ch++) {
													*(uint32 *)samB = (read_le16(src) + src[2] << 16) << 8;
													samB += 4; src += 3;
												}
											}
											break;

										default:
											for (fr = 0; fr < frames; fr++) {
												for (ch = 0; ch < fmt->numChannels; ch++) {
													src += (decSize - 4);
													*(uint32 *)samB = read_le32(src);
													samB += 4; src += 4;
												}
											}
											break;

									} /* switch */
								} /* if */
								remFrames -= frames;
							} /* while */
						}
						if (err == OK) done = TRUE;
						break;

					default:
						Printf("unknown chunk\n");
						if (Seek(file, (ch.size+1)&~1, OFFSET_CURRENT) == -1)
							err = NOTOK;
						break;

				} /* switch */
			} /* while */
			FreeVec(decB);
			if (done) {
				snd->samplesize = samSize << 3;
				snd->channels = fmt->numChannels;
				snd->length = totFrames;
				snd->freq = fmt->samplesPerSec;
			} else {
				FreeSnd(snd);
				snd = NULL;
			}
			FreeVec(fmt);
		}
		Close(file);
	} else
		Printf("File not found\n");
	return snd;
}
