#/Include/Empire.g
#/Include/Request.g
#EmpPrivate.g
#drinc:util.g

/*
 * Amiga Empire
 *
 * Copyright (c) 1990 by Chris Gray
 *
 * Feel free to modify and use these sources however you wish, so long
 * as you preserve this copyright notice.
 */

proc cmd_price()bool:
    register *Sector_t rs;
    register *Ship_t rsh @ rs;
    register *Offer_t rof @ rs;
    register *World_t rw @ rs;
    register uint offerNumber, cost, oldPrice;
    Ship_t saveShip;
    uint shipNumber, price, mapped;
    int r, c;
    ItemType_t what;
    bool isShip, gotOffer;

    gotOffer := false;
    if reqSectorOrShip(&r, &c, &shipNumber, &isShip,
	    "Ship to sell or exchange to sell at? ")
    then
	rs := &ES*.es_request.rq_u.ru_sector;
	if isShip then
	    server(rt_readShip, shipNumber);
	    if rsh*.sh_owner ~= ES*.es_countryNumber then
		err("you don't own that ship");
		false
	    elif rsh*.sh_fleet ~= '*' then
		err("ship must be removed from fleet first");
		false
	    else
		saveShip := rsh*;
		offerNumber := 0;
		while
		    if offerNumber = ES*.es_world.w_offerNext then
			false
		    else
			server(rt_readOffer, offerNumber);
			rof*.of_state ~= of_ship or
			    rof*.of_.of_shipNumber ~= shipNumber
		    fi
		do
		    offerNumber := offerNumber + 1;
		od;
		if offerNumber ~= ES*.es_world.w_offerNext then
		    if rof*.of_who ~= ES*.es_countryNumber and
			saveShip.sh_price ~= 0
		    then
			server(rt_lockShip, shipNumber);
			rsh*.sh_price := 0;
			server(rt_unlockShip, shipNumber);
			saveShip.sh_price := 0;
		    fi;
		    gotOffer := true;
		fi;
		cost := ES*.es_world.w_shipCost[saveShip.sh_type];
		user(getShipName(saveShip.sh_type));
		userN2(" \#", shipNumber);
		if rsh*.sh_price = 0 then
		    user(" is currently not for sale\n");
		else
		    userN2(" is currently offered at $", saveShip.sh_price);
		    userN3(" per ton (total $", saveShip.sh_price * cost,
			   ")\n");
		fi;
		ignore skipBlanks();
		if reqPosRange(&price, 127, "New price per ton? ") then
		    if price = 0 then
			if saveShip.sh_price ~= 0 then
			    server(rt_lockShip, shipNumber);
			    rsh*.sh_price := 0;
			    server(rt_unlockShip, shipNumber);
			    server(rt_lockOffer, offerNumber);
			    rof*.of_state := of_none;
			    server(rt_unlockOffer, offerNumber);
			    userN3("Lot \#", offerNumber, " withdrawn\n");
			else
			    user("OK, ship not offered for sale\n");
			fi;
		    else
			userN3("Total value is $", price * cost, "\n");
			server(rt_lockShip, shipNumber);
			rsh*.sh_price := price;
			server(rt_unlockShip, shipNumber);
			if gotOffer then
			    server(rt_lockOffer, offerNumber);
			else
			    server(rt_lockWorld, 0);
			    offerNumber := rw*.w_offerNext;
			    rw*.w_offerNext := offerNumber + 1;
			    server(rt_unlockWorld, 0);
			    ES*.es_world.w_offerNext := rw*.w_offerNext;
			fi;
			rof*.of_state := of_ship;
			rof*.of_who := ES*.es_countryNumber;
			rof*.of_.of_shipNumber := shipNumber;
			if gotOffer then
			    server(rt_unlockOffer, offerNumber);
			else
			    server(rt_createOffer, offerNumber);
			fi;
			user(getShipName(saveShip.sh_type));
			userN2(" \#", shipNumber);
			userN3(" is now lot \#", offerNumber, "\n");
		    fi;
		fi;
		true
	    fi
	elif doSkipBlanks() and reqCmsgpob(&what, "Set price on what? ") then
	    mapped := mapSector(r, c);
	    server(rt_readSector, mapped);
	    if what = it_civilians or what = it_military then
		err("can't sell people");
		false
	    elif rs*.s_owner ~= ES*.es_countryNumber then
		err("you don't own that sector");
		false
	    elif rs*.s_type ~= s_exchange then
		err("that sector is not an exchange");
		false
	    elif rs*.s_efficiency < 60 then
		err("exchange not efficient enough for trading");
		false
	    else
		offerNumber :=
		    make(rs*.s_threshold[it_civilians], uint) << 8 |
		    rs*.s_threshold[it_military];
		cost := getItemCost(what);
		oldPrice := rs*.s_threshold[what] * cost;
		if offerNumber ~= 0 then
		    offerNumber := offerNumber - 1;
		    server(rt_readOffer, offerNumber);
		    if rof*.of_who ~= ES*.es_countryNumber then
			oldPrice := 0;
		    fi;
		    gotOffer := true;
		fi;
		user(getItemName(what));
		if oldPrice = 0 then
		    user(" currently not for sale");
		else
		    userM3(" currently offered at $", oldPrice, "");
		fi;
		userS(" at ", r, c, "\n");
		ignore skipBlanks();
		if reqPosRange1(&price, cost * 127, "New price? ") then
		    if price / cost = 0 and price ~= 0 then
			userM3("Price too low, must be at least $", cost,"\n");
		    else
			price := price / cost;
			if price = 0 then
			    if oldPrice = 0 then
				user3("OK, ", getItemName(what),
				      " not offered\n");
			    else
				server(rt_lockSector, mapped);
				rs*.s_threshold[what] := 0;
				server(rt_unlockSector, mapped);
				if rs*.s_threshold[it_shells] = 0 and
				    rs*.s_threshold[it_guns] = 0 and
				    rs*.s_threshold[it_planes] = 0 and
				    rs*.s_threshold[it_ore] = 0 and
				    rs*.s_threshold[it_bars] = 0
				then
				    server(rt_lockOffer, offerNumber);
				    rof*.of_state := of_none;
				    server(rt_unlockOffer, offerNumber);
				    userN3("Lot \#", offerNumber,
					   " withdrawn\n");
				else
				    userN3("Lot \#", offerNumber,
					   " updated\n");
				fi;
			    fi;
			else
			    userM3("Price set to $", price * cost, "\n");
			    if gotOffer then
				userN3("Lot \#", offerNumber, " updated\n");
				server(rt_lockOffer, offerNumber);
			    else
				server(rt_lockWorld, 0);
				offerNumber := rw*.w_offerNext;
				rw*.w_offerNext := offerNumber + 1;
				server(rt_unlockWorld, 0);
				ES*.es_world.w_offerNext := rw*.w_offerNext;
				userN3("This item is lot \#",offerNumber,"\n");
			    fi;
			    rof*.of_state := of_sector;
			    rof*.of_who := ES*.es_countryNumber;
			    rof*.of_.of_sect.of_row := rowToAbs(r);
			    rof*.of_.of_sect.of_col := colToAbs(c);
			    if gotOffer then
				server(rt_unlockOffer, offerNumber);
			    else
				server(rt_createOffer, offerNumber);
			    fi;
			    server(rt_lockSector, mapped);
			    rs*.s_threshold[it_civilians] :=
				(offerNumber + 1) >> 8;
			    rs*.s_threshold[it_military] := offerNumber + 1;
			    rs*.s_threshold[what] := price;
			    server(rt_unlockSector, mapped);
			fi;
		    fi;
		else
		    if oldPrice = 0 then
			user3("OK, ", getItemName(what), " not offered\n");
		    else
			user("OK, price not changed\n");
		    fi;
		fi;
		true
	    fi
	else
	    false
	fi
    else
	false
    fi
