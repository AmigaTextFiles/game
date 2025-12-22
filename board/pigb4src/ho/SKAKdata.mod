IMPLEMENTATION MODULE SKAKdata; (* Rev 4/5-94, 12-95 *)

(*$ DEFINE Test:=FALSE *)
(*$ DEFINE Test1:=TRUE *)
(*$ DEFINE Test0:=FALSE *)
(*$ DEFINE Chks:=TRUE *)
(*$ DEFINE True:=TRUE *) (* For at kunne enable/disable kommenterede procs *)

(*$ IF Chks *)
  (*$ Volatile:=FALSE StackChk:=TRUE RangeChk:=TRUE OverflowChk:=TRUE
  NilChk:=TRUE EntryClear:=TRUE CaseChk:=TRUE ReturnChk:=TRUE *)
(*$ ELSE *)
  (*$ Volatile:=TRUE StackChk:=FALSE RangeChk:=FALSE OverflowChk:=FALSE
  NilChk:=FALSE EntryClear:=FALSE CaseChk:=FALSE ReturnChk:=FALSE *)
(*$ ENDIF *)

FROM SYSTEM IMPORT 
  ADR, ADDRESS, ASSEMBLE;
(*$IF Test *)
  FROM W IMPORT
    WRITELN, WRITE, CONCAT, s, l, lf, c, READs;
(*$ENDIF *)
FROM DosD IMPORT
  FileInfoBlock, FileLockPtr, FileLock, accessRead;
FROM DosL IMPORT
  Examine, ExNext, Lock, UnLock; 
FROM IntuitionD IMPORT
  ImagePtr;
FROM Conversions IMPORT
  StrToVal;
FROM String IMPORT
  Copy,Concat,ConcatChar,Length;
FROM VersionLog IMPORT
  LogVersion;
FROM ILBMread IMPORT
  ReadImageILBM,IFFOkay;
FROM QuickIntuition IMPORT
  ChipPicture, MakeImage;
FROM SKAKdata1 IMPORT
  sthX,sts,fh,sss,ssh,srs,srh,sms,smh,sls,sdh,sds,seh,ses,skh,sks,slh;
FROM SKAKdata2 IMPORT
  prh, b75, ups, ok, Farver, hm9,hm8,hm7,hm6,hm5,hm4,hm3,hm2,hm1, vm9,vm8,vm7,vm6,
  vm5,vm4,vm3,vm2,vm1, m5s,m4s,m3s,m2s,m1s, m5h,m4h,m3h,m2h,m1h;
FROM SKAKdata3 IMPORT
  co,cl, Komm, trh,trs, bos, Tom, bo, prs, bns, bn, ok2, ups2;
FROM SKAKdata4 IMPORT
  DiskPIG,ToA,A,Variant,ToStil,
  PIGf1,PIGf10,PIGf2,PIGf4,PIGf5,PIGf8,PIGf9,PIGnumL,PIGscrL,PIGxtra;
FROM SKAKdata5 IMPORT
  sbs,sbh,hts,hth,hss,hsh,hrs,hkh,hks,hlh,hls,hmh,hms,hrh,hes,heh,hds,hdh,hbs;
FROM SKAKdata6 IMPORT
  hbh,fs,Tale,About,Setup,NytSpil,Dominans,pe,pf,pt,ps,dt,dp,di,du,nl,nm,
  ns,mo,ml;

CONST
  DepthChip=2+100; (* 2 bitplaner, 100=markér at IKKE overføre til chip-ram *)
  SKAKdataModCompilation="92";


PROCEDURE sth; (*$ EntryExitCode:=FALSE *) (* !!!! nul-stub for sth i .def *)
BEGIN
  ASSEMBLE(DC.W 1003,1961,0515 END);
END sth;

CONST
  ilbmstr='ilbm';

PROCEDURE readilbms;
VAR
  n:CARDINAL;
  i1:ImagePtr;
  pstr:ARRAY[0..16] OF CHAR;
  minlaas : FileLockPtr;
  fib     : FileInfoBlock;
  err,sgn : BOOLEAN;
  nl      : LONGINT;
