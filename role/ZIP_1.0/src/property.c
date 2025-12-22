/*
 * property.c
 *
 * Property manipulation routines
 *
 * Mark Howell 28-Jul-1992 V1.0
 *
 */

#include "ztypes.h"

/*
 * get_property_addr
 *
 * Calculate the address of the start of the property list associated with an
 * object.
 *
 */

#ifdef __STDC__
static zword_t get_property_addr (zword_t obj)
#else
static zword_t get_property_addr (obj)
zword_t obj;
#endif
{
    zword_t offset, prop;

    /* Calculate the address of the property pointer in the object */

    offset = get_object_address (obj);
    offset += (h_type == V3) ? O3_PROPERTY_OFFSET : O4_PROPERTY_OFFSET;

    /* Read the property pointer */

    prop = get_word (offset);

    /* Skip past object description which is an ASCIC of encoded words */

    prop += (get_byte (prop) * 2) + 1;

    return (prop);

}/* get_property_adr */

/*
 * get_next_property
 *
 * Calculate the address of the next property in a property list.
 *
 */

#ifdef __STDC__
static zword_t get_next_property (zword_t propp)
#else
static zword_t get_next_property (propp)
zword_t propp;
#endif
{
    zbyte_t value;

    /* Load the current property id */

    value = get_byte (propp++);

    /* Calculate the length of this property */

    if (h_type == V3)
        value = (zbyte_t) ((value & property_size_mask) >> 5);
    else if (value & 0x80)
        value = get_byte (propp) & (zbyte_t) property_size_mask;
    else if (value & 0x40)
        value = 1;
    else
        value = 0;

    /* Address property length + 1 to current property pointer */

    return (propp + value + 1);

}/* get_next_property */

/*
 * load_property
 *
 * Load a property from a property list. Properties are held in list sorted by
 * property id, with highest ids first. There is also a concept of a default
 * property for loading only. The default properties are held in a table pointed
 * to be the object pointer, and occupy the space before the first object.
 *
 */

#ifdef __STDC__
void load_property (zword_t obj, zword_t prop)
#else
void load_property (obj, prop)
zword_t obj;
zword_t prop;
#endif
{
    zword_t propp;

    /* Load address of first property */

    propp = get_property_addr (obj);

    /* Scan down the property list while the target property id is less than the
       property id in the list */

    while ((zbyte_t) (get_byte (propp) & property_mask) > (zbyte_t) prop)
        propp = get_next_property (propp);

    /* If the property ids match then load the first property */

    if ((zbyte_t) (get_byte (propp) & property_mask) == (zbyte_t) prop) {

        /* Only load first property if it is a byte sized property */

        if ((get_byte (propp++) & property_size_mask) == 0) {
            store_operand (get_byte (propp));
            return;
        }
    } else

        /* Calculate the address of the default property */

        propp = h_objects_offset + ((prop - 1) * 2);

    /* Load the first property word */

    store_operand (get_word (propp));

}/* load_property */

/*
 * store_property
 *
 * Store a property value in a property list. The property must exist in the
 * property list to be replaced.
 *
 */

#ifdef __STDC__
void store_property (zword_t obj, zword_t prop, zword_t value)
#else
void store_property (obj, prop, value)
zword_t obj;
zword_t prop;
zword_t value;
#endif
{
    zword_t propp;

    /* Load address of first property */

    propp = get_property_addr (obj);

    /* Scan down the property list while the target property id is less than the
       property id in the list */

    while ((zbyte_t) (get_byte (propp) & property_mask) > (zbyte_t) prop)
        propp = get_next_property (propp);

    /* If the property id was found then store a new value, otherwise complain */

    if ((zbyte_t) (get_byte (propp) & property_mask) == (zbyte_t) prop) {

        /* Determine if this is a byte or word sized property */

        if ((get_byte (propp++) & property_size_mask) == 0)
            set_byte (propp, value);
        else
            set_word (propp, value);
    } else
        fatal ("No such property");

}/* store_property */

/*
 * load_next_property
 *
 * Load the property after the current property. If the current property is zero
 * then load the first property.
 *
 */

#ifdef __STDC__
void load_next_property (zword_t obj, zword_t prop)
#else
void load_next_property (obj, prop)
zword_t obj;
zword_t prop;
#endif
{
    zword_t propp;

    /* Load address of first property */

    propp = get_property_addr (obj);

    /* If the property id is non zero then find the next property */

    if (prop) {

        /* Scan down the property list while the target property id is less than the
           property id in the list */

        while ((zbyte_t) (get_byte (propp) & property_mask) > (zbyte_t) prop)
            propp = get_next_property (propp);

        /* If the property id was found then get the next property, otherwise complain */

        if ((zbyte_t) (get_byte (propp) & property_mask) == (zbyte_t) prop)
            propp = get_next_property (propp);
        else
            fatal ("No such property");
    }

    /* Return the next property id */

    store_operand (get_byte (propp) & property_mask);

}/* load_next_property */

