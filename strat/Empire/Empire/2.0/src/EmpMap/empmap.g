uint
    WIDTH = 320,
    HEIGHT = 200,
    DEPTH = 5,
    COLOURS = 1 << DEPTH,

    COUNTRY_MAX = COLOURS - 3,
    OWNER_DEITY = COUNTRY_MAX,
    OWNER_UNKNOWN = COUNTRY_MAX + 1,
    NAME_LENGTH = 32;

type
    Country_t = struct {
	[NAME_LENGTH] char c_name;
	ushort c_colour;
    },

    Header_t = struct {
	uint h_size;
	uint h_countryCount;
	ushort h_me;
	[COUNTRY_MAX] Country_t h_country;
	[COLOURS] uint h_colourMap;
    },

    Sector_t = struct {
	ushort s_owner;
	char s_designation;
    };

extern
    emError(*char message)void,
    getHeader()*Header_t,
    getCountry(uint countryNumber)*Country_t,
    getSector(int r, c)*Sector_t,
    refreshSector(int r, c)void;
