void() Calc_G_time_1;
void() Calc_G_time_2;
entity() spawn_load;
void() AddToQue_apply;

/*
============
spawn_marker

============
*/
entity(vector org) spawn_marker =
{
	marker_ = spawn();
	marker_.classname = "marker";
	marker_.flags = FL_MARKER;
	marker_.origin_x = rint(org_x);
	marker_.origin_y = rint(org_y);
	marker_.origin_z = rint(org_z);
	marker_.solid = SOLID_TRIGGER;
	marker_.touch = marker_touch;
	marker_.frame = 12;

#ifdef MANUAL

	marker_.display = marker_;	// only used in manual mode (is own display entity)
	setmodel (marker_, "progs/player.mdl");
	marker_.mdl = marker_.model;
	if (!manual_mode)
		marker_.model = "";

#endif // MANUAL

	marker_.view_ofs = '81 81 25';
	setsize (marker_, '-80 -80 -24', '80 80 32');
};

/*
============
check_marker

============
*/
void() check_marker =
{
	if (random() < 0.25)
	{
		self.touchPlayer = other;
		self.touchPlayerTime = time + 2.5;
	}

	distance = vlen(self.absmin + self.view_ofs - other.origin);
	if (distance < other.touch_distance)
	{
		other.touch_distance = distance;
		other.touch_marker = self;
		other.Z_ = self.Z_;
		other.touch_marker_time = time + 5;
	}
};

/*
============
marker_touch

============
*/
void() marker_touch =
{
	if (marker_time)
	if (other.client_)
		check_marker();
};

/*
============
LocateMarker

Bot disorientated / BackPacks.
============
*/
entity(vector org) LocateMarker =
{
	shortest_distance = 1000000;
	closest_marker = world;

	marker_ = findradius(org, 1000);
	while (marker_)
	{
		if (marker_.flags & FL_MARKER)
		{
			if (marker_.classname != "trigger_teleport")
			{
				marker_pos = marker_.absmin + marker_.view_ofs;
				distance = vlen(marker_pos - org);
				traceline(org, marker_pos, TRUE, world);
				if (trace_fraction != 1)
					distance = distance + 1000;
				if (distance < shortest_distance)
				{
					shortest_distance = distance;
					closest_marker = marker_;
				}
			}
		}
		marker_ = marker_.chain;
	}

	return closest_marker;
};

/*
============
N  (New marker)

Load a marker
============
*/
void(vector org) N =
{
// put on save que
	spawn_marker(org);
	self = marker_;
	AddToQue();
};

/*
============
LSQ   (Left Shift Que)

============
*/
void() LSQ =
{
	self = world;
	while ((floor(que_size * 0.02) * 50) != que_size)
		AddToQue_apply();
};

/*
============
AddToQue

============
*/
void() AddToQue_apply =
{
// Note: Max 100000 commands in a function call

	if (que_size < 50)
	{
		m1=m2;m2=m3;m3=m4;m4=m5;m5=m6;m6=m7;m7=m8;m8=m9;m9=m10;m10=m11;
		m11=m12;m12=m13;m13=m14;m14=m15;m15=m16;m16=m17;m17=m18;m18=m19;m19=m20;m20=m21;
		m21=m22;m22=m23;m23=m24;m24=m25;m25=m26;m26=m27;m27=m28;m28=m29;m29=m30;m30=m31;
		m31=m32;m32=m33;m33=m34;m34=m35;m35=m36;m36=m37;m37=m38;m38=m39;m39=m40;m40=m41;
		m41=m42;m42=m43;m43=m44;m44=m45;m45=m46;m46=m47;m47=m48;m48=m49;m49=m50;m50=self;
	}
	else if (que_size < 100)
	{
		m51=m52;m52=m53;m53=m54;m54=m55;m55=m56;m56=m57;m57=m58;m58=m59;m59=m60;m60=m61;
		m61=m62;m62=m63;m63=m64;m64=m65;m65=m66;m66=m67;m67=m68;m68=m69;m69=m70;m70=m71;
		m71=m72;m72=m73;m73=m74;m74=m75;m75=m76;m76=m77;m77=m78;m78=m79;m79=m80;m80=m81;
		m81=m82;m82=m83;m83=m84;m84=m85;m85=m86;m86=m87;m87=m88;m88=m89;m89=m90;m90=m91;
		m91=m92;m92=m93;m93=m94;m94=m95;m95=m96;m96=m97;m97=m98;m98=m99;m99=m100;m100=self;
	}
	else if (que_size < 150)
	{
		m101=m102;m102=m103;m103=m104;m104=m105;m105=m106;m106=m107;m107=m108;m108=m109;m109=m110;m110=m111;
		m111=m112;m112=m113;m113=m114;m114=m115;m115=m116;m116=m117;m117=m118;m118=m119;m119=m120;m120=m121;
		m121=m122;m122=m123;m123=m124;m124=m125;m125=m126;m126=m127;m127=m128;m128=m129;m129=m130;m130=m131;
		m131=m132;m132=m133;m133=m134;m134=m135;m135=m136;m136=m137;m137=m138;m138=m139;m139=m140;m140=m141;
		m141=m142;m142=m143;m143=m144;m144=m145;m145=m146;m146=m147;m147=m148;m148=m149;m149=m150;m150=self;
	}
	else if (que_size < 200)
	{
		m151=m152;m152=m153;m153=m154;m154=m155;m155=m156;m156=m157;m157=m158;m158=m159;m159=m160;m160=m161;
		m161=m162;m162=m163;m163=m164;m164=m165;m165=m166;m166=m167;m167=m168;m168=m169;m169=m170;m170=m171;
		m171=m172;m172=m173;m173=m174;m174=m175;m175=m176;m176=m177;m177=m178;m178=m179;m179=m180;m180=m181;
		m181=m182;m182=m183;m183=m184;m184=m185;m185=m186;m186=m187;m187=m188;m188=m189;m189=m190;m190=m191;
		m191=m192;m192=m193;m193=m194;m194=m195;m195=m196;m196=m197;m197=m198;m198=m199;m199=m200;m200=self;
	}
	else if (que_size < 250)
	{
		m201=m202;m202=m203;m203=m204;m204=m205;m205=m206;m206=m207;m207=m208;m208=m209;m209=m210;m210=m211;
		m211=m212;m212=m213;m213=m214;m214=m215;m215=m216;m216=m217;m217=m218;m218=m219;m219=m220;m220=m221;
		m221=m222;m222=m223;m223=m224;m224=m225;m225=m226;m226=m227;m227=m228;m228=m229;m229=m230;m230=m231;
		m231=m232;m232=m233;m233=m234;m234=m235;m235=m236;m236=m237;m237=m238;m238=m239;m239=m240;m240=m241;
		m241=m242;m242=m243;m243=m244;m244=m245;m245=m246;m246=m247;m247=m248;m248=m249;m249=m250;m250=self;
	}
	else if (que_size < 300)
	{
		m251=m252;m252=m253;m253=m254;m254=m255;m255=m256;m256=m257;m257=m258;m258=m259;m259=m260;m260=m261;
		m261=m262;m262=m263;m263=m264;m264=m265;m265=m266;m266=m267;m267=m268;m268=m269;m269=m270;m270=m271;
		m271=m272;m272=m273;m273=m274;m274=m275;m275=m276;m276=m277;m277=m278;m278=m279;m279=m280;m280=m281;
		m281=m282;m282=m283;m283=m284;m284=m285;m285=m286;m286=m287;m287=m288;m288=m289;m289=m290;m290=m291;
		m291=m292;m292=m293;m293=m294;m294=m295;m295=m296;m296=m297;m297=m298;m298=m299;m299=m300;m300=self;
	}
#ifdef MANUAL
	else
	{
		msg_level = PRINT_HIGH;
		bprint("ERROR: Max Que size exceeded\n");
	}
#endif // MANUAL

	que_size = que_size + 1;
};

void() AddToQue =
{
	marker_index = marker_index + 1;
	self.index = marker_index;
	AddToQue_apply();
};

/*
============
ExistsPath

============
*/
float() ExistsPath =
{
	if (from_marker.P0 == to_marker)
		return TRUE;
	if (from_marker.P1 == to_marker)
		return TRUE;
	if (from_marker.P2 == to_marker)
		return TRUE;
	if (from_marker.P3 == to_marker)
		return TRUE;
	if (from_marker.P4 == to_marker)
		return TRUE;
	if (from_marker.P5 == to_marker)
		return TRUE;
	return FALSE;
};

/*
============
AssignVirtualGoal

============
*/
void() AssignVirtualGoal =
{
	marker_ = self.Z_head;

	while (marker_)
	{
		test_goal = marker_;
		if (test_goal.nextthink)
		{
			goal_number = marker_.G_;

			test_goal = marker_.P0;
			if ((test_goal.G_ != goal_number) || (test_goal.nextthink))
			{
				test_goal = marker_.P1;
				if ((test_goal.G_ != goal_number) || (test_goal.nextthink))
				{
					test_goal = marker_.P2;
					if ((test_goal.G_ != goal_number) || (test_goal.nextthink))
					{
						test_goal = marker_.P3;
						if ((test_goal.G_ != goal_number) || (test_goal.nextthink))
						{
							test_goal = marker_.P4;
							if ((test_goal.G_ != goal_number) || (test_goal.nextthink))
							{
								test_goal = marker_.P5;
								if ((test_goal.G_ != goal_number) || (test_goal.nextthink))
								{
									if ((marker_.nextthink > 0) && (marker_.think == SUB_regen))
										test_goal = marker_;
									else
										test_goal = dropper;
								}
							}
						}
					}
				}
			}
		}
		marker_.virtual_goal = test_goal;

		marker_ = marker_.Z_next;
	}
};

/*
============
set_view_ofs_z

============
*/
void() set_view_ofs_z =
{
	self.view_ofs = 0.5 * (self.absmax - self.absmin);
	self.view_ofs_z = self.absmax_z - self.absmin_z + 23;
};

