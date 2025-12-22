/* GUI.h v0.2 */

#ifndef GUI_H
#define GUI_H

struct Prefs
{
    BOOL sound;
    int lives, startlevel, status;
};

void LoadPrefs(struct Prefs *sets);
void SavePrefs(struct Prefs *sets);
BOOL GUI(struct Prefs *settings);

#endif
