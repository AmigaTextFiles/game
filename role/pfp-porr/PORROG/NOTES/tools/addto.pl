#!/usr/bin/perl -w

#while(<>){
   $_=<>;
   chomp($_);
   if($_ ne"") {
     $_+=256;
     print "$_\n";
   }
#}
