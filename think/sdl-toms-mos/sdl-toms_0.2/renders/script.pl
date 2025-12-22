#!/usr/bin/perl -w
for ($p=1;$p<=4;$p++) {
  # groups of 0 atoms are done by plain blanks!
  #      void alias player_colour player2
  open PRAD,">player.rad";
  printf PRAD ("void alias player_colour player%d\n",$p);
  close PRAD;
  for($a=1;$a<8;$a++) {
    $scene="scene$a.rad";
    $cmd=sprintf("oconv mats.rad player.rad light.rad %s >scene.oct",$scene);
    system($cmd);
    system("rpict -av 0.25 0.25 0.25 scene.oct >scene.pic");
    $ofile=sprintf("atom_p%d_n%d.png",$p,$a);
    system("pfilt -1 -x 38 -y 38 scene.pic |ra_ppm -g 1 > scene.ppm");
    system("pnmtopng -gamma 1 scene.ppm >$ofile");
#    sleep(1);
  }
}
