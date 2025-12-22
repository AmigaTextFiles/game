/*
 *  Bubble Train
 *  Copyright (C) 2004  
 *  					Adam Child (adam@dwarfcity.co.uk)
 * 						Craig Marshall (craig@craigmarshall.org)
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */
 #include "OptionsScreen.h"

OptionsScreen::OptionsScreen(SDL_Surface* screen) : Window(screen)
{
	this->state = KS_None;
	this->keyMsgBox = NULL;
	
	// Setup the window to be the same size as the image
	int aWidth = 600;
	int aHeight = 400;
	Rect rOptionScreen; 
	rOptionScreen.topLeft.x = (screen->w - aWidth) / 2;
	rOptionScreen.topLeft.y = (screen->h - aHeight) / 2;
	rOptionScreen.bottomRight.x = rOptionScreen.topLeft.x + aWidth;
	rOptionScreen.bottomRight.y = rOptionScreen.topLeft.y + aHeight;
    Window::setSize(rOptionScreen);
    Window::loadBackgroundImage("../gfx/options.png");

	int left 		= 0;
    int top 		= 70;
    int titleLeft   = 30;
    int settingLeft = 50;
  	int vertSpace	= 23;
  	int controlLeft = settingLeft + 120;
  	int textBoxW	= 30;
  	int sliderW		= 200;
  	int buttonWidth = 80;
	int buttonHeight = 20;
	int buttonGap = 30;

	// Game
	//-------------------------------------
	left = titleLeft;
	
	Label* gameTitlelabel = new Label(Point(left, top), Point(controlLeft, top + 10));
    gameTitlelabel->setLabelText("GAME");
    Window::addControl(gameTitlelabel);
    
    left = settingLeft;
    top += vertSpace;
    
    Label* gameCreditslabel = new Label(Point(left, top), Point(controlLeft, top + 10));
    gameCreditslabel->setLabelText("Credits");
    Window::addControl(gameCreditslabel);
	
	left = controlLeft;
	
	this->txtCredits = new TextBox(Rect(left, top, left + textBoxW, top + 16));
	Callback0<OptionsScreen> creditsCallBack(*this,&OptionsScreen::creditsChanged);
    this->txtCredits->addChangeEvent(creditsCallBack);
    char buffer[5];
    sprintf(buffer ,"%d", Options::Instance()->getCredits());
    this->txtCredits->setText(buffer);
	this->txtCredits->setActiveColour(SDL_MapRGB(screen->format, 0x66, 0x66, 0x66));
	this->txtCredits->setInActiveColour(SDL_MapRGB(screen->format, 0x99, 0x99, 0x99));
	this->txtCredits->setBevelType(BEV_INNER);
    Window::addControl(this->txtCredits);
    
    left += textBoxW + 10;
    
    Label* creditsNotelabel = new Label(Point(left, top), Point(left + 250, top + 10));
    creditsNotelabel->setLabelText("(Note: set to -1 for infinite credits)");
    Window::addControl(creditsNotelabel);
	
	// Sound
	//-------------------------------------
	left = titleLeft;
	top += vertSpace;
	
	Label* soundTitlelabel = new Label(Point(left, top), Point(controlLeft, top + 10));
    soundTitlelabel->setLabelText("SOUND");
    Window::addControl(soundTitlelabel);
    
    left = settingLeft;
    top += vertSpace;
    
    Label* soundlabel = new Label(Point(left, top), Point(controlLeft, top + 10));
    soundlabel->setLabelText("Enabled");
    Window::addControl(soundlabel);

	this->chkSoundEnabled = new CheckBox(Point(controlLeft, top));
	Callback0<OptionsScreen> soundCallBack(*this,&OptionsScreen::soundChanged);
    this->chkSoundEnabled->addChangeEvent(soundCallBack);
    this->chkSoundEnabled->setChecked(Options::Instance()->getSoundEnabled());
	this->chkSoundEnabled->setActiveColour(SDL_MapRGB(screen->format, 0x66, 0x66, 0x66));
	this->chkSoundEnabled->setInActiveColour(SDL_MapRGB(screen->format, 0x99, 0x99, 0x99));
	this->chkSoundEnabled->setBevelType(BEV_INNER);
    Window::addControl(this->chkSoundEnabled);
	
	top += vertSpace;
	
	// Music volume
	Label* musiclabel = new Label(Point(left, top), Point(controlLeft, top + 10));
    musiclabel->setLabelText("Music Volume");
    Window::addControl(musiclabel);
	
	this->sldMusicVolume = new Slider(Rect(controlLeft, top, controlLeft + sliderW, top + 10));
	this->sldMusicVolume->setActiveColour(SDL_MapRGB(screen->format, 0x33, 0x33, 0x33));
	Callback0<OptionsScreen> musicVolCallBack(*this,&OptionsScreen::musicVolumeChanged);
    this->sldMusicVolume->addChangeEvent(musicVolCallBack);
    this->sldMusicVolume->setMaxValue(MIX_MAX_VOLUME);
    this->sldMusicVolume->setStepValue(16);
    this->sldMusicVolume->setValue(Options::Instance()->getMusicVolume());
	Window::addControl(this->sldMusicVolume);
	
	top += vertSpace;
	
	// Effects volume
	Label* effectlabel = new Label(Point(left, top), Point(controlLeft, top + 10));
    effectlabel->setLabelText("Effects Volume");
    Window::addControl(effectlabel);
	
	this->sldEffectsVolume = new Slider(Rect(controlLeft, top, controlLeft + sliderW, top + 10));
	this->sldEffectsVolume->setActiveColour(SDL_MapRGB(screen->format, 0x33, 0x33, 0x33));
	Callback0<OptionsScreen> effectVolCallBack(*this,&OptionsScreen::effectVolumeChagned);
    this->sldEffectsVolume->addChangeEvent(effectVolCallBack);	
    this->sldEffectsVolume->setMaxValue(MIX_MAX_VOLUME);
    this->sldEffectsVolume->setStepValue(16);
    this->sldEffectsVolume->setValue(Options::Instance()->getEffectVolume());    
	Window::addControl(this->sldEffectsVolume);
	
	// Controls - Mouse
	//-------------------------------------
	left = titleLeft;
	top += vertSpace;
	
	Label* mouseTitlelabel = new Label(Point(left, top), Point(controlLeft, top + 10));
    mouseTitlelabel->setLabelText("CONTROLS - MOUSE");
    Window::addControl(mouseTitlelabel);
    
    left = settingLeft;
    top += vertSpace;
    
    Label* mouselabel = new Label(Point(left, top), Point(controlLeft, top + 10));
    mouselabel->setLabelText("Enabled");
    Window::addControl(mouselabel);

	this->chkMouseEnabled = new CheckBox(Point(controlLeft, top));
	Callback0<OptionsScreen> mouseCallBack(*this,&OptionsScreen::mouseChanged);
    this->chkMouseEnabled->addChangeEvent(mouseCallBack);
    this->chkMouseEnabled->setChecked(Options::Instance()->getMouseEnabled());
	this->chkMouseEnabled->setActiveColour(SDL_MapRGB(screen->format, 0x66, 0x66, 0x66));
	this->chkMouseEnabled->setInActiveColour(SDL_MapRGB(screen->format, 0x99, 0x99, 0x99));
	this->chkMouseEnabled->setBevelType(BEV_INNER);
    Window::addControl(this->chkMouseEnabled);
	
	top += vertSpace;
	
	// Mouse sensitivity
	Label* sensitivitylabel = new Label(Point(left, top), Point(controlLeft, top + 10));
    sensitivitylabel->setLabelText("Sensitivity");
    Window::addControl(sensitivitylabel);
	
	this->sldMouseSensitivity = new Slider(Rect(controlLeft, top, controlLeft + sliderW, top + 10));
	Callback0<OptionsScreen> mouseSensCallBack(*this,&OptionsScreen::mouseSensitivityChanged);
    this->sldMouseSensitivity->addChangeEvent(mouseSensCallBack);
    this->sldMouseSensitivity->setMaxValue(5);
    this->sldMouseSensitivity->setStepValue(1);
    this->sldMouseSensitivity->setValue(Options::Instance()->getMouseSensitivity());
	this->sldMouseSensitivity->setActiveColour(SDL_MapRGB(screen->format, 0x33, 0x33, 0x33));
	Window::addControl(this->sldMouseSensitivity);
	
	// Controls - Keys
	//-------------------------------------
	top += vertSpace;
	left = titleLeft;
	
	Label* keysTitlelabel = new Label(Point(left, top), Point(controlLeft, top + 10));
    keysTitlelabel->setLabelText("CONTROLS - KEYS");
    Window::addControl(keysTitlelabel);
    
    left = settingLeft;
    top += vertSpace;
    
    // Fire key
    Label* firelabel = new Label(Point(left, top), Point(controlLeft, top + 10));
    firelabel->setLabelText("Fire: ");
    Window::addControl(firelabel);
    
    this->lblFireKey = new Label(Point(controlLeft, top), Point(controlLeft + sliderW, top + 10));
    this->lblFireKey->setLabelText(getKeyText(Options::Instance()->getFireKey()));
    Window::addControl(this->lblFireKey);
    
    top += vertSpace;

    // Left key
    Label* leftlabel = new Label(Point(left, top), Point(controlLeft, top + 10));
    leftlabel->setLabelText("Left: ");
    Window::addControl(leftlabel);
    
    this->lblLeftKey = new Label(Point(controlLeft, top), Point(controlLeft + sliderW, top + 10));
    this->lblLeftKey->setLabelText(getKeyText(Options::Instance()->getCannonLeftKey()));
    Window::addControl(this->lblLeftKey);
    
    top += vertSpace;

    // Right key
    Label* rightlabel = new Label(Point(left, top), Point(controlLeft, top + 10));
    rightlabel->setLabelText("Right: ");
    Window::addControl(rightlabel);
    
    this->lblRightKey = new Label(Point(controlLeft, top), Point(controlLeft + sliderW, top + 10));
    this->lblRightKey->setLabelText(getKeyText(Options::Instance()->getCannonRightKey()));
    Window::addControl(this->lblRightKey);
    
    // Button to kick start the key assignment
	Rect rbtnKeyAssign(controlLeft + sliderW, aHeight - buttonGap - buttonHeight, controlLeft + sliderW + buttonWidth, aHeight - buttonGap);
	Callback0<OptionsScreen> keysCallBack(*this,&OptionsScreen::assignKeys);
    Button* btnKeyAssign = new Button(keysCallBack, "Assign Keys", rbtnKeyAssign);
    btnKeyAssign->setActiveColour(SDL_MapRGB(screen->format, 0x70, 0xB7, 0xFE));
    Window::addControl(btnKeyAssign);
	
	// Add a button for the ok
	Rect rbtnOK(aWidth - buttonGap - buttonWidth, aHeight - buttonGap - buttonHeight, aWidth - buttonGap, aHeight - buttonGap);
	Callback0<OptionsScreen> okCallBack(*this,&OptionsScreen::ok);
    Button* btnOK = new Button(okCallBack, "Ok", rbtnOK);
    btnOK->setAccessKey(SDLK_RETURN);
    btnOK->setActiveColour(SDL_MapRGB(screen->format, 0x70, 0xB7, 0xFE));
    Window::addControl(btnOK);
    
}

