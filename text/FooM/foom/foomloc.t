/*  Locations  */

ending: insideroom
   sdesc = "End of Level"
   ldesc = "< You can RESTORE, RESTART or QUIT >"
;

startroom:  insideroom
   sdesc = "Hangar Entrance"
   ldesc = "A dark squarish room. You are just inside the entry bay, which 
   has closed behind you. There's no way out \(that\) way. Pillars obscure
   your view, and the viewport on the right lets in but little light. The 
   centre of the room, to the north, is depressed; a couple of steps lead 
   down to it.  A pillar prevents you moving to the northwest but your 
   movement towards your left, to the west, is unhindered.\n"
   west  = leftcorner
   north = centroom
   down  = centroom
;

centroom: insideroom
   sdesc = "Central Depression"
   ldesc = { "The centre of the hangar entrance. You can see more through the
   viewport from here. Outside is a wide open space, with an acid pool in 
   the centre.";
   if ( suit2.location = pool)
       " There appears to be something blue in the pool. "; 
   "On the other side of the opening is another viewport, and on the south
   side is a tunnel entrance. You cannot get through the viewport."; 
   if ( self.exploded = nil )          //check if barrel blown up.
       " There is a leaky barrel here, I wouldn't stand too close to it."; 
   " Near the western end of the depression there lies the corpse of someone
   or something unknown.\n"; }
   south = startroom
   north = topright
   west  = westroom
   sw    = leftcorner
   nw    = topleft
;

leftcorner:  insideroom
   sdesc = "Dingy Corner"
   ldesc = "Peering through the gloom caused by a bad light attenuation 
   algorithm, you can just make out this corner of the room. The walls are
   streaked and grimy. The room opens out to the north, east, and 
   northeast.\n"
   east  = startroom
   north = westroom
   ne    = centroom
   down  = centroom
;

westroom:  insideroom
   sdesc = "Bad Spot"
   ldesc = { "This side of the room forms an entry for the vestibule to the 
   west. The room you're in disappears into the gloom east of here. The 
   depression is directly east of you now. Through the doorway to the west 
   you can just make out some stairs. The pillars around the depression 
   prevent movement to the northeast and southeast. If you were playing a 
   harder level of difficulty, you would be being shot at right now."; 
   if (self.exploded = nil)          //check if barrel blown up.
       " A barrel is dangerously close to you here.";
   "\n"; }
   west  = vestibule
   east  = centroom
   south = leftcorner
   north = topleft
   down  = centroom
;

topleft:  insideroom
   sdesc = "Another Dingy Corner"
   ldesc = "Slightly better than the last one, this dingy corner has a lot
   more to offer. There is a lot of blood on the wall, and a trail of gore 
   leading east.\n"
   east  = topright
   south = westroom
   se    = centroom
   down  = centroom
;

topright:  insideroom
   sdesc = "Tunnel Entrance"
   ldesc = { "A large tunnel leads away from the hangar entrance here,
   heading north for a while before curving around to the east. To the south
   is the depression, and the viewport is southeast. You have a better view 
   of the tunnel outside from here, and can see that it has stairs going down
   inside it."; 
   if (self.exploded = nil)          //check if barrel blown up.
       " Next to a barrel, t";
   else
       " T";
   "he bloody corpse of a marine lies face down on the floor. The body is
   cold and stripped of equipment.\n"; }
   north = tunnel
   south = centroom
   west  = topleft 
   down  = centroom
;

vestibule:  insideroom
   sdesc = "Vestibule"
   ldesc = "The hangar entrance closes here to form a pokey corridor leading 
   into a room with a central staircase and two pillars on either side of the 
   stairs. The carcase of another marine is just to the southwest.\n"
   firstseen = {
                  setfuse( startfight, 1, sarg1 );
               }
   west  = topofstairs
   up    = topofstairs
   east  = westroom
;

topofstairs: insideroom
   sdesc = "Scenic Vista"
   ldesc = "At the top of the stairs is a platform with a central table and 
   windows on all sides, through which the dramatic landscape of wooded 
   mountainous hills can be seen. It's quite bright here, almost like being 
   outside. Sadly, however, you can't go outside - there's no door and the
   drop is too great. Another exploded corpse lies on the floor here.\n"
   east  = vestibule
   down  = vestibule
;

tunnel: insideroom
   sdesc = "Main Tunnel"
   ldesc = "You are in the tunnel from the entrance to the centre of the 
   complex. The streaked and rusty walls have endured a lot of gunfire, and 
   are heavily scarred. To the south is the hangar entrance and to the east 
   is a closed metal fire door. Half under the door is the body of a marine.
   He must be a recent casualty, because the body is well preserved.\n"
   east  = door1
   south = topright
;

computing: gruesome
   sdesc = "Computing Centre, West"
   ldesc = "A dark room with a central cubicle to the east, which contains 
   some useful items. Passages around it to the southeast and northeast are
   obscured by the gloom. The computer terminals around the walls are unlit, 
   but a faint light permeates the room. It is not, however, bright enough
   for you to see by without your lamp.\n"
   firstseen = {
                  setfuse( startfight, 1, soldier3 );
               }
   west  = door2
   in    = cubicle
   east  = cubicle
   se    = compute
   ne    = compute
;

cubicle: insideroom
   sdesc = "Guard Block"
   ldesc = "A guard block in the centre of the room"
   west  = computing
   out   = computing
;

compute: gruesome
   sdesc = "Computing Centre, East"
   ldesc = "The eastern end of the computing centre is darker, as the light 
   from the cubicle doesn't come this direction. A passage leads to the 
   east, curving around to the southeast at its midpoint."
   firstseen = {
                  setfuse( startfight, 1, dsold3 );
               }
   west  = computing
   nw    = computing
   sw    = computing
   east  = passage
;

passage: insideroom
   sdesc = "Short Passage"
   ldesc = "A short passage. The Computing Centre is to the west, and a 
   large chamber with a zig-zag path across its middle opens up before you.
   Acid surrounds the path.\n"
   firstseen = {
                  setfuse( startfight, 1, dimp1 );
               }
   west  = compute
   south = zigzag
;

zigzag: insideroom
   sdesc = "Zig-zaggy Room"
   ldesc = { "A large chamber with a viewport on the west wall, showing you
   that outside area again. There are lamps in the corners of the room, but
   the light from outside illuminates the room quite well enough. Next to the
   lamp on your right is the body of another marine. The shredded corpse of
   someone else lies in the middle of the zig-zag path. To the southeast is"; 
   if ( exitroom.isseen = nil)
      " a ledge.\n";
   else
       " an opening where the ledge used to be.\n"; }
   north = passage
   south = escape
   sw    = escape
   se    = { if ( exitroom.isseen )
                return ( hiddenhall );
             else
                return ( nil );
           }
;

escape: insideroom
   sdesc = "Narrow Passageway"
   ldesc = "This passage gives you some time to breathe - it's fairly safe.
   There is another metal door in front of you. There must be an exit to the 
   outside somewhere around here, judging from where that tunnel outside
   comes out.\n"
   north = zigzag
   south = door5
   west = door3
   down = door3
;

stairways: insideroom
   sdesc = "Steep Stairs"
   ldesc = "A steep stairway descends here to a landing. You almost bash your
   head on the ceiling, it drops so quickly. At the landing, the stairs rise
   precariously again to the exit to the outside, through which sunlight 
   is streaming into the tunnel.\n"
   firstseen = { incsec( 33 ); }
   east  = door4
   nw    = opening
   north = opening
   west  = opening
;

opening: outsideroom
   sdesc = "Courtyard"
   ldesc =
   { 
      "A stone paved courtyard fills the centre of the hangar complex.
      Inside it is a pool of acid";
      if ( suit2.location = pool)
         ", in which you can clearly see a suit of mega-armour";
      ". A cursory glance around the courtyard reveals nothing else of
      interest. The stairs lead down to the south from here.\n";
   }
   down  = stairways
   south = stairways
   in    = pool
;

pool: outsideroom
   sdesc = "Acid Pool"
   ldesc = "\(You are in a pool of burning acid! What do you think you are
   doing? This might not hurt you, buddy, but it's hurting me!\)\n"
   firstseen = { setdaemon(poolDamage, self) ; }
   out = opening
   up = opening
   north = opening
   south = opening
   east  = opening
   west  = opening
   ne    = opening
   nw    = opening
   se    = opening
   sw    = opening
;

exithall: gruesome
   sdesc = "Dark Hall"
   ldesc = { "A dark hall with latticed metal walls. At the far end of the 
   hall an exit light burns brightly, but its light is not enough to light
   the rest of the room, which is barely visible. Under the exit sign to the
   south is a door, and on either side of it are side passages which pass
   back behind the lattice walls."; 
   if (self.exploded = nil)          //check if barrel blown up.
       " A barrel stands against one wall, in front of it lies another dead
       marine.\n";
   else
       " Another dead marine lies near where a barrel once was.\n"; }
   firstseen = {
                  setfuse( startfight, 1, imp3 );
               }
   north = door6
   south = door7
   west  = sidehall1
   east  = sidehall2
;

sidehall1: gruesome
   sdesc = "Grimy Nook"
   ldesc = "A streaky, blood-splattered alcove containing a couple of
   mangled corpses.\n"
   south = exithall
   east  = exithall
;

sidehall2: gruesome
   sdesc = "Gruesome Corner"
   ldesc = { "More evidence of uncontrolled gunfire and bloodshed greets you
   in this loathsome niche."; 
   if (self.exploded = nil)          //check if barrel blown up.
       " Another barrel and another body are ";
   else
       " Another body is ";
   "testament to the brutality of the demonic invasion.\n"; }
   south = exithall
   west  = exithall
;

exitroom: insideroom
   sdesc = "The Way Out"
   ldesc = "Finally! You can leave this place. In this room, on the west 
   wall, is the switch that will end this level.\n"
   firstseen =
   {
       zigzag.isseen := nil;
       "\nAs you enter the room you hear the sound of a lift operating
       somewhere behind you.\n";
       setfuse( startfight, 1, imp4 );
   }
   north = door8
;

hiddenhall: insideroom
   sdesc = "Hidden Passage"
   ldesc = "Revealed by the descent of the ledge, this dusty passage is short
   and straight, with an alcove to the right. As you entered the room, you
   noticed that a lift was descending on the east wall."
   firstseen = { incsec( 33 ); }
   lift = true
   enterRoom( actor ) =    // sent to room as actor is entering it
   {
       self.lift := true;
       setfuse( noExit, 2, self );
       pass enterRoom;
   }
   north = zigzag
   up    =  {
               if (lift) return( helmpas );
               else return( nil );
            }
   east  = self.up
   se    = self.up
;

helmpas: gruesome
   sdesc = "Winding Passage"
   ldesc = "This passage winds it way to the north. You duck your head as
   the lift comes up because the ceiling is very low. The lift grinds to a
   halt. You notice it has no controls, and will not return to the lower
   passage.\n"
   firstseen = { incsec( 34 ); }
   north = midpas
   ne    = midpas
;

midpas: gruesome
   sdesc = "Another Winding Passage"
   ldesc = "The passage continues to the north from here, curving abruptly
   just ahead of you. It winds back towards the lift to the south.\n"
   north = balcony
   ne    = balcony
   east  = balcony
   south = helmpas
   sw    = helmpas
;

balcony: insideroom
   sdesc = "Zigzag View"
   ldesc = "Not a view which goes back and forth abruptly, but a view
   overlooking the zigzag path through the acid. The balcony opens to the
   southwest, pointing almost directly at the southern passageway leading
   to the exit.\n"
   sw    = zigzag
   down  = zigzag
   south = midpas
   east  = midpas
   se    = midpas
;

/*  Items  */
backpack: item    //for maxvalue of ammo, no backpack in mission one.
;

lamp:  lightsource
   islit = true
   sdesc = "lamp"
   ldesc =  "Standard issue lamp"
   noun  = 'lamp'
   location = Me
;

/* inventory weapons & special items */

switch1: levelSwitch
   location = exitroom
;

kfaFists: fists
   location = Me
   isListed = nil
;
kfaPistol: pistol     // you always have this weapon
   location = Me
   thedesc  = "your pistol"
   adjective = 'your' 'my'
;
kfaShotgun: shotgun
   thedesc   = "your shotgun"
   adjective = 'your' 'my'
;
kfaChaingun: chainGun
   thedesc   = "your chain gun"
   adjective = 'your' 'my'
;
kfaRocket: rocketLauncher
   thedesc   = "your rocket launcher"
   adjective = 'your' 'my'
;
kfaPlasma: plasmaGun
   thedesc   = "your plasma gun"
   adjective = 'your' 'my'
;
kfaBfg: bfg
   thedesc   = "your bfg"
   adjective = 'your' 'my'
;
kfaSaw: chainSaw
   thedesc   = "your chain saw"
   adjective = 'your' 'my'
;
redKey: keyItem
   sdesc     = "red keycard"
   adjective = 'red'
;
blueKey: keyItem
   sdesc     = "blue keycard"
   adjective = 'blue'
;
yellowKey: keyItem
   sdesc     = "yellow keycard"
   adjective = 'yellow'
;

fuel: thing
   stock = 2000
   maxvalue = 2000
;

bullets: thing
   name = 'bullets'
   stock = 50
   maxvalue = { if (backpack.location = Me)
                   return( 400 );
                 else
                   return( 200 );
              }
;

shells: thing
   name = 'shells'
   stock = 0
   maxvalue = { if (backpack.location = Me)
                   return( 100 );
                 else
                   return( 50 );
              }
;

rockets: thing
   name = 'rockets'
   stock = 0
   maxvalue = { if (backpack.location = Me)
                   return( 100 );
                 else
                   return( 50 );
              }
;

batteries: thing
   name = 'batteries'
   stock = 0
   maxvalue = { if (backpack.location = Me)
                   return( 200 );
                 else
                   return( 100 );
              }
;

/* doors */
door1: autodoor, firedoor
   otherside = door2
   location  = tunnel
   doordest  = computing
;
door2: autodoor, firedoor
   otherside = door1
   location  = computing
   doordest  = tunnel
;
wall1: decoration                //red herring
   sdesc     = "eastern wall"
   noun      = 'wall'
   adjective = 'eastern' 'east'
   location  = escape
;
door3: walldoor, autodoor
   sdesc   = "western wall"
   thedesc = "the western wall"
   ldesc = "This wall has been scraped by flywheels, and is crumbling at the
   edges from impacts. It must be openable!"
   adjective = 'western' 'west'
   otherside = door4
   location  = escape   
   doordest  = stairways
;
door4: walldoor, autodoor
   thedesc = "wall"
   ldesc = "The back of the wall is unadorned and smooth with wear."
   otherside = door3
   location  = stairways
   doordest  = escape
;
door5: autodoor, firedoor
   otherside = door6
   location  = escape   
   doordest  = exithall
;
door6: autodoor, firedoor
   otherside = door5
   location  = exithall 
   doordest  = escape
;
door7: autodoor, firedoor
   otherside = door8
   location  = exithall 
   doordest  = exitroom  
;
door8: autodoor, firedoor
   otherside = door7
   location  = exitroom     
   doordest  = exithall
;

/* barrels */
bar1: barrel
   location = centroom
;
bar2: barrel
   location = westroom
;
bar3: barrel
   location = topright
;
bar4: barrel
   location = exithall
;
bar5: barrel
   location = sidehall2 
;

/* corpses */
body1: body
   location = 
   {  
      switch( Me.location )
      {
      case topright:
      case tunnel:
      case zigzag:
      case sidehall2:
         return( Me.location);
         break;
      default:
         return( nil );
      }
   }
   locationOK = true
;
body2: mbody
   location = 
   {  
      switch( Me.location )
      {
      case centroom:
      case vestibule:
      case topofstairs:
      case zigzag:
      case escape:
      case exithall:
         return( Me.location);
         break;
      default:
         return( nil );
      }
   }
   locationOK = true
;

/* pillars, windows, etc. */
pillar1: decoration, floatingItem
   sdesc = { if (Me.location = vestibule) "damp "; 
             else if (Me.location = westroom) "north"; "pillar"; }
   noun = 'pillar'
   adjective = 'damp' 'north'
   location = 
   {  switch( Me.location )
      {
      case topright:
      case topleft:
      case centroom:
      case startroom:
      case leftcorner:
      case westroom:
      case vestibule:
         return( Me.location);
         break;
      default:
         return( nil );
      }
   }
   locationOK = true
;
pillar2: decoration, floatingItem
   sdesc = { if (Me.location = westroom) "south"; else "dank"; "pillar"; }
   noun = 'pillar'
   adjective = 'dank' 'south'
   location = 
   {  switch( Me.location )
      {
      case westroom:
      case vestibule:
         return( Me.location );
         break;
      default:
         return( nil );
      }
   }
;
window1: decoration, floatingItem
   sdesc  = "viewport"
   noun   = 'window' 'viewport'
   plural = 'windows' 'viewports'
   location = 
   {  switch( Me.location )
      {
      case centroom:
      case topright:
      case topofstairs:
      case zigzag:
      case opening:
      case pool:
      case balcony:
         return( Me.location);
         break;
      default:
         return( nil );
      }
   }
   locationOK = true
;

table1: decoration, surface, fixeditem
   sdesc = "table"
   ldesc = "The table is a solid block of stone raised above the level of
   the floor, and not really a table at all."
   noun = 'table'
   location = topofstairs
;

alcove1: nestedroom, fixeditem 
   sdesc = "alcove"
   ldesc = "A narrow sideroom used for storing equipment."
   noun = 'alcove'
   isListed = nil
   location = hiddenhall
;

term: decoration, floatingItem
   sdesc = "computer terminal"
   ldesc = "The terminals are all dark. Alex must have disconnected them."
   noun = 'terminal' 'screen' 'computer'
   plural = 'terminals' 'screens' 'computers'
   adjective = 'computer' 
   location = { if ( Me.location = computing or compute )
                      return( Me.location );
                else  return( nil );
              } 
   locationOK = true         
;

tunn: decoration, floatingItem
   sdesc = "tunnel entrance"
   ldesc = "The entrance to the tunnel is a square stone structure, with
   stairs leading down out of sight."
   noun = 'tunnel' 'entrance' 'stairs' 'stairway'
   location = 
   {  switch( Me.location )
      {
      case centroom:
      case opening:
      case zigzag:
      case balcony:
      case pool:
         return( Me.location);
         break;
      default:
         return( nil );
      }
   }
   locationOK = true
;

acpool: decoration, floatingItem
   sdesc = "acid pool"
   ldesc = { "The pool of liquid seethes and boils. Bubbles rise to the
   surface and POP! with sluggish bursts."; 
   if (suit2.location = pool) " There seems to be a suit of armour in it.";
   "\n"; }
   noun = 'pool' 'acid'
   adjective = 'acid'
   location = 
   {  switch( Me.location )
      {
      case centroom:
      case opening:
      case zigzag:
      case balcony:
         return( Me.location);
         break;
      default:
         return( nil );
      }
   }
   locationOK = true
;

/* health & armour */
bon1: bonus
   location = startroom
;
bon2: bonus
   location = leftcorner
;
bon3: bonus
   thedesc   = "fruity bonus"
   location  = vestibule
   adjective = 'fruity'
;
bon4: bonus
   thedesc = "crunchy bonus"
   location = vestibule
   adjective = 'crunchy'
;
bon5: bonus
   thedesc = "tangy bonus"
   location = vestibule
   adjective = 'tangy'
;
bon6: bonus
   thedesc = "zesty bonus"
   location = vestibule
   adjective = 'zesty'
;
bon7: bonus
   thedesc = "concealed health bonus"
   location = passage
   adjective = 'concealed'
;
bon8: bonus
   thedesc = "exposed health bonus"
   location = passage
   adjective = 'exposed'
;
bon9: bonus
   thedesc = "wet health bonus"
   location = sidehall1
   adjective = 'wet'
;
bon10: bonus
   thedesc = "moist health bonus"
   location = sidehall1
   adjective = 'moist'
;
bon11: bonus
   location = sidehall2
;

arm1: armour   
   location = topleft
;
arm2: armour   
   location = topright
;
arm3: armour   
   thedesc = "green armour bonus"
   location = vestibule
   adjective = 'green'
;
arm4: armour   
   thedesc = "black armour bonus"
   location = vestibule
   adjective = 'black'
;
arm5: armour   
   thedesc = "firm armour bonus"
   location = topofstairs
   adjective = 'firm'  
;
arm6: armour   
   thedesc = "soft armour bonus"
   location = topofstairs
   adjective = 'soft'
;
arm7: armour   
   location = computing
;
arm8: armour   
   thedesc = "limp armour bonus"
   location = cubicle
   adjective = 'limp'
;
arm9: armour   
   thedesc = "hard armour bonus"
   location = cubicle
   adjective = 'hard'
;
arm10: armour   
   thedesc = "tame armour bonus"
   location = cubicle
   adjective = 'tame'
;
arm11: armour   
   thedesc = "wild armour bonus"
   location = cubicle
   adjective = 'wild'
;
arm12: armour   
   location = compute
;
arm13: armour   
   location = sidehall1
;
arm14: armour   
   thedesc = "filthy armour bonus"
   location = helmpas
   adjective = 'filthy'
;
arm15: armour   
   thedesc = "dirty armour bonus"
   location = helmpas
   adjective = 'dirty'
;
arm16: armour   
   thedesc = "mild-mannered armour bonus"
   location = midpas
   adjective = 'mild' 'mild-mannered'
;
arm17: armour   
   thedesc = "obscene armour bonus"
   location = midpas
   adjective = 'obscene'
;
arm18: armour   
   thedesc = "flirtatious armour bonus"
   location = midpas
   adjective = 'flirty' 'flirtatious'
;
arm19: armour   
   thedesc = "cagey armour bonus"
   location = balcony
   adjective = 'cagey'
;
arm20: armour   
   thedesc = "closed armour bonus"
   location = balcony
   adjective = 'closed'
;
arm21: armour   
   thedesc = "open armour bonus"
   location = balcony
   adjective = 'open'
;
arm22: armour   
   thedesc = "northeast armour bonus"
   location = exitroom
   adjective = 'ne' 'northeast'
;
arm23: armour   
   thedesc = "northwest armour bonus"
   location = exitroom
   adjective = 'nw' 'northwest'
;
arm24: armour   
   thedesc = "southwest armour bonus"
   location = exitroom
   adjective = 'sw' 'southwest'
;
arm25: armour   
   thedesc = "southeast armour bonus"
   location = exitroom
   adjective = 'se' 'southeast'
;

suit1: nsuit
   location = table1
;

farsuit1: distantItem, floatingItem      //view of mega-armour in acid pool
   location = 
   { 
      switch(Me.location)
      {
      case centroom:
      case zigzag:
      case opening:
         return( Me.location );
         break;
      default:
         return( nil );
      }
   }
   noun = 'thing' 'object' 'suit' 'item'
   adjective = 'blue'
   ldesc = 
   {  if (Me.location = centroom)
        "You can't make out too much from here, but it might be";
      else if (Me.location = zigzag)
        "You can see it much more clearly here, it's definitely";
      else if (Me.location = opening)
        "Yup, it's";
      " a suit of mega-armour."; 
   }
   isListed = nil
;

suit2: xsuit            //the mega-armour seen above
   location = pool
;

/* ammunition & weapons etc. */
clip1: bullClip
   location = sidehall1
;
clip2: bullClip
   location = sidehall2
;

box1: bullBox
   location = stairways
;

box2: shellBox
   location = stairways
;
box3: shellBox
   location = alcove1
;
box4: shellBox
   location = helmpas
;

shotgun1: shotgun
   thedesc = "cached shotgun"
   adjective = 'cached' 'stored' 'hidden'
   itemValue = 1
   location = alcove1
;

shel1: fourShells
   location = zigzag
;
shel2: fourShells
   location = escape
;

kit1: mediKit
   location = stairways
;
pack1: medic
   location = sidehall1
;
pack2: medic
   location = exitroom
;

/* monsters */
soldier1: soldier
   thedesc = "northern soldier"
   adjective = 'northern' 'north'
   location = vestibule
;
solClip1: bullClip
   thedesc = "northern clip"
   adjective = 'northern' 'north'
   location = soldier1
;
/* -------- */
soldier2: soldier
   thedesc = "southern soldier"
   adjective = 'southern' 'south'
   location = vestibule
;
solClip2: bullClip
   thedesc = "southern clip"
   adjective = 'southern' 'south'
   location = soldier2
;
/* --------- */
sarg1: sergeant
   thedesc = "nearest sergeant"
   adjective = 'nearest'
   otherSelf = [ dsarg1 ]
   location = topofstairs
;
sarShot1: shotgun
   thedesc = "nearest shotgun"
   adjective = 'nearest'
   location = sarg1
;
dsarg1: distantSgt
   sdesc = "sergeant at the top of the stairs"
   thedesc = "nearest sergeant"
   adjective = 'nearest'
   otherSelf = [ sarg1 ]
   location = vestibule
;
/* -------- */
sarg2: sergeant
   thedesc = "furthest sergeant"
   adjective = 'furthest'
   otherSelf = [ dsarg2 ]
   location = topofstairs
;
sarShot2: shotgun
   thedesc = "furthest shotgun"
   adjective = 'furthest'
   location = sarg2
;
dsarg2: distantSgt
   sdesc = "sergeant at the top of the stairs"
   thedesc = "furthest sergeant"
   adjective = 'furthest'
   otherSelf = [ sarg2 ]
   location = vestibule
;
/* -------- */
sarg3: sergeant
   thedesc = "left sergeant"
   adjective = 'left'
   otherSelf = [ dsarg3 dsarg3a ]
   location = computing
;
sarShot3: shotgun
   thedesc = "left shotgun"
   adjective = 'left'
   location = sarg3
;
dsarg3: distantSgt
   sdesc = "sergeant to the right"
   thedesc = "right sergeant"
   adjective = 'right'
   otherSelf = [ sarg3 dsarg3a ]
   location = compute
;
dsarg3a: distantSgt
   sdesc = "sergeant to the right"
   thedesc = "right sergeant"
   adjective = 'right'            
   otherSelf = [ sarg3 dsarg3 ]
   location = cubicle
;
/* --------- */
sarg4: sergeant
   thedesc = "right sergeant"
   adjective = 'right'
   otherSelf = [ dsarg4 dsarg4a ]
   location = computing
;
sarShot4: shotgun
   thedesc = "right shotgun"
   adjective = 'right'
   location = sarg4
;
dsarg4: distantSgt
   sdesc = "sergeant to the left"
   thedesc = "left sergeant"
   adjective = 'left'            
   otherSelf = [ sarg4 dsarg4a]
   location = compute
;
dsarg4a: distantSgt
   sdesc = "sergeant to the left"
   thedesc = "left sergeant"
   adjective = 'left'
   otherSelf = [ sarg4 dsarg4 ]
   location = cubicle
;
/* ------- */
soldier3: soldier
   thedesc = "grimy soldier"
   adjective = 'grimy'
   otherSelf = [ dsold1 ]
   location = cubicle
;
solClip5: bullClip
   thedesc = "grimy clip"
   adjective = 'grimy'
   location = soldier3
;
dsold1: distantSoldier
   sdesc = "soldier in the cubicle"
   thedesc = "grimy soldier"
   adjective = 'grimy'
   otherSelf = [ soldier3 ]
   location = computing
;
/* ------- */
soldier4: soldier
   thedesc = "fat soldier"
   adjective = 'fat'
   otherSelf = [ dsold2 ]
   location = cubicle
;
solClip6: bullClip
   thedesc = "fat guy's clip"
   adjective = 'fat' 'fat guy\'s'
   location = soldier4
;
dsold2: distantSoldier
   sdesc = "soldier in the cubicle"
   thedesc = "fat soldier"
   adjective = 'fat'
   otherSelf = [ soldier4 ]
   location = computing
;
/* -------- */
sarg5: sergeant
   sdesc = "sergeant in the dark"
   thedesc = "dark sergeant"
   adjective = 'dark'
   otherSelf = [ dsarg5 ]
   location = compute
;
sarShot5: shotgun
   thedesc = "dark shotgun"
   adjective = 'dark'
   location = sarg5
;
dsarg5: distantSgt
   sdesc = sarg5.sdesc
   thedesc = "dark sergeant"
   adjective = 'dark'
   otherSelf = [ sarg5 ]
   location = passage
;
/* ------- */
soldier5: soldier
   thedesc = "fat soldier"
   adjective = 'fat'
   otherSelf = [ dsold3 dsold4 ]
   location = passage
;
solClip7: bullClip
   thedesc = "fat guy's clip"
   adjective = 'fat' 'fat guy\'s'
   location = soldier5
;
dsold3: distantSoldier
   sdesc = "fat soldier in the passage"
   thedesc = "fat soldier"
   adjective = 'fat'
   otherSelf = [ soldier5 dsold4 ]
   location = compute
;
dsold4: distantSoldier
   sdesc = "fat soldier in the passage"
   thedesc = "fat soldier"
   adjective = 'fat'
   otherSelf = [ soldier5 dsold3 ]
   location = zigzag
;
/* ------- */
soldier6: soldier
   sdesc = "thin soldier"
   adjective = 'thin'
   otherSelf = [ dsold5 dsold6 ]
   location = zigzag
;
solClip8: bullClip
   thedesc = "thin guy's clip"
   adjective = 'thin' 'thin guy\'s'
   location = soldier6
;
dsold5: distantSoldier
   sdesc = "thin soldier"
   adjective = 'thin'
   otherSelf = [ soldier6 dsold6 ]
   location = passage
;
dsold6: distantSoldier
   sdesc = "thin soldier"
   adjective = 'thin'
   otherSelf = [ soldier6 dsold5 ]
   location = escape
;
/* -------- */
sarg6: sergeant
   sdesc = "sergeant on the zig-zag path"
   thedesc = "zigzag sergeant"
   adjective = 'zigzag' 'path'
   otherSelf = [ dsarg6 dsarg6a ]
   location = zigzag
;
sarShot6: shotgun
   thedesc = "shotgun on the path"
   adjective = 'path' 'zigzag'
   location = sarg6
;
dsarg6: distantSgt
   sdesc = sarg6.sdesc
   thedesc = "zigzag sergeant"
   adjective = 'zigzag' 'path'
   otherSelf = [ sarg6 dsarg6a ]
   location = passage
;
dsarg6a: distantSgt
   sdesc = sarg6.sdesc
   thedesc = "zigzag sergeant"
   adjective = 'zigzag' 'path'
   otherSelf = [ sarg6 dsarg6 ]
   location = escape
;
/* -------- */
sarg7: sergeant
   sdesc = "sergeant by the lamp"
   thedesc = "lamp sergeant"
   adjective = 'lamp'
   otherSelf = [ dsarg7 ]
   location = zigzag
;
sarShot7: shotgun
   thedesc = "shotgun by the lamp"
   adjective = 'lamp'
   location = sarg7
;
dsarg7: distantSgt
   sdesc = sarg7.sdesc
   thedesc = "lamp sergeant"
   adjective = 'lamp'
   otherSelf = [ sarg7 ]
   location = escape
;
/* --------- */
imp1: imp
   sdesc = { "imp"; if (exitroom.isseen) " in front of opening";
                    else " on the ledge"; }
   thedesc = "left imp"
   adjective = 'left'
   otherSelf = [ dimp1 dimp1a ]
   location = zigzag
;
dimp1: distantImp
   sdesc = imp1.sdesc
   thedesc = "left imp"
   adjective = 'left'
   otherSelf = [ imp1 dimp1a ]
   location = passage
;
dimp1a: distantImp
   sdesc = { "<<imp1.sdesc>> in zigzag room"; }
   thedesc = "left imp"
   adjective = 'left'
   otherSelf = [ imp1 dimp1 ]
   location = opening
;
/* -------- */
imp2: imp
   sdesc = { "imp"; if (exitroom.isseen) " in front of opening";
                    else " on the ledge"; }
   thedesc = "right imp"
   adjective = 'right'
   otherSelf = [ dimp2 dimp2a ]
   location = zigzag
;
dimp2: distantImp
   sdesc = imp2.sdesc
   thedesc = "right imp"
   adjective = 'right'
   otherSelf = [ imp2 dimp2a ]
   location = passage
;
dimp2a: distantImp
   sdesc = { "<<imp1.sdesc>> in zigzag room"; }
   thedesc = "right imp"
   adjective = 'right'
   otherSelf = [ imp2 dimp2 ]
   location = opening
;
/* -------- */
imp3: imp
   location = exithall
;
/* ------- */
imp4: imp
   location = exitroom
;
