/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * mixaudio16.c
 *
 * Where the mixing gets done.
 *
 *  The MixAudio funcs (2-inf) are generated from the following perl code:

#!/usr/bin/perl

$func = "
void MixAudio16_NUMNUMNUM(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[NUMNUMNUM];
	int sample;
	int i;
	int len;

	len = entries[0].bytes;
	len /= sizeof(ALshort);

	for(i = 0; i < NUMNUMNUM; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < NUMNUMNUM; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < NUMNUMNUM; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}
";

foreach $i (2..64) {
	($new = $func) =~ s/NUMNUMNUM/$i/g;

	print $new;
}

*/

#include <AL/altypes.h>

#include "al_main.h"
#include "al_types.h"
#include "mixaudio16.h"
#include "al_siteconfig.h"

void MixAudio16(ALshort *dst, ALshort *src, int len) {
	int sample;

	len /= sizeof(ALshort); /* len is in bytes */

	while(len--) {
		sample = *dst + *src;

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		src++;
		dst++;
	}

	return;
}

/* FIXME: could be optimized to bisect the data until an "optimized"
 * MixAudio func could be used on it.
 */
void MixAudio16_n(ALshort *dst, alMixEntry *entries, ALuint numents) {
	int sample;
	ALuint i;
	int si; /* source iterator */
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	si = 0;
	while(len--) {
		sample = *dst;

		for(i = 0; i < numents; i++) {
			sample += ((ALshort *) entries[i].data)[si];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		dst++;
		si++;
	}
	return;
}

void MixAudio16_0(UNUSED(ALshort *dst), UNUSED(alMixEntry *entries)) {
	return;
}

void MixAudio16_1(ALshort *dst, alMixEntry *entries) {
	MixAudio16(dst, entries->data, entries->bytes);

	return;
}

void MixAudio16_2(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[2];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 2; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 2; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 2; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_3(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[3];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 3; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 3; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 3; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_4(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[4];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 4; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 4; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 4; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_5(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[5];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 5; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 5; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 5; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_6(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[6];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 6; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 6; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 6; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_7(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[7];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 7; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 7; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 7; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_8(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[8];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 8; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 8; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 8; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_9(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[9];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 9; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 9; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 9; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_10(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[10];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 10; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 10; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 10; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_11(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[11];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 11; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 11; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 11; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_12(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[12];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 12; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 12; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 12; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_13(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[13];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 13; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 13; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 13; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_14(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[14];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 14; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 14; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 14; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_15(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[15];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 15; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 15; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 15; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_16(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[16];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 16; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 16; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 16; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_17(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[17];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 17; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 17; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 17; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_18(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[18];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 18; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 18; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 18; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_19(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[19];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 19; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 19; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 19; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_20(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[20];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 20; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 20; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 20; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_21(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[21];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 21; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 21; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 21; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_22(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[22];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 22; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 22; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 22; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_23(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[23];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 23; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 23; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 23; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_24(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[24];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 24; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 24; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 24; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_25(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[25];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 25; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 25; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 25; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_26(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[26];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 26; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 26; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 26; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_27(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[27];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 27; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 27; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 27; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_28(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[28];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 28; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 28; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 28; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_29(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[29];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 29; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 29; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 29; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_30(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[30];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 30; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 30; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 30; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_31(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[31];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 31; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 31; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 31; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_32(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[32];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 32; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 32; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 32; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_33(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[33];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 33; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 33; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 33; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_34(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[34];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 34; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 34; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 34; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_35(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[35];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 35; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 35; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 35; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_36(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[36];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 36; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 36; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 36; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_37(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[37];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 37; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 37; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 37; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_38(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[38];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 38; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 38; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 38; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_39(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[39];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 39; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 39; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 39; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_40(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[40];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 40; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 40; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 40; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_41(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[41];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 41; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 41; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 41; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_42(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[42];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 42; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 42; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 42; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_43(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[43];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 43; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 43; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 43; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_44(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[44];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 44; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 44; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 44; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_45(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[45];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 45; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 45; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 45; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_46(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[46];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 46; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 46; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 46; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_47(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[47];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 47; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 47; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 47; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_48(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[48];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 48; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 48; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 48; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_49(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[49];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 49; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 49; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 49; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_50(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[50];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 50; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 50; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 50; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_51(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[51];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 51; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 51; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 51; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_52(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[52];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 52; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 52; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 52; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_53(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[53];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 53; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 53; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 53; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_54(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[54];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 54; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 54; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 54; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_55(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[55];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 55; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 55; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 55; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_56(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[56];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 56; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 56; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 56; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_57(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[57];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 57; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 57; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 57; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_58(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[58];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 58; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 58; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 58; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_59(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[59];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 59; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 59; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 59; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_60(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[60];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 60; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 60; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 60; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_61(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[61];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 61; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 61; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 61; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_62(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[62];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 62; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 62; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 62; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_63(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[63];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 63; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 63; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 63; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}

void MixAudio16_64(ALshort *dst, alMixEntry *entries) {
	ALshort *srcs[64];
	int sample;
	int i;
	int len;

	len = entries[0].bytes; /* sure hope all the same */
	len /= sizeof(ALshort);     /* len is in bytes */

	for(i = 0; i < 64; i++) {
		srcs[i] = entries[i].data;
	}

	while(len--) {
		sample = *dst;

		for(i = 0; i < 64; i++) {
			sample += *srcs[i];
		}

		if(sample > max_audioval ) {
			*dst = max_audioval;
		} else if(sample < min_audioval ) {
			*dst = min_audioval;
		} else {
			*dst = sample;
		}

		for(i = 0; i < 64; i++) {
			srcs[i]++;
		}

		dst++;
	}
	return;
}
