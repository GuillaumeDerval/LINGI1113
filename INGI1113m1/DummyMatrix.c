#include <stdio.h>
#include <stdlib.h>
#include "DummyMatrix.h"
#include "test.h"

DummyMatrix createDummyMatrix(int m, int n)
{
    DummyMatrix dummy;
    dummy.n = n;
    dummy.m = m;
    dummy.matrix = (int**)malloc(sizeof(int*)*m);
    for(int i = 0; i < m; i++)
        dummy.matrix[i] = (int*)malloc(sizeof(int)*n);
    
    if(!dummy.matrix)
        exit(EXIT_FAILURE); //only for test.
    return dummy;
}

void freeDummyMatrix(DummyMatrix m)
{
    for(int i = 0; i < m.m; i++)
        free(m.matrix[i]);
    free(m.matrix);
}

DummyMatrix multiplyDummyMatrixes(DummyMatrix first, DummyMatrix second)
{
    if(first.n != second.m)
        exit(EXIT_FAILURE); //only for test.
    
    DummyMatrix dummy = createDummyMatrix(first.m, second.n);
    for(int i = 0; i < first.m; i++)
    {
        for(int j = 0; j < second.n; j++)
        {
            dummy.matrix[i][j] = 0;
            for(int k = 0; k < first.n; k++)
            {
                dummy.matrix[i][j] += first.matrix[i][k]*second.matrix[k][j];
                nbOperations++;
            }
        }
    }
    return dummy;
}

void printDummyMatrix(FILE * out, DummyMatrix matrix, int mode)
{
    //Beautiful
    int* lineWidth = NULL;
    int totalLineWidth = 0;
    if(mode)
    {
        lineWidth = (int*)malloc(sizeof(int)*matrix.n);
        for(int j = 0; j < matrix.n; j++)
            lineWidth[j] = 1;
        
        for(int i = 0; i < matrix.m; i++)
        {
            for(int j = 0; j < matrix.n; j++)
            {
                int size = getIntegerDisplaySize(matrix.matrix[i][j]);
                if(size > lineWidth[j])
                    lineWidth[j] = size;
            }
        }
        
        totalLineWidth = 1;
        for(int j = 0; j < matrix.n; j++)
            totalLineWidth += lineWidth[j]+1;
    }
    
    for(int i = 0; i < matrix.m; i++)
    {
        if(mode >= 3)
        {
            for(int j = 0; j < totalLineWidth; j++)
                fprintf(out, "-");
            fprintf(out, "\n");
        }
        
        if(mode >= 2)
            fprintf(out, "|");
        for(int j = 0; j < matrix.n; j++)
        {
            if(mode)
                for(int spaces = lineWidth[j]-getIntegerDisplaySize(matrix.matrix[i][j]); spaces > 0; spaces--)
                    fprintf(out, " ");
            fprintf(out, "%i", matrix.matrix[i][j]);
            if(mode >= 2)
                fprintf(out, "|");
            else
                fprintf(out, " ");
        }
        fprintf(out, "\n");
    }
    if(mode >= 3)
    {
        for(int j = 0; j < totalLineWidth; j++)
            fprintf(out, "-");
        fprintf(out, "\n");
    }
    
    if(mode)
        free(lineWidth);
}
