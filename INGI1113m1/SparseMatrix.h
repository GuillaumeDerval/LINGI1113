//
//  SparseMatrix.h
//  INGI1113m1
//
//  Created by Guillaume Derval on 23/09/13.
//  Copyright (c) 2013 Guillaume Derval. All rights reserved.
//

#ifndef INGI1113m1_SparseMatrix_h
#define INGI1113m1_SparseMatrix_h
#include "LinkedList.h"

struct SparseMatrix /*http://en.wikipedia.org/wiki/Sparse_matrix#Yale_format*/
{
    int m;
    int n;
    ValueColLinkedListNode** lineStart;
    ValueColLinkedList* valueInfo; /* values on same line have not to be in increasing order of columns.*/
};
typedef struct SparseMatrix SparseMatrix;

SparseMatrix* createMatrix(int m, int n);
void freeMatrix(SparseMatrix* matrix);
SparseMatrix* multiplyMatrixes(SparseMatrix* left, SparseMatrix* right);

// Print matrix.
// mode = 0 -> print directly without formatting the matrix
// mode = 1 -> align numbers
// mode = 2 -> align numbers and create lateral borders
// mode = 3 -> align numbers and create all borders
void printMatrix(FILE* out, SparseMatrix* matrix, int mode);
#endif
