/*  Location classes */

class outsideroom:  room
   outside = true
   floorDesc = 'ground'
   exploded = nil         
;

class insideroom:   room
   inside = true
   floorDesc = 'floor'
   exploded = nil         
;
class gruesome: darkroom
   inside = true
   floorDesc = 'floor'
   exploded = nil         
;

/*  Item classes */

class enemy: Actor
   stamina = 2                //default is basic soldier
   sdesc = "soldier"
   ldesc = "He was once one of your comrades, but now this Former Human is
   a zombie who serves the demonic forces which have invaded the station.\n"
   noun = 'enemy'
   adjective = 'enemy'
   plural = 'enemies'
   otherSelf = []             //not every enemy can be shot from another room
   Hurting = 5                //not very dangerous enemy
   isdead = nil               //alive before you get there...
   fight = nil                //not fighting you yet...
    verDoAttackWith( actor, io ) = {}
    verDoAttack( actor ) = {}
    doAttackWith( actor, io ) =
    {   
        " \(SPLAT!\)";
        if ( isclass( io, weapon ) )  
        {
           "\n";
           self.stamina -= (io.damage * io.fireRate)/3;
        }
        else
           self.stamina -= (io.barrelDamage)*2/3;
        startfight( self );
        if ( length(self.otherSelf) > 0)
        { local i, lim;

          lim := length(self.otherSelf);
          i:= 1;
          while (i <= lim)
          {  
             self.otherSelf[i].stamina := self.stamina;  //update otherSelf
             initfight( self.otherSelf[i] );   //no recursive fights...
             ++i;
          }
        }
        if (self.stamina <= 0)        // monster dies...
        {
          local itemRem, thisItem;
          
          inckills();                //increment no. killed.
          if (isclass(self, distantEnemy) ) //distant enemy will drop its
          {                                 //possessions in its own room
             local i, lim, found, closeSelf;
             
             found := nil;                 //search list of selves for close
             lim := length(self.otherSelf); //self
             i:= 1;
             while ((i <= lim) and (found = nil) )
             { 
                 if (not (isclass(self.otherSelf[i], distantEnemy) ) )
                 {
                    found := true;
                    closeSelf := self.otherSelf[i];
                 }
                 ++i;
             }
             
             itemRem := closeSelf.contents;
             while (car( itemRem ))
             {
               thisItem := car( itemRem );
               if ( not thisItem.isworn )
                   thisItem.moveInto( closeSelf.location );
               itemRem := cdr( itemRem );
             }
          }
          else                          //whereas a close enemy will drop
          {                             //its possessions in the room you
             itemRem := self.contents;  //are in.
             while (car( itemRem ))     
             {
               thisItem := car( itemRem );
               if ( not thisItem.isworn )
                   thisItem.moveInto( self.location );
               itemRem := cdr( itemRem );
             }
          }
          self.moveInto( nil );
          self.isdead := true;
          if ( isclass( io, weapon ) )
             "\(\^<<self.thedesc>> dies from the damage you inflicted.\)\b";
          else
             "\(\ dies in the explosion.\)\b";
          remdaemon( fighting, self );

          if (length(self.otherSelf) > 0)
          {  local lim, i;
             
             lim := length(self.otherSelf);
             i:= 1;
             while (i <= lim)
             {
               self.otherSelf[i].isdead := true;   //other copies of self die
               self.otherSelf[i].moveInto( nil );  //and disappear from game
               remdaemon( fighting, self );        //stop fights
               ++i;
             }
          }
        }
    }
    doAttack( actor ) =
    {
        "( with <<Me.usedGun.thedesc>> )\n";
        Me.usedGun.verIoAttackWith( actor );
        Me.usedGun.ioAttackWith( actor, self );
    }
    ioDefault( actor, prep ) =
    {
        return( Me.usedGun );
    }                         
;

class distantEnemy: distantItem, enemy
                                     //same as enemy except for having
;                                    //distantItem attributes.

class soldier: enemy  //same as default enemy
   noun = 'soldier' 'human' 'zombie'
   adjective = 'former' 'zombie'
   plural = 'soldiers' 'zombies' 'humans'
