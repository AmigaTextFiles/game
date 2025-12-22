replace listcontentsX: function(cont, actor, md, silent, leadingspace, ird, loctype, listfixtures, listactors, cansense, here)
{
	local	i, j, k, len, l, clen;
	local	see := [], hear := [], smell := [], touch := [];
	local	ltlist;
	local	o;
	local	container, lt;
	local	unlisted := [];
	local	tolist := [], tlen;
	local	indislist := [], indiscount := [], indislen, indistot;
	local	listedhere := [], tot := 0;
	local	Silent := silent;

	//
	// list things the player sees.
	//
	if (not (cansense = nil or cansense = &cansee))
		silent := true;

	//
	// Always see what the player can see so we get a valid
	// list of things that are listedhere.	We need this to
	// decide later if we should say "something is ticking"
	// vs. "the bomb is ticking".
	//
	if (true) {
		//
		// If the actor <<t.cant>> see this container, explain why
		// and exit.
		//
		caps();
		if (not actor.cansee(cont, nil, silent))
			return;

		//
		// Construct the list of location types to look for.
		// If loctype is non-nil, verify that it works.
		// Otherwise, try each locationtype.
		//
		if (loctype = nil)
			ltlist := actor.canseecontents(cont, true, nil);
		else 
			ltlist := [loctype];
		if (ltlist = nil)
			see := [];
		else
			see := cont.seecont(actor, ltlist);

		len := length(see);
		for (i := 1; i <= len; i++) {
			l := see[i];
			container := l[1];
			lt := l[2];
			clen := l[3];

			//
			// If this container doesn't want its contents
			// listed in room descriptions, don't list.
			//
			if (ird and not container.(global.loccont[lt])(nil)) {
				unlisted += container;
				continue;
			}

			//
			// If this is a room description and this container
			// does not want to be listed, don't list its
			// contents either.  Furthermore, we don't want
			// to list the contents of any container whose
			// container doesn't want things listed, etc.
			// So we need to keep a list of containers that
			// don't want things listed.  Since our list
			// of objects is guaranteed to go *down* the
			// containment hierarchy as we progress from 
			// 1 to n, we'll always see containers before
			// we see their contents, so this works.
			//
			// The exception to this is that if the container
			// is this Thing (cont), then it doesn't have
			// have to be listable for its contents to be
			// listed.
			//
			if (ird) {
				if (find(unlisted, container) <> nil)
					continue;
				if (find(unlisted, container.location) <> nil) {
					unlisted += container;
					continue;
				}

#ifdef	NEVER
				//
				// This is the clause that implements the
				// statement "contents of things that
				// aren't listed aren't listed".  This is
				// probably better handled in the listcontents
				// methods themselves.	(The problem:  A desk
				// with things on it isn't listed because it's
				// described "by hand" in the room description.
				// Then contents of the desk won't be listed.
				// This is bad.)
				//
				if (container <> cont and not container.islistable(actor)) {
					unlisted += container;
					continue;
				}
#endif	/* NEVER */
			}

			//
			// If this is a room description, remove
			// any items that don't want to be listed
			// in room descriptions.
			//
			if (ird) for (j := 4; j <= clen; j++) {
				if (not l[j].islistable(actor))
					l[j] := nil;
			}


			//
			// Remove any items that aren't noticeable
			//
			for (j := 4; j <= clen; j++) {
				if (l[j] <> nil)
					if (not l[j].isnoticeable(actor))
						l[j] := nil;
			}

			//
			// Now list all the fixtures, if we're listing
			// fixtures. If we're not listing them, just
			// delete them.
			//
			tolist := [];
			tlen := 0;
			for (j := 4; j <= clen; j++) {
				o := l[j];

				if (o = nil)
					continue;
				if (not o.isfixture and not o.isactor)
					continue;
				l[j] := nil;
				if (not listfixtures)
					continue;
				if (o.isactor) {
					if (not listactors)
						continue;
					if (o = actor)
						continue;
				}
				tolist += o;
				tlen++;
			}
			tot += tlen;
			listedhere += tolist;
			if (not silent and listfixtures) {
				for (j := 1; j <= tlen; j++) {
					o := tolist[j];

					if (leadingspace) {
						leadingspace := nil;
						P(); I();
					}
					if (o.isactor) {
						"<<o.actordesc>> ";
						tot++;
						listedhere += o;
					}
					else if (listfixtures) {
						"<<o.heredesc>> ";
						tot++;
						listedhere += o;
					}
				}
			}

			//
			// Now list everything else.
			// We separate out indistinguishables.
			// We move plurals to the front to make the
			// listing more readable.
			//
			tolist := [];
			tlen := 0;
			indislist := [];
			indiscount := [];
			indislen := 0;
			for (j := 4; j <= clen; j++) {
				o := l[j];
				if (o = nil)
					continue;
				if (o.isequivalent) {
					indislist += o;
					indiscount += 1;
					indislen++;
				}
				else {
					if (o.isplural)
						tolist := [o] + tolist;
					else
						tolist += o;
					tlen++;
				}
			}

			//
			// Now merge indistinguishable objects
			//
			for (j := 1; j <= indislen; j++) {
				if (indislist[j] = nil)
					continue;

				for (k := j + 1; k <= indislen; k++) {
					if (indislist[k] = nil)
						continue;

					if (indistinguishable(indislist[j], indislist[k])) {
						indiscount[j]++;
						indislist[k] := nil;
					}
				}
			}

			//
			// Put indistinguishable objects back in tolist
			//
			indistot := 0;
			for (j := 1; j <= indislen; j++) {
				local	o := indislist[j];

				if (o = nil)
					continue;
				
				tolist := [o] + tolist;
				tlen++;
				indistot++;
				indiscount[indistot] := indiscount[j];
			}

			if (tlen = 0)
				continue;

			tot += tlen;
			listedhere += tolist;

			if (silent)
				continue;

			if (leadingspace) {
				leadingspace := nil;
				P(); I();
			}

			" \^";
			if (container.isactor)
				"<<container.subjthedesc>>
				\ <<container.has>>";

			for (j := 1; j <= tlen; j++) {
				o := tolist[j];

				if (j = 1)
					" ";
				else if (j = tlen) {
					if (tlen > 2)
						",";
						" and ";
				}
				else
					", ";

				if (j <= indistot and indiscount[j] > 1)
					"<<saynum(indiscount[j])>> \v<<o.listpluraldesc>>";
				else
					o.listdesc;
			}

			if (container.isactor) {
				". ";
			}
			else {
				if (tlen > 1 or o.isplural)
					" <<t.are>> ";
				else
					" <<t.is>> ";

				if (container = here and global.loctypes[lt] = 'in')
					" here. ";
				else
					" <<global.loctypes[lt]>>
					\ <<container.objthedesc(nil)>>. ";
			}
		}
		global.listed += listedhere;
	}


	//
	// If we only did the "see" code to get a list of things that
	// the player can see, don't count these items in the total.
	//
	silent := Silent;
	if (not (cansense = nil or cansense = &canseee))
		tot := 0;

	//
	// Now list things the player hears.
	//
	if (cansense = nil or cansense = &canhear) {
		if (global.manysounds) {
			//
			// We have many Listablesounds in the
			// game, so it's faster to recurse and
			// see which of the container's contents are
			// Listablesounds rather than which 
			// of the Listablesounds in the game
			// are in this container.
			//

			//
			// If the actor <<t.cant>> hear this container, explain why
			// and exit.
			//
			caps();
			if (not actor.canhear(cont, nil, silent))
				return;

			//
			// Construct the list of location types to look for.
			// If loctype is non-nil, verify that it works.
			// Otherwise, try each locationtype.
			//
			if (loctype = nil)
				ltlist := actor.canhearcontents(cont, true, nil);
			else
				ltlist := [loctype];
			if (ltlist = nil)
				hear := [];
			else
				hear := cont.hearcont(actor, ltlist);

			len := length(hear);
			for (i := 1; i <= len; i++) {
				l := hear[i];
				container := l[1];
				lt := l[2];
				clen := l[3];

				//
				// If this container doesn't want its contents
				// listed in room descriptions, don't list.
				//
				if (ird and not container.(global.locconthear[lt])(nil))
					continue;

				//
				// Remove any items that don't want to be listed.
				//
				for (j := 4; j <= clen; j++) {
					if (not l[j].islistablesound(actor))
						l[j] := nil;
				}

				//
				// Now list everything the player hears.
				//
				tolist := [];
				tlen := 0;
				for (j := 4; j <= clen; j++) {
					o := l[j];
					if (o = nil)
						continue;
					tolist += o;
					tlen++;
				}

				if (tlen = 0)
					continue;

				tot += tlen;

				if (silent)
					continue;

				if (leadingspace) {
					leadingspace := nil;
					P(); I();
				}

				for (j := 1; j <= tlen; j++) {
					o := tolist[j];

					// print either the name of this 
					// thing (if we've listed it) or
					// "something ..."
					if (o.alwaysname(actor) and o.isknownto(actor) or find(listedhere, o) <> nil)
						"\^<<o.subjthedesc>> ";
					else {
						if (o.isplural)
							" Some things ";
						else
							" Something ";

						if (container.alwaysname(actor) and container.isknownto(actor) or find(listedhere, container) <> nil) {
							if (container.isactor)
								"<<container.subjdesc>>
								\ <<container.has>> ";
							else
								"<<o.locationtype>>
								\ <<container.objthedesc(actor)>> ";
						}
					}

					"<<o.listlistendesc>> ";
				}
			}
		}
		else {
			local	o, contained, tolist := [], tlen := 0;

			for (i := length(global.listablesoundlist); i > 0; i--) {
				o := global.listablesoundlist[i];
				contained := nil;

				if (not o.islistablesound(actor))
					continue;

				while (o.location <> nil) {
					if (ird and not o.location.(global.locconthear[o.locationtypenum])(nil))
						break;

					if (o.location = cont and (loctype = nil or o.locationtype = loctype)) {
						contained := true;
						break;
					}

					o := o.location;
				}

				if (contained) {
					o := global.listablesoundlist[i];
					if (actor.canhear(o, nil, true)) {
						tolist += o;
						tlen++;
					}
				}
			}

			if (tlen = 0)
				goto Break1;

			tot += tlen;

			if (silent)
				goto Break1;

			if (leadingspace) {
				leadingspace := nil;
				P(); I();
			}

			for (j := 1; j <= tlen; j++) {
				o := tolist[j];
				container := o.location;

				// print either the name of this 
				// thing (if we've listed it) or
				// "something ..."
				if (o.alwaysname(actor) and o.isknownto(actor) or find(listedhere, o) <> nil)
					"\^<<o.subjthedesc>> ";
				else {
					if (o.isplural)
						" Some things ";
					else
						" Something ";

					if (container.alwaysname(actor) and container.isknownto(actor) or find(listedhere, container) <> nil) {
						if (container.isactor)
							"<<container.subjdesc>>
							\ <<container.has>> ";
						else
							"<<o.locationtype>>
							\ <<container.objthedesc(actor)>> ";
					}
				}

				"<<o.listlistendesc>> ";
			}
Break1:;
		}
	}

	//
	// Now list things the player smells.
	//
	if (cansense = nil or cansense = &cansmell) {
		if (global.manysmells) {
			//
			// If the actor <<t.cant>> smell this container, explain why
			// and exit.
			//
			caps();
			if (not actor.cansmell(cont, nil, silent))
				return;

			//
			// Construct the list of location types to look for.
			// If loctype is non-nil, verify that it works.
			// Otherwise, try each locationtype.
			//
			if (loctype = nil)
				ltlist := actor.cansmellcontents(cont, true, nil);
			else
				ltlist := [loctype];
			if (ltlist = nil)
				smell := [];
			else
				smell := cont.smellcont(actor, ltlist);

			len := length(smell);
			for (i := 1; i <= len; i++) {
				l := smell[i];
				container := l[1];
				lt := l[2];
				clen := l[3];

				//
				// If this container doesn't want its contents
				// listed in room descriptions, don't list.
				//
				if (ird and not container.(global.loccontsmell[lt])(nil))
					continue;

				//
				// Remove any items that don't want to be listed.
				//
				for (j := 4; j <= clen; j++) {
					if (not l[j].islistablesmell(actor))
						l[j] := nil;
				}

				//
				// Now list everything the player smells.
				//
				tolist := [];
				tlen := 0;
				for (j := 4; j <= clen; j++) {
					o := l[j];
					if (o = nil)
						continue;
					tolist += o;
					tlen++;
				}

				if (tlen = 0)
					continue;

				tot += tlen;

				if (silent)
					continue;

				if (leadingspace) {
					leadingspace := nil;
					P(); I();
				}

				for (j := 1; j <= tlen; j++) {
					o := tolist[j];

					// print either the name of this 
					// thing (if we've listed it) or
					// "something ..."
					if (o.alwaysname(actor) and o.isknownto(actor) or find(listedhere, o) <> nil)
						"\^<<o.subjthedesc>> ";
					else {
						if (o.isplural)
							" Some things ";
						else
							" Something ";

						if (container.alwaysname(actor) and container.isknownto(actor) or find(listedhere, container) <> nil) {
							if (container.isactor)
								"<<container.subjdesc>>
								\ <<container.has>> ";
							else
								"<<o.locationtype>>
								\ <<container.objthedesc(actor)>> ";
						}
					}

					"<<o.listsmelldesc>> ";
				}
			}
		}
		else {
			local	o, contained, tolist := [], tlen := 0;

			for (i := length(global.listablesmelllist); i > 0; i--) {
				o := global.listablesmelllist[i];
				contained := nil;

				if (not o.islistablesmell(actor))
					continue;

				while (o.location <> nil) {
					if (ird and not o.location.(global.loccontsmell[o.locationtypenum])(nil))
						break;

					if (o.location = cont and (loctype = nil or o.locationtype = loctype)) {
						contained := true;
						break;
					}

					o := o.location;
				}

				if (contained) {
					o := global.listablesmelllist[i];
					if (actor.cansmell(o, nil, true)) {
						tolist += o;
						tlen++;
					}
				}
			}

			if (tlen = 0)
				goto Break2;

			tot += tlen;

			if (silent)
				goto Break2;

			if (leadingspace) {
				leadingspace := nil;
				P(); I();
			}

			for (j := 1; j <= tlen; j++) {
				o := tolist[j];
				container := o.location;

				// print either the name of this 
				// thing (if we've listed it) or
				// "something ..."
				if (o.alwaysname(actor) and o.isknownto(actor) or find(listedhere, o) <> nil)
					"\^<<o.subjthedesc>> ";
				else {
					if (o.isplural)
						" Some things ";
					else
						" Something ";

					if (container.alwaysname(actor) and container.isknownto(actor) or find(listedhere, container) <> nil) {
						if (container.isactor)
							"<<container.subjdesc>>
							\ <<container.has>> ";
						else
							"<<o.locationtype>>
							\ <<container.objthedesc(actor)>> ";
					}
				}

				"<<o.listsmelldesc>> ";
			}
Break2:;
		}
	}

	//
	// Now handle things the player feels
	//
	if (cansense = nil or cansense = &cantouch) {
		if (global.manytouches) {
			//
			// If the actor <<t.cant>> touch this container, explain why
			// and exit.
			//
			caps();
			if (not actor.cantouch(cont, nil, silent))
				return;

			//
			// Construct the list of location types to look for.
			// If loctype is non-nil, verify that it works.
			// Otherwise, try each locationtype.
			//
			if (loctype = nil)
				ltlist := actor.cantouchcontents(cont, true, nil);
			else
				ltlist := [loctype];
			if (ltlist = nil)
				touch := [];
			else
				touch := cont.touchcont(actor, ltlist);

			len := length(touch);
			for (i := 1; i <= len; i++) {
				l := touch[i];
				container := l[1];
				lt := l[2];
				clen := l[3];

				//
				// If this container doesn't want its contents
				// listed in room descriptions, don't list.
				//
				if (ird and not container.(global.locconttouch[lt])(nil))
					continue;

				//
				// Remove any items that don't want to be listed.
				//
				for (j := 4; j <= clen; j++) {
					if (not l[j].islistabletouch(actor))
						l[j] := nil;
				}

				//
				// Now list everything the player feels.
				//
				tolist := [];
				tlen := 0;
				for (j := 4; j <= clen; j++) {
					o := l[j];
					if (o = nil)
						continue;
					tolist += o;
					tlen++;
				}

				if (tlen = 0)
					continue;

				tot += tlen;

				if (silent)
					continue;

				if (leadingspace) {
					leadingspace := nil;
					P(); I();
				}

				for (j := 1; j <= tlen; j++) {
					o := tolist[j];

					// print either the name of this 
					// thing (if we've listed it) or
					// "something ..."
					if (o.alwaysname(actor) and o.isknownto(actor) or find(listedhere, o) <> nil)
						"\^<<o.subjthedesc>> ";
					else {
						if (o.isplural)
							" Some things ";
						else
							" Something ";

						if (container.alwaysname(actor) and container.isknownto(actor) or find(listedhere, container) <> nil) {
							if (container.isactor)
								"<<container.subjdesc>>
								\ <<container.has>> ";
							else
								"<<o.locationtype>>
								\ <<container.objthedesc(actor)>> ";
						}
					}

					"<<o.listtouchdesc>> ";
				}
			}
		}
		else {
			local	o, contained, tolist := [], tlen := 0;

			for (i := length(global.listabletouchlist); i > 0; i--) {
				o := global.listabletouchlist[i];
				contained := nil;

				if (not o.islistabletouch(actor))
					continue;

				while (o.location <> nil) {
					if (ird and not o.location.(global.locconttouch[o.locationtypenum])(nil))
						break;

					if (o.location = cont and (loctype = nil or o.locationtype = loctype)) {
						contained := true;
						break;
					}

					o := o.location;
				}

				if (contained) {
					o := global.listabletouchlist[i];
					if (actor.cantouch(o, nil, true)) {
						tolist += o;
						tlen++;
					}
				}
			}

			if (tlen = 0)
				goto Break3;

			tot += tlen;

			if (silent)
				goto Break3;

			if (leadingspace) {
				leadingspace := nil;
				P(); I();
			}

			for (j := 1; j <= tlen; j++) {
				o := tolist[j];
				container := o.location;

				// print either the name of this 
				// thing (if we've listed it) or
				// "something ..."
				if (o.alwaysname(actor) and o.isknownto(actor) or find(listedhere, o) <> nil)
					"\^<<o.subjthedesc>> ";
				else {
					if (o.isplural)
						" Some things ";
					else
						" Something ";

					if (container.alwaysname(actor) and container.isknownto(actor) or find(listedhere, container) <> nil) {
						if (container.isactor)
							"<<container.subjdesc>>
							\ <<container.has>> ";
						else
							"<<o.locationtype>>
							\ <<container.objthedesc(actor)>> ";
					}
				}

				"<<o.listtouchdesc>> ";
			}
Break3:;
		}
	}

	return tot;
}

