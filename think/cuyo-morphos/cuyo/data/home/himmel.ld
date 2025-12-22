
Himmel={
  name="Sky"
  name[de]="Himmel"
  author="Jela"
  numexplode=4
  numexplode[1]=6
  chaingrass=1
  pics=Blitz,Voegel,jhHelleWolken.xpm,jhDrachensteigen.xpm,jhBallons.xpm
  bgcolor=150,170,255
  topcolor=60,60,60
  toptime=50
  startpic=jhSonne.xpm
  startdist="KL........","FGH.......","ABCDIJIJDE"
  greypic=jhGraueWolke.xpm
  #(wenn man nur einzelne, nicht verbundene Wolken will.)
  #greypic=GraueWolken
  textcolor=0,0,50
  mirror=1
  toppic=jhLandschaft.xpm
  topoverlap=65
  topstop=65
  description="In which direction do balloons fall?"
  description[de]="In welche Richtung fallen Luftballons?"

  <<
  var fluegel=0;
  global={
    fluegel+=1;
    fluegel%=8
  };
  >>

  Blitz={
    pics=jhBlitz.xpm,jhBlitz_anim.xpm
    <<
    var leucht;
    Blitz={
      switch {
        1:100 && kind@(0,-1)!=Blitz || leucht@(0,-1) => leucht=1,leucht=0;
      };
      switch {
        leucht => 1,1,0,0,0,0,0,0,1;
      };
      schema16
    };
    >>
  }
  
  Voegel={
    pics=jhVoegel.xpm,jhVoegel_ani1.xpm,jhVoegel_ani2.xpm,
         jhVoegel_ani3.xpm,jhVoegel_ani4.xpm,jhVoegel_ani5.xpm,
         jhVoegel_ani6.xpm,jhVoegel_ani7.xpm
    <<
    Voegel={
      file=fluegel@;
      schema16
    };
    >>
  }
  #GraueWolken={
  #pics=jhGraueWolken.xpm
  #schema=0
  #}
}