/*
============
InvalidMap

============
*/
void() InvalidMap =
{
	msg_entity = self;
	msg_level = PRINT_HIGH;
	sprint(mapname);
	sprint(" is not a supported map.\n");
	sprint("The list of supported maps is:\n");
	sprint("dm4, dm6, ztndm3.\n");
};

/*
============
LoadMarkers

Make sure InvalidMap is updated!!!
============
*/
void() map_dm6;
void() map_dm4;
void() map_ztndm3;
//void() map_dm3;
//void() map_dm2;
//void() map_ztndm5;

void() LoadMarkers =
{
	item_marker_index = marker_index;

	if (mapname == "dm6")
		map_dm6();
	else if (mapname == "dm4")
		map_dm4();
	else if (mapname == "ztndm3")
		map_ztndm3();
//	else if (mapname == "dm3")
//		map_dm3();
//	else if (mapname == "dm2")
//		map_dm2();
//	else if (mapname == "ztndm5")
//		map_ztndm5();
	else
	{
		load_frogbots = invalid_map = TRUE;
		return;
	}

	m = first_ent;

	load_position1 = spawn_load();
	load_position2 = spawn_load();
	load_position3 = spawn_load();
	load_position4 = spawn_load();
	load_position5 = spawn_load();
	load_position6 = spawn_load();
	load_position7 = spawn_load();
	load_position8 = spawn_load();
	load_position9 = spawn_load();
	load_position10 = spawn_load();
	load_position11 = spawn_load();
	load_position12 = spawn_load();
	load_position13 = spawn_load();
	load_position14 = spawn_load();
	load_position15 = spawn_load();
	load_position16 = spawn_load();
	load_position17 = spawn_load();
	load_position18 = spawn_load();
	load_position19 = spawn_load();
	load_position20 = spawn_load();

	load_position1.think = Calc_G_time_1;
};

/*
============
spawn_load

============
*/
entity() spawn_load =
{
	load_position = spawn();
	load_position.nextthink = 0.001;
	load_position.think = Calc_G_time_2;
	load_position.next = current_load_position;
	current_load_position = load_position;
	return load_position;
};

/*
============
TravelTime

============
*/
void() TravelTime =
{
	if (m.classname == "trigger_teleport")
		traveltime = 0.5;	// destination is only path
	else
		traveltime = ((vlen((to_marker.absmin + to_marker.view_ofs) - m_pos) / sv_maxspeed));
};

/*
============
Calc_G_time_1

============
*/
void() Calc_G_time_1 =
{
//	local float count_;

// Note: Max 100000 commands in a function call

	self.nextthink = 0.001;

	dropper.flags = FL_MARKER;

	while (TRUE)
	{
		if (m.flags & FL_MARKER)
		{
			m_pos = m.absmin + m.view_ofs;

			if (m.Z_)
			{
				if (m.P0)
				{
					to_marker = m.P0;
					TravelTime();
					m.P0_time = traveltime;
				}

				if (m.P1)
				{
					to_marker = m.P1;
					TravelTime();
					m.P1_time = traveltime;
				}

				if (m.P2)
				{
					to_marker = m.P2;
					TravelTime();
					m.P2_time = traveltime;
				}

				if (m.P3)
				{
					to_marker = m.P3;
					TravelTime();
					m.P3_time = traveltime;
				}

				if (m.P4)
				{
					to_marker = m.P4;
					TravelTime();
					m.P4_time = traveltime;
				}

				if (m.P5)
				{
					to_marker = m.P5;
					TravelTime();
					m.P5_time = traveltime;
				}
			}

			if (!m.G1_) {m.G1_time = 1000; m.G1_ = dropper;}
			if (!m.G2_) {m.G2_time = 1000; m.G2_ = dropper;}
			if (!m.G3_) {m.G3_time = 1000; m.G3_ = dropper;}
			if (!m.G4_) {m.G4_time = 1000; m.G4_ = dropper;}
			if (!m.G5_) {m.G5_time = 1000; m.G5_ = dropper;}
			if (!m.G6_) {m.G6_time = 1000; m.G6_ = dropper;}
			if (!m.G7_) {m.G7_time = 1000; m.G7_ = dropper;}
			if (!m.G8_) {m.G8_time = 1000; m.G8_ = dropper;}
			if (!m.G9_) {m.G9_time = 1000; m.G9_ = dropper;}
			if (!m.G10_) {m.G10_time = 1000; m.G10_ = dropper;}
			if (!m.G11_) {m.G11_time = 1000; m.G11_ = dropper;}
			if (!m.G12_) {m.G12_time = 1000; m.G12_ = dropper;}
			if (!m.G13_) {m.G13_time = 1000; m.G13_ = dropper;}
			if (!m.G14_) {m.G14_time = 1000; m.G14_ = dropper;}
			if (!m.G15_) {m.G15_time = 1000; m.G15_ = dropper;}
			if (!m.G16_) {m.G16_time = 1000; m.G16_ = dropper;}
			if (!m.G17_) {m.G17_time = 1000; m.G17_ = dropper;}
			if (!m.G18_) {m.G18_time = 1000; m.G18_ = dropper;}
			if (!m.G19_) {m.G19_time = 1000; m.G19_ = dropper;}
			if (!m.G20_) {m.G20_time = 1000; m.G20_ = dropper;}
			if (!m.G21_) {m.G21_time = 1000; m.G21_ = dropper;}
			if (!m.G22_) {m.G22_time = 1000; m.G22_ = dropper;}
			if (!m.G23_) {m.G23_time = 1000; m.G23_ = dropper;}
			if (!m.G24_) {m.G24_time = 1000; m.G24_ = dropper;}

			if (!m.Z1_) {m.Z1_time = 1000; m.Z1_ = dropper;}
			if (!m.Z2_) {m.Z2_time = 1000; m.Z2_ = dropper;}
			if (!m.Z3_) {m.Z3_time = 1000; m.Z3_ = dropper;}
			if (!m.Z4_) {m.Z4_time = 1000; m.Z4_ = dropper;}
			if (!m.Z5_) {m.Z5_time = 1000; m.Z5_ = dropper;}
			if (!m.Z6_) {m.Z6_time = 1000; m.Z6_ = dropper;}
			if (!m.Z7_) {m.Z7_time = 1000; m.Z7_ = dropper;}
			if (!m.Z8_) {m.Z8_time = 1000; m.Z8_ = dropper;}
			if (!m.Z9_) {m.Z9_time = 1000; m.Z9_ = dropper;}
			if (!m.Z10_) {m.Z10_time = 1000; m.Z10_ = dropper;}
			if (!m.Z11_) {m.Z11_time = 1000; m.Z11_ = dropper;}
			if (!m.Z12_) {m.Z12_time = 1000; m.Z12_ = dropper;}
			if (!m.Z13_) {m.Z13_time = 1000; m.Z13_ = dropper;}
			if (!m.Z14_) {m.Z14_time = 1000; m.Z14_ = dropper;}
			if (!m.Z15_) {m.Z15_time = 1000; m.Z15_ = dropper;}
			if (!m.Z16_) {m.Z16_time = 1000; m.Z16_ = dropper;}

			if (m.S_ != 1) m.S1_time = 1000;
			if (m.S_ != 2) m.S2_time = 1000;
			if (m.S_ != 3) m.S3_time = 1000;
			if (m.S_ != 4) m.S4_time = 1000;
			if (m.S_ != 5) m.S5_time = 1000;
			if (m.S_ != 6) m.S6_time = 1000;
			if (m.S_ != 7) m.S7_time = 1000;
			if (m.S_ != 8) m.S8_time = 1000;
			if (m.S_ != 9) m.S9_time = 1000;
			if (m.S_ != 10) m.S10_time = 1000;
			if (m.S_ != 11) m.S11_time = 1000;
			if (m.S_ != 12) m.S12_time = 1000;
			if (m.S_ != 13) m.S13_time = 1000;
			if (m.S_ != 14) m.S14_time = 1000;
			if (m.S_ != 15) m.S15_time = 1000;
			if (m.S_ != 16) m.S16_time = 1000;
			if (m.S_ != 17) m.S17_time = 1000;
			if (m.S_ != 18) m.S18_time = 1000;
			if (m.S_ != 19) m.S19_time = 1000;
			if (m.S_ != 20) m.S20_time = 1000;
			if (m.S_ != 21) m.S21_time = 1000;
			if (m.S_ != 22) m.S22_time = 1000;
			if (m.S_ != 23) m.S23_time = 1000;
			if (m.S_ != 24) m.S24_time = 1000;
			if (m.S_ != 25) m.S25_time = 1000;
			if (m.S_ != 26) m.S26_time = 1000;
			if (m.S_ != 27) m.S27_time = 1000;
			if (m.S_ != 28) m.S28_time = 1000;
			if (m.S_ != 29) m.S29_time = 1000;
			if (m.S_ != 30) m.S30_time = 1000;
			if (m.S_ != 31) m.S31_time = 1000;
			if (m.S_ != 32) m.S32_time = 1000;

			m.touch_marker = m;

//			count_ = count_ + 1;
		}

		m = nextent(m);

		if (!m)
		{
			m = first_ent;
			no_change = TRUE;
			load_position1.think = Calc_G_time_2;

			dropper.flags = 0;

			return;
		}
/*
		// load 150 at a time
		if (count_ == 150)
			return;
*/
	}
};