modify TOP

	//
	// Don't pass sense by default.
	//
	passcanseeacross(actor, obj, selfloctype, objloctype) = {
		"\^<<actor.subjprodesc>> <<actor.doesnt>> see
		anything matching that vocabulary <<t.here>>.";
		return nil;
	}
	passcantouchacross(actor, obj, selfloctype, objloctype) = {
		"\^<<actor.subjprodesc>> <<t.cant>> touch anything
		matching that vocabulary <<t.here>>.";
		return nil;
	}
	passcantakeacross(actor, obj, selfloctype, objloctype) = {
		"There <<t.is>> nothing matching that vocabulary <<t.here>>.";
		return nil;
	}
	passcansmellacross(actor, obj, selfloctype, objloctype) = {
		"\^<<actor.subjprodesc>> <<t.cant>> smell anything
		matching that vocabulary <<t.here>>.";
		return nil;
	}
	passcanhearacross(actor, obj, selfloctype, objloctype) = {
		"\^<<actor.subjprodesc>> <<t.cant>> hear anything
		matching that vocabulary <<t.here>>.";
		return nil;
	}
	passcanspeaktoacross(actor, obj, selfloctype, objloctype) = {
		"Nothing matching that vocabulary <<t.can>> hear 
		 <<actor.objprodesc(nil)>>.";
		return nil;
	}
