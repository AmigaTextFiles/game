void () fire_touchalb =
{
T_Damage (other,self,self, level);
remove(self);
};

void () magiczahl =
{
local string alb;
//centerprint(self,"Haaaa!!! the Magic 42\n");
   alb = ftos(playerlevel);
   sprint(self,"Level:");
   sprint(self,alb);
   sprint(self," Exp:");
   alb = ftos(playerexp);
   sprint(self,alb);
   sprint(self,"\n");
};

void (entity targ) ALBDamage =
{
  if (targ.classname == "monster_dog")
  {
    playerexp = playerexp + 1;
    return;
  }
  if (targ.classname == "monster_army")
  {
    playerexp = playerexp + 2;
    return;
  }
  if (targ.classname == "monster_zombie")
  {
    playerexp = playerexp + 10;
    return;
  }
  if (targ.classname == "monster_wizard")
  {
    playerexp = playerexp + 5;
    return;
  }
  if (targ.classname == "monster_enforcer")
  {
    playerexp = playerexp + 10;
    return;
  }
  if (targ.classname == "monster_knight")
  {
    playerexp = playerexp + 5;
    return;
  }
  if (targ.classname == "monster_hell_knight")
  {
    playerexp = playerexp + 10;
    return;
  }
  if (targ.classname == "monster_ogre")
  {
    playerexp = playerexp + 20;
    return;
  }
  if (targ.classname == "monster_demon1")
  {
    playerexp = playerexp + 20;
    return;
  }
  if (targ.classname == "monster_fish")
  {
    playerexp = playerexp + 5;
    return;
  }
  if (targ.classname == "monster_shambler")
  {
    playerexp = playerexp + 50;
    return;
  }
  if (targ.classname == "monster_shalrath")
  {
    playerexp = playerexp + 100;
    return;
  }
  if (targ.classname == "monster_tarbaby")
  {
    playerexp = playerexp + 1000;
    return;
  }
  if (targ.classname == "monster_oldone")
  {
    playerexp = playerexp + 10000;
    return;
  }
};

void (entity attacker) CheckLevelUp =
{
local float oldlevel;
local string nextlevel;
local string alb1;
local string alb2;
oldlevel = playerlevel;
  if (playerexp>=100)
  {
    playerlevel = 1;
    playerschaden = 10;
    attacker.max_health = 110;
    nextlevel = "200";
  }
  if (playerexp>=200)
  {
    playerlevel = 2;
    playerschaden = 20;
    attacker.max_health = 125;
    nextlevel = "400";
  }
  if (playerexp>=400)
  {
    playerlevel = 3;
    playerschaden = 30;
    attacker.max_health = 140;
    nextlevel="750";
  }
  if (playerexp>=750)
  {
    playerlevel = 4;
    playerschaden = 40;
    attacker.max_health = 160;
    nextlevel = "1300";
  }
  if (playerexp>=1300)
  {
    playerlevel = 5;
    playerschaden = 50;
    attacker.max_health = 175;
    nextlevel = "2000";
  }
  if (playerexp>=2000)
  {
    playerlevel = 6;
    playerschaden = 60;
    attacker.max_health = 190;
    nextlevel = "3300";
  }
  if (playerexp>=3300)
  {
    playerlevel = 7;
    playerschaden = 70;
    attacker.max_health = 220;
    nextlevel = "4500";
  }
  if (playerexp>=4500)
  {
    playerlevel = 8;
    playerschaden = 80;
    attacker.max_health = 250;
    nextlevel = "Last Level reached";
  }
  if (oldlevel != playerlevel)
  {
    sprint(attacker,"You have reached Level ");
    alb1 = ftos(playerlevel);
    sprint(attacker,alb1);
    sprint(attacker,"\n the next Level on ");
    sprint(attacker,nextlevel);
    sprint(attacker,"\n");
  }
};