/*
============
Calc_G_time_2_apply

============
*/
void() Calc_G_time_2_apply =
{
	if (m_P)
	{
		if (m.G1_time > (P_time + m_P.G1_time)) { no_change = FALSE; m.G1_ = m_P.G1_; m.G1_time = P_time + m_P.G1_time; }
		if (m.G2_time > (P_time + m_P.G2_time)) { no_change = FALSE; m.G2_ = m_P.G2_; m.G2_time = P_time + m_P.G2_time; }
		if (m.G3_time > (P_time + m_P.G3_time)) { no_change = FALSE; m.G3_ = m_P.G3_; m.G3_time = P_time + m_P.G3_time; }
		if (m.G4_time > (P_time + m_P.G4_time)) { no_change = FALSE; m.G4_ = m_P.G4_; m.G4_time = P_time + m_P.G4_time; }
		if (m.G5_time > (P_time + m_P.G5_time)) { no_change = FALSE; m.G5_ = m_P.G5_; m.G5_time = P_time + m_P.G5_time; }
		if (m.G6_time > (P_time + m_P.G6_time)) { no_change = FALSE; m.G6_ = m_P.G6_; m.G6_time = P_time + m_P.G6_time; }
		if (m.G7_time > (P_time + m_P.G7_time)) { no_change = FALSE; m.G7_ = m_P.G7_; m.G7_time = P_time + m_P.G7_time; }
		if (m.G8_time > (P_time + m_P.G8_time)) { no_change = FALSE; m.G8_ = m_P.G8_; m.G8_time = P_time + m_P.G8_time; }
		if (m.G9_time > (P_time + m_P.G9_time)) { no_change = FALSE; m.G9_ = m_P.G9_; m.G9_time = P_time + m_P.G9_time; }
		if (m.G10_time > (P_time + m_P.G10_time)) { no_change = FALSE; m.G10_ = m_P.G10_; m.G10_time = P_time + m_P.G10_time; }
		if (m.G11_time > (P_time + m_P.G11_time)) { no_change = FALSE; m.G11_ = m_P.G11_; m.G11_time = P_time + m_P.G11_time; }
		if (m.G12_time > (P_time + m_P.G12_time)) { no_change = FALSE; m.G12_ = m_P.G12_; m.G12_time = P_time + m_P.G12_time; }
		if (m.G13_time > (P_time + m_P.G13_time)) { no_change = FALSE; m.G13_ = m_P.G13_; m.G13_time = P_time + m_P.G13_time; }
		if (m.G14_time > (P_time + m_P.G14_time)) { no_change = FALSE; m.G14_ = m_P.G14_; m.G14_time = P_time + m_P.G14_time; }
		if (m.G15_time > (P_time + m_P.G15_time)) { no_change = FALSE; m.G15_ = m_P.G15_; m.G15_time = P_time + m_P.G15_time; }
		if (m.G16_time > (P_time + m_P.G16_time)) { no_change = FALSE; m.G16_ = m_P.G16_; m.G16_time = P_time + m_P.G16_time; }
		if (m.G17_time > (P_time + m_P.G17_time)) { no_change = FALSE; m.G17_ = m_P.G17_; m.G17_time = P_time + m_P.G17_time; }
		if (m.G18_time > (P_time + m_P.G18_time)) { no_change = FALSE; m.G18_ = m_P.G18_; m.G18_time = P_time + m_P.G18_time; }
		if (m.G19_time > (P_time + m_P.G19_time)) { no_change = FALSE; m.G19_ = m_P.G19_; m.G19_time = P_time + m_P.G19_time; }
		if (m.G20_time > (P_time + m_P.G20_time)) { no_change = FALSE; m.G20_ = m_P.G20_; m.G20_time = P_time + m_P.G20_time; }
		if (m.G21_time > (P_time + m_P.G21_time)) { no_change = FALSE; m.G21_ = m_P.G21_; m.G21_time = P_time + m_P.G21_time; }
		if (m.G22_time > (P_time + m_P.G22_time)) { no_change = FALSE; m.G22_ = m_P.G22_; m.G22_time = P_time + m_P.G22_time; }
		if (m.G23_time > (P_time + m_P.G23_time)) { no_change = FALSE; m.G23_ = m_P.G23_; m.G23_time = P_time + m_P.G23_time; }
		if (m.G24_time > (P_time + m_P.G24_time)) { no_change = FALSE; m.G24_ = m_P.G24_; m.G24_time = P_time + m_P.G24_time; }

		if (m.Z_ == m_P.Z_)
		{
			if (m.S1_time > (P_time + m_P.S1_time)) { no_change = FALSE; m.S1_time = P_time + m_P.S1_time; }
			if (m.S2_time > (P_time + m_P.S2_time)) { no_change = FALSE; m.S2_time = P_time + m_P.S2_time; }
			if (m.S3_time > (P_time + m_P.S3_time)) { no_change = FALSE; m.S3_time = P_time + m_P.S3_time; }
			if (m.S4_time > (P_time + m_P.S4_time)) { no_change = FALSE; m.S4_time = P_time + m_P.S4_time; }
			if (m.S5_time > (P_time + m_P.S5_time)) { no_change = FALSE; m.S5_time = P_time + m_P.S5_time; }
			if (m.S6_time > (P_time + m_P.S6_time)) { no_change = FALSE; m.S6_time = P_time + m_P.S6_time; }
			if (m.S7_time > (P_time + m_P.S7_time)) { no_change = FALSE; m.S7_time = P_time + m_P.S7_time; }
			if (m.S8_time > (P_time + m_P.S8_time)) { no_change = FALSE; m.S8_time = P_time + m_P.S8_time; }
			if (m.S9_time > (P_time + m_P.S9_time)) { no_change = FALSE; m.S9_time = P_time + m_P.S9_time; }
			if (m.S10_time > (P_time + m_P.S10_time)) { no_change = FALSE; m.S10_time = P_time + m_P.S10_time; }
			if (m.S11_time > (P_time + m_P.S11_time)) { no_change = FALSE; m.S11_time = P_time + m_P.S11_time; }
			if (m.S12_time > (P_time + m_P.S12_time)) { no_change = FALSE; m.S12_time = P_time + m_P.S12_time; }
			if (m.S13_time > (P_time + m_P.S13_time)) { no_change = FALSE; m.S13_time = P_time + m_P.S13_time; }
			if (m.S14_time > (P_time + m_P.S14_time)) { no_change = FALSE; m.S14_time = P_time + m_P.S14_time; }
			if (m.S15_time > (P_time + m_P.S15_time)) { no_change = FALSE; m.S15_time = P_time + m_P.S15_time; }
			if (m.S16_time > (P_time + m_P.S16_time)) { no_change = FALSE; m.S16_time = P_time + m_P.S16_time; }
			if (m.S17_time > (P_time + m_P.S17_time)) { no_change = FALSE; m.S17_time = P_time + m_P.S17_time; }
			if (m.S18_time > (P_time + m_P.S18_time)) { no_change = FALSE; m.S18_time = P_time + m_P.S18_time; }
			if (m.S19_time > (P_time + m_P.S19_time)) { no_change = FALSE; m.S19_time = P_time + m_P.S19_time; }
			if (m.S20_time > (P_time + m_P.S20_time)) { no_change = FALSE; m.S20_time = P_time + m_P.S20_time; }
			if (m.S21_time > (P_time + m_P.S21_time)) { no_change = FALSE; m.S21_time = P_time + m_P.S21_time; }
			if (m.S22_time > (P_time + m_P.S22_time)) { no_change = FALSE; m.S22_time = P_time + m_P.S22_time; }
			if (m.S23_time > (P_time + m_P.S23_time)) { no_change = FALSE; m.S23_time = P_time + m_P.S23_time; }
			if (m.S24_time > (P_time + m_P.S24_time)) { no_change = FALSE; m.S24_time = P_time + m_P.S24_time; }
			if (m.S25_time > (P_time + m_P.S25_time)) { no_change = FALSE; m.S25_time = P_time + m_P.S25_time; }
			if (m.S26_time > (P_time + m_P.S26_time)) { no_change = FALSE; m.S26_time = P_time + m_P.S26_time; }
			if (m.S27_time > (P_time + m_P.S27_time)) { no_change = FALSE; m.S27_time = P_time + m_P.S27_time; }
			if (m.S28_time > (P_time + m_P.S28_time)) { no_change = FALSE; m.S28_time = P_time + m_P.S28_time; }
			if (m.S29_time > (P_time + m_P.S29_time)) { no_change = FALSE; m.S29_time = P_time + m_P.S29_time; }
			if (m.S30_time > (P_time + m_P.S30_time)) { no_change = FALSE; m.S30_time = P_time + m_P.S30_time; }
			if (m.S31_time > (P_time + m_P.S31_time)) { no_change = FALSE; m.S31_time = P_time + m_P.S31_time; }
			if (m.S32_time > (P_time + m_P.S32_time)) { no_change = FALSE; m.S32_time = P_time + m_P.S32_time; }
		}

		if (m.Z1_time > (P_time + m_P.Z1_time)) { no_change = FALSE; m.Z1_ = m_P.Z1_; m.Z1_time = P_time + m_P.Z1_time; m.Z1_task = m_D | m_P.Z1_task; }
		if (m.Z2_time > (P_time + m_P.Z2_time)) { no_change = FALSE; m.Z2_ = m_P.Z2_; m.Z2_time = P_time + m_P.Z2_time; }
		if (m.Z3_time > (P_time + m_P.Z3_time)) { no_change = FALSE; m.Z3_ = m_P.Z3_; m.Z3_time = P_time + m_P.Z3_time; }
		if (m.Z4_time > (P_time + m_P.Z4_time)) { no_change = FALSE; m.Z4_ = m_P.Z4_; m.Z4_time = P_time + m_P.Z4_time; }
		if (m.Z5_time > (P_time + m_P.Z5_time)) { no_change = FALSE; m.Z5_ = m_P.Z5_; m.Z5_time = P_time + m_P.Z5_time; }
		if (m.Z6_time > (P_time + m_P.Z6_time)) { no_change = FALSE; m.Z6_ = m_P.Z6_; m.Z6_time = P_time + m_P.Z6_time; }
		if (m.Z7_time > (P_time + m_P.Z7_time)) { no_change = FALSE; m.Z7_ = m_P.Z7_; m.Z7_time = P_time + m_P.Z7_time; }
		if (m.Z8_time > (P_time + m_P.Z8_time)) { no_change = FALSE; m.Z8_ = m_P.Z8_; m.Z8_time = P_time + m_P.Z8_time; }
		if (m.Z9_time > (P_time + m_P.Z9_time)) { no_change = FALSE; m.Z9_ = m_P.Z9_; m.Z9_time = P_time + m_P.Z9_time; }
		if (m.Z10_time > (P_time + m_P.Z10_time)) { no_change = FALSE; m.Z10_ = m_P.Z10_; m.Z10_time = P_time + m_P.Z10_time; }
		if (m.Z11_time > (P_time + m_P.Z11_time)) { no_change = FALSE; m.Z11_ = m_P.Z11_; m.Z11_time = P_time + m_P.Z11_time; }
		if (m.Z12_time > (P_time + m_P.Z12_time)) { no_change = FALSE; m.Z12_ = m_P.Z12_; m.Z12_time = P_time + m_P.Z12_time; }
		if (m.Z13_time > (P_time + m_P.Z13_time)) { no_change = FALSE; m.Z13_ = m_P.Z13_; m.Z13_time = P_time + m_P.Z13_time; }
		if (m.Z14_time > (P_time + m_P.Z14_time)) { no_change = FALSE; m.Z14_ = m_P.Z14_; m.Z14_time = P_time + m_P.Z14_time; }
		if (m.Z15_time > (P_time + m_P.Z15_time)) { no_change = FALSE; m.Z15_ = m_P.Z15_; m.Z15_time = P_time + m_P.Z15_time; }
		if (m.Z16_time > (P_time + m_P.Z16_time)) { no_change = FALSE; m.Z16_ = m_P.Z16_; m.Z16_time = P_time + m_P.Z16_time; }
	}
};

