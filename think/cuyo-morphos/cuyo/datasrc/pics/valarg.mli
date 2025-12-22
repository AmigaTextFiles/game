(*
   Copyright 2006,2007 by Mark Weyer

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*)

type spec =
  | Options of string * (string * string) list
    (* For flags.
       The string is an internal identifier, let's say a type.
       The first string of list elements is the option,
       the second is an explanation for -help. *)
  | Int of string * string
    (* Integer valued option and its explanation. *)
  | Str of string * string
    (* String valued option and its explanation. *)

type parsres

val parse : spec list -> string -> parsres

val option : parsres -> string -> string option
val int : parsres -> string -> int option
val string : parsres -> string -> string option
val anon : parsres -> string list