;

modify NIL
	passcanseeacross(actor, obj, selfloctype, objloctype) = {
		"\^<<actor.subjprodesc>> <<actor.doesnt>> see
		anything matching that vocabulary <<t.here>>.";
		return nil;
	}
	passcantouchacross(actor, obj, selfloctype, objloctype) = {
		"\^<<actor.subjprodesc>> <<t.cant>> touch anything
		matching that vocabulary h<<t.here>>ere.";
		return nil;
	}
	passcantakeacross(actor, obj, selfloctype, objloctype) = {
		"There <<t.was>> nothing matching that vocabulary <<t.here>>.";
		return nil;
	}
	passcansmellacross(actor, obj, selfloctype, objloctype) = {
		"\^<<actor.subjprodesc>> <<t.cant>> smell anything
		matching that vocabulary <<t.here>>.";
		return nil;
	}
	passcanhearacross(actor, obj, selfloctype, objloctype) = {
		"\^<<actor.subjprodesc>> <<t.cant>> hear anything
		matching that vocabulary <<t.here>>.";
		return nil;
	}
	passcanspeaktoacross(actor, obj, selfloctype, objloctype) = {
		"Nothing matching that vocabulary <<t.can>> hear 
		 <<actor.objprodesc(nil)>>.";
		return nil;
	}
