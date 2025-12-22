! ----------------------------------------------------------------------------
!  GRAMMAR:  Grammar table entries for the standard verbs library.
!
!  Supplied for use with Inform 6                         Serial number 970918
!                                                                  Release 6/7
!  (c) Graham Nelson 1993, 1994, 1995, 1996, 1997
!      but freely usable (see manuals)
! ----------------------------------------------------------------------------
!  The "meta-verbs", commands to the game rather than in the game, come first:
! ----------------------------------------------------------------------------

System_file;

Verb meta 'score'
                *                                -> Score;
Verb meta 'fullscore' 'full'
                *                                -> FullScore
                * 'score'                        -> FullScore;
Verb meta 'q//' 'quit' 'die'
                *                                -> Quit;
Verb meta 'restore'
                *                                -> Restore;
Verb meta 'restart'
                *                                -> Restart;
Verb meta 'verify'
                *                                -> Verify;
Verb meta 'save'
                *                                -> Save;
Verb meta 'script' 'transcript'
                *                                -> ScriptOn
                * 'off'                          -> ScriptOff
                * 'on'                           -> ScriptOn;
Verb meta 'noscript' 'unscript'
                *                                -> ScriptOff;
Verb meta 'superbrief' 'short'
                *                                -> LMode3;
Verb meta 'verbose' 'long'
                *                                -> LMode2;
Verb meta 'brief' 'normal'
                *                                -> LMode1;
Verb meta 'pronouns' 'nouns'
                *                                -> Pronouns;
Verb meta 'notify'
                * 'on'                           -> NotifyOn
                * 'off'                          -> NotifyOff;
Verb meta 'version'
                *                                -> Version;
#IFNDEF NO_PLACES;
Verb meta 'places'
                *                                -> Places;
Verb meta 'objects'
                *                                -> Objects;
#ENDIF;

! ----------------------------------------------------------------------------
!  Debugging grammar
! ----------------------------------------------------------------------------

#ifdef DEBUG;
Verb meta 'trace'
                *                                -> TraceOn
                * number                         -> TraceLevel
                * 'on'                           -> TraceOn
                * 'off'                          -> TraceOff;
Verb meta 'actions'
                *                                -> ActionsOn
                * 'on'                           -> ActionsOn
                * 'off'                          -> ActionsOff;
Verb meta 'routines' 'messages'
                *                                -> RoutinesOn
                * 'on'                           -> RoutinesOn
                * 'off'                          -> RoutinesOff;
Verb meta 'timers' 'daemons'
                *                                -> TimersOn
                * 'on'                           -> TimersOn
                * 'off'                          -> TimersOff;
Verb meta 'recording'
                *                                -> CommandsOn
                * 'on'                           -> CommandsOn
                * 'off'                          -> CommandsOff;
Verb meta 'replay'
                *                                -> CommandsRead;
Verb meta 'random'
                *                                -> Predictable;
Verb meta 'purloin'
                * multi                          -> XPurloin;
Verb meta 'abstract'
                * noun 'to' noun                 -> XAbstract;
Verb meta 'tree'
                *                                -> XTree
                * noun                           -> XTree;
Verb meta 'goto'
                * number                         -> Goto;
Verb meta 'gonear'
                * noun                           -> Gonear;
Verb meta 'scope'
                *                                -> Scope
                * noun                           -> Scope;
Verb meta 'showverb'
                * special                        -> Showverb;
Verb meta 'showobj'
                *                                -> Showobj
                * multi                          -> Showobj;
#endif;

! ----------------------------------------------------------------------------
!  And now the game verbs.
! ----------------------------------------------------------------------------

Verb 'take' 'carry' 'hold' 'grab' 'grasp' 'snatch' 'lift' 'peel' 'strip'
                * multi                          -> Take
                * multiheld 'off'                -> Disrobe
                * 'off' multiheld                -> Disrobe
                * worn 'off'                     -> Disrobe
                * 'off' worn                     -> Disrobe
                * multiinside 'from' noun        -> Remove
                * multiinside 'off' noun         -> Remove
                * multiinside 'on' noun          -> Remove
                * multiinside 'in' noun          -> Remove
                * 'inventory'                    -> Inv;