;

class distantSoldier: soldier, distantEnemy  
;

class sergeant: enemy
   sdesc = "sergeant"
   ldesc = "He was once one of your commanders, but now this Former Sergeant
   is a zombie who fights for the invading demonic forces. He carries a mean
   shotgun, so watch out!\n"
   noun = 'human' 'zombie' 'sargeant' 'sergeant' 'sgt'
   adjective = 'former' 'zombie'
   plural = 'zombies' 'humans' 'sergeants' 'sargeants' 'sgts'
   stamina = 5
   Hurting = 10
;

class distantSgt: distantEnemy, sergeant
;

class imp: enemy
   sdesc = "imp"
   ldesc = "The imps are the most numerous of the invaders. They cast balls
   of fire at you from a distance, and rip you with their talons when they
   get close to you.\n"
   noun = 'imp' 'demon' 'daemon'
   adjective = 'demonic'        
   plural = 'imps' 'demons'
   stamina = 7
   Hurting = 18
;

class distantImp: distantEnemy, imp
;

class bonus:  thing
   sdesc = "health bonus"
   ldesc = "A standard health bonus, it will revitalise you!"
   noun = 'bonus' 'health'
   plural = 'bonuses'
   adjective = 'health'
   bulk = 0
   value = 1
    verDoTake(actor) =
    {
        pass verDoTake;
    }
    doTake(actor) =
    {
        incscore(self.value);
        self.moveInto(nil);
        "Your health just improved!\n";  
    }
;

class medic: bonus
   sdesc = "stim pack"
   ldesc = "A stimulation pack, which will boost your health if you are
   injured."
   noun = 'kit' 'medikit' 'medic' 'pack' 'stimpack'
   plural = 'kits' 'packs'
   adjective = 'medical' 'stim' 'medi' 'stimulation'
   value = 10         // stim-pack boost default
   maxvalue = 100     // max. boost for medical kits
    verDoTake(actor) =
    {
      if ( global.score >= self.maxvalue)  
        "Your health is already quite good enough.\n";
      pass verDoTake;
    }
    doTake(actor) =
    {
        incscore(self.value);
        if ( global.score > self.maxvalue )
           global.score := self.maxvalue; // special case for exceding max. 
        self.moveInto(nil);               // health when picking up bonus
        "Your health just improved!\n";
    }
;

class mediKit: medic
   sdesc = "medi kit"
   ldesc = "A medical pack, which will significantly boost your health if
   you are injured."
   value = 25
;

class armour:  thing
   sdesc = "armour bonus"
   adesc = "an armour bonus"
   ldesc = "A boost for your armour."
   noun = 'bonus' 'armour'
   plural = 'bonuses'
   adjective = 'armour'
   bulk = 0
   value = 1
    verDoTake(actor) =
    {
        pass verDoTake;
    }
    doTake(actor) =
    {
        incarm(self.value);
        self.moveInto(nil);                //object disappears
        "Your armour just improved!\n";
    }
;

class nsuit: thing
   sdesc = "suit of green armour"
   adesc = "a suit of green armour"
   ldesc = "A standard suit of space marine armour."
   noun = 'suit' 'armour'
   plural = 'suits'
   adjective = 'green'
   bulk = 0
   value = 100
   itemValue = 1
    verDoTake(actor) =
    {
        if ( global.armlev >= self.value )    
           "Your armour is already quite good enough.\n"; 
        pass verDoTake;
    }                                         //only pick up suit if armour
    doTake(actor) =                           //level is below suit value
    {
        global.armlev := self.value;
        self.moveInto(nil);
        incitems(self.itemValue);
        "Your armour just improved!\n";
        if (Me.location = pool)
           incscore ( - 4);
    }
;

class xsuit: nsuit
   sdesc = "suit of blue armour"
   adesc = "a suit of blue armour"
   ldesc = "A suit of space marine mega-armour."
   adjective = 'blue'
   value = 200
   itemValue = 1
;

