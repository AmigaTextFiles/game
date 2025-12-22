/* ==== coords.h ==== */

/* stuff for converting from barycentric to cartesian (easy) and
   cartesian to barycentric (not easy this way) coordinates */


/* Our types */
typedef struct {
    unsigned long coeff_a; /* 2^48 == 1.0 */
    unsigned long coeff_b;
    unsigned long coeff_c;
} baryc_coord_t;

typedef struct {
    unsigned short x_val; /* 2^15==10 (in next square) */
    unsigned short y_val;
} carte_coord_t;

enum tri_type_t {TOP_TRI, LEFT_TRI, RGHT_TRI, BOT_TRI};



carte_coord_t baryc_to_cartesian(baryc_coord_t pos, enum tri_type_t type);
