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

type punkt = float * float

type bildchen = int * int * (punkt -> farbe)
  (* Die ints sind Breite und Höhe in Elementarquadraten *)

val monochrom: farbe -> int -> int -> bildchen
val spiegel_x: bildchen -> bildchen
val kombiniere_bildchen: int -> int -> (int * int * bildchen) list -> bildchen
  (* Breite, Höhe, zu kombinierende Bildchen mit Positionen *)
val ueberlagerung: bildchen -> bildchen -> bildchen option -> bildchen
  (* ueberlagerung unten oben maske
     malt oben über unten.
     Dabei wird die Transparenz von oben aus dem durchsichtig-Kanal von
     maske genommen. Ist maske None, so stattdessen aus dem von oben.
     Breite und Höhe des Ergebnisses sind die von unten. *)



type pixelbild = int * int * farbe array array
  (* Die kleinen array sind Zeilen.
     Ein pixelbild hat den Ursprung links oben, ein bildchen links unten! *)

val berechne: int -> bildchen -> pixelbild
  (* Der int ist die Anzahl an Pixeln pro Elementarquadrat. *)

val extrahiere_farben: pixelbild -> palette * farbkarte
val extrahiere_verteilung : pixelbild -> farbverteilung



val anz_xpm_zeichen : int

val gib_xpm_aus_exakt: rgb_farbe -> string -> pixelbild -> unit
val gib_xpm_aus_runden: rgb_farbe -> palette -> string -> pixelbild -> unit
val gib_xpm_aus: rgb_farbe -> string -> pixelbild -> unit
  (* Die rgb_farbe wird bei Mischfarben für durchsichtig und hintergrund
     benutzt.
     Der string ist der Dateiname ohne ".xpm".
     Die dritte Version ist die zweite mit Reduktion auf anz_xpm_zeichen
     Farben. *)

val lies_xpm: string -> pixelbild
val lies_ppm: string -> pixelbild
val lies_pam: string -> pixelbild (* nur RGB_ALPHA *)

