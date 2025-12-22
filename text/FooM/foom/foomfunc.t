
randlist: function (thelist)
{
   local l;
   l := length (thelist);
   if (l = 0)
      return (nil);
   else
      return (thelist[rand(l)]);
}

pickobject:  function (currentroom)
{
   local objlist, theobj;
   objlist := visibleList (currentroom) +  visibleList (Me);
   if (length (objlist) = 0)
      currentroom.sdesc;
   else {
      theobj := (randlist(objlist));
      theobj.thedesc;
   };
   return (nil);
}

findobj:  function (obj, list)
{
   local l;
   l := length (list);
   if (l > 0) {
      local pointer;
      pointer := 1;
      while ((pointer <= l) and (not (list[pointer] = obj))) {
         pointer++;
      }
      if (pointer > l) 
         return (nil);
      else 
         return (pointer);
    };
}
              
/*
 *  incarm: function( amount )
 *
 *  Adds amount to the total armour, and updates global.armlev
 */
incarm: function( amount )
{
    global.armlev += amount;
    if ( global.armlev < 0 )  global.armlev := 0;
}

/*
 *  incsec: function( amount )
 *
 *  Adds amount to the total secret, and updates global.secret
 */
incsec: function( amount )
{
    global.secret += amount;
}

/*
 *  inckills: function( amount )
 *
 *  Adds amount to the total secret, and updates global.secret
 */
inckills: function()
{
    ++global.kills;
}

/*
 *  incitems: function( amount )
 *
 *  Adds amount to the total secret, and updates global.secret
 */
incitems: function( amount )
{
    global.items += amount;
}


/*
 *  incammo: function( ammunition, amount )
 *
 *  Adds amount to the stock of ammo type, and updates it.
 */
incammo: function( ammotype, amount )
{
    ammotype.stock += amount;
    if ( ammotype.stock < 0 ) ammotype.stock := 0;
    if ( ammotype.stock > ammotype.maxvalue ) 
                      ammotype.stock := ammotype.maxvalue;
/* special case for ammo exceeding max. value when picking up new supply */        
    if ( isclass(ammotype, fuel) ) ammotype.stock := 2000;
    /* never run out of chain saw fuel, or fists */
}

fighting: function( monster )
{   local theDam, youDam, armDam, hitTest;

    if ( Me.isIn(monster.location) )
    {   
       "\n \^<<monster.thedesc>>";
       theDam := rand(monster.Hurting);
       hitTest := rand(10);
       if ( hitTest > 4 )  //60% chance of being hit
       {
         youDam := rand(global.armlev/75 + 1) + 
                   4 * (global.armlev/75) - theDam;
         if (youDam >= 0)
                youDam := - 1;            //always get some damage.
         armDam := - theDam/5;
         if (global.god)
         {
             youDam := 0;                 //unless in god mode.
             armDam := 0;
         }
         " attacks, doing "; say( - youDam ); " point";
         if (youDam <> -1 ) "s"; " of damage. ";
       
         incscore( youDam );           //health affected
         incarm( armDam );               //and armour too
       }
       else " misses you.";
    }
}

attack: function( monster )
{
        initfight( monster );
        
        if ( length(monster.otherSelf) > 0)
        { local i, lim;

          lim := length(monster.otherSelf);
          i:= 1;
          while (i <= lim)
          {  
             initfight( monster.otherSelf[i] );
             ++i;
          }
        }
}

startfight: function( monster )
{       local i, lim, olist, present;

        attack( monster );
        present := [];
        olist := monster.location.contents;
        lim := length(olist);
        i := 1;
        while ( i <= lim )              //search room for enemies
        {
           if ( isclass(olist[i], enemy) ) 
           {
               present += i;
           }
           i++;
        }
        if ( length(present) > 0 )  //if any other enemies in room...
        {
           lim := length(present);
           i := 1;
           while (i <= lim)
           {   local curmon;

               curmon := olist[present[i]];
               attack( curmon );
               i++;
           }
        }
}

initfight: function( monster )
{
        if (not(monster.fight))
        {   
           setdaemon( fighting, monster );  //start continued fighting
           monster.fight := true;
        }
}

noExit: function( room )
{
        room.lift := nil;
        if (Me.location = room)
          "\nThe lift rises into the ceiling. If only you'd been faster!";
}

poolDamage: function( identifier )
{
        if (Me.location = pool)
        {
           "Ouch! This acid hurts!\n";
           incscore( -3 );
        }
}

/* --- New Verbs --- */

dikfaVerb: deepverb
    verb = 'dikfa'
    action( actor ) =
    {
        bullets.stock := bullets.maxvalue;
        shells.stock := shells.maxvalue;
        rockets.stock := rockets.maxvalue;
        batteries.stock := batteries.maxvalue;
        global.armlev := 200;
        kfaSaw.moveInto( Me );
        kfaShotgun.moveInto( Me );
        kfaChaingun.moveInto( Me );
        kfaRocket.moveInto( Me );
        kfaPlasma.moveInto( Me );
        kfaBfg.moveInto( Me );
        redKey.moveInto( Me );
        blueKey.moveInto( Me );
        yellowKey.moveInto( Me );
        "Very happy ammo included\n";
    }
