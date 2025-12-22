/*
 * magic/base.m
 */


/************* Definitions and properties ************/

define tp_magic STEPS_PER_REGAINED_MANA_POINT 25.

define tp_magic p_pManaNow    CreateIntProp().  /* Current mana */
define tp_magic p_pManaAux    CreateIntProp().
define tp_magic p_pManaMax    CreateIntProp().  /* Max Mana */
define tp_magic p_pLearnt     CreateThingListProp(). /* Spells known - also on objects */

define tp_magic p_sName       CreateStringProp().   /* Name of a spell */
define tp_magic p_sEffect     CreateActionProp().   /* Effect action */
define tp_magic p_sCost       CreateIntProp().  /* Mana cost */
define tp_magic p_sLevel      CreateIntProp().  /* Spell level */
define tp_magic p_sCharges    CreateIntProp().  /* number fo charges */
define tp_magic p_sDice       CreateStringProp().   /* another form of "power" */
define tp_magic p_sDesc       CreateStringProp().   /* Help string */
define tp_magic p_sCastCheck  CreateActionProp().   /* will become obselete... */
define tp_magic p_sLearnCheck CreateActionProp().   /* will become obselete... */
define tp_magic p_sTarget     CreateThingProp().    /* Target of spell, after casting */
define tp_magic p_sPower      CreateIntProp().  /* "power" of the spell */
define tp_magic p_sDuration   CreateIntProp().  /* duration of the spell */
define tp_magic p_sCaster     CreateThingProp().  /* caster of the spell */
define tp_magic p_sNull       CreateStringProp().   /* Cast with no args (potion) */
define tp_magic p_sMangled    CreateStringProp().   /* use with LangTranslate */
define tp_magic p_sPotionDesc CreateStringProp().   /* Description, when in potion form */
define tp_magic p_sPotionName CreateStringProp().   /* Name, when in potion form */
define tp_magic p_sWandDesc   CreateStringProp().   /* Description, when in wand form */
define tp_magic p_sWandName   CreateStringProp().   /* Name, when in wand form */

define tp_magic p_oIsScroll    CreateBoolProp().   /* Spell is actually a scroll */
define tp_magic p_oIsPotion    CreateBoolProp().   /* Spell is actually a potion */
define tp_magic p_oIsWand      CreateBoolProp().   /* Spell is actually a wand */
define tp_magic p_oIsStaff     CreateBoolProp().   /* Spell is actually a staff */
define tp_magic p_oIsGrimoire  CreateBoolProp().   /* Object is a GRIMOIRE */
define tp_magic p_oMaxCharges  CreateIntProp().

define tp_magic p_sCastChecks   CreateActionListProp(). /* On Object, Room, Person and Spell */
define tp_magic p_sLearnChecks  CreateActionListProp(). /* On Object, Room, Person and Spell */
define tp_magic p_sScribeChecks CreateActionListProp(). /* On Object, Room, Person and Spell */


