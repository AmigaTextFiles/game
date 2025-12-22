#!/usr/bin/perl -w

while(<>) {
   chomp;
   /.(.)(.)(.)(.)(.)(.)(.)(.)/; # 4 topless women? no, just collect digits.
   # ignore the first character, which is bit 8 (256) to force bc to pad.
   # remap: SOURCE    TARGET
   #         765       765
   #         4 3       0 4
   #         210       123
   #
   #         123       
   #         4 5
   #         678
   $bin=sprintf("$1$2$3$5$8$7$6$4"); # um, what direction we do this?
#   print "$bin\n";
   foreach(0..7) {
      $bit=substr($bin,7-$_,1);
      $decival+=$bit*(2**$_);
   }
   print "$decival\n";
}
