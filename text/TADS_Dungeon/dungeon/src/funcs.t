mapprop: function( list, prop )
{
    local cur;
    while( cur := car(list) ) {
	cur.(prop);
	list := cdr(list);
    }
}

notlikely: function {
    switch (rand(6)) {
    case 1: "Not likely."; break;
    case 2: "An interesting idea, but..."; break;
    case 3: "A valiant attempt."; break;
    case 4: "You can't be serious."; break;
    case 5: "Not a prayer."; break;
    case 6: "What a concept!"; break;
    }
}

dummy: function {
    switch (rand(3)) {
    case 1: "Look around. "; break;
    case 2: "You think it isn't? "; break;
    case 3: "I think you've already done that. "; break;
    }
}

useless: function {
    switch(rand(6)) {
    case 1: "does not seem to do anything"; break;
    case 2: "is not notably useful"; break;
    case 3: "isn't very interesting"; break;
    case 4: "doesn't appear worthwhile"; break;
    case 5: "has no effect"; break;
    case 6: "doesn't do anything"; break;
    }
}

toplocation: function(ob)
{
    while(ob.location) ob := ob.location;
    return( ob );
}

prob: function(goodchance, badchance) {
    local x;
    if (global.badluck)
	goodchance := badchance;
    return (rand(99) < goodchance);  /* ?? */
}

/* steal treasures from an object */
stealtreasures: function(obj, chance, dest) {
    local i, len, list, cur, ret;
    
    ret := nil;

    list := obj.contents;
    len := length(list);
    for (i := 1; i <= len; i++) {
	cur := list[i];
	if (isclass(cur, treasure) and (not cur.sacred)
	    and prob(chance,chance))
	{
	    cur.moveInto(dest);
	    cur.touched := true;
	    ret := true;
	} else if (cur.isactor) {
	    ret := ret or stealtreasures(cur, 100, dest);
	}
    }
    return ret;
}