/*
============
Calc_G_time_2

============
*/
void() Calc_G_time_2 =
{
	local float count_;

// Note: Max 100000 commands in a function call

	self.nextthink = 0.001;

	while (TRUE)
	{
		if (m.flags & FL_MARKER)
		{
			m_P = m.P0;
			m_D = m.D0;
			P_time = m.P0_time;
			Calc_G_time_2_apply();

			m_P = m.P1;
			m_D = m.D1;
			P_time = m.P1_time;
			Calc_G_time_2_apply();

			m_P = m.P2;
			m_D = m.D2;
			P_time = m.P2_time;
			Calc_G_time_2_apply();

			m_P = m.P3;
			m_D = m.D3;
			P_time = m.P3_time;
			Calc_G_time_2_apply();

			m_P = m.P4;
			m_D = m.D4;
			P_time = m.P4_time;
			Calc_G_time_2_apply();

			m_P = m.P5;
			m_D = m.D5;
			P_time = m.P5_time;
			Calc_G_time_2_apply();

			count_ = count_ + 1;
		}

		m = nextent(m);

		if (!m)
		{
			m = first_ent;

			if (no_change)
			{
				time_start = time;
				framecount_start = framecount;

				markers_loaded = load_frogbots = TRUE;
				while (current_load_position)
				{
					remove_apply(current_load_position);
					current_load_position = current_load_position.next;	// current_load_position still has values
				}
				return;
			}

			no_change = TRUE;
		}

		// load 40 at a time
		if (count_ == 40)
			return;
	}
};

/*
============
Field loading functions

============
*/

void(entity marker) G1 = { marker.G1_ = marker; marker.G_ = 1; };
void(entity marker) G2 = { marker.G2_ = marker; marker.G_ = 2; };
void(entity marker) G3 = { marker.G3_ = marker; marker.G_ = 3; };
void(entity marker) G4 = { marker.G4_ = marker; marker.G_ = 4; };
void(entity marker) G5 = { marker.G5_ = marker; marker.G_ = 5; };
void(entity marker) G6 = { marker.G6_ = marker; marker.G_ = 6; };
void(entity marker) G7 = { marker.G7_ = marker; marker.G_ = 7; };
void(entity marker) G8 = { marker.G8_ = marker; marker.G_ = 8; };
void(entity marker) G9 = { marker.G9_ = marker; marker.G_ = 9; };
void(entity marker) G10 = { marker.G10_ = marker; marker.G_ = 10; };
void(entity marker) G11 = { marker.G11_ = marker; marker.G_ = 11; };
void(entity marker) G12 = { marker.G12_ = marker; marker.G_ = 12; };
void(entity marker) G13 = { marker.G13_ = marker; marker.G_ = 13; };
void(entity marker) G14 = { marker.G14_ = marker; marker.G_ = 14; };
void(entity marker) G15 = { marker.G15_ = marker; marker.G_ = 15; };
void(entity marker) G16 = { marker.G16_ = marker; marker.G_ = 16; };
void(entity marker) G17 = { marker.G17_ = marker; marker.G_ = 17; };
void(entity marker) G18 = { marker.G18_ = marker; marker.G_ = 18; };
void(entity marker) G19 = { marker.G19_ = marker; marker.G_ = 19; };
void(entity marker) G20 = { marker.G20_ = marker; marker.G_ = 20; };
void(entity marker) G21 = { marker.G21_ = marker; marker.G_ = 21; };
void(entity marker) G22 = { marker.G22_ = marker; marker.G_ = 22; };
void(entity marker) G23 = { marker.G23_ = marker; marker.G_ = 23; };
void(entity marker) G24 = { marker.G24_ = marker; marker.G_ = 24; };


void() S1_time_ = { traveltime = zone_time + middle_marker.S1_time; };
void() S2_time_ = { traveltime = zone_time + middle_marker.S2_time; };
void() S3_time_ = { traveltime = zone_time + middle_marker.S3_time; };
void() S4_time_ = { traveltime = zone_time + middle_marker.S4_time; };
void() S5_time_ = { traveltime = zone_time + middle_marker.S5_time; };
void() S6_time_ = { traveltime = zone_time + middle_marker.S6_time; };
void() S7_time_ = { traveltime = zone_time + middle_marker.S7_time; };
void() S8_time_ = { traveltime = zone_time + middle_marker.S8_time; };
void() S9_time_ = { traveltime = zone_time + middle_marker.S9_time; };
void() S10_time_ = { traveltime = zone_time + middle_marker.S10_time; };
void() S11_time_ = { traveltime = zone_time + middle_marker.S11_time; };
void() S12_time_ = { traveltime = zone_time + middle_marker.S12_time; };
void() S13_time_ = { traveltime = zone_time + middle_marker.S13_time; };
void() S14_time_ = { traveltime = zone_time + middle_marker.S14_time; };
void() S15_time_ = { traveltime = zone_time + middle_marker.S15_time; };
void() S16_time_ = { traveltime = zone_time + middle_marker.S16_time; };
void() S17_time_ = { traveltime = zone_time + middle_marker.S17_time; };
void() S18_time_ = { traveltime = zone_time + middle_marker.S18_time; };
void() S19_time_ = { traveltime = zone_time + middle_marker.S19_time; };
void() S20_time_ = { traveltime = zone_time + middle_marker.S20_time; };
void() S21_time_ = { traveltime = zone_time + middle_marker.S21_time; };
void() S22_time_ = { traveltime = zone_time + middle_marker.S22_time; };
void() S23_time_ = { traveltime = zone_time + middle_marker.S23_time; };
void() S24_time_ = { traveltime = zone_time + middle_marker.S24_time; };
void() S25_time_ = { traveltime = zone_time + middle_marker.S25_time; };
void() S26_time_ = { traveltime = zone_time + middle_marker.S26_time; };
void() S27_time_ = { traveltime = zone_time + middle_marker.S27_time; };
void() S28_time_ = { traveltime = zone_time + middle_marker.S28_time; };
void() S29_time_ = { traveltime = zone_time + middle_marker.S29_time; };
void() S30_time_ = { traveltime = zone_time + middle_marker.S30_time; };
void() S31_time_ = { traveltime = zone_time + middle_marker.S31_time; };
void() S32_time_ = { traveltime = zone_time + middle_marker.S32_time; };


void(entity marker) Set_sub_arrival_time =
{
	marker.S_ = S_index;
	if (S_index <= 16)
	{
		if (S_index <= 8)
		{
			if (S_index <= 4)
			{
				if (S_index <= 2)
				{
					if (S_index == 1)
						marker.sub_arrival_time = S1_time_;
					else
						marker.sub_arrival_time = S2_time_;
				}
				else
				{
					if (S_index == 3)
						marker.sub_arrival_time = S3_time_;
					else
						marker.sub_arrival_time = S4_time_;
				}
			}
			else
			{
				if (S_index <= 6)
				{
					if (S_index == 5)
						marker.sub_arrival_time = S5_time_;
					else
						marker.sub_arrival_time = S6_time_;
				}
				else
				{
					if (S_index == 7)
						marker.sub_arrival_time = S7_time_;
					else
						marker.sub_arrival_time = S8_time_;
				}
			}
		}
		else
		{
			if (S_index <= 12)
			{
				if (S_index <= 10)
				{
					if (S_index == 9)
						marker.sub_arrival_time = S9_time_;
					else
						marker.sub_arrival_time = S10_time_;
				}
				else
				{
					if (S_index == 11)
						marker.sub_arrival_time = S11_time_;
					else
						marker.sub_arrival_time = S12_time_;
				}
			}
			else
			{
				if (S_index <= 14)
				{
					if (S_index == 13)
						marker.sub_arrival_time = S13_time_;
					else
						marker.sub_arrival_time = S14_time_;
				}
				else
				{
					if (S_index == 15)
						marker.sub_arrival_time = S15_time_;
					else
						marker.sub_arrival_time = S16_time_;
				}
			}
		}
	}
	else
	{
		if (S_index <= 24)
		{
			if (S_index <= 20)
			{
				if (S_index <= 18)
				{
					if (S_index == 17)
						marker.sub_arrival_time = S17_time_;
					else
						marker.sub_arrival_time = S18_time_;
				}
				else
				{
					if (S_index == 19)
						marker.sub_arrival_time = S19_time_;
					else
						marker.sub_arrival_time = S20_time_;
				}
			}
			else
			{
				if (S_index <= 22)
				{
					if (S_index == 21)
						marker.sub_arrival_time = S21_time_;
					else
						marker.sub_arrival_time = S22_time_;
				}
				else
				{
					if (S_index == 23)
						marker.sub_arrival_time = S23_time_;
					else
						marker.sub_arrival_time = S24_time_;
				}
			}
		}
		else
		{
			if (S_index <= 28)
			{
				if (S_index <= 26)
				{
					if (S_index == 25)
						marker.sub_arrival_time = S25_time_;
					else
						marker.sub_arrival_time = S26_time_;
				}
				else
				{
					if (S_index == 27)
						marker.sub_arrival_time = S27_time_;
					else
						marker.sub_arrival_time = S28_time_;
				}
			}
			else
			{
				if (S_index <= 30)
				{
					if (S_index == 29)
						marker.sub_arrival_time = S29_time_;
					else
						marker.sub_arrival_time = S30_time_;
				}
				else
				{
					if (S_index == 31)
						marker.sub_arrival_time = S31_time_;
					else
						marker.sub_arrival_time = S32_time_;
				}
			}
		}
	}
};