corp;

/*
 * printOffer - print out an offer. Return 'false' if it is gone.
 *	Convention - the offer is in the request.
 */

proc printOffer(uint offerNumber)bool:
    register *Offer_t rof;
    register *Ship_t rsh @ rof;
    register *Sector_t rs @ rof;
    register uint cost;
    int r, c;
    uint shipNumber, mapped, who;
    register ItemType_t it;
    bool needMess;

    rof := &ES*.es_request.rq_u.ru_offer;
    who := rof*.of_who;
    needMess := false;
    if rof*.of_state = of_ship then
	shipNumber := rof*.of_.of_shipNumber;
	server(rt_readShip, shipNumber);
	if rsh*.sh_owner ~= who then
	    server(rt_lockShip, shipNumber);
	    rsh*.sh_price := 0;
	    server(rt_unlockShip, shipNumber);
	    server(rt_lockOffer, offerNumber);
	    rof*.of_state := of_none;
	    server(rt_unlockOffer, offerNumber);
	    needMess := true;
	else
	    userN3("Lot \#", offerNumber, ":\n");
	    user(getShipName(rsh*.sh_type));
	    userN2(" \#", shipNumber);
	    userS(" at ", rowToMe(rsh*.sh_row), colToMe(rsh*.sh_col), ": ");
	    userN(rsh*.sh_efficiency);
	    userN2("%  crew ", rsh*.sh_crew);
	    userN2("  guns: ", rsh*.sh_guns);
	    userN2("  shells: ", rsh*.sh_shells);
	    userN2("  @ $", rsh*.sh_price);
	    userN3(" (tot $",
		   rsh*.sh_price * ES*.es_world.w_shipCost[rsh*.sh_type],
		   ")\n");
	fi;
    elif rof*.of_state = of_sector then
	r := rowToMe(rof*.of_.of_sect.of_row);
	c := colToMe(rof*.of_.of_sect.of_col);
	mapped := mapSector(r, c);
	server(rt_readSector, mapped);
	if rs*.s_owner ~= who or rs*.s_type ~= s_exchange or
	    rs*.s_efficiency < 60
	then
	    server(rt_lockSector, mapped);
	    for it from it_first upto it_last do
		rs*.s_threshold[it] := 0;
	    od;
	    server(rt_unlockSector, mapped);
	    server(rt_lockOffer, offerNumber);
	    rof*.of_state := of_none;
	    server(rt_unlockOffer, offerNumber);
	    needMess := true;
	else
	    userN3("Lot \#", offerNumber, ":\n");
	    for it from it_shells upto it_bars do
		if rs*.s_threshold[it] ~= 0 then
		    cost := getItemCost(it) * rs*.s_threshold[it];
		    userN(readQuan(rs, it));
		    user2(" ", getItemName(it));
		    userM3(" @ $", cost, "  ");
		fi;
	    od;
	    userNL();
	fi;
    fi;
    if needMess then
	userN3("Your lot \#", offerNumber, " cancelled");
	notify(rof*.of_who);
    fi;
    rof*.of_state ~= of_none
