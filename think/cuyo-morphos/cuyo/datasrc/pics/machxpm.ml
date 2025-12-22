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

open Farbe
open Graphik
open Valarg

let argspec = [
  Options ("format",[
    "-ppm", "Expect ppm input format";
    "-rgba", "Expect RGBA pam input format";
    "-xpm", "Expect xpm input format";
    ]);
  Options ("method",[
    "-average", "Try to minimize average error when quantizing";
    "-maximal", "Try to minimize maximal error when quantizing";
    ]);
  Int ("-colours", "Maximal number of output colours");
  Int ("-chars", "Maximal number of output chars per pixel");
  Str ("-recolour", "Colour in format r/g/b to replace for red channel");
  Str ("-transcolour", "Colour in format r/g/b for bluescreening");
  ]

let rec hoch a b = if b=0  then 1  else a*(hoch a (b-1))

let parsecol s = match s  with
  | "trans" -> durchsichtig
  | s ->
    let rgslash = String.index s '/'  in
    let gbslash = String.index_from s (rgslash+1) '/'  in
    let red = int_of_string (String.sub s 0 rgslash)  in
    let green = int_of_string
      (String.sub s (rgslash+1) (gbslash-rgslash-1))  in
    let blue = int_of_string
      (String.sub s (gbslash+1) ((String.length s)-gbslash-1))  in
    let f x = (float_of_int x)/.255.0  in
    von_rgb (rgbrgb (f red) (f green) (f blue))

let ersetz f f' = if f=f'  then durchsichtig  else f'

let bildmap f (w,h,pixel) = w,h, Array.map (Array.map f) pixel

;;

let args = parse argspec "machxpm options file [file]"  in

let farben = match int args "-colours", int args "-chars"  with
| None, None -> anz_xpm_zeichen
| None, Some chars -> hoch anz_xpm_zeichen chars
| Some colours, None -> colours  in
let name1,name2 = match anon args  with
| [name] -> name,name
| name1::name2::_ -> name1,name2  in

let bild = match option args "format"  with
| Some "-ppm" -> lies_ppm name1
| Some "-rgba" -> lies_pam name1
| Some "-xpm" -> lies_xpm name1  in
let bild = match string args "-transcolour"  with
| None -> bild
| Some s -> let f = parsecol s  in bildmap (ersetz f) bild  in
let bild = match string args "-recolour"  with
| None -> bild
| Some s -> let f = parsecol s  in bildmap (mischspezial f) bild  in

match option args "method" with
| None -> gib_xpm_aus_exakt (rgb_grau 0.0) name2 bild
| Some "-average" -> gib_xpm_aus_runden (rgb_grau 0.0)
  (reduziere_farben1 (extrahiere_verteilung bild) farben)
  name2  bild
| Some "-maximal" -> gib_xpm_aus_runden (rgb_grau 0.0)
  (reduziere_farben2 (fst (extrahiere_farben bild)) farben)
  name2  bild