// zone 1
entity() Z1_marker =
{
	middle_marker = from_marker.Z1_;
	zone_time = from_marker.Z1_time;
};

void(entity marker) Z1 =
{
	marker.Z1_ = marker;
	marker.Z_ = 1;
	marker.zone_marker = Z1_marker;
	Z1_S_index = Z1_S_index + 1;
	S_index = Z1_S_index;
	Set_sub_arrival_time(marker);

	if (Z1_tail)
	{
		Z1_tail.Z_next = marker;
		Z1_tail = marker;
	}
	else
		Z1_head = Z1_tail = marker;

	marker.Z_head = Z1_head;
};

// zone 2
entity() Z2_marker =
{
	middle_marker = from_marker.Z2_;
	zone_time = from_marker.Z2_time;
};

void(entity marker) Z2 =
{
	marker.Z2_ = marker;
	marker.Z_ = 2;
	marker.zone_marker = Z2_marker;
	Z2_S_index = Z2_S_index + 1;
	S_index = Z2_S_index;
	Set_sub_arrival_time(marker);

	if (Z2_tail)
	{
		Z2_tail.Z_next = marker;
		Z2_tail = marker;
	}
	else
		Z2_head = Z2_tail = marker;

	marker.Z_head = Z2_head;
};

// zone 3
entity() Z3_marker =
{
	middle_marker = from_marker.Z3_;
	zone_time = from_marker.Z3_time;
};

void(entity marker) Z3 =
{
	marker.Z3_ = marker;
	marker.Z_ = 3;
	marker.zone_marker = Z3_marker;
	Z3_S_index = Z3_S_index + 1;
	S_index = Z3_S_index;
	Set_sub_arrival_time(marker);

	if (Z3_tail)
	{
		Z3_tail.Z_next = marker;
		Z3_tail = marker;
	}
	else
		Z3_head = Z3_tail = marker;

	marker.Z_head = Z3_head;
};

// zone 4
entity() Z4_marker =
{
	middle_marker = from_marker.Z4_;
	zone_time = from_marker.Z4_time;
};

void(entity marker) Z4 =
{
	marker.Z4_ = marker;
	marker.Z_ = 4;
	marker.zone_marker = Z4_marker;
	Z4_S_index = Z4_S_index + 1;
	S_index = Z4_S_index;
	Set_sub_arrival_time(marker);

	if (Z4_tail)
	{
		Z4_tail.Z_next = marker;
		Z4_tail = marker;
	}
	else
		Z4_head = Z4_tail = marker;

	marker.Z_head = Z4_head;
};

// zone 5
entity() Z5_marker =
{
	middle_marker = from_marker.Z5_;
	zone_time = from_marker.Z5_time;
};

void(entity marker) Z5 =
{
	marker.Z5_ = marker;
	marker.Z_ = 5;
	marker.zone_marker = Z5_marker;
	Z5_S_index = Z5_S_index + 1;
	S_index = Z5_S_index;
	Set_sub_arrival_time(marker);

	if (Z5_tail)
	{
		Z5_tail.Z_next = marker;
		Z5_tail = marker;
	}
	else
		Z5_head = Z5_tail = marker;

	marker.Z_head = Z5_head;
};

// zone 6
entity() Z6_marker =
{
	middle_marker = from_marker.Z6_;
	zone_time = from_marker.Z6_time;
};

void(entity marker) Z6 =
{
	marker.Z6_ = marker;
	marker.Z_ = 6;
	marker.zone_marker = Z6_marker;
	Z6_S_index = Z6_S_index + 1;
	S_index = Z6_S_index;
	Set_sub_arrival_time(marker);

	if (Z6_tail)
	{
		Z6_tail.Z_next = marker;
		Z6_tail = marker;
	}
	else
		Z6_head = Z6_tail = marker;

	marker.Z_head = Z6_head;
};

// zone 7
entity() Z7_marker =
{
	middle_marker = from_marker.Z7_;
	zone_time = from_marker.Z7_time;
};

void(entity marker) Z7 =
{
	marker.Z7_ = marker;
	marker.Z_ = 7;
	marker.zone_marker = Z7_marker;
	Z7_S_index = Z7_S_index + 1;
	S_index = Z7_S_index;
	Set_sub_arrival_time(marker);

	if (Z7_tail)
	{
		Z7_tail.Z_next = marker;
		Z7_tail = marker;
	}
	else
		Z7_head = Z7_tail = marker;

	marker.Z_head = Z7_head;
};

// zone 8
entity() Z8_marker =
{
	middle_marker = from_marker.Z8_;
	zone_time = from_marker.Z8_time;
};

void(entity marker) Z8 =
{
	marker.Z8_ = marker;
	marker.Z_ = 8;
	marker.zone_marker = Z8_marker;
	Z8_S_index = Z8_S_index + 1;
	S_index = Z8_S_index;
	Set_sub_arrival_time(marker);

	if (Z8_tail)
	{
		Z8_tail.Z_next = marker;
		Z8_tail = marker;
	}
	else
		Z8_head = Z8_tail = marker;

	marker.Z_head = Z8_head;
};

// zone 9
entity() Z9_marker =
{
	middle_marker = from_marker.Z9_;
	zone_time = from_marker.Z9_time;
};

void(entity marker) Z9 =
{
	marker.Z9_ = marker;
	marker.Z_ = 9;
	marker.zone_marker = Z9_marker;
	Z9_S_index = Z9_S_index + 1;
	S_index = Z9_S_index;
	Set_sub_arrival_time(marker);

	if (Z9_tail)
	{
		Z9_tail.Z_next = marker;
		Z9_tail = marker;
	}
	else
		Z9_head = Z9_tail = marker;

	marker.Z_head = Z9_head;
};

// zone 10
entity() Z10_marker =
{
	middle_marker = from_marker.Z10_;
	zone_time = from_marker.Z10_time;
};

void(entity marker) Z10 =
{
	marker.Z10_ = marker;
	marker.Z_ = 10;
	marker.zone_marker = Z10_marker;
	Z10_S_index = Z10_S_index + 1;
	S_index = Z10_S_index;
	Set_sub_arrival_time(marker);

	if (Z10_tail)
	{
		Z10_tail.Z_next = marker;
		Z10_tail = marker;
	}
	else
		Z10_head = Z10_tail = marker;

	marker.Z_head = Z10_head;
};

// zone 11
entity() Z11_marker =
{
	middle_marker = from_marker.Z11_;
	zone_time = from_marker.Z11_time;
};

void(entity marker) Z11 =
{
	marker.Z11_ = marker;
	marker.Z_ = 11;
	marker.zone_marker = Z11_marker;
	Z11_S_index = Z11_S_index + 1;
	S_index = Z11_S_index;
	Set_sub_arrival_time(marker);

	if (Z11_tail)
	{
		Z11_tail.Z_next = marker;
		Z11_tail = marker;
	}
	else
		Z11_head = Z11_tail = marker;

	marker.Z_head = Z11_head;
};

// zone 12
entity() Z12_marker =
{
	middle_marker = from_marker.Z12_;
	zone_time = from_marker.Z12_time;
};

void(entity marker) Z12 =
{
	marker.Z12_ = marker;
	marker.Z_ = 12;
	marker.zone_marker = Z12_marker;
	Z12_S_index = Z12_S_index + 1;
	S_index = Z12_S_index;
	Set_sub_arrival_time(marker);

	if (Z12_tail)
	{
		Z12_tail.Z_next = marker;
		Z12_tail = marker;
	}
	else
		Z12_head = Z12_tail = marker;

	marker.Z_head = Z12_head;
};

// zone 13
entity() Z13_marker =
{
	middle_marker = from_marker.Z13_;
	zone_time = from_marker.Z13_time;
};

void(entity marker) Z13 =
{
	marker.Z13_ = marker;
	marker.Z_ = 13;
	marker.zone_marker = Z13_marker;
	Z13_S_index = Z13_S_index + 1;
	S_index = Z13_S_index;
	Set_sub_arrival_time(marker);

	if (Z13_tail)
	{
		Z13_tail.Z_next = marker;
		Z13_tail = marker;
	}
	else
		Z13_head = Z13_tail = marker;

	marker.Z_head = Z13_head;
};

// zone 14
entity() Z14_marker =
{
	middle_marker = from_marker.Z14_;
	zone_time = from_marker.Z14_time;
};

void(entity marker) Z14 =
{
	marker.Z14_ = marker;
	marker.Z_ = 14;
	marker.zone_marker = Z14_marker;
	Z14_S_index = Z14_S_index + 1;
	S_index = Z14_S_index;
	Set_sub_arrival_time(marker);

	if (Z14_tail)
	{
		Z14_tail.Z_next = marker;
		Z14_tail = marker;
	}
	else
		Z14_head = Z14_tail = marker;

	marker.Z_head = Z14_head;
};

// zone 15
entity() Z15_marker =
{
	middle_marker = from_marker.Z15_;
	zone_time = from_marker.Z15_time;
};

