#include <GL/gl.h>
#include "scenario.h"
#include "texture.h"

static int scenario_width = 180;
static int scenario_height = 180;

void Scenario_draw(int disable_textures)
{
    int line_spacing = 2;
    int j;

    if (!disable_textures) {
	/* solid floor */
	glBindTexture(GL_TEXTURE_2D, texture[0]);
	glEnable(GL_TEXTURE_2D);
	//glColor3f(0.0, 0.0, 0.5);
	glBegin(GL_QUADS);
	glTexCoord2i(0, 0);
	glVertex3i(scenario_width, 0, 0);
	glTexCoord2i(scenario_width / 10, 0);
	glVertex3i(0, 0, 0);
	glTexCoord2i(scenario_width / 10, scenario_height / 10);
	glVertex3i(0, 0, scenario_height);
	glTexCoord2i(0, scenario_height / 10);
	glVertex3i(scenario_width, 0, scenario_height);
	glEnd();
	glDisable(GL_TEXTURE_2D);

    } else {
	/* lines as floor... */
	glColor3f(0.0, 0.0, 1.0);
	glBegin(GL_LINES);
	for (j = 0; j <= scenario_height + 1; j += line_spacing) { // vertical
	    glVertex3i(0, 0, j);
	    glVertex3i(scenario_width, 0, j);
	}

	for (j = 0; j <= scenario_width + 1; j += line_spacing) { // horizontal
	    glVertex3i(j, 0, 0);
	    glVertex3i(j, 0, scenario_height);
	}
	glEnd();
    }
}

int Scenario_get_width()
{
    return scenario_width;
}

int Scenario_get_height()
{
    return scenario_height;
}

void Scenario_set_size(int width, int height)
{
    scenario_width = width;
    scenario_height = height;
}
