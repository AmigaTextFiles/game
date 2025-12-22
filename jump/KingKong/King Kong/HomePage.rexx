     /* Load the openurl.library as a function host */
      IF ~SHOW('L','openurl.library') THEN
        CALL ADDLIB('openurl.library',3,-66)
     /* Open my homepage URL */
      OpenURL("drhirudo.hit.bg", SHOW, TOFRONT, LAUNCH)