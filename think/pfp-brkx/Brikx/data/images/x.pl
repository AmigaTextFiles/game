#!/usr/bin/perl -w

for ($i=1; $i<=70; $i++)
  {
    printf("c:\\bin\\convert shine.png -scale %dx%d  -background 000000  -rotate %d shine%d.png\n",$i>35?71-$i:$i,$i>35?71-$i:$i,$i*10,$i);
    #printf("convert shine.png -scale %dx%d  -background 000000  -rotate %d shine%d.png\n",$i>35?71-$i:$i,$i>35?71-$i:$i,$i*10,$i);
  }