corp;

proc cmd_report()bool:
    register *Offer_t rof;
    uint choice, offerNumber;
    bool doNaval, doLand;

    if ES*.es_textInPos* >= '0' and ES*.es_textInPos* <= '9' and
	ES*.es_world.w_offerNext ~= 0
    then
	if getPosRange(&offerNumber, ES*.es_world.w_offerNext - 1) then
	    server(rt_readOffer, offerNumber);
	    ignore printOffer(offerNumber);
	    true
	else
	    false
	fi
    else
	doNaval := true;
	doLand := true;
	if ES*.es_textInPos* ~= '\e' then
	    doNaval := false;
	    doLand := false;
	    if getChoice(&choice, "naval\eland\e") then
		if choice = 0 then
		    doNaval := true;
		else
		    doLand := true;
		fi;
	    fi;
	fi;
	if doLand or doNaval then
	    user("        Empire Trade Report as of ");
	    uTime(ES*.es_request.rq_time);
	    userNL();
	    userNL();
	    if ES*.es_world.w_offerNext ~= 0 then
		rof := &ES*.es_request.rq_u.ru_offer;
		for offerNumber from 0 upto ES*.es_world.w_offerNext - 1 do
		    server(rt_readOffer, offerNumber);
		    if (rof*.of_state = of_ship and doNaval or
			rof*.of_state = of_sector and doLand) and
			printOffer(offerNumber)
		    then
			userNL();
		    fi;
		od;
	    fi;
	    true
	else
	    false
	fi
    fi
corp;

/*
 * doBuy - try to buy a given item from an exchange sector.
 *	Convention: the sector pair is in the request on both entry and exit.
 */

proc doBuy(uint mapped1, mapped2; register ItemType_t what; *ulong pFunds)void:
    register *[2]Sector_t rp;
    ulong price, cost;
    uint max, q1, q2, count, countOrig;
    [100] char buff;

    rp := &ES*.es_request.rq_u.ru_sectorPair;
    price := getItemCost(what) * rp*[0].s_threshold[what];
    if price ~= 0 then
	/* note assumption that bundle size in exchange is 1 for everything */
	max := min(readQuan(&rp*[0], what), 127 - readQuan(&rp*[1], what));
	user2("Buy how many ", getItemName(what));
	userM3(" at $", price, " (max ");
	userN(max);
	user(")? ");
	getPrompt(&buff[0]);
	if reqPosRange(&count, max, &buff[0]) then
	    cost := price * count / 10;
	    if pFunds* > cost then
		countOrig := count;
		server2(rt_lockSectorPair, mapped1, mapped2);
		q1 := readQuan(&rp*[0], what);
		if q1 < count then
		    count := q1;
		fi;
		q2 := readQuan(&rp*[1], what);
		if count > 127 - q2 then
		    count := 127 - q2;
		fi;
		writeQuan(&rp*[0], what, q1 - count);
		writeQuan(&rp*[1], what, q2 + count);
		server2(rt_unlockSectorPair, mapped1, mapped2);
		if count ~= countOrig then
		    userN3("Events reduced the sale to ", count, " units\n");
		    cost := price * count / 10;
		fi;
		pFunds* := pFunds* - cost;
	    else
		err("insufficient funds");
	    fi;
	else
	    user("OK, none bought\n");
	fi;
    fi;
