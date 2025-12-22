jumpStick: Qcontainer, Item
	maxbulk = 1
	color = 'none'
	
	sdesc = "black cylinder"
	ldesc = {
		P(); I();
		"The black cylinder <<t.looks>> just like 
		one of those jump sticks that secret agents 
		in action movies always use when they need
		to get from one place to another in a hurry. 
		\^<<t.itis>> a hand-sized device with 
		a button on top and a square hole in the bottom"; note(self); ". ";

		if (length (jumpStick.contents) > 0) {
			"There <<t.is>> a <<jumpStick.contents[1].color>> cube in the hole. ";
		}
	}
	footnote = "Or the other way around, depending 
		on how you <<t.hold>> it. "
	
	noun = 'cylinder' 'stick' 'device' 'hole'
	adjective = 'black' 'jump' 'square'
	
	location = nil
	
	ioPutin(actor, dobj) = 
	{	
		if (length (jumpStick.contents) = 0) {
			if (not (dobj.iscube) ) {
				"\^<<dobj.thedesc>> <<t.wont>> fit into the square hole. ";
			}
			else {
				self.color := dobj.color;
				
				"\^<<dobj.thedesc>> <<t.fits>> into the hole in the
				cylinder with a satisfying click. \b";
				inherited.ioPutin(actor, dobj);
			}
		}
		else {
			"There <<t.is>> already a <<jumpStick.contents[1].color>> cube in the hole. ";
		}
	}
;

button: Button, Part
	partof = jumpStick
	
	sdesc = "button on the jump stick"
	
	noun = 'button'
	adjective = 'jump' 'stick'
	
	doPush(actor) =
	{
	
		if (length (jumpStick.contents) > 0) {
			jumpStick.color := jumpStick.contents[1].color;
			if (not (jumpStick.iscontained(Me, 'in'))) {
				self.oopsMsg;
				jumpStick.movein(nil);
			}
			else if (jumpStick.color = 'green') {
				if (Me.location = greenRoom) {
					"<click>\bNothing happens. ";
				}
				else {
					if (not (self.firstGreen)) {
						self.firstGreen := true;
						self.greenMsg;
					}
					else { self.genericMsg; }
					
					Me.travelto(greenRoom);
				}
			}
			else if (jumpStick.color = 'blue') {
				if (Me.location = blueRoom) {
					"<click>\bNothing happens. ";
				}
				else {
					if (not (self.firstBlue)) {
						self.firstBlue := true;
						self.blueMsg;
					}
					else { self.genericMsg; }
					
					Me.travelto(blueRoom);
				}
			}
		}
		else {
			"<click>\bNothing <<t.happens>>. ";
		}
	}
	
	oopsMsg = {
		"<click>\b The cylinder <<t.disappears>> in a flash of light! 
		Too bad you weren't holding it. ";
	}
	
	genericMsg = { "<click>\n";}
	
	blueMsg = { "<click>\n";}
	
	greenMsg = {
		"<click>";
		P(); I();
		"The instant your thumb <<t.depresses>> the button 
		a bright light <<t.fills>> your field of vision  
		and waves of electricity <<t.crackle>> over the surface 
		of your skin!  The pain <<t.is>> more than you <<t.can>>  
		bear; you <<t.fall>> to the ground, writhing in agony.  
		Consciousness <<t.flees>> from your mortal frame like 
		rats from a sinking ship...
		\b
		\b
		\t\t*\t*\t*
		\b
		\b";
		Me.travelto(cliff);
		"\b
		\b
		\t\t*\t*\t*
		
		\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b
		
		\tYour head <<t.hurts>>.  Your body <<t.aches>>.  
		And you <<t.havent>> even had breakfast yet. 
		Lifting your head off the floor, 
		you <<t.see>> that you <<t.are>> in some sort of\b";
	}
;

class Cubeitem: Item
	iscube = true

	sdesc = "<<self.color>> cube"
	ldesc = "A <<self.color>> cube one inch to a side. "
	
	noun = 'cube'
	plural = 'cubes'
	
	doTake(actor) = {
		local	tot, m;
		if (self.isin(actor)) {
			if (self.isclothing and self.isworn) {
				self.doUnwear(actor);
				return;
			}
			else if (self.location = actor) {
				"%You% already <<actor.has>>
				\ <<self.objthedesc(actor)>>.";
				return;
			}
		}
		if (self.location = jumpStick) {
			jumpStick.color := 'none';
		}
		actor.ioPutX(actor, self, 'in');
	}

;

greenCube: Cubeitem
	adjective = 'green' 'colored'
	color = 'green'
	location = package
	ldesc = "A <<self.color>> cube one inch to a side. The word \"laboratory\"
		<<t.has>> been etched onto one face. "
;

blueCube: Cubeitem
	adjective = 'blue' 'colored'
	color = 'blue'
	location = nil
	ldesc = "A <<self.color>> cube one inch to a side. The word \"cathedral\"
		<<t.has>> been etched onto one face. "
;
/*
redCube: Cubeitem
	adjective = 'red' 'colored'
	color = 'red'
	location = safe
;

*/

cliff: Room
	sdesc = "The Cliff"
	ldesc = {
		I();
		"The Master <<t.stands>> with his back to you.  
		After a time, he <<t.turns>> and <<t.asks>> you a question:
		\"What do you see over the edge of the cliff, mmmm?\" ";
		P(); I();
		"A voice within you <<t.moves>> to speak:
		 \"I see the ocean towering over the void, Master.\" ";
		 P(); I();
		"Upon hearing those words, the crooked old 
		man <<t.hurls>> himself over the edge into the 
		cool blue water below.";
	}
;
