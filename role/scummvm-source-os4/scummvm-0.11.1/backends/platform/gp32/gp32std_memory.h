/* ScummVM - Graphic Adventure Engine
 *
 * ScummVM is the legal property of its developers, whose names
 * are too numerous to list here. Please refer to the COPYRIGHT
 * file distributed with this source distribution.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.

 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 *
 * $URL: https://scummvm.svn.sourceforge.net/svnroot/scummvm/scummvm/tags/release-0-11-1/backends/platform/gp32/gp32std_memory.h $
 * $Id: gp32std_memory.h 30944 2008-02-23 22:50:18Z sev $
 *
 */

#ifndef __GP32STD_MEMORY_H
#define __GP32STD_MEMORY_H

extern void *	gp_memcpy(void *dst, const void *src, size_t count);
extern void *	gp_memset(void *dst, int val, size_t count);
extern void *	gp_malloc(size_t size);
extern void *	gp_calloc(size_t nitems, size_t size);
extern void 	gp_free(void *block);

#endif