void(entity marker) Z15 =
{
	marker.Z15_ = marker;
	marker.Z_ = 15;
	marker.zone_marker = Z15_marker;
	Z15_S_index = Z15_S_index + 1;
	S_index = Z15_S_index;
	Set_sub_arrival_time(marker);

	if (Z15_tail)
	{
		Z15_tail.Z_next = marker;
		Z15_tail = marker;
	}
	else
		Z15_head = Z15_tail = marker;

	marker.Z_head = Z15_head;
};

// zone 16
entity() Z16_marker =
{
	middle_marker = from_marker.Z16_;
	zone_time = from_marker.Z16_time;
};

void(entity marker) Z16 =
{
	marker.Z16_ = marker;
	marker.Z_ = 16;
	marker.zone_marker = Z16_marker;
	Z16_S_index = Z16_S_index + 1;
	S_index = Z16_S_index;
	Set_sub_arrival_time(marker);

	if (Z16_tail)
	{
		Z16_tail.Z_next = marker;
		Z16_tail = marker;
	}
	else
		Z16_head = Z16_tail = marker;

	marker.Z_head = Z16_head;
};





#ifdef MANUAL

void() ConnectMarker;
void() DisconnectMarker;
void(string print_string) DescriptionMarker;
void() SaveCoords;
void() SavePaths;
void(entity marker) changed_view_ofs_z;

/*
===========
FrogbotManual

============
*/
void() FrogbotManual =
{
	if (self.flags & FL_PLAYER)
	{
		if (self.touch_marker)
			manual_marker_touch(self.touch_marker);

		MarkerDisplay();
	}

	if (!(self.flags & FL_FROGBOT))
		return;

	self.pitchaccel = self.yawaccel = self.button0_ = self.arrow = 0;
};

/*
============
manual_marker_touch

============
*/
void(entity marker) manual_marker_touch =
{
	if (mode & STATIC_ACTIVE_MARKER)
	{
		if (!active_marker)
			return;
		if (marker == active_marker)
			return;
		if (mode & CONNECT_MARKERS)
		{
			from_marker = active_marker;
			to_marker = marker;

			if (path_mode == DISCONNECT_MARKERS)
				DisconnectMarker();
			else
			{
				ConnectMarker();

				if (mode & ONE_WAY)
				{
					description = NO_LOOK;
					DescriptionMarker("no look");
					description = DIFFICULT;
					DescriptionMarker("difficult");
					description = DM6_DOOR;
					DescriptionMarker("dm6 door");
					description = WAIT_GROUND;
					DescriptionMarker("wait ground");
					description = SHORT_HAZARD;
					DescriptionMarker("short hazard");
					description = JUMP_LEDGE;
					DescriptionMarker("jump ledge");
					description = LOOKAHEAD;
					DescriptionMarker("look ahead");
					description = HIGH_ENOUGH;
					DescriptionMarker("high enough");
				}
				else
				{
					from_marker = marker;
					to_marker = active_marker;
					ConnectMarker();
				}
			}

			mode = mode - CONNECT_MARKERS;
		}

		if (mode & DISPLAY_TRAVEL_TIME)
		{
			from_marker = active_marker;
			marker.zone_marker();
			marker.sub_arrival_time();
			bprintold("time from active marker = ");
			bprintold(ftos(traveltime));
			bprintold("\n");

			from_marker = marker;
			active_marker.zone_marker();
			active_marker.sub_arrival_time();
			bprintold("time to active marker = ");
			bprintold(ftos(traveltime));
			bprintold("\n");

			mode = mode - DISPLAY_TRAVEL_TIME;
		}
	}
	else
	{
		if (active_marker)
			active_marker.display.frame = 12;
		active_marker = marker;
		active_marker.display.frame = 0;
	}
};

/*
============
RemoveActiveMarker

============
*/
void() RemoveActiveMarker =
{
	if (!active_marker)
	{
		bprintold("no active marker\n");
		return;
	}
	if (active_marker.classname == "marker")
	{
		m = first_ent;
		while (m)
		{
			if (m.flags & FL_MARKER)
			{
				if (m.P0 == active_marker)
					m.P0 = world;
				if (m.P1 == active_marker)
					m.P1 = world;
				if (m.P2 == active_marker)
					m.P2 = world;
				if (m.P3 == active_marker)
					m.P3 = world;
				if (m.P4 == active_marker)
					m.P4 = world;
				if (m.P5 == active_marker)
					m.P5 = world;
			}

			m = nextent(m);
		}

		remove_apply(active_marker);
		bprintold("active marker removed\n");
		active_marker = world;
	}
	else
		bprintold("Active marker cannot be removed\n");
};

/*
============
DisableActiveMarker

============
*/
void() DisableActiveMarker =
{
	if (!active_marker)
	{
		bprintold("no active marker\n");
		return;
	}
	bprintold("active marker disabled\n");
	active_marker.display.frame = 12;
	active_marker = world;
	if (!(mode & STATIC_ACTIVE_MARKER))
	{
		mode = mode | STATIC_ACTIVE_MARKER;
		bprintold("static active marker ON\n");
	}
};

/*
============
ClearActiveMarker

============
*/
void() ClearActiveMarker =
{
	if (!active_marker)
	{
		bprintold("no active marker\n");
		return;
	}

	active_marker.P0 = active_marker.P1 = active_marker.P2 = active_marker.P3 =
	active_marker.P4 = active_marker.P5 = world;
	active_marker.D0 = active_marker.D1 = active_marker.D2 = active_marker.D3 =
	active_marker.D4 = active_marker.D5 = 0;
	bprintold("Active marker path cleared\n");
};

/*
============
DisplayZone

============
*/
void() DisplayZone =
{
	marker_ = first_ent;
	while (marker_)
	{
		if (marker_.flags & FL_MARKER)
		{
			if (marker_.Z_ == active_marker.Z_)
				marker_.display.angles_y = marker_.display.angles_y + (frametime * 90);
		}
		marker_ = nextent(marker_);
	}
};

/*
============
Display

============
*/
void(entity marker_P, float marker_D) Display =
{
	if (!marker_P)
		return FALSE;
	return ((path_mode & marker_D) == path_mode);
};

/*
============
MarkerDisplay

============
*/
void() MarkerDisplay =
{
	if (mode & CLOSEST_MARKER)
	{
		if (active_marker)
		{
			active_marker.display.frame = 12;
		}
		active_marker = LocateMarker(self.origin);
	}

	if (!active_marker)
		return;

	active_marker.display.frame = 0;

	if (mode & DISPLAY_ZONE)
		DisplayZone();
	else if (mode & DISPLAY_TYPE)
	{
		if (active_marker.T)
			if ((active_marker.T & type_mode) == type_mode)
				active_marker.display.angles_y = active_marker.display.angles_y + (frametime * 90);
	}
	else
	{
		if (Display(active_marker.P0, active_marker.D0))
			active_marker.P0.display.angles_y = active_marker.P0.display.angles_y + (frametime * 90);
		if (Display(active_marker.P1, active_marker.D1))
			active_marker.P1.display.angles_y = active_marker.P1.display.angles_y + (frametime * 90);
		if (Display(active_marker.P2, active_marker.D2))
			active_marker.P2.display.angles_y = active_marker.P2.display.angles_y + (frametime * 90);
		if (Display(active_marker.P3, active_marker.D3))
			active_marker.P3.display.angles_y = active_marker.P3.display.angles_y + (frametime * 90);
		if (Display(active_marker.P4, active_marker.D4))
			active_marker.P4.display.angles_y = active_marker.P4.display.angles_y + (frametime * 90);
		if (Display(active_marker.P5, active_marker.D5))
			active_marker.P5.display.angles_y = active_marker.P5.display.angles_y + (frametime * 90);
	}
};

/*
============
ConnectMarker

============
*/
void() ConnectMarker =
{
	if (!from_marker.P0)
	{
		bprintold("marker connected on path 0\n");
		from_marker.P0 = to_marker;
		from_marker.D0 = 0;
	}
	else if (from_marker.P0 == to_marker)
		return;
	else if (!from_marker.P1)
	{
		bprintold("marker connected on path 1\n");
		from_marker.P1 = to_marker;
		from_marker.D1 = 0;
	}
	else if (from_marker.P1 == to_marker)
		return;
	else if (!from_marker.P2)
	{
		bprintold("marker connected on path 2\n");
		from_marker.P2 = to_marker;
		from_marker.D2 = 0;
	}
	else if (from_marker.P2 == to_marker)
		return;
	else if (!from_marker.P3)
	{
		bprintold("marker connected on path 3\n");
		from_marker.P3 = to_marker;
		from_marker.D3 = 0;
	}
	else if (from_marker.P3 == to_marker)
		return;
	else if (!from_marker.P4)
	{
		bprintold("marker connected on path 4\n");
		from_marker.P4 = to_marker;
		from_marker.D4 = 0;
	}
	else if (from_marker.P4 == to_marker)
		return;
	else if (!from_marker.P5)
	{
		bprintold("marker connected on path 5\n");
		from_marker.P5 = to_marker;
		from_marker.D5 = 0;
	}
	else if (from_marker.P5 == to_marker)
		return;
	else
		bprintold("to_markerets full.\n");
};

/*
============
DisconnectMarker

============
*/
void() DisconnectMarker =
{
	if (from_marker.P0 == to_marker)
	{
		bprintold("marker disconnected on path 0\n");
		from_marker.P0 = world;
		from_marker.D0 = 0;
	}
	else if (from_marker.P1 == to_marker)
	{
		bprintold("marker disconnected on path 1\n");
		from_marker.P1 = world;
		from_marker.D1 = 0;
	}
	else if (from_marker.P2 == to_marker)
	{
		bprintold("marker disconnected on path 2\n");
		from_marker.P2 = world;
		from_marker.D2 = 0;
	}
	else if (from_marker.P3 == to_marker)
	{
		bprintold("marker disconnected on path 3\n");
		from_marker.P3 = world;
		from_marker.D3 = 0;
	}
	else if (from_marker.P4 == to_marker)
	{
		bprintold("marker disconnected on path 4\n");
		from_marker.P4 = world;
		from_marker.D4 = 0;
	}
	else if (from_marker.P5 == to_marker)
	{
		bprintold("marker disconnected on path 5\n");
		from_marker.P5 = world;
		from_marker.D5 = 0;
	}
};