;

modify class Thing
	is = {
		if (self.isplural)
			"<<t.are>>";
		else
			"<<t.is>>";
	}
	isnt = {
		if (self.isplural)
			"<<t.arent>>";
		else
			"<<t.isnt>>";
	}
	does = {
		if (self.isplural)
			"<<t.doH>>";
		else
			"<<t.does>>";
	}
	doesnt = {
		if (self.isplural)
			"<<t.dont>>";
		else
			"<<t.doesnt>>";
	}
	has = {
		if (self.isplural)
			"<<t.have>>";
		else
			"<<t.has>>";
	}
	youll = { "<<self.subjprodesc>><<t.ll>>"; }
	youre = {
		if (self.isplural)
			"<<t.theyre>>";
		else
			"<<t.its>>";
	}

	ldesc = {
		if (self.isplural)
			"\^<<self.subjprodesc>> <<t.look>> like ordinary
			 <<self.objsdesc(nil)>>.";
		else
			"\^<<self.subjprodesc>> <<t.looks>> like an ordinary
			 <<self.objsdesc(nil)>>.";
	}
	seepath(obj, loctype, silent) = {
		local	b, i;
		local	output;
		
		Outhide(true);
		b := self.blocksreach(obj, loctype, &passcanseein, &passcanseeout, &passcanseeacross, nil, nil);
		output := Outhide(nil);

		//
		// Print output if there was any.
		//
		if (output and not silent)
			self.blocksreach(obj, loctype, &passcanseein, &passcanseeout, &passcanseeacross, nil, nil);
			
		if (b <> nil) {
			if (not silent and not output)
				"<<b.subjthedesc>> <<t.blocks>> 
				 <<self.possessivedesc>> view of
				 <<obj.objthedesc(self)>>";
		}

		global.canoutput := output;
		return b ? nil : true;
	}
	touchpath(obj, loctype, silent) = {
		local	b, i;
		local	output;

		Outhide(true);
		b := self.blocksreach(obj, loctype, &passcantouchin, &passcantouchout, &passcantouchacross, nil, nil);
		output := Outhide(nil);

		//
		// Print output if there was any.
		//
		if (output and not silent)
			self.blocksreach(obj, loctype, &passcantouchin, &passcantouchout, &passcantouchacross, nil, nil);
			
		if (b <> nil) {
			if (not silent and not output)
				"<<self.subjprodesc>> <<t.cant>> reach 
				 <<obj.objthedesc(self)>> --
				\ <<b.subjthedesc>>
				\ <<b.is>> in the way";
		}

		global.canoutput := output;
		return b ? nil : true;
	}
	takepath(obj, loctype, silent) = {
		local	b, i;
		local	output;
		
		Outhide(true);
		b := self.blocksreach(obj, loctype, &passcantakein, &passcantakeout, &passcantakeacross, nil, nil);
		output := Outhide(nil);

		//
		// Print output if there was any.
		//
		if (output and not silent)
			self.blocksreach(obj, loctype, &passcantakein, &passcantakeout, &passcantakeacross, nil, nil);
			
		if (b <> nil) {
			if (not silent and not output)
				"<<b.subjthedesc>> <<t.prevents>> 
				 <<self.objprodesc(nil)>> from taking
				 <<obj.objthedesc(nil)>>";
		}

		global.canoutput := output;
		return b ? nil : true;
	}
	smellpath(obj, loctype, silent) = {
		local	b, i;
		local	output;
		
		Outhide(true);
		b := self.blocksreach(obj, loctype, &passcansmellin, &passcansmellout, &passcansmellacross, nil, nil);
		output := Outhide(nil);

		//
		// Print output if there was any.
		//
		if (output and not silent)
			self.blocksreach(obj, loctype, &passcansmellin, &passcansmellout, &passcansmellacross, nil, nil);
			
		if (b <> nil) {
			if (not silent and not output)
				"<<b.subjthedesc>> <<t.prevents>> 
				 <<self.objprodesc(nil)>> from smelling
				 <<obj.objthedesc(self)>>";
		}

		global.canoutput := output;
		return b ? nil : true;
	}
	hearpath(obj, loctype, silent) = {
		local	b, i;
		local	output;

		Outhide(true);
		b := self.blocksreach(obj, loctype, &passcanhearin, &passcanhearout, &passcanhearacross, nil, nil);
		output := Outhide(nil);

		//
		// Print output if there was any.
		//
		if (output and not silent)
			self.blocksreach(obj, loctype, &passcanhearin, &passcanhearout, &passcanhearacross, nil, nil);
			
		if (b <> nil) {
			if (not silent and not output)
				"<<b.subjthedesc>> <<t.prevents>> 
				 <<self.objprodesc(nil)>> from hearing
				 <<obj.objthedesc(self)>>";
		}

		global.canoutput := output;
		return b ? nil : true;
	}
	speaktopath(obj, loctype, silent) = {
		local	b, i;
		local	output;

		Outhide(true);
		b := self.blocksreach(obj, loctype, &passcanspeaktoout, &passcanspeaktoin, &passcanspeaktoacross, nil, nil);
		output := Outhide(nil);

		//
		// Print output if there was any.
		//
		if (output and not silent)
			self.blocksreach(obj, loctype, &passcanspeaktoout, &passcanspeaktoin, &passcanspeaktoacross, nil, nil);
			
		if (b <> nil) {
			if (not silent and not output)
				"<<b.subjthedesc>> <<t.prevents>> 
				 <<obj.objprodesc(nil)>> from hearing
				 <<self.objthedesc(self)>>";
		}

		global.canoutput := output;
		return b ? nil : true;
	}
	putintopath(obj, loctype, silent) = {
		local	b, i;
		local	output;
		
		Outhide(true);
		b := self.blocksreach(obj, loctype, &passcantakeout, &passcantakein, &passcantakeacross, nil, true);
		output := Outhide(nil);

		//
		// Print output if there was any.
		//
		if (output and not silent)
			self.blocksreach(obj, loctype, &passcantakeout, &passcantakein, &passcantakeacross, nil, true);
			
		if (b <> nil) {
			if (not silent and not output)
				"<<b.subjthedesc>> <<t.prevents>> 
				 <<self.objprodesc(nil)>> from putting
				things in <<obj.objthedesc(nil)>>";
		}

		global.canoutput := output;
		return b ? nil : true;
	}
	cansee(obj, loctype, silent) = {
		if (not silent)
			"<<self.subjthedesc>> <<t.cant>> see anything.";

		return nil;
	}
	cantouch(obj, loctype, silent) = {
		if (not silent)
			"<<self.subjthedesc>> <<t.cant>> touch anything.";

		return nil;
	}
	cantake(obj, loctype, silent) = {
		if (not silent)
			"<<self.subjthedesc>> <<t.cant>> take anything.";

		return nil;
	}
	cansmell(obj, loctype, silent) = {
		if (not silent)
			"<<self.subjthedesc>> <<t.cant>> smell anything.";

		return nil;
	}
	canhear(obj, loctype, silent) = {
		if (not silent)
			"<<self.subjthedesc>> <<t.cant>> hear anything.";

		return nil;
	}
	canspeakto(obj, loctype, silent) = {
		if (not silent)
			"<<self.subjthedesc>> <<t.cant>> say anything.";

		return nil;
	}
	canputinto(obj, loctype, silent) = {
		if (not silent)
			"<<self.subjthedesc>> <<t.cant>> put anything anywhere.";
		return nil;
	}
	verDoX(actor, v) = {
		"%You% <<t.cant>> <<v.sdesc>> <<self.objthedesc(actor)>>.";
	}
	verDoClean(actor) = {
		"\^<<actor.possessivedesc>> efforts to clean
		 <<self.objthedesc(actor)>> <<t.have>> little effect.";
	}
	verDoEnter(actor) = { 
		"%You% <<t.cant>> enter <<self.objthedesc(actor)>>.";
	}
	verDoExit(actor) = {
		"%You% <<t.cant>> exit <<self.objthedesc(actor)>>.";
	}
	verDoHit(actor) = {
		"\^<<t.theres>> no reason to get huffy!";
	}	
	verDoKick(actor) = {
		"\^<<t.theres>> no reason to get huffy!";
	}
	verDoLookbehind(actor) = {
		"Trying to look behind <<self.objthedesc(actor)>> <<t.doesnt>>
		 gain %you% anything.";		
	}
	verDoLookin(actor) = {
		"%You% <<t.have>> no way of looking inside <<self.objthedesc(actor)>>.";
	}
	verDoLookon(actor) = {
		"\^<<t.theres>> nothing on <<self.objthedesc(nil)>>.";
	}
	verDoLookthrough(actor) = {
		"%You% <<t.cant>> look through <<self.objthedesc(actor)>>.";
	}
	verDoLookunder(actor) = {
		"Trying to look under <<self.objthedesc(actor)>> <<t.doesnt>>
		 gain %you% anything.";		
	}
	verDoPoke(actor) = {
		"Poking <<self.objthedesc(actor)>> <<t.doesnt>> seem to
		have much effect.";
	}
	verDoPull(actor) = {
		"Pulling on <<self.objthedesc(actor)>> <<t.doesnt>> seem to
		have much effect.";
	}
	verDoPush(actor) = {
		"Pushing <<self.objthedesc(actor)>> <<t.doesnt>> seem to
		have much effect.";
	}
	verDoStand(actor) = { "%You% <<t.cant>> stand <<t.here>>."; }
	verDoAskabout(actor, io) = {
		"%You% <<t.cant>> ask <<io.objthedesc(actor)>> about
		anything.";
	}
	verDoAskfor(actor, io) = {
		"%You% <<t.cant>> ask <<io.objthedesc(actor)>> for
		anything.";
	}
	verDoAttachto(actor, io) = {
		"%You% <<t.cant>> attach <<self.objthedesc(actor)>> to anything.";
	}
	verIoAttachto(actor) = {
		"%You% <<t.cant>> attach anything to <<self.objthedesc(actor)>>.";
	}
	verIoAttackwith(actor) = {
		"%You% <<t.cant>> attack anything with <<self.objthedesc(actor)>>.";
	}
	verIoDetachfrom(actor) = {
		"\^<<t.theres>> nothing attached to <<self.objthedesc(actor)>>.";
	}
	verDoDigwith(actor, io) = {
		"%You% <<t.cant>> dig in <<self.objthedesc(actor)>>.";
	}
	verDoGiveto(actor, io) = {
		"%You% <<t.cant>> give <<self.objthedesc(actor)>> to anyone.";
	}
	verIoGiveto(actor) = {
		"%You% <<t.cant>> give things to <<self.objthedesc(actor)>>.";
	}
	verIoHitwith(actor) = {
		"Hitting things with <<self.objthedesc(actor)>> <<t.isnt>> helpful.";
	}
	verDoLock(actor) = { "%You% <<t.cant>> lock <<self.objthedesc(actor)>>."; }
	verIoLockwith(actor) = {
		"%You% <<t.cant>> lock things with <<self.objthedesc(actor)>>.";
	}
	verDoMovewith(actor, io) = { self.verDoMove(actor); }
	verIoMovewith(actor) = {
		"%You% <<t.cant>> move things with <<self.objthedesc(actor)>>.";
	}
	verDoPlugin(actor, io) = {
		"%You% <<t.cant>> plug <<self.objthedesc(actor)>> into anything.";
	}
	verIoPlugin(actor) = {
		"%You% <<t.cant>> plug anything into <<self.objthedesc(actor)>>.";
	}
	verDoPutX(actor, io, loctype) = {
		"%You% <<t.cant>> put <<self.objthedesc(actor)>> anywhere.";
	}
	verIoPutin(actor) = {
		"%You% <<t.cant>> put anything in <<self.objthedesc(actor)>>.";
	}
	verIoPuton(actor) = {
		"%You% <<t.cant>> put anything on <<self.objthedesc(actor)>>.";
	}
	verIoPutunder(actor) = {
		"%You% <<t.cant>> put anything under <<self.objthedesc(actor)>>.";
	}
	verIoPutbehind(actor) = {
		"%You% <<t.cant>> put anything behind <<self.objthedesc(actor)>>.";
	}
	verIoPutthrough(actor) = {
		"%You% <<t.cant>> put anything through <<self.objthedesc(actor)>>.";
	}
	verIoScrewwith(actor) = {
		"%You% <<t.cant>> screw anything with <<self.objthedesc(actor)>>.";
	}
	verDoShootat(actor, io) = {
		"%You% <<t.cant>> shoot anything with <<self.objthedesc(actor)>>.";		
	}
	verIoShootwith(actor) = {
		"%You% <<t.cant>> shoot anything with <<self.objthedesc(actor)>>.";		
	}
	verIoShowto(actor) = {
		"%You% <<t.cant>> show things to <<self.objthedesc(actor)>>.";
	}
	verIoTakefrom(actor) = {
		"%You% <<t.cant>> take anything from <<self.objthedesc(actor)>>.";
	}
	verIoTakeoff(actor) = {
		"%You% <<t.cant>> take anything off <<self.objthedesc(actor)>>.";
	}
	verIoTakeout(actor) = {
		"%You% <<t.cant>> take anything out of <<self.objthedesc(actor)>>.";
	}
	verIoTakeunder(actor) = {
		"%You% <<t.cant>> take anything out from
		under <<self.objthedesc(actor)>>.";
	}
	verIoTakebehind(actor) = {
		"%You% <<t.cant>> take anything from behind <<self.objthedesc(actor)>>.";
	}
	verDoTellabout(actor, io) = {
		"%You% <<t.cant>> tell <<self.objthedesc(actor)>> about anything.";
	}
	verDoThrowX(actor, io) = {
		"%You% <<t.cant>> throw <<self.objthedesc(actor)>>.";
	}
	verIoThrowat(actor) = {
		"Throwing things at <<self.objthedesc(actor)>> <<t.isnt>> helpful.";
	}
	verIoThrowbehind(actor) = {
		"%You% <<t.cant>> throw things behind <<self.objthedesc(actor)>>.";
	}
	verIoThrowthrough(actor) = {
		"%You% <<t.cant>> throw things through <<self.objthedesc(actor)>>.";
	}
	verIoThrowto(actor) = {
		"%You% <<t.cant>> throw things to <<self.objthedesc(actor)>>.";
	}
	verIoThrowunder(actor) = {
		"%You% <<t.cant>> throw things under <<self.objthedesc(actor)>>.";
	}
	ioTouchWith(actor, dobj) = {
		"Nothing unusual <<t.happens>> when you touch
		 <<dobj.objthedesc(actor)>> with <<self.objthedesc(actor)>>.";
	}
	verDoTurnto(actor, io) = {
		"%You% <<t.cant>> turn <<self.objthedesc(actor)>> to anything.";
	}
	verIoTurnto(actor) = {
		"%You% <<t.cant>> turn anything to <<self.objthedesc(actor)>>.";
	}
	verIoTypeon(actor) = {
		"%You% <<t.cant>> type anything on <<self.objthedesc(actor)>>.";
	}
	verDoUnlock(actor) = { "%You% <<t.cant>> unlock <<self.objthedesc(actor)>>."; }
	verIoUnlockwith(actor) = {
		"%You% <<t.cant>> unlock things with <<self.objthedesc(actor)>>.";
	}
	verDoUnplugfrom(actor, io) = {
		"%You% <<t.cant>> unplug <<self.objthedesc(actor)>> from anything.";
	}
	verIoUnplugfrom(actor) = {
		"%You% <<t.cant>> unplug anything from <<self.objthedesc(actor)>>.";
	}
	verDoUntiefrom(actor, io) = {
		"%You% <<t.cant>> untie <<self.objthedesc(actor)>> from anything.";
	}
	verIoUntiefrom(actor) = {
		"%You% <<t.cant>> untie anything from <<self.objthedesc(actor)>>.";
	}
	verIoUnscrewwith(actor) = {
		"%You% <<t.cant>> unscrew anything with <<self.objthedesc(actor)>>.";
	}
