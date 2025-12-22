;Pandora
;Krzysztof LOS, 01-813 Warszawa 118, ul. Marymoncka 137/139 m 69

          dat $0    $323
          dat $0 
start     mov #10   $-1
          mov @-2   <-3
          djn $-1   $-3
          spl @-5
          add #263  $-6
          jmp $-5   
          end
