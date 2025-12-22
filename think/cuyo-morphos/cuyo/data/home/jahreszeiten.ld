
Jahreszeiten={
  name="The four Seasons"
  name[de]="Die vier Jahreszeiten"
  author="Jela"
  numexplode=4
  numexplode[1]=7
  chaingrass=1
  pics=jjWinter,jjFruehling,jjSommer,jjHerbst
  bgcolor=160,170,255
  topcolor=150,10,0
  toptime=50
  startpic="jjErde.xpm"
  startdist="..ABC.....","DFEEEDDFDF"
  greypic="jjGrau.xpm"
  textcolor=200,0,0
  description="Everything changes..."
  description[de]="Alles wandelt sich..."
  
  <<
  var zeit, zeit2, nex;
  global={
    zeit = (zeit + 1) % 128; # 32*4
    zeit2 = zeit / 32;
  };
  
  jahreszeit={
    file=zeit2@;
    schema16;
    switch {
      zeit@==127 -> kind=nex;
    }
  };
  >>
  
  jjWinter={
    pics=jjWinter1.xpm,jjWinter2.xpm,jjWinter3.xpm,jjWinter4.xpm
    << jjWinter={nex=jjFruehling; jahreszeit}; >>
  }
  jjFruehling={
    pics=jjFruehling1.xpm,jjFruehling2.xpm,jjFruehling3.xpm,jjFruehling4.xpm
    << jjFruehling={nex=jjSommer; jahreszeit}; >>
  }
  jjSommer={
    pics=jjSommer1.xpm,jjSommer2.xpm,jjSommer3.xpm,jjSommer4.xpm
    << jjSommer={nex=jjHerbst; jahreszeit}; >>
  }
  jjHerbst={
    pics=jjHerbst1.xpm,jjHerbst2.xpm,jjHerbst3.xpm,jjHerbst4.xpm
    << jjHerbst={nex=jjWinter; jahreszeit}; >>
  }
}