;

difaVerb: deepverb
    verb = 'difa'
    action( actor ) =
    {
        bullets.stock := bullets.maxvalue;
        shells.stock := shells.maxvalue;
        rockets.stock := rockets.maxvalue;
        batteries.stock := batteries.maxvalue;
        global.armlev := 200;
        kfaSaw.moveInto( Me );
        kfaShotgun.moveInto( Me );
        kfaChaingun.moveInto( Me );
        kfaRocket.moveInto( Me );
        kfaPlasma.moveInto( Me );
        kfaBfg.moveInto( Me );
        "Happy ammo included\n";
    }
;

didqdVerb: deepverb
    verb = 'didqd'
    action( actor ) =
    {
        if (global.god)
        {   
            "Back to normal mode\n";
            global.god := nil;
        }
        else
        {
            "Degreelessness Mode on\n";
            global.god := true;
            global.score := 100;
            global.armlev := 0;
        }
    }
;

didtVerb: deepverb
    verb = 'didt'
    action( actor ) =
    {
       if (global.mapcount = 0)
       {  
          "OK, get out your map and draw in the rooms you haven't seen
          yet.";
          ++global.mapcount;
       }
       else if (global.mapcount = 1)
       {
          "Now draw in all the objects and monsters too.";
          ++global.mapcount;
       }
       else
       {
          global.mapcount := 0;
          "Now you'd better erase all those rooms and monsters from the
          map.";
       }
    }
;

dichVerb: deepverb
    verb = 'dichoppers'
    action( actor ) =
    {
        "Chainsaw! Let's go find some meat.\n";
        kfaSaw.moveInto( Me );
        Me.usedGun := kfaSaw;
    }
;

dimpVerb: deepverb
    verb = 'dimypos'
    action( actor ) =
    {
        "You're in "; Me.location.sdesc; " ! Why don't you read the
        status line ?\n";
    }
;

digenVerb: deepverb
    verb = 'dipispopd' 'diclev' 'dibehold' 'diclip'
    action( actor ) =
    {
       "I'm *not* going to implement this cheat. Go away!";
    }
;

idVerb: deepverb
    verb = 'idkfa' 'iddqd' 'idfa' 'idbehold' 'idmypos' 'idchoppers' 'iddt'
           'idpispopd' 'idmypos' 'idclev' 'idclip'
    action( actor ) =
    {
       "This game wasn't made by id Software... it was made by di Software";
    }
;


helpVerb: deepverb
      verb = 'help' 'hint'
      action( actor ) =
      {
         "You're playing \(FooM\), the shoot'em-up text adventure.\nWritten 
         by Piers Johnson for di Software (which is Piers Johnson).\bImportant
         commands are:\n\(SHOOT\) - randomly attack objects in the current 
         room (or which are visible from the current room) with the weapon you are
         using at the time.\n\(SHOOT [object(s)]\) - attack one or more things
         with your wielded weapon. e.g. \"shoot soldier\", \"shoot imps\", or
         for general carnage: \"shoot enemies\". Try shooting a barrel! 
         Especially if there are monsters in the room!\n\(SHOOT [object(s)]
         with [weapon]\) - Attack things with a weapon other than that you are
         wielding. Switches back to wielded weapon after attack.\n\(GET\) - can
         be used with single or multiple objects to increase your armaments or 
         inventory.\n\(SCORE\) - displays your current health and armour 
         levels, as well as how much ammunition you are carrying (it also 
         doesn't cost you a turn). Your health level appears at all times on 
         the right of the Status Line.\n\(I or INVENTORY\) - tells you what
         you're carrying. Most objects in \(FooM\) are used as soon as you pick
         them up (health and armour bonuses, ammunition clips, etc.), so they
         don't appear in your inventory. What will appear there are any weapons 
         you have, door keys, your lamp etc.\bTry using the \(FooM\) cheat 
         codes for added pleasure :)\bThe map doesn't appear on screen, so <TAB> 
         doesn't do anything: use a piece of paper.\nSimilarly, the Function
         Keys <F1> - <F12> aren't implemented, because there's little need for 
         gamma correction, and the game save and load, etc. functions are 
         supplied by the commands \(SAVE\), \(RESTORE\) and \(RESTART\).\n
         \(FooM\) is not really copyright 1995, di Software, as it is all 
         remarkably like another game...\n";
      }
;

diagVerb: sysverb
    verb = 'diagnose'
    action( actor ) =
    {
        if (global.score<100)
        {
          if (global.score <= 10)
             "\(You can hardly see for all the blood on your face\)";
          else if (global.score <=30)
             "\(You have a bloody nose and forehead, and you're spitting
             blood\)";
          else if (global.score <=50)
             "Your sides hurt, your body aches, your wounds are smarting.";
          else if (global.score <=75)
             "These wounds are starting to hurt.";
          else "You have a few cuts and bruises.";
        }     
        else "You haven't a scratch.";
        abort;
    }
;