class barrel:  decoration
   sdesc = "barrel"
   ldesc = "A leaky barrel containing explosive material."
   noun  = 'barrel'
   plural = 'barrels'
   isListed = nil
   barrelDamage = 0
    verDoAttackWith( actor, io ) = {}
    doAttackWith( actor, io ) =
    {  local youDam, armDam, olist, present, lim, i;
       
       self.barrelDamage := rand(40);
       youDam := rand(global.armlev/75 + 1) 
                 + 4 * (global.armlev/75) - self.barrelDamage;
       armDam := - self.barrelDamage/4;
       "\(KABOOM!\)\nThe barrel explodes";

       present := [];
       olist := Me.location.contents;

       lim := length(olist);
       i := 1;
       while ( i <= lim )              //search room for barrels & enemies
       {
          if (( isclass(olist[i], enemy)) or ( isclass(olist[i], barrel)) 
                 and ( not(olist[i] = self)) )
          {
              present += i;
          }
          i++;
       }

       if ( length(present) > 0 )
       {  local j, no, chosen;         //if there are some, randomly attack
                                       //a random number of them.
          chosen := [];                   //chosen is a list of booleans
          lim := length(present);         //the same length (theoretically)
          i := 1;                         //as present
          while (i<=lim)
          {
             chosen += nil; i++;    //clear chosen
          }
          no := rand(lim); i := 1;
          while (i <= no)              
          {
             do
                j := rand(lim); 
             while ( chosen[j] )       //if not chosen, use it
             chosen[j] := true;
             if (olist[present[j]].location) //if not now dead, attack it
             {   
                ", and <<olist[present[j]].thedesc>>";
                if ( isclass( olist[present[j]], enemy ) )
                {
                   olist[present[j]].doAttackWith( actor, self );
                   if (olist[present[j]].location)
                      "\ is injured in the blast.\n";
                }
                else
                {
                   olist[present[j]].moveInto(nil);
                   " explodes with it. \(KABOOM!\) Burning oil fills the 
                   air.\n";
                }
             }
             i++;
          }
       }
       youDam /= (1 + 2*length(present));
       armDam /= (1 + 2*length(present));
       if ( youDam >= 0 ) youDam := -1;
       if ( armDam >= 0 ) armDam := -1;
       if ( isclass(Me.usedGun, fists))
       {
         if (youDam < 20) youDam := 20;
       }
       if ((global.god) or (not(Me.isIn(self.location))))
       {                  //in god mode, nothing hurts you.
          youDam := 0;
          armDam := 0;
       }
       if (length(present) < 1) ". ";
       if (not(Me.isIn(self.location)))
       {
          "%You% suffer "; say( - youDam ); " point";
          if ( youDam <> -1) "s"; " of damage."; 
          if (length(present) < 1)
             "\nYou won't be doing \(that\) again, I should imagine.";
          "\b";
       }
       incscore( youDam );             //health affected
       incarm( armDam );               //and armour too
       self.location.exploded := true; //set flag to change room desc'n
       self.location.lookAround(true); //display new description verbosely
       self.moveInto(nil);             //exploded barrels do not appear
    }  
    verDoAttack( actor ) = {}
    doAttack( actor ) =
    {
        "( with <<Me.usedGun.thedesc>> )\b";
        Me.usedGun.verIoAttackWith( actor );
        Me.usedGun.ioAttackWith( actor, self );
    }
    ioDefault( actor, prep ) =
    {
        return( Me.usedGun );
    }                         
;

class body:  decoration, floatingItem
   sdesc     = "body"
   thedesc   = "dead soldier"
   ldesc     = "The mangled corpse of a dead soldier."
   noun      = 'body' 'corpse' 'soldier'
   adjective = 'dead'
   isListed  = nil
;

class mbody: decoration, floatingItem
   sdesc = "body"
   thedesc = "exploded ribcage of a body"
   noun = 'body' 'corpse' 'pulp' 'ribs' 'ribcage'
   adjective = 'unknown' 'unrecognisable'
   ldesc = "The bloody, pulpy mess that was once a person."
   isListed = nil
;

