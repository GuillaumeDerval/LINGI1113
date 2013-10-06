#ifndef INGI1113m1_DummyMatrix_h
#define INGI1113m1_DummyMatrix_h

#include <stdlib.h>

struct DummyMatrix
{
    int n;
    int m;
    int** matrix;
};
typedef struct DummyMatrix DummyMatrix;

DummyMatrix createDummyMatrix(int m, int n);
void freeDummyMatrix(DummyMatrix m);
DummyMatrix multiplyDummyMatrixes(DummyMatrix first, DummyMatrix second);

// Print matrix.
// mode = 0 -> print directly without formatting the matrix
// mode = 1 -> align numbers
// mode = 2 -> align numbers and create lateral borders
// mode = 3 -> align numbers and create all borders
void printDummyMatrix(FILE* out, DummyMatrix matrix, int mode);
int getIntegerDisplaySize(int integer);
#endif