Verb 'get'      * 'out'/'off'/'up'               -> Exit
                * multi                          -> Take
                * 'in'/'into'/'on'/'onto' noun   -> Enter
                * 'off' noun                     -> GetOff
                * multiinside 'from' noun        -> Remove
                * multiinside 'off' noun         -> Remove
                * multiinside 'on' noun          -> Remove
                * multiinside 'in' noun          -> Remove;
Verb 'pick'
                * 'up' multi                     -> Take
                * multi 'up'                     -> Take;
Verb 'stand'
                *                                -> Exit
                * 'up'                           -> Exit
                * 'on' noun                      -> Enter;
Verb 'remove'
                * multiheld                      -> Disrobe
                * multi                          -> Take
                * multiinside 'from' noun        -> Remove;
Verb 'shed' 'doff' 'disrobe'
                * multiheld                      -> Disrobe;
Verb 'wear' 'don'
                * multiheld                      -> Wear;
Verb 'put'
                * 'out' multi                    -> SwitchOff
                * multiexcept 'in'/'inside'/'into' noun
                                                 -> Insert
                * multiexcept 'on'/'onto' noun   -> PutOn
                * 'on' multiheld                 -> Wear
                * 'down' multiheld               -> Drop
                * multiheld 'down'               -> Drop;
Verb 'place' 'stick'
                * multiexcept 'in'/'inside'/'into' noun
                                                 -> Insert
                * multiexcept 'on'/'onto' noun   -> PutOn;
Verb 'insert'
                * multiexcept 'in'/'into' noun   -> Insert;
Verb 'empty' 'dump'
                * multi                          -> Empty
                * 'out' multi                    -> Empty
                * multi 'out'                    -> Empty
                * multi 'to'/'into'/'on'/'onto' noun
                                                 -> EmptyT;
Verb 'transfer'
                * multi 'to' noun                -> Transfer;
Verb 'drop' 'throw' 'discard' 'lose' 'chuck'
                * multiheld                      -> Drop
                * multiexcept 'in'/'into'/'down' noun
                                                 -> Insert
                * multiexcept 'on'/'onto' noun   -> PutOn
                * multiheld 'at'/'against'/'on'/'onto'/'toward'/'towards' noun
                                                 -> ThrowAt;
Verb 'give' 'pay' 'offer' 'feed' 'hand'
                * multiheld 'to' creature        -> Give
                * creature multiheld             -> Give reverse
                * 'over' multiheld 'to' creature -> Give
                * 'up' multiheld 'to' creature   -> Give;
Verb 'show' 'present' 'display'
                * creature multiheld             -> Show reverse
                * multiheld 'to' creature        -> Show;
[ ADirection; if (noun in compass) rtrue; rfalse; ];
Verb 'go' 'walk' 'run'
                *                                -> VagueGo
                * noun=ADirection                -> Go
                * noun                           -> Enter
                * 'out'/'into'/'in'/'inside'/'through' noun
                                                 -> Enter;
Verb 'step' 'stomp'
                *                                -> VagueGo
                * noun=ADirection                -> Go
                * noun                           -> Enter
                * 'out'/'into'/'in'/'inside'/'through' noun
                                                 -> Enter
                * 'on' noun                      -> Attack;
Verb 'leave'
                *                                -> VagueGo
                * noun=ADirection                -> Go
                * noun                           -> Exit
                * 'out'/'into'/'in'/'inside'/'through' noun
                                                 -> Enter
                * multiexcept 'in'/'inside'/'into' noun
                                                 -> Insert
                * multiexcept 'on'/'onto' noun   -> PutOn;
Verb 'inventory' 'inv' 'i//' 'list' 'items' 'possessions'
                *                                -> Inv
                * 'tall'                         -> InvTall
                * 'wide'                         -> InvWide;
Verb 'look' 'l//'
                *                                -> Look
                * 'at' multi                     -> Examine
                * 'inside'/'in'/'into'/'through'/'out' multi
                                                 -> Search
                * 'under' multi                  -> LookUnder
                * 'up' topic 'in' noun           -> Consult;
Verb 'consult'  * multi 'about' topic            -> Consult
                * multi 'on' topic               -> Consult;
Verb 'open' 'unwrap' 'uncover' 'undo'
                * multi                          -> Open
                * multi 'with' held              -> Unlock;