/*
============
PrintDescription

============
*/
void(string print_string, float path_number) PrintDescription =
{
	bprintold("marker ");
	bprintold(print_string);
	bprintold(" on path ");
	bprintold(ftos(path_number));
	bprintold("\n");
};

/*
============
DescriptionMarker

============
*/
void(string print_string) DescriptionMarker =
{
	if (!(path_mode & description))
		return;

	if (from_marker.P0 == to_marker)
	{
		PrintDescription(print_string, 0);
		from_marker.D0 = from_marker.D0 | description;
	}
	else if (from_marker.P1 == to_marker)
	{
		PrintDescription(print_string, 1);
		from_marker.D1 = from_marker.D1 | description;
	}
	else if (from_marker.P2 == to_marker)
	{
		PrintDescription(print_string, 2);
		from_marker.D2 = from_marker.D2 | description;
	}
	else if (from_marker.P3 == to_marker)
	{
		PrintDescription(print_string, 3);
		from_marker.D3 = from_marker.D3 | description;
	}
	else if (from_marker.P4 == to_marker)
	{
		PrintDescription(print_string, 4);
		from_marker.D4 = from_marker.D4 | description;
	}
	else if (from_marker.P5 == to_marker)
	{
		PrintDescription(print_string, 5);
		from_marker.D5 = from_marker.D5 | description;
	}
};

/*
============
Save_m_G

============
*/
void(entity m_G, string field) Save_m_G =
{
	if (m_G == m)
	{
		bprintold(field);
		bprintold("(m");
		bprintold(ftos(m_G.index));
		bprintold(");");
	}
};

/*
============
Save_m_P

============
*/
void(string field) Save_m_P =
{
	if (m_P)
	{
		bprintold("m");
		bprintold(ftos(m.index));
		bprintold(".");
		bprintold(field);
		bprintold("=m");
		bprintold(ftos(m_P.index));
		bprintold(";");
	}
};

/*
============
Save_m_D

============
*/
void(string field) Save_m_D =
{
	if (m_P)
	{
		if (m_D)
		{
			bprintold("m");
			bprintold(ftos(m.index));
			bprintold(".");
			bprintold(field);
			bprintold("=");
			bprintold(ftos(m_D));
			bprintold(";");
		}
	}
};

/*
============
Save_dm6_door

============
*/
void() Save_dm6_door =
{
	bprintold("dm6_door=m");
	bprintold(ftos(m.index));
	bprintold(";\n");
};

/*
============
SaveMarkers

============
*/
void() SaveMarkers =
{
	if (markers_loaded || invalid_map)
	{
	// too big to print out all at once, print in stages

		bprintold("void() map_");
		bprintold(mapname);
		bprintold(" =\n");

		bprintold("{\n");

		m = first_ent;
		marker_index = item_marker_index;

		save_position = spawn();
		save_position.nextthink = time + 0.1;
		save_position.think = SaveCoords;
	}
};

/*
============
SaveCoords

============
*/
void() SaveCoords =
{
	local float count_;

	self.nextthink = time + 0.1;

	while (m)
	{
		if (m.classname == "marker")
		{
			marker_index = marker_index + 1;
			m.index = marker_index;

			bprintold("N('");
			bprintold(ftos(m.origin_x));
			bprintold(" ");
			bprintold(ftos(m.origin_y));
			bprintold(" ");
			bprintold(ftos(m.origin_z));
			bprintold("');");

		// print 10 out at a time
			count_ = count_ + 1;
		}
		m = nextent(m);
		if (count_ == 10)
		{
			bprintold("\n");
			return;
		}
	}

	if (count_)
		bprintold("\n");

	bprintold("LSQ();\n");

	m = first_ent;

	self.think = SavePaths;
};

/*
============
SavePaths

============
*/
void() SavePaths =
{
	local float count_;

	self.nextthink = time + 0.1;

	while (m)
	{
		if (m.flags & FL_MARKER)
		{
			if (changed_view_ofs_z(m))
			{
				bprintold("m");
				bprintold(ftos(m.index));
				bprintold(".view_ofs_z=");
				bprintold(ftos(m.view_ofs_z));
				bprintold(";");
			}

			if (m.T)
			{
				bprintold("m");
				bprintold(ftos(m.index));
				bprintold(".T=");
				bprintold(ftos(m.T));
				bprintold(";");
			}

		//
		// save goal
		//

			if (m.G_)
			if (m.flags & FL_ITEM)
			{
				if ((m.classname != "item_cells") || (m.G_ != 19))
				if ((m.classname != "weapon_supernailgun") || (m.G_ != 20))
				if ((m.classname != "weapon_supershotgun") || (m.G_ != 21))
				if ((m.classname != "weapon_nailgun") || (m.G_ != 22))
				if ((m.classname != "item_spikes") || (m.G_ != 23))
				if ((m.classname != "item_shells") || (m.G_ != 24))
				{
					bprintold("G");
					bprintold_ftos(m.G_);
					bprintold("(m");
					bprintold_ftos(m.index);
					bprintold(");");
				}
			}

		//
		// save zone
		//

			if (m.Z_)
			{
				bprintold("Z");
				bprintold_ftos(m.Z_);
				bprintold("(m");
				bprintold_ftos(m.index);
				bprintold(");");
			}

			m_P = m.P0;
			Save_m_P("P0");
			m_P = m.P1;
			Save_m_P("P1");
			m_P = m.P2;
			Save_m_P("P2");
			m_P = m.P3;
			Save_m_P("P3");
			m_P = m.P4;
			Save_m_P("P4");
			m_P = m.P5;
			Save_m_P("P5");

			m_P = m.P0;
			m_D = m.D0;
			Save_m_D("D0");

			m_P = m.P1;
			m_D = m.D1;
			Save_m_D("D1");

			m_P = m.P2;
			m_D = m.D2;
			Save_m_D("D2");

			m_P = m.P3;
			m_D = m.D3;
			Save_m_D("D3");

			m_P = m.P4;
			m_D = m.D4;
			Save_m_D("D4");

			m_P = m.P5;
			m_D = m.D5;
			Save_m_D("D5");

		// map specific stuff

			if (mapname == "dm6")
			{
				if (m.classname == "door")
					Save_dm6_door();
			}


		// print 10 out at a time
			count_ = count_ + 1;
		}

		m = nextent(m);
		if (count_ == 10)
		{
			bprintold("\n");
			return;
		}
	}

	if (count_)
		bprintold("\n");

	bprintold("};\n");

	remove();	// all done
};

/*
============
DisplayAllMarkers

============
*/
void() DisplayAllMarkers =
{
	marker_ = first_ent;
	while (marker_)
	{
		if (marker_.classname == "marker")
		{
			marker_.model = marker_.mdl;
		}
		else if (marker_.flags & FL_MARKER)
		{
			virtual_marker = spawn();
			virtual_marker.classname = "virtual_marker";
			marker_.display = virtual_marker;
			virtual_marker.origin = marker_.absmin + marker_.view_ofs;
			virtual_marker.frame = 12;
			setmodel (virtual_marker, "progs/player.mdl");
			virtual_marker.mdl = virtual_marker.model;
			if (!manual_mode)
				virtual_marker.model = "";
		}
		marker_ = nextent(marker_);
	}
};

/*
============
MoveActiveMarker

============
*/
void() MoveActiveMarker =
{
	if (!active_marker)
	{
		bprintold("no active marker\n");
		return;
	}
	if (active_marker.classname == "marker")
	{
		bprintold("active marker moved\n");
		active_marker.origin_x = rint(self.origin_x);
		active_marker.origin_y = rint(self.origin_y);
		active_marker.origin_z = rint(self.origin_z);
		setsize (active_marker, VEC_HULL_MIN, VEC_HULL_MAX);
	}
	else
		bprintold("Active marker cannot be moved\n");
};

/*
============
VerMoveActiveMarker

============
*/
void() VerMoveActiveMarker =
{
	if (!active_marker)
	{
		bprintold("no active marker\n");
		return;
	}

	bprintold("active marker vertically moved\n");

	if (active_marker.classname == "marker")
		active_marker.origin_z = rint(self.origin_z);
	else
	{
		active_marker.view_ofs_z = rint(self.origin_z - active_marker.absmin_z);
		active_marker.display.origin_z = rint(self.origin_z);
	}
};

/*
============
HideAllMarkers

============
*/
void() HideAllMarkers =
{
	marker_ = first_ent;
	while (marker_)
	{
		if (marker_.classname == "marker")
			marker_.model = "";
		else if (marker_.classname == "virtual_marker")
			remove_apply(marker_);
		marker_ = nextent(marker_);
	}
};

/*
============
changed_view_ofs_z

============
*/
void(entity marker) changed_view_ofs_z =
{
	if (marker.classname == "marker")
	{
		return FALSE;
	}
	else if ((marker.classname == "door") ||
	         (marker.classname == "plat") || (marker.classname == "train"))
	{
		if (marker.view_ofs_z == (marker.absmax_z - marker.absmin_z + 23))
			return FALSE;
	}
	else
	{
		if (marker.view_ofs_z == 25)
			return FALSE;
	}

	return TRUE;
};

/*
============
print_goal

============
*/
void() print_goal =
{
	if (!goal_index)
		bprintold("clear goal");
	else if (goal_index <= NUMBER_GOALS)
	{
		bprintold("goal index = ");
		bprintold_ftos(goal_index);
	}
	else
	{
		bprintold("zone index = ");
		bprintold_ftos(goal_index - NUMBER_GOALS);
	}
	bprintold("\n");
};