/*
 * load_property_address
 *
 * Load the address address of the data associated with a property.
 *
 */

#ifdef __STDC__
void load_property_address (zword_t obj, zword_t prop)
#else
void load_property_address (obj, prop)
zword_t obj;
zword_t prop;
#endif
{
    zword_t propp;

    /* Load address of first property */

    propp = get_property_addr (obj);

    /* Scan down the property list while the target property id is less than the
       property id in the list */

    while ((zbyte_t) (get_byte (propp) & property_mask) > (zbyte_t) prop)
        propp = get_next_property (propp);

    /* If the property id was found then calculate the property address, otherwise return zero */

    if ((zbyte_t) (get_byte (propp) & property_mask) == (zbyte_t) prop) {

        /* Skip past property id, can be a byte or a word */

        if (h_type != V3 && (get_byte (propp) & 0x80))
            propp++;
        propp++;
        store_operand (propp);
    } else

        /* No property found, just return 0 */

        store_operand (0);

}/* load_property_address */

/*
 * load_property_length
 *
 * Load the length of a property.
 *
 */

#ifdef __STDC__
void load_property_length (zword_t propp)
#else
void load_property_length (propp)
zword_t propp;
#endif
{

    /* Back up the property pointer to the property id */

    propp--;

    if (h_type == V3)

        /* Property length is in high bits of property id */

        store_operand (((get_byte (propp) & property_size_mask ) >> 5) + 1);
    else if (get_byte (propp) & 0x80)

        /* Property length is in property id */

        store_operand (get_byte (propp) & property_size_mask);
    else

        /* Word sized property if bit 6 set, else byte sized property */

        store_operand ((get_byte (propp) & 0x40) ? 2 : 1);

}/* load_property_length */

/*
 * scan_word
 *
 * Scan an array of words looking for a target word.
 *
 */

#ifdef __STDC__
void scan_word (zword_t search, zword_t addr, zword_t count)
#else
void scan_word (search, addr, count)
zword_t search;
zword_t addr;
zword_t count;
#endif
{
    unsigned long address;
    unsigned int i;

    address = addr;

    /* Scan down an array for count words looking for a match */

    for (i = 0; i < count; i++)

        /* If the word was found store its address and jump */

        if (read_data_word (&address) == search) {
            store_operand ((zword_t) (address - 2));
            conditional_jump (TRUE);
            return;
        }

    /* If the word was not found store zero and jump */

    store_operand (0);
    conditional_jump (FALSE);

}/* scan_word */

/*
 * load_word
 *
 * Load a word from an array of words
 *
 */

#ifdef __STDC__
void load_word (zword_t addr, zword_t offset)
#else
void load_word (addr, offset)
zword_t addr;
zword_t offset;
#endif
{
    unsigned long address;

    /* Calculate word array index address */

    address = addr + (offset * 2);

    /* Store the byte */

    store_operand (read_data_word (&address));

}/* load_word */

/*
 * load_byte
 *
 * Load a byte from an array of bytes
 *
 */

#ifdef __STDC__
void load_byte (zword_t addr, zword_t offset)
#else
void load_byte (addr, offset)
zword_t addr;
zword_t offset;
#endif
{
    unsigned long address;

    /* Calculate byte array index address */

    address = addr + offset;

    /* Load the byte */

    store_operand (read_data_byte (&address));

}/* load_byte */

/*
 * store_word
 *
 * Store a word in an array of words
 *
 */

#ifdef __STDC__
void store_word (zword_t addr, zword_t offset, zword_t value)
#else
void store_word (addr, offset, value)
zword_t addr;
zword_t offset;
zword_t value;
#endif
{

    /* Calculate word array index address */

    addr += offset * 2;

    /* Check we are not writing outside of the writeable data area */

    if (addr > data_size)
        fatal ("Attempted write out of data area");

    /* Store the word */

    set_word (addr, value);

}/* store_word */

/*
 * store_byte
 *
 * Store a byte in an array of bytes
 *
 */

#ifdef __STDC__
void store_byte (zword_t addr, zword_t offset, zword_t value)
#else
void store_byte (addr, offset, value)
zword_t addr;
zword_t offset;
zword_t value;
#endif
{

    /* Calculate byte array index address */

    addr += offset;

    /* Check we are not writing outside of the writeable data area */

    if (addr > data_size)
        fatal ("Attempted write out of data area");

    /* Store the byte */

    set_byte (addr, value);

}/* store_byte */