class autodoor: doorway
    destination =
    {
        if ( self.isopen ) return( self.doordest );
        else if ( not self.islocked and not self.noAutoOpen )
        {
            self.isopen := true;
            notify( self, &shut, 2 );
            if ( self.otherside ) 
            {
               self.otherside.isopen := true;
               notify( self.otherside, &shut, 2 );
            }
            "(Opening << self.thedesc >>)\n";
            return( self.doordest );
        }
        else
        {
            "%You%'ll have to open << self.thedesc >> first. ";
            setit( self );
            return( nil );
        }
    }
    doOpen( actor ) =
    {
        "Opened. ";
        self.isopen := true;
        notify( self, &shut, 2 );
        if ( self.otherside ) 
        {
           self.otherside.isopen := true;
           notify( self.otherside, &shut, 2 );
        }

    }
    shut =
    {
        self.isopen := nil;
        if (Me.isIn(self.location) )
             "\bThe <<self.sdesc>> closes with a bang.\n";
    }
;

class firedoor: autodoor
   sdesc       = "door"
   thedesc     = "metal fire door"
   noun        = 'door'
   plural      = 'doors'
   adjective   = 'metal' 'fire'
;

class walldoor: autodoor
   sdesc     = "wall"
   thedesc   = "secret door in the wall"
   noun      = 'wall' 'secret door'
   adjective = 'moving' 'secret' 'hidden'
;

class levelSwitch: switchItem
    sdesc = "switch"
    noun = 'switch' 'lever' 
    adjective = 'level'
    verDoFlip( actor ) = {}
    doFlip( actor ) = { self.doSwitch( actor ); }
    verDoPush( actor ) = {}
    doPush( actor ) = { self.doSwitch( actor ); }
    verDoPull( actor ) = {}
    doPull( actor ) = { self.doSwitch( actor ); }
    doSwitch( actor ) =
    {
        self.isActive := not self.isActive;
        if ( self.isActive ) 
            self.doEndlevel( actor );
    }
    doTurnon( actor ) =
    {
        self.isActive := true;
        self.doEndlevel( actor );
    }
    doEndlevel( actor ) =
    {
        Me.location := ending;
        "Hangar Entrance Complete.\b";
        scoreRank(); "\b";
        "KILLS:\ \ \ "; say( global.kills*100/17 ); " % ";
        "ITEMS:\ \ \ "; say( global.items*100/3 ); " % ";
        "SECRETS: "; say( global.secret ); " % \b You have finished the first
        level of FooM ! Congratulations.\nThe shareware version of FooM is
        just this level.\nIf you want more exciting levels of.. blah, blah,
        blah,... \b< You can RESTORE, RESTART or QUIT >";
        
        abort;
    }
;