;

modify class Dial
	ldesc = {
		"\^<<self.subjthedesc>> <<t.can>> be turned to settings 
		numbered from <<self.minsetting>> to 
		 <<self.maxsetting>>."; P();

		I(); "\^<<t.itis>> currently set to <<self.setting>>.";
	}
	doTurnto(actor, io) = {
		if (io = numObj) {
			if (numObj.value < self.minsetting or
			    numObj.value > self.maxsetting) {

				    "\^<<t.theres>> no such setting.";
			    }
			 else if (numObj.value <> self.setting) {
				 self.setting := numObj.value;
				 "Okay, <<t.itis>> now turned to
				 <<self.setting>>.";
			 }
			 else {
				 "\^<<t.itis>> already set to <<self.setting>>.";
			 }
		}
		else {
			"%You% <<t.cant>> turn <<self.objthedesc(actor)>>
			\ to that.";
		}
	}
;

modify class Switch
	doSwitch(actor) = {
		self.isactive := not self.isactive;
		"Okay, <<self.subjthedesc>> <<t.is>> now switched ";
		if (self.isactive)
			"on";
		else
			"off";
		".";
	}
	verDoPull(actor) = {
		if (not self.pullable)
			"\^<<actor.subjprodesc>> <<t.cant>> pull
			 <<self.objthedesc(actor)>>.";
	}
	verDoMove(actor) = {
		if (not self.moveable)
			"\^<<actor.subjprodesc>> <<t.cant>> move
			 <<self.objthedesc(actor)>>.";
	}
