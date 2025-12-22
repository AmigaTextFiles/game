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
  | Int of string * string
  | Str of string * string

type parsres =
  (string*string) list *
  (string*int) list *
  (string*string) list *
  string list


let parse specs usage =
  let options = Array.make (List.length specs) None  in
  let ints = Array.make (List.length specs) None  in
  let strings = Array.make (List.length specs) None  in
  let anon = ref []  in
  let _,specs' = List.fold_left
    (fun (n,s') -> fun s -> (n+1, match s  with
    | Options (intname,os) -> s' @ (List.map
      (fun (name,help) ->
        name, Arg.Unit (fun u -> options.(n) <- Some name), help)
      os)
    | Int (name,help) -> s' @
      [name, Arg.Int (fun i -> ints.(n) <- Some i), help]
    | Str (name,help) -> s' @
      [name, Arg.String (fun s -> strings.(n) <- Some s), help]))
    (0,[])  specs  in
  Arg.parse specs' (fun s -> anon := !anon @ [s]) usage;
  let _,opts = Array.fold_left
    (fun (n,os) -> fun o -> (n+1, match o  with
    | None -> os
    | Some o -> os@[(match List.nth specs n  with Options (name,rest) -> name),
      o]))
    (0,[])  options  in
  let _,ints = Array.fold_left
    (fun (n,is) -> fun i -> (n+1, match i  with
    | None -> is
    | Some i -> is@[(match List.nth specs n  with Int (name,help) -> name),i]))
    (0,[])  ints  in
  let _,strings = Array.fold_left
    (fun (n,ss) -> fun s -> (n+1, match s  with
    | None -> ss
    | Some s -> ss@
      [(match List.nth specs n  with Str (name,help) -> name),s]))
    (0,[])  strings  in
  opts,ints,strings,!anon


let option (opts,ints,strings,anon) name =
  try
    Some (List.assoc name opts)
  with
    Not_found -> None

let int (opts,ints,strings,anon) name =
  try
    Some (List.assoc name ints)
  with
    Not_found -> None

let string (opts,ints,strings,anon) name =
  try
    Some (List.assoc name strings)
  with
    Not_found -> None

let anon (opts,ints,strings,anon) = anon