corp;

/*
 * makeSale - a sale for the given amount has been made.
 */

proc makeSale(register uint seller; uint offerNumber;
	      register ulong amount)void:
    register *Country_t rc;

    server(rt_lockCountry, ES*.es_countryNumber);
    rc := &ES*.es_request.rq_u.ru_country;
    rc*.c_money := rc*.c_money - amount;
    server(rt_unlockCountry, ES*.es_countryNumber);
    ES*.es_country.c_money := rc*.c_money;
    server(rt_lockCountry, seller);
    rc*.c_money := rc*.c_money + amount;
    server(rt_unlockCountry, seller);
    userN3("You made a sale (lot \#", offerNumber, ") to ");
    user(&ES*.es_country.c_name[0]);
    notify(seller);
    news(n_make_sale, seller, ES*.es_countryNumber);
    userN3("You are now $", amount, " poorer!\n");
corp;

proc cmd_buy()bool:
    register *Offer_t rof;
    register *Ship_t rsh @ rof;
    register *[2]Sector_t rp @ rof;
    uint shipNumber, mapped1, mapped2;
    long cost;
    ulong funds;
    uint which, seller;
    int r1, c1, r2, c2;
    ShipType_t shType;
    register ItemType_t it;

    if ES*.es_world.w_offerNext = 0 then
	err("nothing is for sale yet");
	false
    elif reqPosRange(&which, ES*.es_world.w_offerNext - 1, "Buy which lot? ")
    then
	server(rt_readOffer, which);
	rof := &ES*.es_request.rq_u.ru_offer;
	if printOffer(which) then
	    server(rt_readOffer, which);
	    if rof*.of_who = ES*.es_countryNumber then
		err("can't sell to yourself");
		false
	    elif rof*.of_state = of_ship then
		shipNumber := rof*.of_.of_shipNumber;
		server(rt_readShip, shipNumber);
		cost := rsh*.sh_price * ES*.es_world.w_shipCost[rsh*.sh_type];
		if cost < ES*.es_country.c_money then
		    if ask("Buy the ship? ") then
			server(rt_lockShip, shipNumber);
			rsh*.sh_price := 0;
			rsh*.sh_owner := ES*.es_countryNumber;
			server(rt_unlockShip, shipNumber);
			shType := rsh*.sh_type;
			server(rt_lockOffer, which);
			rof*.of_state := of_none;
			server(rt_unlockOffer, which);
			user("You now own ");
			user(getShipName(shType));
			userN3(" \#", shipNumber, "\n");
			makeSale(rof*.of_who, which, cost);
		    else
			user("OK, you chickened out\n");
		    fi;
		else
		    err("you don't have enough money");
		fi;
		true
	    else	/* rof*.of_state = of_sector */
		ignore skipBlanks();
		if reqSector(&r2, &c2, "Exchange to deliver to? ") then
		    r1 := rowToMe(rof*.of_.of_sect.of_row);
		    c1 := colToMe(rof*.of_.of_sect.of_col);
		    seller := rof*.of_who;
		    mapped1 := mapSector(r1, c1);
		    mapped2 := mapSector(r2, c2);
		    server2(rt_readSectorPair, mapped1, mapped2);
		    if rp*[1].s_owner ~= ES*.es_countryNumber then
			err("you don't own that sector");
		    elif rp*[1].s_type ~= s_exchange then
			err("that sector is not an exchange");
		    elif rp*[1].s_efficiency < 60 then
			err("exchange not efficient enough yet");
		    else
			funds := ES*.es_country.c_money;
			for it from it_shells upto it_bars do
			    doBuy(mapped1, mapped2, it, &funds);
			od;
			if funds ~= ES*.es_country.c_money then
			    /* the offer sticks around */
			    makeSale(seller, which,
				     ES*.es_country.c_money - funds);
			fi;
		    fi;
		    true
		else
		    false
		fi
	    fi
	else
	    userN3("Lot \#", which, " is not available\n");
	    false
	fi
    else
	false
    fi
corp;