;

modify class Holder
	doLookX(actor, loctype, emptyquiet) = {
		local	tot;
		if (not actor.canseecontents(self, nil, loctype))
			return;				
		tot := listcontents(self, actor, 3, nil, nil, nil, loctype, true, true, nil, actor.location);
		if (tot = 0 and not emptyquiet)
			"There <<t.doesnt>> appear to be anything <<loctype>> <<self.objthedesc(nil)>>.";
	}
	verIoPutX(actor, dobj, loctype) = {
		// dobj = self?
		if (dobj = self) {
			"%You% <<t.cant>> put <<dobj.objthedesc(actor)>> <<loctype>>
			\ <<dobj.reflexivedesc>>!";
			return;
		}
		// Is the dobj already in this Holder at the top level?
		if (dobj.location = self and dobj.locationtype = loctype) {
			"\^<<dobj.subjthedesc>> <<dobj.is>> already
			 <<loctype>> <<self.objthedesc(nil)>>.";
			return;
		}
	}
	weightexceeded(dobj, loctype) = {
		"\^<<self.subjthedesc>> <<t.cant>> hold any more.";
	}
	bulkexceeded(dobj, loctype) = {
		"\^<<dobj.subjthedesc>> <<t.wont>> fit <<loctype>> 
		 <<self.objthedesc(nil)>>.";
	}
