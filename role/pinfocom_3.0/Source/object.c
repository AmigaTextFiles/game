/* object.c
 *
 *  ``pinfocom'' -- a portable Infocom Inc. data file interpreter.
 *  Copyright (C) 1987-1992  InfoTaskForce
 *
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
 *  along with this program; see the file COPYING.  If not, write to the
 *  Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
 */

/*
 * $Header: RCS/object.c,v 3.0 1992/10/21 16:56:19 pds Stab $
 */

#include "infocom.h"

static void
pr_obj A1(word, obj_num)
{
    print_str(print_hnum(obj_num));
    print_str(":\"");
    p_obj(obj_num);
    print_char('"');
}
    
static void
cut_obj A2(object_t *, obj, word, obj_num)
{
    object_t *op;

    if (obj->parent == 0)
        return;

    op = obj_addr(obj->parent);

    if (op->child == obj_num)
        op->child = obj->sibling;
    else
    {
        op = obj_addr(op->child);
        while (op->sibling != obj_num)
            op = obj_addr(op->sibling);
        op->sibling = obj->sibling;
    }
    obj->parent = 0;
    obj->sibling = 0;
}

void
transfer A2(word, o1, word, o2)
{
    object_t  *obj1;
    object_t  *obj2;

    obj1 = obj_addr(o1);
    obj2 = obj_addr(o2);

    cut_obj(obj1, o1);

    obj1->sibling = obj2->child;
    obj1->parent  = o2;
    obj2->child   = o1;

    if (gflags.pr_xfers)
    {
        print_char((word)'[');
        pr_obj(o1);
        print_str(" -> ");
        pr_obj(o2);
        print_char((word)']');

        new_line();
    }
}

void
remove_obj A1(word, obj_num)
{
    object_t  *obj;

    obj = obj_addr(obj_num);
    cut_obj(obj, obj_num);

    if (gflags.pr_xfers)
    {
        print_char((word)'[');
        pr_obj(obj_num);
        print_str(" -> (limbo)]");
        new_line();
    }
}

void
test_attr A2(word, obj_num, word, attr)
{
    object_t    *obj;
    int         b;
    int         i;

    obj = obj_addr(obj_num);
    b = 0x80;
    for (i = attr % 8; i > 0; --i)
        b >>= 1;

    if (gflags.pr_atest)
    {
        print_char((word)'[');
        pr_obj(obj_num);
        print_char((word)'(');
        print_num(attr);
        print_str(") == ");
        if (obj->attributes[attr / 8] & b)
            print_str("ON");
        else
            print_str("OFF");
        print_char((word)']');
        new_line();
    }

    ret_value((obj->attributes[attr / 8] & b) != 0);
}

void
set_attr A2(word, obj_num, word, attr)
{
    object_t    *obj;
    int         b;
    int         i;

    obj = obj_addr(obj_num);
    b = 0x80;
    for (i = attr % 8; i > 0; --i)
        b >>= 1;
    obj->attributes[attr / 8] |= b;

    if (gflags.pr_attr)
    {
        print_char((word)'[');
        pr_obj(obj_num);
        print_char((word)'(');
        print_num(attr);
        print_str(") := ON");
        print_char((word)']');
        new_line();
    }
}

void
clr_attr A2(word, obj_num, word, attr)
{
    object_t    *obj;
    int         b;
    int         i;

    obj = obj_addr(obj_num);
    b = 0x80;
    for (i = attr % 8; i > 0; --i)
        b >>= 1;
    obj->attributes[attr / 8] &= (~b);

    if (gflags.pr_attr)
    {
        print_char((word)'[');
        pr_obj(obj_num);
        print_char((word)'(');
        print_num(attr);
        print_str(") := OFF");
        print_char((word)']');
        new_line();
    }
}

void
get_loc A1(word, obj_num)
{
    object_t *obj;

    obj = obj_addr(obj_num);
    store((word)obj->parent);
}

void
get_holds A1(word, obj_num)
{
    object_t *obj;

    obj = obj_addr(obj_num);
    store((word)obj->child);
    ret_value(obj->child != 0);
}

void
get_link A1(word, obj_num)
{
    object_t *obj;

    obj = obj_addr(obj_num);
    store((word)obj->sibling);
    ret_value(obj->sibling != 0);
}

void
check_loc A2(word, o1, word, o2)
{
    object_t *obj;

    obj = obj_addr(o1);
    ret_value(obj->parent == o2);
}

object_t *
obj_addr A1(word, obj_num)
{
    return (object_t *)(objd.obj_base+(obj_num*objd.obj_size)+objd.obj_offset);
}