class weapon: item
    takedesc = "Click, clunk." //default of shotgun take.
    held = kfaPistol           // default of pistol
    itemValue = 0              // not all weapons are important items
    verDoTake(actor) =
    {
        if ((self.ammotype.stock = self.ammotype.maxvalue) and
             (self.held.location = Me) )
            "%You% don't need another one of those. "; //check ammo supply
        pass verDoTake;
    }
    doTake( actor ) =                     //redefine doTake for this class 
    {
       incammo(self.ammotype, self.load); //increment ammunition with 
       if (self.held.location = Me)       //that already in new gun.
       {                              //check to see if this weapon
          self.moveInto( nil );       //already in inventory
          "\(<<self.takedesc>>\)";
       }
       else
       {
          self.moveInto( nil );
          self.held.moveInto( Me );
          "\(<<self.takedesc>>\)";
       }
       incitems(self.itemValue);               //important weapon?
       if ( (self.rank > Me.usedGun.rank) or 
             (isclass(self, chainSaw)) )     //automatically use better
               Me.usedGun := self.held;      //weapon or chain saw
    }
    verIoAttackWith( actor ) = 
    {                                  //if 'use' an empty gun, then try 
        if (self.ammotype.stock < 1)   //to shoot enemies with it.
        {  local i, lim, foundGun, Rank; 
        
           "You're out of ammo for that gun now.\n Switching to ";
           Rank := 0;
           foundGun := nil;
           lim := length(Me.contents);          //search inventory for other
           i := 1;                              //weapons with ammo, and use
           while (i <= lim)                     //the best you have.
           {
              if (isclass(Me.contents[i], weapon) ) 
              {
                if ( (Me.contents[i].ammotype.stock > 0) and 
                     (Me.contents[i].rank > Rank) )
                {
                 foundGun := Me.contents[i];
                 Rank := Me.contents[i].rank;
                }
              }
              ++i;
           }
           Me.usedGun := foundGun;
           "<<foundGun.sdesc>>.\n";
        }
        
    }
    ioAttackWith( actor, dobj ) =
    {   
      if ( ( (isclass( self, fists)) or (isclass( self, chainSaw)) ) 
                         and (isclass( dobj, distantEnemy)) )
         "\^<<dobj.thedesc>> is too far away.";
      else
      {  
        if (isclass( self, chainSaw))
           "\(WHIRRR GRIND CHOP\) ";
        else if (isclass( self, fists))
           "\(THUNK THUNK CRUNCH\) ";
        else  "\(BLAM BLAM BLAM\) ";
        incammo( self.ammotype, - self.fireRate );
        dobj.doAttackWith( actor, self );
      }
    }
    verdoDrop( actor ) =       // don't let player drop weapons
    {                                   
       "%You% %do%n't want to drop %your% weapons!\n";
    }   
    verDoWield( actor ) =
    {
        if ( self = Me.usedGun )
        {
            "%You're% already wielding "; self.thedesc; "! ";
        }
        else if ( not actor.isCarrying( self ))
        {
            "%You% %do%n't have "; self.thedesc; ". ";
        }
        else if (self.ammotype.stock < 1)
        {  
           caps(); self.thedesc; "has no ammunition.\n";
        }
    }
    doWield( actor ) =
    {
        "Okay, %you're% now wielding "; self.thedesc; ". ";
        Me.usedGun := self;
    }
;

class pistol: weapon
   takedesc = " "
   sdesc = "pistol"
   ldesc = "Your trusty standard issue Marine's pistol is smooth and easy to
   wield for long periods of time. You've been through a lot together."
   noun = 'pistol' 'gun'
   ammotype =  bullets
   fireRate = 3
   load = 0
   damage = 2
   rank = 2
;

class shotgun: weapon
   held = kfaShotgun
   sdesc = "pump-action shotgun"
   ldesc = "This gun really packs a punch! One shell from this instrument is
   easily enough to finish off any marine."
   noun = 'shotgun' 'gun'
   plural = 'shotguns'
   adjective = 'pump-action'
   ammotype = shells
   fireRate = 2
   load = 4
   damage = 8
   rank = 3
;
class chainGun: weapon
   takedesc = "Alright! A chain gun!"
   held = kfaChaingun
   sdesc = "multi-barrel chain gun"
   ldesc = "This hefty machine gun fires huge numbers of rounds at your
   adversaries through it's rotating barrels, and can wipe out a roomful
   of people in an instant."
   noun = 'chain gun' 'chaingun' 'machinegun' 'machine gun' 'gun'
   adjective = 'chain' 'machine' 'big'
   ammotype = bullets
   fireRate = 10
   load = 50
   damage = 7
   rank = 4
;

class rocketLauncher: weapon
   takedesc = "You got the rocket launcher!"
   held = kfaRocket
   sdesc = "rocket launcher"
   ldesc = "The rocket launcher is your enemies' worst nightmare! The
   carnage this baby can produce is truly formidable. Only the BFG can
   out-perform this weapon."
   noun = 'launcher' 'rocket' 'rocketlauncher' 'bazooka' 'gun'
   adjective = 'rocket'               
   ammotype = rockets
   fireRate = 1 
   load = 10
   damage = 40
   rank = 5
;

class plasmaGun: weapon
   takedesc = "You have a plasma gun."
   held = kfaPlasma
   sdesc = "plasma gun"
   ldesc = "The fast-shooting but energy-hungry plasma gun is a match for all
   but the biggest opponents."
   noun = 'plasmagun' 'plasma gun' 'gun'
   adjective = 'plasma'
   ammotype = batteries
   fireRate = 20
   load = 50
   damage = 10
   rank = 6
;