;

modify class Attachable
	verDoAttachto(actor, io) = {
		local	attach, detaching;

		if (self.tieable) {
			attach := 'tie to';
			detaching := 'untying';
		}
		else {
			attach := 'attach to';
			detaching := 'detaching';
		}

		if (find(self.attachesto, io) = nil)
			"%You% <<t.cant>> <<attach>>
			\ <<self.objthedesc(actor)>> to
			 <<io.objthedesc(actor)>>.";
		else if (length(self.attachedto) >= self.maxattachments)
			"%You% <<t.cant>> <<attach>>
			\ <<self.objthedesc(actor)>> to
			 <<io.objthedesc(actor)>> without
			 <<detaching>> it from something else first.";
		else if (length(io.attachedto) >= io.maxattachments)
			"%You% <<t.cant>> <<attach>>
			\ <<io.objthedesc(actor)>> to
			 <<self.objthedesc(actor)>> without
			 <<detaching>> it from something else first.";
		else if (self.location <> io.location or self.locationtype <> io.locationtype) {

			if (not actor.canputinto(io.location, io.locationtype, true))
				actor.canputinto(io.location, io.locationtype, nil);
		}
	}
;

modify class Nestedroom
	verIoPutin(actor) = {
		"%You% <<t.cant>> put anything in <<self.objthedesc(actor)>>.";
	}
	verIoTakeout(actor) = {
		"%You% <<t.cant>> take anything out of <<self.objthedesc(actor)>>.";
	}
;

modify class Sensor
	cansee(obj, loctype, silent) = {
		local	i;

		// Is there a clear line of sight to the object?
		if (not self.seepath(obj, loctype, silent))
			return nil;

		// Is the object visible?
		Outhide(true);
		i := obj.isvisible(self);
		global.canoutput := Outhide(nil);

		if (not i) {
			if (not silent) {
				if (global.canoutput)
					obj.isvisible(self);
				else
					"<<self.subjprodesc>> <<t.cant>> see
					 <<obj.objthedesc(self)>>.";
			}

			return nil;
		}

		return true;			
	}

	// Can this thing touch the object?
	cantouch(obj, loctype, silent) = {
		local	i;

		// Is there a clear path to the object?
		if (not self.touchpath(obj, loctype, silent))
			return nil;
		
		// Is the object touchable?
		Outhide(true);
		i := obj.istouchable(self);
		global.canoutput := Outhide(nil);

		if (not i) {
			if (not silent) {
				if (global.canoutput)
					obj.istouchable(self);
				else
					"<<self.subjprodesc>> <<t.cant>> touch
					 <<obj.objthedesc(self)>>.";
			}

			return nil;
		}

		return true;
	}
	
	// Can this thing take the object?
	cantake(obj, loctype, silent) = {
		local	i;

		// Is there a clear path to the object?
		if (not self.takepath(obj, loctype, silent))
			return nil;
		
		// Is the object takeable?
		Outhide(true);
		i := obj.istakeable(self);
		global.canoutput := Outhide(nil);

		if (not i) {
			if (not silent) {
				if (global.canoutput)
					obj.istakeable(self);
				else
					"<<self.subjprodesc>> <<t.cant>> take
					 <<obj.objthedesc(self)>>.";
			}

			return nil;
		}

		return true;
	}

	// Can this thing smell the object?
	cansmell(obj, loctype, silent) = {
		local	i;

		// Is there a clear line of sight to the object?
		if (not self.smellpath(obj, loctype, silent))
			return nil;
		
		// Is the object smellable?
		Outhide(true);
		i := obj.issmellable(self);
		global.canoutput := Outhide(nil);

		if (not i) {
			if (not silent) {
				if (global.canoutput)
					obj.issmellable(self);
				else
					"<<self.subjprodesc>> <<t.cant>> smell
					 <<obj.objthedesc(self)>>.";
			}

			return nil;
		}

		return true;
	}
	
	// Can this thing hear the object?
	canhear(obj, loctype, silent) = {
		local	i;

		// Is there a clear path to the object?
		if (not self.hearpath(obj, loctype, silent))
			return nil;
		
		// Is the object audible?
		Outhide(true);
		i := obj.isaudible(self);
		global.canoutput := Outhide(nil);

		if (not i) {
			if (not silent) {
				if (global.canoutput)
					obj.isaudible(self);
				else
					"<<self.subjprodesc>> <<t.cant>> hear
					 <<obj.objthedesc(self)>>.";
			}

			return nil;
		}

		return true;
	}

	// Can this thing speak to the object?
	canspeakto(obj, loctype, silent) = {
		local	i;

		// Is there a clear path to the object?
		if (not self.speaktopath(obj, loctype, silent))
			return nil;
		
		// Can the object hear anything?
		Outhide(true);
		i := obj.islistener(self);
		global.canoutput := Outhide(nil);

		if (not i) {
			if (not silent) {
				if (global.canoutput)
					obj.islistener(self);
				else
					"<<obj.subjprodesc>> <<t.cant>> hear
					 <<self.objthedesc(obj)>>.";
			}

			return nil;
		}

		return true;
	}

	// Can this thing put something into the object?
	canputinto(obj, loctype, silent) = {
		local	i;

		// Is there a clear path to the object?
		if (not self.putintopath(obj, loctype, silent))
			return nil;
		
		// Can the object accept things?
		Outhide(true);
		i := obj.acceptsput(self, loctype);
		global.canoutput := Outhide(nil);

		if (not i) {
			if (not silent) {
				if (global.canoutput)
					obj.acceptsput(self, loctype);
				else
					"<<self.subjprodesc>> <<t.cant>> put
					anything <<loctype>>
					\ <<obj.objthedesc(self)>>.";
			}

			return nil;
		}

		return true;
	}
;

modify class Actor
	bulkexceeded(dobj, loctype) = {
		"\^<<self.subjthedesc>> <<t.cant>> carry any more.";
	}

	verDoLookin(actor) = {
		"%You% <<t.cant>> look inside <<self.objthedesc(actor)>>.";
	}
;

modify class Follower
    ldesc = { caps(); self.thedesc; " <<t.is>> no longer <<t.here>>. "; }
    dobjGen(a, v, i, p) =
    {
	if (v <> followVerb)
	{
	    "\^<< self.myactor.thedesc >> <<t.is>> no longer <<t.here>>.";
	    exit;
	}
    }
    iobjGen(a, v, d, p) =
    {
	"\^<< self.myactor.thedesc >> <<t.is>> no longer <<t.here>>.";
	exit;
    }
;

