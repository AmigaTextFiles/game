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
# NOW THIS ONE
#  does a curve that fits the control points as expressed in polar coords!

use GD;

$pi=3.1415926;

$c0x=rand(80)+10; $c0y=rand(80)+10;
$c1x=rand(80)+10; $c1y=rand(80)+10;
$c2x=rand(80)+10; $c2y=rand(80)+10;
#$a3x=rand(80)+10; $a3y=rand(80)+10;
$centx=50;$centy=50; # IF the same as any other points, change!
$cp0r=radius($c0x-$centx,$c0y-$centy);
$cp1r=radius($c1x-$centx,$c1y-$centy);
$cp2r=radius($c2x-$centx,$c2y-$centy);

$cp0b=bearing($c0x-$centx,$c0y-$centy);
$cp1b=bearing($c1x-$centx,$c1y-$centy);
$cp2b=bearing($c2x-$centx,$c2y-$centy);

$cp0b+=($cp0b<0)?720:360;
$cp1b+=($cp1b<0)?720:360;
$cp2b+=($cp2b<0)?720:360;

#Don't allow either arc (0-1 or 1-2) to be greater than 225 degrees.
if($cp1b-$cp0b>225) {
    $cp0b+=360;
}
if($cp0b-$cp1b>225) {
    $cp0b-=360;
}
if($cp2b-$cp1b>225) {
    $cp2b-=360;
}
if($cp1b-$cp2b>225) {
    $cp2b+=360;
}


$a0r=$cp0r;$a0b=$cp0b;
$a1r= (-$cp2r)+(4*$cp1r)-(3*$cp0r); $a1b= (-$cp2b)+(4*$cp1b)-(3*$cp0b);
$a2r=(2*$cp2r)-(4*$cp1r)+(2*$cp0r); $a2b=(2*$cp2b)-(4*$cp1b)+(2*$cp0b);
#Now, our graph
newGraph();
#draw the control points FIRST!
$graph->arc($c0x,$c0y,6,6,0,360,$red);
$graph->arc($c1x,$c1y,6,6,0,360,$red);
$graph->arc($c2x,$c2y,6,6,0,360,$red);
foreach(0..31) {
   $t1=$_/32;
   $t2=($_+1)/32;
#   print "$t1 -> $t2\n";

   $r1=  ($a2r*($t1**2)) + ($a1r*$t1) + $a0r;
   $r2=  ($a2r*($t2**2)) + ($a1r*$t2) + $a0r;
   $b1=  ($a2b*($t1**2)) + ($a1b*$t1) + $a0b;
   $b2=  ($a2b*($t2**2)) + ($a1b*$t2) + $a0b;
   $x1=$centx+($r1*sin($b1*$pi/180));
   $x2=$centx+($r2*sin($b2*$pi/180));
   $y1=$centy+($r1*cos($b1*$pi/180));
   $y2=$centy+($r2*cos($b2*$pi/180));
   $graph->line($x1,$y1, $x2,$y2,$black);
}
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
  $red=$graph->colorAllocate(255,32,64);
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

sub radius {
  my ($x,$y)=@_;
  sqrt(($x**2)+($y**2));
}

sub bearing {
  my ($x,$y)=@_;
  #assume +ve y is upwards. Even though it isn't here. And 0 is north.
  #hmm... no sign function? Teh suck.

  #normally this would be wrong, but it's the way I want it!!!
  return (180/$pi)*atan2($x,$y);
#  if($x==0) {
#     if($y<0) return 180;
#     return 0; #that goes for y==0 too, though that ought to be n/a
#  }
#  if($y==0) {
#     if($x<0) return 270;
#     return 90;
#  }
#  if($y>0) {
#     if($x>0) return atn;...
#  }
}

#END--