class bfg: weapon
   takedesc = "Alright! You've got the BFG!"
   held = kfaBfg
   sdesc = "bfg"
   ldesc = "The bfg is the ultimate in personal military hardware - it will
   shoot anything in sight in one blast, it's computer guidance system
   searching the area for enemy lifeforms."
   noun = 'bfg' 'gun'
   adjective = 'bfg'
   ammotype = batteries
   fireRate = 35
   load = 100
   damage = 20
   rank = 7
;

class chainSaw: weapon
   held = kfaSaw
   sdesc = "chain saw"
   ldesc = "Chain saw! Let's go find some meat!"
   takedesc = self.ldesc
   noun = 'chainsaw' 'saw'
   adjective = 'chain'
   ammotype = fuel
   fireRate = 50
   load = 0
   damage = 75
   rank = 1
;

class fists: weapon
   takedesc = " "
   held = kfaFists
   sdesc = "fists"
   ldesc = "Your hands are killing machines.\n"
   thedesc = "your bare hands"
   noun = 'fists'
   ammotype = fuel
   fireRate = 2
   load = 0
   damage = 2
   rank = 1
    verDoWield( actor ) =
    {
        if ( self = Me.usedGun )
        {
            "%You're% already using "; self.thedesc; "! ";
        }
    }
    doWield( actor ) =
    {
        "Okay, %you're% now using "; self.thedesc; ". ";
        Me.usedGun := self;
    }
;
   
class ammunition: item
    ammotype = bullets       //default ammo is bullets, modified by classes
    bulk = 0                 //below.
    verDoTake(actor) =       
    {
        if ( self.ammotype.stock >= self.ammotype.maxvalue)  
        {
           "You already have quite enough ";
           say( self.ammotype.name ); ".\n";
        }
        pass verDoTake;
    }
    doTake(actor) =
    {
       incammo( self.ammotype, self.value);
       self.moveInto(nil);
       "You just increased you ammunition supply!\n";
    }
;


class bullClip: ammunition
   sdesc = "clip of bullets"
   ldesc = "A clip of ten bullets."
   noun = 'clip'
   plural = 'clips' 'ammo' 'ammunition' 'bullets'
   adjective = 'ammo' 'ammunition' 'bullet'
   value = 10
;

class bullBox: ammunition
   sdesc = "box of bullets"
   ldesc = "A box packed full with 100 bullets!"
   noun = 'box'
   plural = 'boxes' 'ammo' 'ammunition' 'bullets'
   adjective = 'ammo' 'ammunition' 'bullet'
   value = 100
;

class fourShells: ammunition
   sdesc = "pile of shotgun shells"
   ldesc = "Four shells for your shotgun."
   noun = 'shell' 'pile'
   plural = 'shells' 'ammo' 'ammunition'
   adjective = 'shotgun'
   ammotype = shells
   value = 4
;

class shellBox: ammunition
   sdesc = "box of shotgun shells"
   ldesc = "A box filled with fifty shotgun shells!"
   noun = 'box'
   plural = 'boxes' 'ammo' 'ammunition' 'shells'
   adjective = 'ammo' 'ammunition' 'shotgun' 'shell'
   bulk = 0
   ammotype = shells
   value = 8
;

class oneRocket: ammunition
   sdesc = "rocket"
   ldesc = "A rocket for the standard-issue rocket launcher."
   noun = 'rocket'
   plural = 'rockets' 'ammo' 'ammunition'
   adjective = 'ammo' 'ammunition'
   ammotype = shells
   value = 1
;

class someRockets: ammunition
   sdesc = "crate of rockets"
   ldesc = "A crate of rockets for the standard-issue rocket launcher."
   noun = 'rocket' 'box'
   plural = 'rockets' 'ammo' 'ammunition'
   adjective = 'ammo' 'ammunition' 'rocket'
   ammotype = shells
   value = 8
;

class batPack: ammunition
   sdesc = "battery pack"
   ldesc = "A standard battery pack for powering plasma guns and bfgs!"
   noun = 'battery' 'pack'
   plural = 'batteries' 'packs' 'ammo' 'ammunition'
   adjective = 'battery'
   ammotype = batteries
   value = 25
;
