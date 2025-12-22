/*
 *  This file is part of Dune Legacy.
 *
 *  Dune Legacy is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  Dune Legacy is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Dune Legacy.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef OPTIONSMENU_H
#define OPTIONSMENU_H

#include "MenuClass.h"
#include <GUI/Container.h>
#include <GUI/TextButton.h>
#include <GUI/Spacer.h>
#include <GUI/TextBox.h>


class OptionsMenu : public MenuClass
{
public:
	OptionsMenu();
	~OptionsMenu();

	void UpdateButtonCaptions();

private:
	void	OnOptionsConcrete();
	void	OnOptionsIntro();
	void	OnOptionsLanguage();
	void	OnOptionsRes();
	void	OnOptionsFullscreen();
	void	OnOptionsDoubleBuffered();
	void	OnOptionsOK();
	void	OnOptionsCancel();

	void	SaveConfiguration2File();

	StaticContainer	WindowWidget;

	TextButton	Button_Concrete;
	TextButton	Button_Res;
	TextButton	Button_FullScreen;
	TextButton	Button_DoubleBuffered;
	TextButton	Button_Intro;
	TextButton	Button_Language;
	TextButton	Button_Ok;
	TextButton	Button_Cancel;
	VBox		MainVBox;
	HBox		OkCancel_HBox;
	TextBox		TextBox_Name;

	bool	newConcreteRequired;
	bool	newIntro;
	int		newLanguage;
	bool	newDoubleBuffered;
	bool	newFullscreen;
	int		newWidth;
	int		newHeight;
};


#endif // OPTIONSMENU_H