Verb 'close' 'shut' 'cover'
                * multi                          -> Close
                * 'up' multi                     -> Close
                * 'off' multi                    -> SwitchOff;
Verb 'slam'
                * multi                          -> Close;
Verb 'enter' 'cross'
                *                                -> GoIn
                * noun                           -> Enter;
Verb 'sit' 'lie'
                * 'on' 'top' 'of' noun           -> Enter
                * 'on'/'in'/'inside' noun        -> Enter;
Verb 'in' 'inside'
                *                                -> GoIn;
Verb 'exit' 'out' 'outside'
                *                                -> Exit;
Verb 'examine' 'x//' 'watch' 'describe' 'check'
                * multi                          -> Examine;
Verb 'read' 'browse'
                * multi                          -> Examine
                * 'about' topic 'in' multi       -> Consult
                * topic 'in' multi               -> Consult;
Verb 'yes' 'y//'
                *                                -> Yes;
Verb 'no'
                *                                -> No;
Verb 'sorry'
                *                                -> Sorry;
Verb 'frig' 'mess'
                * 'with' multi                   -> Push;
Verb 'fuck' 'shit' 'damn' 'sod'
                *                                -> Strong
                * topic                          -> Strong;
Verb 'bother' 'curses' 'drat' 'darn'
                *                                -> Mild
                * topic                          -> Mild;
Verb 'search'
                * multi                          -> Search;
Verb 'wave'
                *                                -> WaveHands
                * multi                          -> Wave;
Verb 'set' 'adjust'
                * multi                          -> Set
                * multi 'to' special             -> SetTo;
Verb 'pull' 'drag'
                * multi                          -> Pull;
Verb 'clear' 
                * multi                          -> Push
                * 'off' multi                    -> Empty
                * multi 'off'                    -> Empty
                * 'out' multi                    -> Empty
                * multi 'out'                    -> Empty
                * multi 'to'/'into'/'on'/'onto' noun
                                                 -> EmptyT;
Verb 'push' 'move' 'shift' 'press' 'shove' 'manipulate' 'tap' 'knock'
                * multi                          -> Push
                * multi noun                     -> PushDir
                * multi 'to' noun                -> Transfer;
Verb 'turn' 'rotate' 'twist' 'unscrew' 'screw' 'flip' 'flick'
                * multi                          -> Turn
                * multi 'on'                     -> Switchon
                * multi 'off'                    -> Switchoff
                * 'on' multi                     -> Switchon
                * 'off' multi                    -> Switchoff;
Verb 'switch'
                * multi                          -> Switchon
                * multi 'on'                      -> Switchon
                * multi 'off'                    -> Switchoff
                * 'on' multi                     -> Switchon
                * 'off' multi                    -> Switchoff;
Verb 'activate' 'use' 'utilize'
                * multi                          -> Switchon;
Verb 'deactivate' 'extinguish'
                * multi                          -> Switchoff;
Verb 'lock'
                * multi 'with' held              -> Lock;
Verb 'unlock'
                * multi 'with' held              -> Unlock;
Verb 'attack' 'break' 'smash' 'hit' 'fight' 'wreck' 'crack' 'maim'
     'destroy' 'murder' 'kill' 'torture' 'punch' 'thump'
                * multi                          -> Attack;
Verb 'wait' 'z//'
                *                                -> Wait;
Verb 'answer' 'say' 'shout' 'yell' 'hollar'
                * topic 'to' creature            -> Answer;
Verb 'speak' 'communicate'
                * topic 'to' creature            -> Answer
                * 'to' creature 'about' topic    -> Tell;
Verb 'tell'
                * creature 'about' topic         -> Tell;
Verb 'talk'
                * 'to' creature 'about' topic    -> Tell;
Verb 'chat'
                * 'with' creature 'about' topic    -> Tell;
Verb 'ask'
                * creature 'about' topic         -> Ask
                * creature 'for' multi           -> AskFor;
Verb 'eat' 'consume' 'ingest'
                * held                           -> Eat;
Verb 'sleep' 'nap'
                *                                -> Sleep;
Verb 'sing'
                *                                -> Sing;
Verb 'climb' 'scale'
                * noun                           -> Climb
                * 'up'/'over' noun               -> Climb;
Verb 'buy' 'purchase'
                * multi                          -> Buy;