BEGIN
(*$IF Test *)
WRITELN(s('prøver at læse ')+s(pstr)+s(' brushes'));
(*$ENDIF *)
  minlaas:=Lock(ADR(ilbmstr),accessRead);
  IF minlaas<>NIL THEN
    IF Examine(minlaas,ADR(fib)) THEN
      REPEAT
        IF (fib.entryType<0) & (Length(fib.fileName)=3) THEN
          StrToVal(fib.fileName,nl,sgn,10,err);
          n:=nl;
          IF ~err & (n>0) & (n<=MaxGrafik) THEN
            Copy(pstr,ilbmstr);
            ConcatChar(pstr,'/');
            Concat(pstr,fib.fileName);
            IF ReadImageILBM(pstr,i1)=IFFOkay THEN
              Grafik[n]:=i1;
(*$IF Test *)
WRITELN(s('læst:')+l(n));
(*$ENDIF *)
            END;
          END;
        END;
      UNTIL ~ExNext(minlaas,ADR(fib));
    END;
    UnLock(minlaas);
  END; 
(*$IF Test *)
WRITELN(s('færdig.'));
(*$ENDIF *)
END readilbms;

VAR
  n:CARDINAL;

BEGIN
(*$IF Test *)
  WRITELN(s('SKAKdata.1'));
(*$ENDIF *)

  FOR n:=1 TO MaxGrafik DO
    Grafik[n]:=NIL;
  END;
  

 (* til at slette spillermunde: *)