/*
============
IncGoal

============
*/
void() IncGoal =
{
	goal_index = goal_index + 1;
	if (goal_index > (NUMBER_GOALS + NUMBER_ZONES))
		goal_index = 0;
	print_goal();
};

/*
============
DecGoal

============
*/
void() DecGoal =
{
	goal_index = goal_index - 1;
	if (goal_index < 0)
		goal_index = (NUMBER_GOALS + NUMBER_ZONES);
	print_goal();
};

/*
============
SetGoal

============
*/
void() SetGoal =
{
	if (!active_marker)
	{
		bprintold("no active marker\n");
		return;
	}

	if (goal_index <= NUMBER_GOALS)
	{
		if (!(active_marker.flags & FL_ITEM))
		{
			bprint("goal must be an item.\n");
			return;
		}

		if (!goal_index)
		{
			active_marker.G_ = 0;
			bprintold("goal cleared\n");
			return;
		}

		Z_index = goal_index;
		S_index = 0;
		active_marker.G_ = Z_index;

		marker_ = first_ent;
		while (marker_)
		{
			if (marker_.flags & FL_MARKER)
			{
				if (marker_.G_ == Z_index)
					S_index = S_index + 1;
			}
			marker_ = nextent(marker_);
		}

		bprintold("goal ");
	}
	else
	{
		Z_index = goal_index - NUMBER_GOALS;

	//
	// TrySet_Z
	//

		S_index = 1;

		active_marker.Z_ = 0;	// clear first

		marker_ = first_ent;
		while (marker_)
		{
			if (marker_.flags & FL_MARKER)
			{
				if (marker_.Z_ == Z_index)
					S_index = S_index + 1;
			}
			marker_ = nextent(marker_);
		}

		if (S_index <= NUMBER_SUBZONES)
		{
			active_marker.Z_ = Z_index;
			bprintold("zone ");
		}
		else
		{
			bprintold("Zone full.\n");
			return;
		}
	}

	bprintold_ftos(Z_index);
	bprintold(" set (total = ");
	bprintold_ftos(S_index);
	bprint(")\n");
};

/*
============
PrintGoals

============
*/
void() PrintGoals =
{
	if (!active_marker)
	{
		bprintold("no active marker\n");
		return;
	}

	bprintold("zone = ");
	bprintold_ftos(active_marker.Z_);
	bprintold("\n");

	if (active_marker.G_)
	{
		bprintold("goal = ");
		bprintold_ftos(active_marker.G_);
		bprintold("\n");
	}
};

/*
============
ToggleManualMode

============
*/
void() ToggleManualMode =
{
	if (manual_mode)
	{
		manual_mode = FALSE;
		HideAllMarkers();
		bprintold("Manual mode OFF\n");
	}
	else
	{
		manual_mode = TRUE;
		DisplayAllMarkers();
		bprintold("Manual mode ON\n");
	}
};

/*
============
ToggleActiveMarker

============
*/
void() ToggleActiveMarker =
{
	if (mode & STATIC_ACTIVE_MARKER)
	{
		mode = mode - STATIC_ACTIVE_MARKER;
		bprintold("static active marker OFF\n");
	}
	else
	{
		mode = mode | STATIC_ACTIVE_MARKER;
		bprintold("static active marker ON\n");
	}
};

/*
============
ToggleOneWayMode

============
*/
void() ToggleOneWayMode =
{
	if (mode & ONE_WAY)
	{
		mode = mode - ONE_WAY;
		bprintold("one way mode OFF\n");
	}
	else
	{
		mode = mode | ONE_WAY;
		bprintold("one way mode ON\n");
	}
};

/*
============
ToggleConnectMarkersMode

============
*/
void() ToggleConnectMarkersMode =
{
	if (mode & DISPLAY_TYPE)
	{
		if (!active_marker)
			return;

		if (type_mode)
		{
			active_marker.T = active_marker.T | type_mode;
			bprintold("active marker type SET\n");
		}
		else
		{
			active_marker.T = 0;
			bprintold("active marker type CLEARED\n");
		}

		return;
	}

	if (mode & CONNECT_MARKERS)
	{
		mode = mode - CONNECT_MARKERS;
		bprintold("connect markers mode OFF\n");
	}
	else
	{
		mode = mode | CONNECT_MARKERS;
		bprintold("connect markers mode ON\n");
		if (!(mode & STATIC_ACTIVE_MARKER))
		{
			mode = mode | STATIC_ACTIVE_MARKER;
			bprintold("static active marker ON\n");
		}
	}
};

/*
============
CycleDescriptionMode

============
*/
void() CycleDescriptionMode =
{
	if (mode & DISPLAY_TYPE)
	{
		if (type_mode == 0)
		{
			type_mode = UNREACHABLE;
			bprintold("unreachable node ON\n");
		}
		else if (type_mode == UNREACHABLE)
		{
			type_mode = 0;
			bprintold("type mode OFF\n");
		}
	}
	else
	{
		if (path_mode == 0)
		{
			path_mode = DIFFICULT;
			bprintold("difficult mode ON\n");
		}
		else if (path_mode == DIFFICULT)
		{
			path_mode = NO_LOOK;
			bprintold("no look mode ON\n");
		}
		else if (path_mode == NO_LOOK)
		{
			path_mode = WAIT_GROUND;
			bprintold("wait ground mode ON\n");
		}
		else if (path_mode == WAIT_GROUND)
		{
			path_mode = SHORT_HAZARD;
			bprintold("short hazard mode ON\n");
		}
		else if (path_mode == SHORT_HAZARD)
		{
			path_mode = JUMP_LEDGE;
			bprintold("jump ledge mode ON\n");
		}
		else if (path_mode == JUMP_LEDGE)
		{
			path_mode = DM6_DOOR;
			bprintold("dm6 door mode ON\n");
		}
		else if (path_mode == DM6_DOOR)
		{
			path_mode = LOOKAHEAD;
			bprintold("look ahead mode ON\n");
		}
		else if (path_mode == LOOKAHEAD)
		{
			path_mode = HIGH_ENOUGH;
			bprintold("high enough ON\n");
		}
		else if (path_mode == HIGH_ENOUGH)
		{
			path_mode = DISCONNECT_MARKERS;
			bprintold("disconnect mode ON\n");
		}
		else if (path_mode == DISCONNECT_MARKERS)
		{
			path_mode = 0;
			bprintold("path mode OFF\n");
		}
	}
};

/*
============
DefaultMarkerMode

============
*/
void() DefaultMarkerMode =
{
	mode = path_mode = type_mode = 0;
	bprintold("default marker mode\n");
};

/*
============
ToggleClosestMarkerMode

============
*/
void() ToggleClosestMarkerMode =
{
	if (mode & CLOSEST_MARKER)
	{
		mode = mode - CLOSEST_MARKER;
		bprintold("Closest marker mode OFF\n");
	}
	else
	{
		mode = mode | CLOSEST_MARKER;
		bprintold("Closest marker mode ON\n");
	}
};

/*
============
DisplayTravelTime

============
*/
void() DisplayTravelTime =
{
	mode = mode | DISPLAY_TRAVEL_TIME;
};

/*
============
CycleDisplayMode

============
*/
void() CycleDisplayMode =
{
	if (mode & DISPLAY_ZONE)
	{
		mode = (mode - DISPLAY_ZONE) | DISPLAY_TYPE;
		bprintold("Display type ON\n");
	}
	else if (mode & DISPLAY_TYPE)
	{
		mode = mode - DISPLAY_TYPE;
		bprintold("Display mode OFF\n");
	}
	else
	{
		mode = mode | DISPLAY_ZONE;
		bprintold("Display zone ON\n");
	}
};

/*
============
CheckAllZones

============
*/
void() CheckAllZones =
{
	m = first_ent;
	while (m)
	{
		if (m.flags & FL_MARKER)
		{
			if (!m.Z_)
			{
				active_marker = m;
				bprintold("Zone missing\n");
				setorigin(self, active_marker.absmin + active_marker.view_ofs + '0 0 22' - self.view_ofs);
				return;
			}
		}
		m = nextent(m);
	}
	bprintold("Zones completed\n");
};

/*
============
CheckAllGoals

============
*/
void() CheckAllGoals =
{
	m = first_ent;
	while (m)
	{
		if (m.flags & FL_ITEM)
		{
			if (!m.G_)
			{
				active_marker = m;
				bprintold("Goal missing\n");
				setorigin(self, active_marker.absmin + active_marker.view_ofs + '0 0 22' - self.view_ofs);
				return;
			}
		}
		m = nextent(m);
	}
	bprintold("Goals completed\n");
};

/*
============
ManualImpulseCommands

============
*/
void() ManualImpulseCommands =
{
	if (impulse_ == 119)
		spawn_marker(self.origin - '0 0 22' + self.view_ofs);
	else if (impulse_ == 125)
		CheckAllGoals();
	else if (impulse_ == 126)
		CheckAllZones();
	else if (impulse_ == 127)
		ToggleActiveMarker();
	else if (impulse_ == 128)
		RemoveActiveMarker();
	else if (impulse_ == 129)
		DisableActiveMarker();
	else if (impulse_ == 130)
		ToggleOneWayMode();
	else if (impulse_ == 131)
		ToggleConnectMarkersMode();
	else if (impulse_ == 132)
		DefaultMarkerMode();
	else if (impulse_ == 133)
		SaveMarkers();
	else if (impulse_ == 135)
		ToggleClosestMarkerMode();
	else if (impulse_ == 137)
		ClearActiveMarker();
	else if (impulse_ == 138)
		MoveActiveMarker();
	else if (impulse_ == 139)
		VerMoveActiveMarker();
	else if (impulse_ == 140)
		IncGoal();
	else if (impulse_ == 141)
		DecGoal();
	else if (impulse_ == 142)
		SetGoal();
	else if (impulse_ == 143)
		PrintGoals();
	else if (impulse_ == 144)
		CycleDescriptionMode();
	else if (impulse_ == 145)
		DisplayTravelTime();
	else if (impulse_ == 146)
		CycleDisplayMode();
};

#endif // MANUAL