Verb 'squeeze' 'squash' 'squish' 'crush' 'crumple'
                * multi                          -> Squeeze;
Verb 'swim' 'dive'
                *                                -> Swim;
Verb 'swing'
                * multi                          -> Swing
                * 'on' multi                     -> Swing;
Verb 'blow'
                * multiheld                      -> Blow;
Verb 'pray'
                *                                -> Pray;
Verb 'wake' 'awake' 'awaken'
                *                                -> Wake
                * 'up'                           -> Wake
                * creature                       -> WakeOther
                * creature 'up'                  -> WakeOther
                * 'up' creature                  -> WakeOther;
Verb 'kiss' 'embrace' 'hug'
                * creature                       -> Kiss;
Verb 'think'
                *                                -> Think;
Verb 'smell' 'sniff'
                *                                -> Smell
                * multi                          -> Smell;
Verb 'hear' 'listen'
                *                                -> Listen
                * multi                          -> Listen
                * 'to' multi                     -> Listen;
Verb 'taste'
                * multi                          -> Taste;
Verb 'touch' 'fondle' 'feel' 'grope' 'caresse'
                * multi                          -> Touch;
Verb 'rub' 'shine' 'polish' 'sweep' 'clean' 'dust' 'wipe' 'scrub'
                * multi                          -> Rub;
Verb 'tie' 'attach' 'fasten' 'fix' 'affix'
                * multi                          -> Tie
                * multi 'to' multi               -> Tie;
Verb 'burn' 'light' 'ignite'
                * multi                          -> Burn
                * multi 'with' held               -> Burn;
Verb 'drink' 'swallow' 'sip' 'chug'
                * multi                          -> Drink;
Verb 'fill'
                * multi                          -> Fill;
Verb 'cut' 'slice' 'prune' 'chop' 'snip'
                * multi                          -> Cut;
Verb 'tear' 'rip'
                * multi                          -> Cut
                * 'up' multi                     -> Cut
                * 'off' multiheld                -> Disrobe
                * 'off' multi                    -> Take;
Verb 'jump' 'skip' 'hop' 'leap'
                *                                -> Jump
                * noun=ADirection                -> Go
                * 'over' noun                    -> JumpOver
                * 'out' noun                     -> JumpOver
                * 'out'/'into'/'in'/'inside'/'through' noun
                                                 -> Enter;


Verb 'dig'      * multi                          -> Dig
                * multi 'with' held              -> Dig;
! ----------------------------------------------------------------------------
!  This routine is no longer used here, but provided to help existing games
!  which use it as a general parsing routine:

[ ConTopic w; consult_from = wn;
  do w=NextWordStopped();
  until (w==-1 || (w=='to' && action_to_be==##Answer));
  wn--;
  consult_words = wn-consult_from;
  if (consult_words==0) return -1;
  if (action_to_be==##Ask or ##Answer or ##Tell)
  {   w=wn; wn=consult_from; parsed_number=NextWord();
      if (parsed_number=='the' && consult_words>1) parsed_number=NextWord();
      wn=w; return 1;
  }
  return 0;
];
! ----------------------------------------------------------------------------
!  Final task: provide trivial routines if the user hasn't already:
! ----------------------------------------------------------------------------
#Stub TimePasses      0;
#Stub Amusing         0;
#Stub DeathMessage    0;
#Stub DarkToDark      0;
#Stub NewRoom         0;
#Stub LookRoutine     0;
#Stub AfterLife       0;
#Stub GamePreRoutine  0;
#Stub GamePostRoutine 0;
#Stub AfterPrompt     0;
#Stub BeforeParsing   0;
#Stub PrintTaskName   1;
#Stub InScope         1;
#Stub UnknownVerb     1;
#Stub PrintVerb       1;
#Stub ParserError     1;
#Stub ParseNumber     2;
#Stub ChooseObjects   2;
#IFNDEF PrintRank;
Constant Make__PR;
#ENDIF;
#IFDEF Make__PR;
[ PrintRank; "."; ];
#ENDIF;
#IFNDEF ParseNoun;
Constant Make__PN;
#ENDIF;
#IFDEF Make__PN;
[ ParseNoun obj; obj=obj; return -1; ];
#ENDIF;
#Default Story 0;
#Default Headline 0;
! ----------------------------------------------------------------------------