(*
  Grafik[128]:=MakeImage(50,9,DepthChip,ADR(hm0)); 
*)
  (* Hvid/Sort T,R,B,E,K,M,S,L,D brik på Hvid/Sort felt *)
  Grafik[ 19]:=MakeImage(60,30,DepthChip,ADR(sthX));
  Grafik[119]:=MakeImage(60,30,DepthChip,ADR(sts));
  Grafik[  1]:=MakeImage(60,30,DepthChip,ADR(fh)); (* Felt Hvidt *)
  Grafik[123]:=MakeImage(60,30,DepthChip,ADR(sss));
  Grafik[ 23]:=MakeImage(60,30,DepthChip,ADR(ssh));
  Grafik[117]:=MakeImage(60,30,DepthChip,ADR(srs));
  Grafik[ 17]:=MakeImage(60,30,DepthChip,ADR(srh));
  Grafik[111]:=MakeImage(60,30,DepthChip,ADR(sms)); (* (60-1) div 16+1)*30*2 =240 words *)
  Grafik[ 11]:=MakeImage(60,30,DepthChip,ADR(smh)); (* Sorte*)
  Grafik[121]:=MakeImage(60,30,DepthChip,ADR(sls));
  Grafik[ 15]:=MakeImage(60,30,DepthChip,ADR(sdh));
  Grafik[115]:=MakeImage(60,30,DepthChip,ADR(sds));
  Grafik[ 25]:=MakeImage(60,30,DepthChip,ADR(seh));
  Grafik[125]:=MakeImage(60,30,DepthChip,ADR(ses));
  Grafik[ 13]:=MakeImage(60,30,DepthChip,ADR(skh)); (* Xs=60, Ys=30, Bplaner=2     *)
  Grafik[113]:=MakeImage(60,30,DepthChip,ADR(sks));
  Grafik[ 21]:=MakeImage(60,30,DepthChip,ADR(slh));
  Grafik[127]:=MakeImage(60,30,DepthChip,ADR(sbs));
  Grafik[ 27]:=MakeImage(60,30,DepthChip,ADR(sbh));

  Grafik[118]:=MakeImage(60,30,DepthChip,ADR(hts)); (* Hvide *)
  Grafik[ 18]:=MakeImage(60,30,DepthChip,ADR(hth));
  Grafik[122]:=MakeImage(60,30,DepthChip,ADR(hss));
  Grafik[ 22]:=MakeImage(60,30,DepthChip,ADR(hsh));
  Grafik[116]:=MakeImage(60,30,DepthChip,ADR(hrs));
  Grafik[ 12]:=MakeImage(60,30,DepthChip,ADR(hkh));
  Grafik[112]:=MakeImage(60,30,DepthChip,ADR(hks));
  Grafik[ 20]:=MakeImage(60,30,DepthChip,ADR(hlh));
  Grafik[120]:=MakeImage(60,30,DepthChip,ADR(hls));
  Grafik[ 10]:=MakeImage(60,30,DepthChip,ADR(hmh));
  Grafik[110]:=MakeImage(60,30,DepthChip,ADR(hms));
  Grafik[ 16]:=MakeImage(60,30,DepthChip,ADR(hrh));
  Grafik[124]:=MakeImage(60,30,DepthChip,ADR(hes));
  Grafik[ 24]:=MakeImage(60,30,DepthChip,ADR(heh));
  Grafik[114]:=MakeImage(60,30,DepthChip,ADR(hds));
  Grafik[ 14]:=MakeImage(60,30,DepthChip,ADR(hdh));
  Grafik[126]:=MakeImage(60,30,DepthChip,ADR(hbs));
  Grafik[ 26]:=MakeImage(60,30,DepthChip,ADR(hbh));

  Grafik[  2]:=MakeImage(60,30,DepthChip,ADR(fs)); (* Felt Sort  *)

  Grafik[ 81]:=MakeImage(44,22,DepthChip,ADR(Tale));
  Grafik[ 85]:=MakeImage(44,22,DepthChip,ADR(About));
  Grafik[ 75]:=MakeImage(44,22,DepthChip,ADR(Setup));
  Grafik[ 77]:=MakeImage(44,22,DepthChip,ADR(NytSpil));
  Grafik[ 79]:=MakeImage(44,22,DepthChip,ADR(Dominans));
  Grafik[ 73]:=MakeImage(36,20,DepthChip,ADR(pe)); (* pilend *)
  Grafik[ 71]:=MakeImage(36,20,DepthChip,ADR(pf)); (* pilfrem *)
  Grafik[ 69]:=MakeImage(36,20,DepthChip,ADR(pt)); (* piltilbage *)
  Grafik[ 67]:=MakeImage(36,20,DepthChip,ADR(ps)); (* pilstart *)
  Grafik[ 62]:=MakeImage(68,33,DepthChip,ADR(dt)); (* disk *)
  Grafik[ 64]:=MakeImage(68,33,DepthChip,ADR(dp)); (* printer*)
  Grafik[ 65]:=MakeImage(75,11,DepthChip,ADR(du)); (* gemmepil *)
  Grafik[ 63]:=MakeImage(75,11,DepthChip,ADR(di)); (* hentepil *)
  Grafik[ 37]:=MakeImage(30,12,DepthChip,ADR(nl)); (* nede lav *)
  Grafik[ 40]:=MakeImage(30,12,DepthChip,ADR(nm));
  Grafik[ 43]:=MakeImage(30,14,DepthChip,ADR(ns));
  Grafik[ 32]:=MakeImage(95,38,DepthChip,ADR(mo));
  Grafik[ 33]:=MakeImage(95,38,DepthChip,ADR(ml)); (* mand lukkede *)
  
  (* Imported grafik *)
  Grafik[  4]:=MakeImage(6,3,DepthChip,ADR(prh));
  Grafik[ 28]:=MakeImage(93,229,DepthChip,ADR(b75));
  Grafik[103]:=MakeImage(72,15,DepthChip,ADR(ups));
  Grafik[101]:=MakeImage(72,15,DepthChip,ADR(ok));
  Grafik[ 83]:=MakeImage(44,22,DepthChip,ADR(Farver));
  Grafik[ 61]:=MakeImage(25,9,DepthChip,ADR(hm9)); (* højre mund *)
  Grafik[ 60]:=MakeImage(25,9,DepthChip,ADR(hm8));
  Grafik[ 59]:=MakeImage(25,9,DepthChip,ADR(hm7));
  Grafik[ 58]:=MakeImage(25,9,DepthChip,ADR(hm6));
  Grafik[ 57]:=MakeImage(25,9,DepthChip,ADR(hm5));
  Grafik[ 56]:=MakeImage(25,9,DepthChip,ADR(hm4));
  Grafik[ 55]:=MakeImage(25,9,DepthChip,ADR(hm3));
  Grafik[ 54]:=MakeImage(25,9,DepthChip,ADR(hm2));
  Grafik[ 53]:=MakeImage(25,9,DepthChip,ADR(hm1));
  Grafik[ 52]:=MakeImage(25,9,DepthChip,ADR(vm9)); (* venstre mund *)
  Grafik[ 51]:=MakeImage(25,9,DepthChip,ADR(vm8));
  Grafik[ 50]:=MakeImage(25,9,DepthChip,ADR(vm7));
  Grafik[ 49]:=MakeImage(25,9,DepthChip,ADR(vm6));
  Grafik[ 48]:=MakeImage(25,9,DepthChip,ADR(vm5));
  Grafik[ 47]:=MakeImage(25,9,DepthChip,ADR(vm4));
  Grafik[ 46]:=MakeImage(25,9,DepthChip,ADR(vm3));
  Grafik[ 45]:=MakeImage(25,9,DepthChip,ADR(vm2));
  Grafik[ 44]:=MakeImage(25,9,DepthChip,ADR(vm1));
  Grafik[109]:=MakeImage(22,3,DepthChip,ADR(m5s)); (* mund sort *)
  Grafik[108]:=MakeImage(22,3,DepthChip,ADR(m4s));
  Grafik[107]:=MakeImage(22,3,DepthChip,ADR(m3s));
  Grafik[106]:=MakeImage(22,3,DepthChip,ADR(m2s));
  Grafik[105]:=MakeImage(22,3,DepthChip,ADR(m1s));
  Grafik[  9]:=MakeImage(22,3,DepthChip,ADR(m5h)); (* mund hvid *)
  Grafik[  8]:=MakeImage(22,3,DepthChip,ADR(m4h));
  Grafik[  7]:=MakeImage(22,3,DepthChip,ADR(m3h));
  Grafik[  6]:=MakeImage(22,3,DepthChip,ADR(m2h));
  Grafik[  5]:=MakeImage(22,3,DepthChip,ADR(m1h));
  Grafik[ 35]:=MakeImage(95,38,DepthChip,ADR(co));
  Grafik[ 36]:=MakeImage(95,38,DepthChip,ADR(cl));
  Grafik[ 93]:=MakeImage(44,22,DepthChip,ADR(Komm));
  Grafik[ 95]:=MakeImage(44,22,DepthChip,ADR(trh));
  Grafik[ 96]:=MakeImage(44,22,DepthChip,ADR(trs));
  Grafik[ 89]:=MakeImage(44,22,DepthChip,ADR(Tom));
  Grafik[ 30]:=MakeImage(114,34,DepthChip,ADR(bo)); (* Brædt omvendt før 124,50 *)
  Grafik[  3]:=MakeImage(6,3,DepthChip,ADR(prs));
  Grafik[ 29]:=MakeImage(114,34,DepthChip,ADR(bn)); (* bræt normalt før 124,50 *)

  Grafik[104]:=MakeImage(50,11,DepthChip,ADR(ups2));
  Grafik[102]:=MakeImage(50,11,DepthChip,ADR(ok2));

  Grafik[129]:=MakeImage(68,33,DepthChip,ADR(DiskPIG)); (* gnr: 232 *)
  Grafik[131]:=MakeImage(26,11,DepthChip,ADR(ToA));     (* gnr: 231 *)
  Grafik[132]:=MakeImage(26,11,DepthChip,ADR(A));       (* gnr: 231 *)
  Grafik[133]:=MakeImage(26,11,DepthChip,ADR(Variant)); (* gnr: 233 *)
  Grafik[135]:=MakeImage(19,11,DepthChip,ADR(ToStil));  (* gnr: 235 *)

  Grafik[137]:=MakeImage(28,15,DepthChip,ADR(PIGf5));     (* gnr: GrNr+100 *)
  Grafik[138]:=MakeImage(28,15,DepthChip,ADR(PIGf2));     (* gnr: GrNr+100 *)
  Grafik[139]:=MakeImage(28,15,DepthChip,ADR(PIGf1));     (* gnr: GrNr+100 *)
  Grafik[140]:=MakeImage(28,15,DepthChip,ADR(PIGscrL));   (* gnr: GrNr+100 *)
  Grafik[141]:=MakeImage(28,15,DepthChip,ADR(PIGxtra));   (* gnr: GrNr+100 *)
  Grafik[142]:=MakeImage(28,15,DepthChip,ADR(PIGf8));     (* gnr: GrNr+100 *)
  Grafik[143]:=MakeImage(28,15,DepthChip,ADR(PIGf10));    (* gnr: GrNr+100 *)
  Grafik[144]:=MakeImage(28,15,DepthChip,ADR(PIGf9));     (* gnr: GrNr+100 *)
  Grafik[145]:=MakeImage(28,15,DepthChip,ADR(PIGf4));     (* gnr: GrNr+100 *)
  Grafik[146]:=MakeImage(28,15,DepthChip,ADR(PIGnumL));   (* gnr: GrNr+100 *)

  (* Grafik[1..150] Frie:
     31,34,(38-39,41-42),(lige 66-94,98,100,130,134-136),87,91,97,99, 147-150 *)

  LogVersion("SKAKdata.def",SKAKdataDefCompilation);
  LogVersion("SKAKdata.mod",SKAKdataModCompilation);

  readilbms;

(*$IF Test *)
  WRITELN(s('SKAKdata.2'));
(*$ENDIF *)
END SKAKdata.
