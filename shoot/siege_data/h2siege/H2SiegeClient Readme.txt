Heretic II Siege v1.1 - Client Files Update
by David "The Shadowlord" Corrales
Based on Siege for HexenWorld 
by Raven 
-------------------------------------------------------------------------------------------------
Visit the Heretic II Siege web site for more information and news:
http://www.raven-games.com/siege
-------------------------------------------------------------------------------------------------

Installation:

You must have v1.0 installed before installing the v1.1 update.
Unzip the Client files into your h2siege folder with the directory structure intact.
Or you can manually move the zip file contents to their respective folders.
ie: C:\Program Files\Heretic II\h2siege

Note on server connections:

Use the H2siegeclient.bat to connect to a H2Siege server. If you don't use the bat file your game 
messages will not work correctly. When you use the H2siegeclient.bat for the 
first time a new folder called H2suser should be created in your hereticii 
directory. This will contain a new config.cfg file for H2Siege. So you will have
to edit your Hereticii settings again. This new config will help prevent binding
mix ups with other mods.
Note: If you use PingTool you don't have to use the bat file.(www.PingTool.com)
      If you use Gamespy, it will cause binding problems and your gamemsg.txt will not work correctly.

New Bindings:

bind k :Drops the Throne key
bind d :Drops current item
bind l :Lifts barrels or other objects
bind = :Cycles to next class
bind - :Cycles to previous class
bind s :say
bind t :team say
bind 3 :Succubus' Bloodfire
bind 4 :Necromancer's Plague spell
bind 7 :Wizard's Thunder spell
bind x :Status Display
bind Tab :Look around for aiming the ballista 
bind f : First Person View (Not recommended for Slow Computers)
bind r : Third Person View
bind f11: Siege help menu

You can alter these binding in the h2siege.cfg file. Use a text editor to open the file.

Taunts:
To use taunts type the following in the console:
taunt tauntname

Where tauntname is the name of the taunt wav file, with out the extension.
You can add new taunts by placing them in the h2siege/sounds/taunts folder.
The taunts must be in Mono and in wav format. All players and the server must have the same taunt files
in order to hear the taunts.

I recommend converting custom wav files to 11,025 Hz,8-bit,Mono to reduce the file size.
Look for new taunt packs at the Heretic II Siege site.

Status Display:

Status Display gives you player class information, such as class starting stats and spell 
names and spell cost. 

To display your current class information press "x" or type "stat" in console.
The first screen gives you the class's attributes and weapons. 
Pressing "stat" for a second time will display the class's offensive spells.
Pressing "stat" for a third time will give you the class's defensive spells.
Pressing "stat" a forth time will close the status display.

You can get the status display of any other class by typing the following:

stat_fighter 
stat_assassin 
stat_wizard
stat_necro
stat_cleric
stat_succubus

To cycle to the next status screen you must use the same command. Using another stat command
will close the status display. 


-------------------------------------------------------------------------------------------------
Go visit the Heretic II Siege website for information on how to play.
http://www.raven-games.com/siege
-------------------------------------------------------------------------------------------------

What's New in v2 beta:
- Added new Succubus class with new spells.
- Added customizable taunts.
- Removed cheats.
- Added barrel kill messages.
- Dropped items no longer block doors.
- Added team death limit.
- Altered some spells.
- Added Skulltrap kill messages.
- Reduce the Super Chicken's flight ability. 
- Added new icons.
- Added new cleric model.
- Added new necromancer model.
- Added new fighter skins.
- Added new wizard skins.
- Added new wizard model.
- Fix problems with torch lights.
- Altered the catapults and altered the way they can be fired.
- Added a server variable that limits client rates.
- Altered h2siege map and sgbridge map. Throne Room doors fixed.
- Added trigger_hardfall. Jumping off castle walls will result in more fall damage then normal.
- Increase limit of entity overflow message.
- Blade walking does no damage.
- Using polymorph on a player that is already a chicken will not turn them back to normal. 
- Polymorphing a Super Chicken will now turn them into a normal chicken.
- Plus may more minor fixes and improvements.

Know Bugs:
-The Flight spell still has a client prediction problem. 
-Also when in flight the player can not swim.

