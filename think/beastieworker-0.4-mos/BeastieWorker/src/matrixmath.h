#define _MATRIX_SIZE_  4
#define _VERTEX_SIZE_  3

typedef float type_matrix[_MATRIX_SIZE_][_MATRIX_SIZE_];
typedef float type_vertex[_VERTEX_SIZE_];

int MatrixCopy (type_matrix, type_matrix);
int VertexFilling (type_vertex, float, float, float);
int VertexAdd (type_vertex, type_vertex, type_vertex);
int VertexMul (type_vertex, type_vertex, type_vertex);
int VertexSub (type_vertex, type_vertex, type_vertex);
int MatrixRotX (type_matrix, float);
int MatrixRotY (type_matrix, float);
int MatrixRotZ (type_matrix, float);
int MatrixConcat (type_matrix, type_matrix);
int MatrixApply (type_vertex, type_matrix);
int MatrixApply (float *, float *, float *, type_matrix);
int MatrixApplyNormal (float *, float *, float *, type_matrix);
int MatrixInvertApply (type_vertex, type_matrix);
int MatrixInvertApply (float *, float *, float *, type_matrix);
int MatrixInvertApplyNormal (float *, float *, float *, type_matrix);

