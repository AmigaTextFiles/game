#!/bin/bash
oconv mats.rad light.rad menuscene.rad >scene.oct

rpict -vh 60 -vv 60 -x 640 -y 640  -av 0.2 0.2 0.2 scene.oct >scene.pic


ra_ppm -g 1 scene.pic |pnmcut 0 80 640 480 |pnmtopng -gamma 1 >menuscene_640x480.png