What's New in v1.0:
- Classes with advanced staff are the only ones who can block.
- Class movement rates are fully implemented.
- Complete set of team skins and models for each class.
- Dropping items next to walls is easier now.
- Dropped items timeout after 5 min.
- Item respawn is now on a set rate.
- Fixed the color problem with shownames.
- Fixed the light of the Doc when he is chickened.
- Added delay between lifts.
- Armor now absorbs less damage when hit my arrows.
- Added sound to backflip.
- Added new icon for flight spell and thunder spell.
- Added new flap sound when succubus glides.
- Added Class Status Display.
- Increased the cost of the Wizard's teleport spell.
- Added forced time and forced frag server variables.
- Added forced player respawn server variable.
- Added frag limit and time limit overrides in worldspawn.
- Added new Wrath of God cleric spell.
- Added new Triggers entities (See New Entities List).
- Server files now require the taunts, so that the player can use them.
- Strafe running is now the same speed as forward running. Same goes for swimming.
- Strafe jumping speed also reduced.
- When holding key your mana does not raise and your speed is reduced.
- Can now have multiple intermission points dependent on who wins (See Altered Entities List).
- Improved Imp targeting. Now will use owner as help to find its enemies.
  Owner is secondary eyes for imp.
- Super Chicken spell will not make player into normal chicken when there is not enough room.
  Player will revert to normal form at no cost.
- Barrels no longer respawn on players.
- Can no longer cast Ovum through closed doors.
- Bloodfire can now be powered up.
- Fishes now hop back in the water if they swim out.
- Fixed the bug with the catapult not always firing when player hops on launch pad.
- Altered other entities (See Altered Entities List).
- Altered the maps.
- Altered some spells.
- Added new help menu.
- Siege bindings no longer carry over into normal game bindings.
- Includes a total of 72 Taunts: Monty Python Holy Grail taunts plus a few others.
- Also includes a Grail Taunts script by HellRaiser & Airdance.

What's New in v1.1:
- Barrels will automatically go on top of catapult when you push a barrel against a catapult.
- Assassin can now creep while hiding in shadows.
- Delayed Sphere of Annihilation damage now reduces as you go farther from the center of the explosion. 
- Fixed the bug where the Defender of the Crown loses his flame sword after becoming a chicken.
- Reduced the respawn time of the rings.
- Added customizable objects (See New Entities list).
- Added customizable ambient sounds (See New Entities list).
- Monsters can now target and attack objects (See Altered Entities list).
- Made Skull Trap spell faster.
- Modified Wrath of God Spell.
- A chicken player holding the key will now run slower and will not be able to fly well. 
- Altered the player hud.
- Altered h2siege map to reduce packet size on connection.
- Added death messages to plague spell.
- In h2siege map defenders will take a large amount of damage if jump off the front wall before the chains are down.
- Remove the Superchicken's flight ability and increased jump ability.
- Defenders in chicken form can no longer pick up the Sword in the Lake.
- Modified fish's targeting ai.
- Fixed a problem in the trigger_multiple.
- Modified Ogles with my new "Ogle Follower Intelligence Code"© for Ogles Rescue and Escort missions. 
- Added new team Ogles skins.
- Modified catapult. When launching barrels, the distance from the center of the catapult isn't as big of a factor.
- Monsters will not target players when using Hide in Shadows ability in dark places (Only monsters without nightvision).
- Monsters will not target players in really dark places (Only monsters without nightvision).
- Players can no longer lift objects if the player loses an arm. 
- Fixed a problem with dispelling chickened monsters.
- Fixed under water swimming speed so that class modifiers are more effective.

-------------------------------------------------------------------------------------------------
Special Thanks to:

Raven and Mike Grummelt - Who made the original mod.
Phoebus -  for hosting the HereticII Siege site.
Drax - for the Assassin skins, alternate console background, and web site designer.
Gwynhala  - for the player models and his modeling tools.
trix and Green - for helping me with model conversions.
Wankeroo - for his help with coding questions and fixes.
Fortuna - for his anti-hack code.
JackStraw - for hosting the test server.
Monster - for Fighter skins, Necromancer skins, and team banners. Also runs Siege server.
Gunsmoke - for Wizard skins and Cleric skins.
HellRaiser & Airdance - for Grail Taunts script
And all the players who help out with the testing.
-------------------------------------------------------------------------------------------------
If you find any bugs, have a question, or a comment you can contact me at:

theshadowlord@raven-games.com
-------------------------------------------------------------------------------------------------
Disclaimer:

If this files adversely affects your, or anyone else's computer system, I do not
accept liability either in negligence or any other type. You have voluntarily 
accepted any risks of damage that may result from their use.  Any loss you suffer 
from these effects is non-recoverable from me, and this includes financial, 
economic, or consequential loss.


