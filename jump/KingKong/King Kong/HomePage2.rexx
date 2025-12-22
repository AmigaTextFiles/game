     /* Load the openurl.library as a function host */
      IF ~SHOW('L','openurl.library') THEN
        CALL ADDLIB('openurl.library',3,-66)
     /* Open homepage URL */
      OpenURL("mermaid.c64scene.org", SHOW, TOFRONT, LAUNCH)