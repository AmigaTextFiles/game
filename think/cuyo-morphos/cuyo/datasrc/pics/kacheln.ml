(*
   Copyright 2006 by Mark Weyer

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
open Vektorgraphik

open Male_mit_aa

let farbraum = [
  grau (1.0/.3.0);
  grau (2.0/.3.0);
  von_rgb (rgbrgb 1.0 0.0 0.0);
  von_rgb (rgbrgb 0.0 1.0 0.0);
  von_rgb (rgbrgb 0.0 0.0 1.0);
  von_rgb (rgbrgb 1.0 1.0 0.0);
  von_rgb (rgbrgb 1.0 0.0 1.0);
  ]

let strichdicke = 0.025

let male breite hoehe bild =
  male bild (1.0/.32.0) (monochrom durchsichtig breite hoehe)

let raus gric name bild = gib_xpm_aus (rgb_grau 1.0) name (berechne gric bild)

let kachel breite hoehe rand farbe =
  let x0,y0,x1,y1 = -1.0, -1.0,
    float_of_int (breite+1), float_of_int (hoehe+1)  in
  let p1,p2,p3,p4 = (x0,y0), (x1,y0), (x1,y1), (x0,y1)  in
  let rahmen = konvertiere_polygon [
    Strecke (p1,p2); Strecke (p2,p3); Strecke (p3,p4); Strecke (p4,p1)]  in
  male breite hoehe (erzeuge_vektorbild [
    Flaechen ([| List.nth farbraum farbe |], [rand, 0, None]);
    Dicker_Strich (schwarz, strichdicke, [rand]);
    Flaechen ([| durchsichtig |], [rand, 0, None; rahmen, 0, None])
  ])

let kacheln breite hoehe rand =
  let farben = List.length farbraum  in
  let rec bilder i = if i>=farben
    then []
    else (0, i*hoehe, kachel breite hoehe rand i)::(bilder (i+1))  in
  kombiniere_bildchen breite (farben*hoehe) (bilder 0)

let fall rand farbe =
  male 1 1 (erzeuge_vektorbild [
    Flaechen ([| List.nth farbraum farbe |], [rand,0, None]);
    Dicker_Strich (schwarz, strichdicke, [rand])
  ])

let faelle rand =
  let farben = List.length farbraum  in
  let rec bilder i = if i>=farben
    then []
    else (farben-i-1, 0, fall rand i)::(bilder (i+1))  in
  kombiniere_bildchen farben 1 (bilder 0)



let rundzug (h::t) =
  let p,z = List.fold_left
    (function p,bisher -> function p' -> p',(Strecke (p,p'))::bisher)
    (h,[])  t  in
  (Strecke (p,h))::z

let punktaus punkte i x y = let x',y' = punkte.(i)  in x+.x', y+.y'



let sechseck =
  let kantenlaenge_x = 2.0/.(3.0+.(sqrt 3.0))  in
  let halbkante = kantenlaenge_x/.2.0  in
  let kantenlaenge_y = 1.0/.(1.0+.(sqrt 3.0))  in
  let dreieckshoehe = kantenlaenge_y*.(sqrt 0.75)  in
  [|
  kantenlaenge_x, 0.0;
  halbkante, dreieckshoehe;
  -.halbkante, dreieckshoehe;
  -.kantenlaenge_x, 0.0;
  -.halbkante, -.dreieckshoehe;
  halbkante, -.dreieckshoehe;
  |]

let punkt = punktaus sechseck

let sechseck_rahmen =
  let sechseck links unten rechts x y =
    (rundzug [punkt 0 x y; punkt 1 x y; punkt 2 x y;
      punkt 3 x y; punkt 4 x y; punkt 5 x y]) @
    (if links
      then [
        Strecke (punkt 3 x y, punkt 1 (x-.1.0) (y-.0.5));
        Strecke (punkt 4 x y, punkt 0 (x-.1.0) (y-.0.5))]
      else []) @
    (if unten
      then [
        Strecke (punkt 4 x y, punkt 2 x (y-.1.0));
        Strecke (punkt 5 x y, punkt 1 x (y-.1.0))]
      else []) @
    (if rechts
      then [
        Strecke (punkt 5 x y, punkt 3 (x+.1.0) (y-.0.5));
        Strecke (punkt 0 x y, punkt 2 (x+.1.0) (y-.0.5))]
      else [])  in
  erzeuge_vektorbild [Dicker_Strich (schwarz,strichdicke,[konvertiere_polygon (
    (sechseck true  false false 1.5 2.0) @
    (sechseck false true  true  0.5 1.5) @
    (sechseck true  true  false 1.5 1.0) @
    (sechseck false false true  0.5 0.5) @
    (sechseck false false false 1.5 0.0))])]

let sechseck_kacheln =
  let rand = konvertiere_polygon (
    (rundzug [
      punkt 0 0.5 0.5; punkt 1 0.5 0.5; punkt 2 0.5 0.5;
      punkt 3 0.5 0.5; punkt 4 0.5 0.5; punkt 5 0.5 0.5]) @
    (rundzug [
      punkt 1 1.5 0.0; punkt 5 1.5 1.0; punkt 4 1.5 1.0; punkt 2 1.5 0.0]) @
    (rundzug [
      punkt 3 3.5 0.5; punkt 2 3.5 0.5; punkt 0 2.5 1.0; punkt 5 2.5 1.0;
      punkt 3 3.5 0.5; punkt 1 2.5 0.0; punkt 0 2.5 0.0; punkt 4 3.5 0.5]) @
    (rundzug [
      punkt 3 4.5 0.5; punkt 5 3.5 1.0; punkt 1 3.5 0.0]) @
    (rundzug [
      punkt 0 4.5 0.5; punkt 2 5.5 0.0; punkt 4 5.5 1.0]))  in
  kacheln 6 1 rand



let viereck =
  let halbkante = 1.0 /. (1.0+.(sqrt 3.0))  in
  [|
  halbkante, 0.0;
  1.0, halbkante;
  1.0-.halbkante, 1.0;
  0.0, 1.0-.halbkante;
  |]

let punkt = punktaus viereck

let ein_viereck x y umgekehrt = if umgekehrt
  then rundzug [punkt 0 x (y+.1.0); punkt 1 (x-.1.0) y;
    punkt 2 x (y-.1.0); punkt 3 (x+.1.0) y]
  else rundzug [punkt 0 x y; punkt 1 x y; punkt 2 x y; punkt 3 x y]

let zwei_vierecke x y = (ein_viereck x y false) @ (ein_viereck x (1.0-.y) true)

let viereck_rahmen =
  erzeuge_vektorbild [Dicker_Strich (schwarz,strichdicke,[konvertiere_polygon (
    (zwei_vierecke (-1.0) 0.0) @ (zwei_vierecke 0.0 (-1.0)) @
    (zwei_vierecke 1.0 0.0) @ (zwei_vierecke 2.0 1.0) @
    (zwei_vierecke 3.0 2.0) @ (zwei_vierecke 4.0 1.0) @
    [
      Strecke (punkt 2 (-1.0) 0.0, punkt 0 0.0 1.0);
      Strecke (punkt 3 1.0 0.0, punkt 1 0.0 1.0);
      Strecke (punkt 2 1.0 0.0, punkt 0 2.0 1.0);
      Strecke (punkt 3 3.0 0.0, punkt 1 2.0 1.0);
      Strecke (punkt 2 3.0 0.0, punkt 0 4.0 1.0);
    ])])]

let viereck_kacheln =
  let rand = konvertiere_polygon (
    (rundzug [
      punkt 0 2.0 0.0; punkt 1 2.0 0.0; punkt 2 2.0 0.0; punkt 3 3.0 1.0;
      punkt 0 2.0 2.0; punkt 1 1.0 1.0; punkt 2 2.0 0.0; punkt 3 2.0 0.0]) @
    (rundzug [punkt 0 1.0 1.0; punkt 1 0.0 0.0; punkt 2 0.0 0.0]) @
    (rundzug [punkt 0 1.0 1.0; punkt 3 1.0 1.0; punkt 2 0.0 0.0]) @
    (rundzug [punkt 1 3.0 1.0; punkt 2 4.0 0.0; punkt 3 4.0 0.0]) @
    (rundzug [punkt 1 3.0 1.0; punkt 0 3.0 1.0; punkt 3 4.0 0.0]))  in
  kacheln 5 2 rand

let viereck_fall =
  let rand = konvertiere_polygon
    (rundzug [0.1,0.5; 0.5,0.1; 0.9,0.5; 0.5,0.9])  in
  faelle rand



let abschnitt = ((sqrt 7.0)-.1.0)/.6.0

let fuenfeck x y r =
  let drehung = List.nth
    [(function x,y -> x,y); (function x,y -> 1.0-.y,x);
      (function x,y -> 1.0-.x,1.0-.y); (function x,y -> y,1.0-.x)]
    r  in
  let richtung x' y' = let x'',y'' = drehung (x',y')  in x+.x'',y+.y''  in
  rundzug [richtung abschnitt abschnitt;
    richtung 1.0 0.0; richtung (1.0+.abschnitt) (1.0-.abschnitt);
    richtung (1.0-.abschnitt) (1.0+.abschnitt); richtung 0.0 1.0]

let fuenfeck_rahmen =
  erzeuge_vektorbild [Dicker_Strich (schwarz,strichdicke,[konvertiere_polygon (
    (fuenfeck 0.0 1.0 0) @ (fuenfeck 1.0 2.0 2) @ (fuenfeck 0.0 2.0 1)
      @ (fuenfeck 0.0 (-1.0) 3) @ (fuenfeck 1.0 (-1.0) 0) @
    (fuenfeck 4.0 0.0 1) @ (fuenfeck 3.0 1.0 3) @ (fuenfeck 3.0 0.0 2)
      @ (fuenfeck 6.0 0.0 0) @ (fuenfeck 6.0 1.0 1) @
    (fuenfeck 5.0 4.0 2) @ (fuenfeck 4.0 3.0 0) @ (fuenfeck 5.0 3.0 3)
      @ (fuenfeck 5.0 6.0 1) @ (fuenfeck 4.0 6.0 2) @
    (fuenfeck 1.0 5.0 3) @ (fuenfeck 2.0 4.0 1) @ (fuenfeck 2.0 5.0 0)
      @ (fuenfeck (-1.0) 5.0 2) @ (fuenfeck (-1.0) 4.0 3)
    )])]

let fuenfeck_kacheln =
  let rand = konvertiere_polygon (
    (fuenfeck 0.0 0.0 0) @ (fuenfeck 2.0 1.0 2) @
    (fuenfeck 3.0 1.0 3) @ (fuenfeck 5.0 0.0 1))  in
  kacheln 6 2 rand

let fuenfeck_fall =
  let rad = 0.4  in
  let d = rad*.abschnitt  in
  let rand = konvertiere_polygon
    (rundzug [0.5-.2.0*.d, 0.5-.rad+.d;  0.5+.2.0*.d, 0.5-.rad+.d;
      0.5+.rad, 0.5+.d;  0.5, 0.5+.rad-.d;  0.5-.rad, 0.5+.d])  in
  faelle rand



let rhombus_rahmen =
  erzeuge_vektorbild [Dicker_Strich (schwarz,strichdicke,[konvertiere_polygon (
    (rundzug [1.0,-0.5; 4.0,1.0; 2.0,2.0; 4.0,3.0;
      1.0,4.5; -2.0,3.0; 0.0,2.0; -2.0,1.0]) @
    [Strecke ((1.0,0.5),(1.0,3.5));
      Strecke ((0.0,1.0),(1.0,1.5)); Strecke ((2.0,1.0),(1.0,1.5));
      Strecke ((0.0,3.0),(1.0,2.5)); Strecke ((2.0,3.0),(1.0,2.5))])])]

let rhombus_kacheln =
  let rad = 2.0*.strichdicke  in
  let rand = konvertiere_polygon (
    (rundzug [0.0,2.5; 1.0,2.0; 2.0,2.5; 1.0,3.0]) @
    (rundzug [0.0,1.0; 1.0,0.5; 1.0,1.5; 0.0,2.0]) @
    (rundzug [2.0,0.5; 1.0,0.0; 1.0,1.0; 2.0,1.5]) (*@
    [Kreis ((4.0/.3.0,2.5),rad);
      Kreis ((1.0/.3.0,1.5),rad);
      Kreis ((4.0/.3.0,0.5),rad)]*) )  in
  kacheln 2 3 rand


;;

let gric = int_of_string Sys.argv.(1)  in

raus gric "mkaSechseckRahmen" (male 2 2 sechseck_rahmen);
raus gric "mkaSechseckKacheln" sechseck_kacheln;

raus gric "mkaViereckRahmen" (male 4 2 viereck_rahmen);
raus gric "mkaViereckKacheln" viereck_kacheln;
raus gric "mkaViereckFall" viereck_fall;

raus gric "mkaFuenfeckRahmen" (male 6 6 fuenfeck_rahmen);
raus gric "mkaFuenfeckKacheln" fuenfeck_kacheln;
raus gric "mkaFuenfeckFall" fuenfeck_fall;

raus gric "mkaRhombusRahmen" (male 2 4 rhombus_rahmen);
raus gric "mkaRhombusKacheln" rhombus_kacheln;

