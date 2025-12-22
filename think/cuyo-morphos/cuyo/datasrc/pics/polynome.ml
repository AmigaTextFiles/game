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

let pi = 4.0*.(atan 1.0)
let drittel = 1.0/.3.0
let zweidrittelpi = pi*.2.0*.drittel

exception Nullpolynom

let loese_0 a = if a=0.0  then raise Nullpolynom  else []

let loese_1 a b = if a=0.0  then loese_0 b  else [-.b/.a]

let loese_2_normiert a b =
  let a' = a*.0.5  in
  let diskriminante = a'*.a'-.b  in
  if diskriminante<0.0
    then []
    else
      let wurzel = sqrt diskriminante  in
      [wurzel-.a'; -.wurzel-.a']

let loese_2 a b c = if a=0.0
  then loese_1 b c
  else loese_2_normiert (b/.a) (c/.a)

let loese_3 a b c d = if a=0.0
  then loese_2 b c d
  else
    let e,f,g = b/.(a*.3.0), c/.a, d/.a  in
      (* Jetzt: x^3 + 3ex^2 + fx + g = 0
         Substitution: x=y-e
                       x reell <=> y reell *)
    let h,i = f*.drittel-.e*.e, g*.0.5-.(f*.0.5-.e*.e)*.e  in
      (* Jetzt: y^3 + 3hy + 2i = 0 *)
    if i=0.0
      then
        if h>0.0
          then [-.e]
          else
            let y1=sqrt (h*.(-3.0))  in
            [-.e; y1-.e; -.y1-.e]
      else
        (* Substitution: y=z-h/z
                         y reell <=> z reell oder |z|^2 = -h
                                                  (und dann y=2*Re(z)) *)
        let j = -.h*.h*.h  in
          (* Jetzt: z^3 + 2i + j/z^3 = 0
             Substituiere: z=t^1/3
                           eins von drei z reell <=> t reell
                           |z|^2 = -h <=> |t|^2 = j
             Dann: t^2 + 2it + j = 0 *)
        let i2 = i*.i  in
        if i2<=j
          then (* Für t gibt es keine reelle Lösung (außer im Spezialfall
                  i^2=j). Dafür gibt es drei reelle Lösungen für y,
                  (also natürlich alle über die "|t|^2=j"-Schiene). *)
            let alpha = (atan2 (sqrt (j-.i2)) (-.i))*.drittel  in
              (* t=(j^1/2, 3*alpha) in Polardarstellung *)
            let k=2.0*.(sqrt (-.h))  in    (* k=2*|z| *)
            [k*.(cos alpha)-.e; k*.(cos (alpha+.zweidrittelpi))-.e;
              k*.(cos (alpha-.zweidrittelpi))-.e]
          else (* Jetzt ist |t|^2=j unmöglich. Also wird nur das reelle z
                  weiterverfolgt. *)
            let t = (sqrt (i2-.j))-.i  in
            let z = if t<0.0
              then -.((-.t) ** drittel)
              else t ** drittel  in
            [z-.h/.z-.e]

let loese_4 a b c d e = if a=0.0
  then loese_3 b c d e
  else
    let f,g,h,i = b/.(a*.4.0),c/.a,d/.a,e/.a  in
      (* Jetzt: x^4 + 4fx^3 + gx^2 + hx + i = 0
         Substitution: x=y-f *)
    let j,k,l = -6.0*.f*.f+.g, (8.0*.f*.f-.2.0*.g)*.f+.h,
      ((-3.0*.f*.f+.g)*.f-.h)*.f+.i  in
      (* Jetzt: y^4 + jy^2 + ky + l = 0 *)
    if k=0.0
      then (* Substitution y=z^1/2, also dann z^2 + jz + l = 0 *)
        let ze = loese_2_normiert j l  in
        List.concat (List.map
          (function z -> if z>=0.0
            then let y=sqrt z  in [y-.f;-.y-.f]
            else [])
          ze)
      else if l=0.0
        then (-.f)::(List.map (function y -> y-.f)
          (loese_3 1.0 0.0 j k))
        else
          (* Ziel: Faktorisierung in zwei quadratische Polynome.
             Das wären dann (y^2 + my + l/n) und (y^2 - my + n).
             Da nichtreelle Nullstellen paarweise konjugiert auftreten,
             ist das auf jeden Fall mit rellem m und n machbar.
             Wir erhalten das System:
               j = n-m^2+l/n  und  k = mn-ml/n
             m=0 ist ausgeschlossen, da sonst k=0, also unter
             Äquivalenzumformungen:
               m^2+j = n+l/n  und  k/m = n-l/n
               m^2+j+k/m = 2n und  m^2+j-k/m = 2l/n
               4l = m^4 + 2jm^2 + j^2 - k^2/m^2  und  n = (m^2+j+k/m)/2 *)
          let m2 = List.find (function m2 -> m2>0.0)
            (loese_3 1.0 (2.0*.j) (j*.j-.4.0*.l) (-.k*.k))  in
          let m = sqrt m2  in
          let n = (m2+.j+.k/.m)/.2.0  in
          (loese_2_normiert m (l/.n)) @ (loese_2_normiert (-.m) n)