OptionsScreen::~OptionsScreen()
{
	if (this->keyMsgBox)
	{
		delete this->keyMsgBox;
		this->keyMsgBox = NULL;
	}
		
}

void OptionsScreen::soundChanged()
{
	Options::Instance()->setSoundEnabled(this->chkSoundEnabled->getChecked());
	// simply pause the music for now
	Theme::Instance()->pauseMusic(!Options::Instance()->getSoundEnabled());
}

void OptionsScreen::musicVolumeChanged()
{
	Options::Instance()->setMusicVolume(this->sldMusicVolume->getValue());
	// Set the volume
	Mix_VolumeMusic(Options::Instance()->getMusicVolume());
}

void OptionsScreen::effectVolumeChagned()
{
	Options::Instance()->setEffectVolume(this->sldEffectsVolume->getValue());
	Theme::Instance()->playSound(SND_FIREBULLET);
}

// Game events
void OptionsScreen::creditsChanged()
{
	Options::Instance()->setCredits(atoi(this->txtCredits->getText()));
}

// Control events
void OptionsScreen::mouseChanged()
{
	Options::Instance()->setMouseEnabled(this->chkMouseEnabled->getChecked());
}

void OptionsScreen::mouseSensitivityChanged()
{
	Options::Instance()->setMouseSensitivity(this->sldMouseSensitivity->getValue());
}


