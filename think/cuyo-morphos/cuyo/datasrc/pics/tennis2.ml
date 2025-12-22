(*
    Copyright 2002,2005 by Mark Weyer

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

open Sys

let ignore x = ()

let command c = print_string (c^"\n"); flush stdout; ignore (command c)

let list_nat n =
  let rec do_it i = if i=n  then []  else i::(do_it (i+1))  in
  do_it 0

let exp_name name = "mt"^name^".ppm"
let exp_name' name = "mt"^name^".pgm"
let exp_name'' name = "mt"^name^".xpm"
let exp_aname name = "mt"^name^"Alpha.pgm"

let add_name name j = name^(string_of_int j)
let add2_name name j1 j2 = add_name (add_name name j1) j2

let source = ["Source",0,0]

let move_stack base stack dest =
  command ("cat "^(exp_name base)^
    (List.fold_left (function s -> function pic,x,y ->
        s^" | pamcomp -xoff "^(string_of_int x)^" -yoff "^(string_of_int y)
          ^" -alpha "^(exp_aname pic)^" "^(exp_name pic)^" -")
      "" stack)^
    " > "^(exp_name dest))

let bounce5 = "Ball",
  [13,20; 13,18; 13,17; 13,17; 13,18]
let bounce7 = "Ball",
  [13,20; 13,17; 13,15; 13,14; 13,14; 13,15; 13,17]

let bounce = "Ball",
  [13,25; 13,21; 13,18; 13,16; 13,15; 13,15; 13,16; 13,18; 13,21]
let intro_m = "Ball",
  [13, 7; 13, 8; 13, 9; 13,10; 13,10; 13,11; 13,13; 13,16; 13,20]
let intro_r = "Ball",
  [45,-7; 41,-7; 38,-6; 34,-4; 31,-1; 27,03; 24,07; 20,12; 17,18]
let intro_l = "Ball",
  [-19,-7;-15,-7;-12,-6; -8,-4; -5,-1; -1,03;  2,07;  6,12;  9,18]
let exit_m = "Ball",
  [13,25; 13,22; 13,20; 13,20; 13,19; 13,17; 13,14; 13,11; 13, 7]

let dxb = -1
let dyb = -2

let dxr = -1
let dyr = -2

let list_command_i s f e l = command ((snd (List.fold_left
    (function i,c -> function a -> i+1, c^(f i a))
    (0,s)  l))^
  e)

let sequence base color dest dx dy front back (name,seq) =
  let pic i = if name="Burst"
    then add_name (color^name) i
    else (color^name)  in
  ignore (List.fold_left
    (function i -> function x,y ->
      move_stack base (front@[pic i,x+dx,y+dy]@back) (add_name dest i); i+1)
    0  seq);
  list_command_i
    "pnmcat -leftright"
    (function i -> function x,y -> " "^(exp_name (add_name dest i)))
    (" | ppmtoxpm -hexonly | sed -e s/None/#012345/ -e s/#000000/None/ > "
      ^(exp_name'' dest))
    seq;
  list_command_i
    "rm"
    (function i -> function x,y -> " "^(exp_name (add_name dest i)))
    ""
    seq

let roof_seq color i s =
  command ("pamcut "^(string_of_int ((i-1)*32))^" 0 32 32 mtRoof.ppm > "
    ^(exp_name (add_name "Roof_" i)));
  sequence (add_name "Roof_" i) color (add_name "Roof" i) dxr dyr [] [] s;
  command ("rm "^(exp_name (add_name "Roof_" i)))

let small_blob_seq color dest =
  sequence "Black32" color (color^dest) dxb dyb

let large_blob_seq color dest dx dy =
  sequence "Black64" color (color^dest) (dxb+dx) (dyb+dy) [] []

let do_blob color =
  large_blob_seq color "Left" 0 32 intro_r;
  large_blob_seq color "Right" 32 32 intro_l;
  small_blob_seq color "Bounce" [] [] bounce;
  small_blob_seq color "In" [] source intro_m;
  small_blob_seq color "Out" [] source exit_m

let colors = [
  "Grey","0.7/0.7/0.7";
  "Green","0/1/0";
(*  "Red","1/0/0";*)
  "Blue","0/0/1";
  "Yellow","1/1/0"]

let raw_files = ["Ball"]

let prepare_pic color name =
  command ("pgmtoppm rgbi:"^(List.assoc color colors)^" "^(exp_name' name)^
    " > "^(exp_name (color^name)));
  command ("cp "^(exp_name' name)^" "^(exp_aname (color^name)))

let prepare_all u = List.iter
  (function name,c -> List.iter (prepare_pic name) raw_files)
  colors

let unprepare color =
  command (List.fold_left
    (function c -> function name -> c^" "^(exp_name (color^name))
      ^" "^(exp_aname (color^name)))
    "rm"  raw_files)

let unprepare_all u = List.iter
  (function name,c -> unprepare name)
  colors

;;

prepare_all ();

roof_seq "Yellow" 1 bounce5;
roof_seq "Grey" 2 bounce7;
roof_seq "Green" 3 bounce5;
roof_seq "Blue" 4 bounce7;

List.iter (function c,v -> do_blob c) colors;

unprepare_all ();

