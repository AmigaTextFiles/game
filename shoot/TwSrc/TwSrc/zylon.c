            #include "g_local.h" 
            //====================================================== 
            //============= ZYLON GAS GRENADES ===================== 
            //====================================================== 
            //====================================================== 
            void Zylon_Touch(edict_t *Zylon, edict_t *target, cplane_t *plane, 
            csurface_t *surf) { 
            vec3_t dir={0,0,0}; 
            Zylon->enemy=target; 
            if (target->takedamage) 
            T_Damage(target, // entity which touched the gas cloud.. 
            Zylon, // this entity 
            Zylon->owner, // the grenades owner.. 
            dir, // not needed.. 
            Zylon->s.origin,// location in world where touch occurred. 
            plane->normal, // not needed... 
            15, // deduct 20 health units per gas cloud touch!! 
            0, // no knockback force 
            0, // no damage radius 
            MOD_ZYLON_GAS );// for client obituaries.. 
            G_FreeEdict(Zylon); // free up this cloud upon touch.. 
            } 
            //====================================================== 
            void Generate_Zylon_Gas(edict_t *ent, vec3_t last_angles) { 
            edict_t *Zylon; 
            int x,y; 
            Zylon = G_Spawn(); 
            Zylon->classname = "Zylon"; 
            Zylon->owner = ent->owner; // owner is the grenade.. 
            // player is grenade's owner! 
            VectorCopy (ent->s.origin, Zylon->s.origin); 
            x = (random()>0.5?-1:1); 
            y = (random()>0.5?-1:1); 
            Zylon->s.origin[0] += (random()*20+1)*x; 
            Zylon->s.origin[1] += (random()*20+1)*y; 
            Zylon->s.origin[2] += 8; 
            VectorCopy (ent->s.old_origin, Zylon->s.old_origin); 
            VectorClear(Zylon->s.angles); 
            Zylon->velocity[2] = (random()*40)+40; 
            Zylon->velocity[1] = ((int)((random()*40)+20+last_angles[1])%60)*y; 
            Zylon->velocity[0] = ((int)((random()*40)+20+last_angles[0])%60)*x; 
            VectorCopy(Zylon->velocity, last_angles); 
            Zylon->movetype = MOVETYPE_FLY; // clouds float gently around.. 
            Zylon->solid = SOLID_BBOX; // enable touch detection.. 
            Zylon->s.renderfx = RF_SHELL_GREEN; // gas clouds have green glow.. 
            Zylon->s.effects = EF_COLOR_SHELL; // change this to see what you 
            VectorSet(Zylon->mins, -10, -10, -10); // size of bbox for touch 
            VectorSet(Zylon->maxs, 10, 10, 10); // size of bbox for touch 
            Zylon->s.modelindex = gi.modelindex("sprites/s_explod.sp2"); 
            Zylon->touch=Zylon_Touch; // Touch detection function. 
            Zylon->nextthink = level.time+10; 
            Zylon->think=G_FreeEdict; // kill gas cloud in 10 secs if not 
            gi.linkentity (Zylon); 
            } 
            //====================================================== 
            void Zylon_Grenade(edict_t *ent) { 
            Generate_Zylon_Gas(ent, ent->move_angles); 
            if (ent->Zylon_timer > level.time) { 
            ent->nextthink = level.time + 0.3; 
            ent->think = Zylon_Grenade; 
            return; } 
            G_FreeEdict(ent); 
            } 
