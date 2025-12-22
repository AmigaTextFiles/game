#!/usr/bin/perl -w
#Renders a bezier curve, and draws its control points (OR WHATEVER
# THE POINTS ARE CALLED) a0,a1,a2 (,and a3??)
# for: f(t)== a3 t^3 + a2 t^2 + a1 t + a0
# (aN is 2d coord here. Question is, is it still meaningful without the
#  a3t3 term?)

# evidentally, a2,a1,a0 are NOT the "control points" of such a curve.
# I'm going to suppose they're variables that aren't visible on the line
# (except a0, which is at the end t=0), that have to be *derived* from
# the control points.
# Lets say the control points are c0,c1,c2. c0 is at t==0,so c0==a0.
# Then lets say c1 is at t==0.5, and c2 is at t==1.
#  At t==0.5, t^2==0.25. At t==1, t^2==1.
# So, c1== (a2*0.25)+(a1*0.5)+a0;
#     c2== a2+a1+a0.

# So, c2+2a1-a1=4c1+c0-4c0
#     a1=-c2+4c1-3c0
# Whilst
#     c2-a2-c0=c1-0.5a2-2c0
#     2c2-2a2-2c0=4c1-a2-4c0
#     a2=2c2-4c1+2c0

use GD;

$c0x=rand(80)+10; $c0y=rand(80)+10;
$c1x=rand(80)+10; $c1y=rand(80)+10;
$c2x=rand(80)+10; $c2y=rand(80)+10;
#$a3x=rand(80)+10; $a3y=rand(80)+10;
$a0x=$c0x;$a0y=$c0y;
$a1x= (-$c2x)+(4*$c1x)-(3*$c0x); $a1y= (-$c2y)+(4*$c1y)-(3*$c0y);
$a2x=(2*$c2x)-(4*$c1x)+(2*$c0x); $a2y=(2*$c2y)-(4*$c1y)+(2*$c0y);
#Now, our graph
newGraph();
foreach(0..15) {
   $t1=$_/16;
   $t2=($_+1)/16;
#   print "$t1 -> $t2\n";

   $x1=  ($a2x*($t1**2)) + ($a1x*$t1) + $a0x;
   $x2=  ($a2x*($t2**2)) + ($a1x*$t2) + $a0x;
   $y1=  ($a2y*($t1**2)) + ($a1y*$t1) + $a0y;
   $y2=  ($a2y*($t2**2)) + ($a1y*$t2) + $a0y;
   $graph->line($x1,$y1, $x2,$y2,$black);
}
$graph->arc($c0x,$c0y,6,6,0,360,$blue);
$graph->arc($c1x,$c1y,6,6,0,360,$blue);
$graph->arc($c2x,$c2y,6,6,0,360,$blue);
#$graph->arc($a3x,$a3y,6,6,0,360,$blue);
closeGraph();

# STUFF FROM ICBLcypher graphing code
#Now concatenate into one big PNG block
#system("wbmptopbm a.wbmp >block.pbm");#initialise
#foreach (map(chr,98..122)) {
#   system("wbmptopbm $_.wbmp >tmp.pbm");
#   system("pnmcat -lr block.pbm tmp.pbm >t2.pbm");
#   rename "t2.pbm", "block.pbm";
#   unlink "tmp.pbm";
#}
#system("pnmtopng block.pbm >block.png");
#unlink "block.pbm";
exit 0;

sub newGraph {
  $graph=new GD::Image(100, 100);
  $white=$graph->colorAllocate(255,255,255);
  $black=$graph->colorAllocate(0,0,0);
  $blue=$graph->colorAllocate(32,32,255);
  #do we have to clear it?
#  $graph->line(40,0,40,339,$black); From ICBLcypher graphing code
#  $graph->line(59,0,59,339,$black);
}

sub closeGraph {
  open IMGFILE, ">bezier.png" or die "Couldnt open file for output";
  binmode IMGFILE;
  print IMGFILE $graph->png();
  close IMGFILE;
  #don't actually close the image?
}

#END--