modify class Player
	
	is = "<<t.are>>"
	isnt = "<<t.arent>>"
	does = "<<t.doH>>"
	doesnt = "<<t.dont>>"
	has = "<<t.have>>"
	doesnthave = "<<t.dont>> have"
	youre = "you<<t.re>>"
	ldesc = {
		"You <<t.are>> <<self.position>>";
		if (self.position = 'lying' or self.position = 'sitting')
			" down.";
		else
			".";
	}
	inventory = {
		local	tot;
		caps();
		if (not self.cansee(self, nil, nil))
			return;
		
		tot := listcontents(self, self, 3, nil, nil, nil, nil, true, true, nil, nil);
		if (tot = 0)
			"You <<t.dont>> appear to be carrying anything.";
	}

	verIoPutin(actor) = {
		"%You% <<t.cant>> put things in <<self.objthedesc(actor)>>.";
	}
	verIoTakeout(actor) = {
		"%You% <<t.cant>> take things out of <<self.objthedesc(actor)>>.";
	}
	verIoGiveto(actor) = {
		"%You% <<t.cant>> give things to <<self.objthedesc(actor)>>.";
	}
	verIoShowto(actor) = {
		"%You% <<t.cant>> show things to <<self.objthedesc(actor)>>.";
	}
	verIoThrowat(actor) = {
		"%You% <<t.cant>> throw things at <<self.objthedesc(actor)>>.";
	}
	verIoThrowto(actor) = {
		"%You% <<t.cant>> throw things to <<self.objthedesc(actor)>>.";
	}
	verIoTakefrom(actor) = {
		"%You% <<t.cant>> take things from <<self.objthedesc(actor)>>.";
	}
	starvationmessage(t) = {
		switch (t) {
			case 0:
				P(); I();
				"\^<<self.subjthedesc>> simply <<t.cant>> go on any
				longer without food. \^<<self.subprodesc>> ";
				
				if (self.isplural)
					"perish";
				else
					"perishes";
					
				" from lack of nutrition.";
				break;
			case 5:
			case 10:
				P(); I();
				"\^<<self.subjthedesc>> <<t.cant>> go much
				longer without food. ";
				break;
			case 15:
			case 20:
			case 25:
				P(); I();
				"\^<<self.subjthedesc>> <<self.is>>
				\ feeling very hungry.	\^<<self.subjprodesc>>
				\ better find some food soon.";
				break;
			case 30:
			case 35:
				P(); I();
				"\^<<self.subjthedesc>> <<self.is>>
				\ feeling a bit peckish.  Perhaps it would
				be a good idea to find something to eat.";
				break;
		}
	}
	dehydrationmessage(t) = {
		switch (t) {
			case 0:
				P(); I();
				"\^<<self.subjthedesc>> simply <<t.cant>> go on any
				longer without water. \^<<self.subprodesc>> ";
				
				if (self.isplural)
					"die";
				else
					"dies";
					
				" of thirst.";
				break;
			case 5:
			case 10:
				P(); I();
				"\^<<self.subjthedesc>> <<t.cant>> go much
				longer without water. ";
				break;
			case 15:
			case 20:
			case 25:
				P(); I();
				"\^<<self.subjthedesc>> <<self.is>>
				\ feeling very thirsty.	 \^<<self.subjprodesc>>
				\ better find something to drink soon.";
				break;
			case 30:
			case 35:
				P(); I();
				"\^<<self.subjthedesc>> <<self.is>>
				\ feeling a bit thirsty.  Perhaps it would
				be a good idea to find something to drink.";
				break;
		}
	}
	sleep = {
		P(); I(); "\^<<self.subjthedesc>> ";
		if (self.isplural)
			"<<t.wake>>";
		else
			"<<t.wakes>>";
		" up later with a headache.";
		self.turnsuntilsleep := self.sleeptime;
	}
	sleepmessage(t) = {
		switch (t) {
			case 0:
				P(); I();
				"\^<<self.subjthedesc>> ";

				if (self.isplural)
					"<<t.passH>> out";
				else
					"<<t.passes>> out";

				" from exhaustion.";
				break;
			case 5:
			case 10:
				P(); I();
				"\^<<self.subjthedesc>> <<self.is>> so
				tired, <<self.subjprodesc>> <<t.can>> barely keep
				 <<self.possessivedesc>> eyes open.";
				break;
			case 15:
			case 20:
			case 25:
				P(); I();
				"\^<<self.subjthedesc>> <<self.is>>
				\ feeling very sleepy.	\^<<self.subjprodesc>>
				\ better find a place to rest soon.";
				break;
			case 30:
			case 35:
				P(); I();
				"\^<<self.subjthedesc>> <<self.is>>
				\ feeling a bit sleepy.	 Perhaps it would
				be a good idea to a place to sleep.";
				break;
		}
	}
;

modify class Verb
	cantReach(actor, dolist, iolist, prep) = {
		local	i, lbase, l, isdo;

		if (global.playtestfailtime = global.ticks) {
			"That command is only for playtesting!";
			return;
		}

		if (iolist <> nil) {
			lbase := iolist;
			isdo := nil;
		}
		else {
			lbase := dolist;
			isdo := true;
		}

		l := [];
		for (i := 1; i <= length(lbase); i++) {
			if (lbase[i].isknownto(actor)) {
				l += lbase[i];
			}
		}


		if (l = []) {
			"\^<<actor.subjprodesc>> <<actor.doesnt>> know
			what that is.";

			// "I can't imagine what you're referring to.";

			return;
		}
		else if (length(l) = 1) {
			self.invalidobject(actor, l[1], isdo);
			setit(l[1]);
		}
		else {
			local	l2;

			l2 := [];
			for (i := 1; i <= length(l); i++)
				if (l[i].iscontained(actor.location, nil))
					l2 += l[i];

			if (l2 = [])
				"There <<t.is>> nothing <<t.here>> matching that 
				vocabulary that <<actor.subjprodesc>> <<t.can>>
				do that to.";
			else if (length(l2) = 1) {
				self.invalidobject(actor, l2[1], isdo);
				setit(l2[1]);
			}
			else for (i := 1; i <= length(l2); i++)
				"<<l2[i].multisdesc>>: <<self.invalidobject(actor, l2[i], isdo)>>\n";
		}
	}
	
	invalidobject(actor, o, isdo) = {
		local	v := self;
		
		if (not isclass(actor, Actor)) {
			actor.aamessage(v, o, nil, nil);
			return;
		}

		if (isdo)
			v.checkDo(actor, o, true);
		else
			v.checkIo(actor, o, true);

		if (isdo and v.dolongexplanation or not isdo and v.iolongexplanation) {
			if (not global.canoutput) {
				"%You% <<t.cant>> do that, because ";
			}
			else {
				local	pos;

				pos := find(global.senses, global.failedsense);
				if (pos <> nil)
					"(trying to <<global.senses[pos+1]>>
					\ <<o.objthedesc(actor)>> first)\b";

				caps();
			}
		}
		else	
			caps();

		if (isdo)
			v.checkDo(actor, o, nil);
		else
			v.checkIo(actor, o, nil);
	}
;
