(*
   Copyright 2007 by Mark Weyer

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


open Make


(*===========================================================================*)

let gric = 32  (* Not everything respects gric changes *)

let ml_graphik = ["pam";"natmod";"vektor";"farbe";"xpmlex";"graphik"]
let ml_vektorgraphik = ml_graphik @ ["polynome"; "vektorgraphik"]



let colour colour none some = match colour  with
  | None -> none
  | Some (r,g,b) -> some^" "^
      (string_of_int r)^"/"^(string_of_int g)^"/"^(string_of_int b)^" "


let rec num_anim digits a b = if a>b
  then []
  else
    let s = string_of_int a  in
    let missing = digits-(String.length s)  in
    ((String.make (max 0 missing) '0')^s)::(num_anim digits (a+1) b)

let fill_anim left stages right = List.map
  (fun stage -> left^stage^right)
  stages



let group file files = [[file],files,groupaction]

let xgz file = [[file^".xpm.gz"], [file^".xpm"],
  ["gzip -c -f -n "^file^".xpm > "^file^".xpm.gz"]]

let xzgroup file files = List.concat [
  group file (fill_anim "" files ".xpm.gz");
  List.concat (List.map xgz files);
  ]

let xpm_of_rgba ?(quant_colours=None) ?(quant_method="maximal") file = [
  [file^".xpm"],
  [file^".pam"; "machxpm.opt"],
  ["./machxpm.opt -rgba "^
    (match quant_colours  with
    | None -> ""
    | Some n -> "-colours "^(string_of_int n))^
    " -"^quant_method^
    " "^file]]

let pam_of_ppmpgm file = [
  [file^".pam"],
  [file^".ppm"; file^".umriss.pgm"],
  ["pamarith -multiply "^file^".ppm "^file^".umriss.pgm "^
      "| pamstack - "^file^".umriss.pgm > "^file^".pam"]]

let pgm_of_ppm file = [
  [file^".pgm"],
  [file^".ppm"],
  ["ppmtopgm "^file^".ppm | pamfunc -multiplier 255 > "^file^".pgm"]]

let xpm_of_ppm2 quant_colours quant_method file =
  List.concat [
    pgm_of_ppm (file^".umriss");
    pam_of_ppmpgm file;
    xpm_of_rgba ~quant_colours:quant_colours ~quant_method:quant_method file;
  ]

let pov_umriss file = [
  [file^".umriss.pov"],
  [file^".pov"],
  ["echo \"#declare Nur_Umriss=1;\" | "^
      "cat - "^file^".pov > "^file^".umriss.pov"]]

let ppm_of_pov width height aa extra file includes =
  let w,h = width*gric, height*gric  in
  let ws,hs = string_of_int w, string_of_int h  in
  [
    (* The antialiasing argument aa is:
         None for no antialiasing
         Some true for antialising which respects pixel boundaries
         Some false for antialising which does not respect pixel boundaries *)
  [file^".ppm"],
  [file^".pov"]@includes,
  ["povray +FP -D -w"^ws^" -h"^hs^
      (match aa with
      |	None -> ""
      |	Some true -> " +A +AM1 -J"
      |	Some false -> " +A +AM2 +R2 -J")^
      " "^extra^
      " "^file^".pov";
    "test -e "^file^".ppm && test `wc -c < "^file^".ppm` -eq "^
        (* Test whether povray did well.
           (Exit code 0 from povray does not really mean much.) *)
      (string_of_int (w*h*3+(String.length ws)+(String.length hs)+9));
  ]]

let xpm_of_pov_trans width height ?(aa=Some false) ?(extra="")
    ?(quant_colours=None) ?(quant_method="maximal") file includes =
  let includes = "cuyopov.inc"::includes  in
  List.concat [
    ppm_of_pov width height aa extra file includes;
    pov_umriss file;
    ppm_of_pov width height aa extra (file^".umriss") includes;
    xpm_of_ppm2 quant_colours quant_method file;
  ]

let xpm_of_ppm trans_colour quant_colours quant_method file = [
  [file^".xpm"],
  [file^".ppm"; "machxpm.opt"],
  ["./machxpm.opt -ppm "^
    (colour trans_colour "" "-transcolour")^
    (match quant_colours  with
    | None -> ""
    | Some n -> "-colours "^(string_of_int n))^
    " -"^quant_method^
    " "^file]]

let xpm_of_pov width height ?(aa=Some false) ?(extra="") ?(trans_colour=None)
    ?(quant_colours=None) ?(quant_method="maximal") file includes =
  List.concat [
    ppm_of_pov width height aa extra file includes;
    xpm_of_ppm trans_colour quant_colours quant_method file;
  ]

let stuff_of_prog files prog options = [
  files,
  [prog],
  ["./"^prog^" "^options]]

let ml_prog file includes =
  let endings ending = List.map (fun include_ -> include_^ending) includes  in
  [
    [file^".opt"; file^".cmx"; file^".cmi"; file^".o"],
    (file^".ml")::(endings ".cmi")@(endings ".cmx"),
    ["ocamlopt.opt -o "^file^".opt"^
      (List.fold_left (fun l -> fun r -> l^" "^r^".cmx") "" includes)^
      " "^file^".ml"]]

let stuff_of_ml targets prog ?(options="") includes = List.concat [
    stuff_of_prog targets (prog^".opt") options;
    ml_prog prog includes;
  ]

let group_of_ml name targets includes = List.concat [
    xzgroup name targets;
    stuff_of_ml (fill_anim "" targets ".xpm") name
      ~options:(string_of_int gric) includes;
  ]

let ml_module file includes =
  let endings ending = List.map (fun include_ -> include_^ending) includes  in
  [
    [file^".cmi"],
      (file^".mli")::(endings ".cmi"),
      ["ocamlopt.opt "^file^".mli"];
    [file^".cmx"; file^".o"],
      (file^".ml")::(file^".cmi")::(endings ".cmi")@(endings ".cmx"),
      ["ocamlopt.opt -c "^file^".ml"];
  ]

let recolour source drain colour' = [
  [drain^".xpm"],
  [source^".xpm"; "machxpm.opt"],
  ["./machxpm.opt -xpm -recolour "^(colour colour' "trans " "")^
    " "^source^" "^drain]]

let pov_fill2 source drain povvar value stage = [
  [drain^stage^".pov"],
  [source^".pov"],
  ["echo \"#declare "^povvar^"="^value^";\" "^
    "| cat - "^source^".pov > "^drain^stage^".pov"]]

let pov_fill file povvar stage = pov_fill2 file file povvar stage stage

let xpm_of_pov_fill_trans width height ?(aa=Some false) ?(extra="")
    ?(quant_colours=None) ?(quant_method="maximal") file includes
    povvar stages = List.concat (List.map
  (fun stage -> List.concat [
    xpm_of_pov_trans width height ~aa:aa ~extra:extra
      ~quant_colours:quant_colours ~quant_method:quant_method
      (file^stage) includes;
    pov_fill file povvar stage])
  stages)

(*===========================================================================*)

let rules = List.concat [

    group "all"
      ["aehnlich"; "aux"; "breakout"; "bunt"; "dungeon"; "fische"; "kacheln";
        "kolben"; "puzzle"; "reversi"; "reversi_brl";
        "rohrpost"; "rollenspiel"; "slime"; "tennis"; "zahn"; "ziehlen"];


    xzgroup "aehnlich" ["maeSorten"; "maeSchema"];
    xpm_of_pov_trans 4 4 "maeSchema" ["aehnlich.inc"];
    xpm_of_pov_trans 7 14 ~quant_colours:(Some 400)
      "maeSorten" ["aehnlich.inc"];


    xzgroup "aux" ["font-big"; "highlight"; "feenstaub"];
    xpm_of_rgba "font-big";
    [["font-big.pam"],
      ["font-orig.png";"genSchrift"],
      ["./genSchrift -font font-orig.png font-big.pam"]];
    [["genSchrift"],
      ["genSchrift.cc"],
      ["g++ -g genSchrift.cc -L../lib -lSDL -lSDL_image -lm"^
          " -I../include -I/usr/include/SDL -O2 -o genSchrift"]];
    xpm_of_pov 3 3 ~trans_colour:(Some (30,30,70)) "highlight" [];
    stuff_of_ml ["feenstaub.xpm"] "feenstaub" ml_graphik;


    xzgroup "breakout" ["mbrBall2"; "mbrBall4"; "mbrSchlaeger"; "mbrStein"];
    xpm_of_pov_trans 4 4 "mbrBall2" ["breakout.inc"];
    xpm_of_pov_trans 8 8 "mbrBall4" ["breakout.inc"];
    xpm_of_pov_trans 4 3 "mbrSchlaeger" ["breakout.inc"];
    xpm_of_pov_trans 4 1 "mbrStein" ["breakout.inc"];
    pov_fill "mbrBall" "Anzahl" "2";
    pov_fill "mbrBall" "Anzahl" "4";


    (* bunt *)
    (let schmelz = num_anim 1 1 4  in
    List.concat [
      xzgroup "bunt" (["mbUnbunt";"mbBunt"]@
        (fill_anim "mbSchmelz" schmelz ""));
      xpm_of_pov_trans 17 1 ~quant_colours:(Some 512) "mbUnbunt" ["bunt.inc"];
      xpm_of_pov_trans 17 8 ~quant_colours:(Some 512) "mbBunt" ["bunt.inc"];
      xpm_of_pov_fill_trans 16 32 ~quant_colours:(Some 512)
        "mbSchmelz" ["bunt.inc"] "Schritt" schmelz;
    ]);


    (* dungeon

       Damit niemand denkt, das Ausschalten von antialiasing (~aa:None)
       sei aus Angst vor der Rechenzeit geschehen: Es ist völlig normal,
       daß sich die Graphiken überlappen, so daß antialiasing gegen
       irgendeine feste Farbe immer falsch ist.
    *)
    (let farben22 =
      ["Plastik"; "Gold"]  in
    let farben31 =
      ["Ziegel"; "Holz"; "Eisen"; "Stein"; "Fels"]  in
    let farben = farben22@farben31  in
    let boden = num_anim 2 0 15  in
    let render = num_anim 2 0 11  in
    let render4 = num_anim 2 0 3  in
    let render3 = num_anim 2 4 8  in
    let render2 = num_anim 2 9 11  in
    let includes =
      ["dungeon_boden.inc"; "dungeon.inc"; "mdGold.inc"; "cuyo.ppm"]  in
      (* Eigentlich werden mdGold.inc und cuyo.ppm nur für den
         Gold-Zweig gebraucht, aber wir machen es uns mal einfach. *)
    List.concat [
      group "dungeon" (fill_anim "dungeon" ("Boden"::farben) "");
      xzgroup "dungeonBoden" (fill_anim "mdBoden" boden "");
      List.concat (List.map
        (fun farbe ->
          xpm_of_pov 3 1 ~aa:(Some true) ("md"^farbe) includes)
        farben31);
      List.concat (List.map
        (fun farbe ->
          xpm_of_pov_trans 2 2 ~aa:(Some true) ("md"^farbe) includes)
        farben22);
      xpm_of_pov_fill_trans 4 2 ~extra:"-UV" "mdBoden" includes
        "BodenVersion" boden;
      List.concat (List.map
        (fun farbe -> List.concat [
          xzgroup ("dungeon"^farbe) (fill_anim ("md"^farbe) (""::render) "");
          xpm_of_pov_fill_trans 4 4 ~aa:None ("md"^farbe) includes
            "Version" render4;
          xpm_of_pov_fill_trans 4 3 ~aa:None ~extra:"-UV" ("md"^farbe) includes
            "Version" render3;
          xpm_of_pov_fill_trans 4 2 ~aa:None ("md"^farbe) includes
            "Version" render2;
	])
        farben);
      ml_prog "mdGold" [];
      [["mdGold.inc"],
        ["mdGold.opt"],
        ["./mdGold.opt > mdGold.inc"]];
      [["cuyo.ppm"],
        ["cuyo.xpm"],
        ["xpmtoppm cuyo.xpm > cuyo.ppm"]];

      (* Um sich die Prägung auf den Goldmünzen anzusehen: *)
      xpm_of_pov 10 5 "mdGoldM" includes;
      pov_fill2 "mdGold" "mdGold" "Version" "-1" "M";
    ]);


    group_of_ml "fische" ["mffisch1"; "mffisch2"; "mffisch3"; "mffisch4";
        "mfmuschel"; "mfqualle"]
      ml_vektorgraphik;


    group_of_ml "kacheln" ["mkaSechseckRahmen"; "mkaSechseckKacheln";
        "mkaViereckRahmen"; "mkaViereckKacheln"; "mkaViereckFall";
        "mkaFuenfeckRahmen"; "mkaFuenfeckKacheln"; "mkaFuenfeckFall";
        "mkaRhombusRahmen"; "mkaRhombusKacheln"]
      ml_vektorgraphik;


    xzgroup "kolben" ["mkKolben"; "mkKolbenBlitzBlau";
      "mkKolbenBlitzGruen"; "mkKolbenBlitzRot"];
    recolour "mkKolben.src" "mkKolben" None;
    recolour "mkKolben.src" "mkKolbenBlitzBlau" (Some (0,0,255));
    recolour "mkKolben.src" "mkKolbenBlitzGruen" (Some (0,255,0));
    recolour "mkKolben.src" "mkKolbenBlitzRot" (Some (255,0,0));


    group_of_ml "puzzle" ["mpAlle"] ml_vektorgraphik;


    xzgroup "reversi" ["mrAlle"; "mrTrenn"];
    xpm_of_pov_trans 5 4 "mrAlle" ["reversi.inc"];
    xpm_of_pov_trans ~aa:(Some true) 4 3
      "mrTrenn" ["reversi.inc"; "fall_dreh.inc"];


    xzgroup "reversi_brl" ["lreAlle"];
    xpm_of_pov 3 6 ~trans_colour:(Some (255,255,255)) "lreAlle" [];


    xzgroup "rohrpost" ["lpStart"; "lpWhite"; "lpYellow"; "lpPink"; "lpCyan"];
    xpm_of_pov 4 20 ~trans_colour:(Some (0,0,0)) "lpStart" ["rohrpost.inc"];
    xpm_of_pov 8 9 ~trans_colour:(Some (0,0,0)) "lpAlle" ["rohrpost.inc"];
    recolour "lpAlle" "lpWhite" (Some (255,255,255));
    recolour "lpAlle" "lpYellow" (Some (255,255,0));
    recolour "lpAlle" "lpPink" (Some (255,0,255));
    recolour "lpAlle" "lpCyan" (Some (0,255,255));


    group_of_ml "rollenspiel" ["mrpAlle"] ml_vektorgraphik;


    (* slime *)
    (let slime_anim = num_anim 1 0 5  in
    let slime_pics = "msGreen"::"msRed"::(fill_anim "msRed" slime_anim "")  in
    List.concat [
      xzgroup "slime" slime_pics;
      List.concat (List.map
        (fun file -> xpm_of_pov_trans 5 1 file [])
        slime_pics);
      pov_fill2 "slime2" "msGreen" "Case" "1" "";
      pov_fill2 "slime2" "msRed" "Case" "2" "";
      List.concat (List.map
        (fun stage -> pov_fill "msRed" "Time" stage)
        slime_anim);
    ]);


    (* tennis *)
    (let times = num_anim 1 0 8  in
    let colours = ["Yellow"; "Grey"; "Blue"; "Green"]  in
    let roofs = fill_anim "mtRoof" (num_anim 1 1 4) ""  in
    let moves = ["Left"; "Right"; "Bounce"; "In"; "Out"]  in
    let balls = List.concat (List.map (fill_anim "mt" colours) moves)  in
    let progtargets = roofs @ balls  in
    let ppmstuff = ["Wall"; "Roof"]  in
    let ppmpgmstuff = ["Ball"; "Source"]  in
    let extra = ["Source"; "Wall"; "Racket"]  in
    List.concat [
      xzgroup "tennis" (progtargets @ (fill_anim "mt" extra ""));
      ml_prog "tennis2" [];
      List.map
        (fun file ->
          ["mt"^file^".ppm"; "mt"^file^"Alpha.pgm"],
            ["mt"^file^".xpm"],
            ["xpmtoppm --alphaout=mt"^file^"Alpha.pgm mt"^file^".xpm > mt"^file^".ppm"])
        ("Racket_"::ppmpgmstuff);
      List.map
        (fun file ->
          ["mt"^file^".ppm"],
            ["mt"^file^".xpm"],
            ["xpmtoppm mt"^file^".xpm > mt"^file^".ppm"])
        ppmstuff;
      xpm_of_ppm None None "maximal" "mtRacket";
      [
      (fill_anim "" progtargets ".xpm"),
        ["mtBall.pgm"; "mtRoof.ppm"; "mtBlack32.ppm"; "mtBlack64.ppm"; "tennis2.opt"] @
          (fill_anim "mt" ppmpgmstuff ".ppm") @
          (fill_anim "mt" ppmpgmstuff "Alpha.pgm"),
        ["./tennis2.opt"];
      ["mtBall.pgm"],
        ["mtBall.ppm"],
        ["ppmtopgm mtBall.ppm > mtBall.pgm"];
      ["mtBlack32.ppm"], [],
        ["ppmmake rgbi:0/0/0 32 32 > mtBlack32.ppm"];
      ["mtBlack64.ppm"], [],
        ["ppmmake rgbi:0/0/0 64 64 > mtBlack64.ppm"];
      ["mtRacket.ppm"],
        ["mtRacket_.ppm"; "mtRacket_Alpha.pgm"; "mtWall.ppm"],
	["pnmcat -topbottom mtWall.ppm mtWall.ppm mtWall.ppm | pamcomp -alpha=mtRacket_Alpha.pgm mtRacket_.ppm - > mtRacket.ppm"];
      ];
    ]);




    xzgroup "zahn" ["mzZahn"; "mzZahnGras"; "mzZahnDreh"];
    xpm_of_pov_trans 3 9 "mzZahn" ["zahn.inc"];
    xpm_of_pov_trans 3 9 "mzZahnGras" ["zahn.inc"];
    xpm_of_pov_trans 4 8 "mzZahnDreh" ["zahn.inc"];
    pov_fill2 "mzZahn" "mzZahn" "Gras" "1" "Gras";


    xzgroup "ziehlen" ["mziAlle"];
    xpm_of_pov_trans 5 2 "mziAlle" [];


    ml_module "pam" [];
    ml_module "natmod" [];
    ml_module "vektor" ["natmod"];
    ml_module "farbe" ["natmod"; "vektor"];
    ml_module "xpmlex" ["farbe"];
    ml_module "graphik" ["pam"; "farbe"; "xpmlex"];
    ml_module "polynome" [];
    ml_module "vektorgraphik" ["farbe"; "graphik"; "polynome"];
    ml_module "valarg" [];
    [["xpmlex.ml"],
      ["xpmlex.mll"],
      ["ocamllex xpmlex.mll"]];
    ml_prog "machxpm" ("valarg"::ml_graphik);

  ]

(*===========================================================================*)

;;

main rules ();

