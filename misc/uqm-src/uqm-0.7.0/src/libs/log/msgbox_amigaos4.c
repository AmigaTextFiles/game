/*
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

#include "msgbox.h"
#include <classes/requester.h>
#include <proto/intuition.h>
#include <proto/requester.h>

void log_displayBox (const char *title, int isError, const char *msg)
{
    struct ClassLibrary *RequesterBase;
    Class *RequesterClass;
    RequesterBase = IIntuition->OpenClass("requester.class", 53, &RequesterClass);
    if (RequesterBase != NULL) {
        Object *requester;
        requester = IIntuition->NewObject(RequesterClass, NULL,
            REQ_TitleText,  title,
            REQ_BodyText,   msg,
            REQ_GadgetText, "_Ok",
            REQ_Image,      isError ? REQIMAGE_ERROR : REQIMAGE_INFO,
            TAG_END);
        if (requester != NULL) {
            IIntuition->IDoMethod(requester, RM_OPENREQ, NULL, NULL, NULL);
            IIntuition->DisposeObject(requester);
        }
        IIntuition->CloseClass(RequesterBase);
    }
}