void OptionsScreen::ok()
{
	WindowManager::Instance()->remove(this);
}

void OptionsScreen::assignKeys()
{
	this->state = KS_Fire;
	
	// Show the prompt for which key to assign
	if (this->keyMsgBox)
		delete this->keyMsgBox;
	this->keyMsgBox = new MessageBox(SDL_GetVideoSurface(), "Cannon Fire");
}

void OptionsScreen::draw(SDL_Surface* screenDest)
{
	Window::draw(screenDest);
	
	if (this->keyMsgBox)
		this->keyMsgBox->draw(screenDest);
}

bool OptionsScreen::keyPress( SDLKey key, SDLMod mod, Uint16 character )
{
	// Depending on the state of the options screen then assign the key pressed
	// with the associated game key
	switch(this->state)
	{
		case KS_None:
			break;
		case KS_Fire:
			Options::Instance()->setFireKey((int)key);
			this->lblFireKey->setLabelText(getKeyText((int)key));
			
			// Move onto the next state
			this->state = KS_Left;
			if (this->keyMsgBox)
				delete this->keyMsgBox;
			this->keyMsgBox = new MessageBox(SDL_GetVideoSurface(), "Cannon Left");
			
			return true;
		case KS_Left:
			Options::Instance()->setCannonLeftKey((int)key);
			this->lblLeftKey->setLabelText(getKeyText((int)key));

			// Move onto the next state
			this->state = KS_Right;
			if (this->keyMsgBox)
				delete this->keyMsgBox;
			this->keyMsgBox = new MessageBox(SDL_GetVideoSurface(), "Cannon Right");
			
			return true;
		case KS_Right:
			Options::Instance()->setCannonRightKey((int)key);
			this->lblRightKey->setLabelText(getKeyText((int)key));

			// Reset the state back to normal
    		this->state = KS_None;
    		if (this->keyMsgBox)
    		{
    			delete this->keyMsgBox;
    			this->keyMsgBox = NULL;
    		}	
    		return true;
	}
	
	// Process all child control events as well
	return Window::keyPress(key, mod, character);
}
