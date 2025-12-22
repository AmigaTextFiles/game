PRIMER:
---
This is an AmigaOS4 port of Space Cadet Pinball based from the great work of:
- https://github.com/k4zmu2a/SpaceCadetPinball
- http://www.xenosoft.de/space-cadet-pinball-2.0-linux.powerpc.tar.gz
- rjd324: Further changes to compile for AmigaOS4

TO RUN
---
- doubleclick or run 'SpaceCadetPinball' from the 'bin' folder
- requires that you have the DATA files in the 'bin' folder

KNOWN ISSUES:
---
- Fix when pressing 'ESC': causes iconfication and re-opening seems to not re-render

CHANGES v1.1 (since version 1.0):
---
- Updated core codebase to latest version (Feb 10 2022) from October 2021
- Fixed crash if there is no .DAT file in any search paths
- Game now runs with linear filtering at an acceptable rate
- Added an appropriate icon (thank you Steven Solie/Kevin Lester (CreateIcon)
- GITHUB: Forked to: https://github.com/3246251196/SpaceCadetPinball
          from     : https://github.com/k4zmu2a/SpaceCadetPinball

CHANGES v1.2 (since version 1.1)
---
- Removed the output of SDL Error messages to console window
- Compile with NDEBUG

CHANGES v1.3 (since version 1.2)
---
- Merged latest master (commit: 42226a14c96f6d570c63dccdfc36e2b487ad8075 /
  September 2022) branch
