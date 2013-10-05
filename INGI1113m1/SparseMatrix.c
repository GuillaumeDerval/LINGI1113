//
//  SparseMatrix.c
//  INGI1113m1
//
//  Created by Guillaume Derval on 24/09/13.
//  Copyright (c) 2013 Guillaume Derval. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include "SparseMatrix.h"

/*
 * Based on http://www.mgnet.org/~douglas/Preprints/pub0034.pdf SYMBMM algorithm.
 * Determine positions of non-zeros values in the result matrix.
 */
void determinePositions(SparseMatrix* firstMatrix, SparseMatrix* secondMatrix, SparseMatrix* result)
{
    int maxMNL = firstMatrix->m; //maximum number of lines or columns
    if(maxMNL < firstMatrix->n) maxMNL = firstMatrix->n;
    if(maxMNL < secondMatrix->n) maxMNL = secondMatrix->n;
    
    //Init index
    int* index = (int*)malloc(sizeof(int)*maxMNL);
    if(!index)
        return;
    
    for(int i = 0; i < firstMatrix->m; i++)
    {
        for(int j = 0; j < maxMNL; j++)
            index[j] = 0;
        
        ValueColLinkedListNode* rmNode = result->valueInfo->last;
        for(ValueColLinkedListNode* fmNode = firstMatrix->lineStart[i]; fmNode != firstMatrix->lineStart[i+1]; fmNode = fmNode->next)
        {
            for(ValueColLinkedListNode* smNode = secondMatrix->lineStart[fmNode->column]; smNode != secondMatrix->lineStart[fmNode->column+1]; smNode = smNode->next)
            {
                if(index[smNode->column] == 0)
                {
                    pushBackValueCol(result->valueInfo, -1, smNode->column);
                    index[smNode->column] = 1;
                }
            }
        }
        
        result->lineStart[i] = NULL;
        if((rmNode == NULL && result->valueInfo->first != NULL) || rmNode->next != NULL) //if we added a new element
        {
            rmNode = rmNode == NULL ? result->valueInfo->first : rmNode->next;
            
            for(int j = 0; result->lineStart[i-j] == NULL && i-j >= 0; j++)
                result->lineStart[i-j] = rmNode;
        }
    }
    
    result->lineStart[firstMatrix->m] = NULL;
    free(index);
}

/*
 * Based on http://www.mgnet.org/~douglas/Preprints/pub0034.pdf NUMBMM algorithm.
 * Compute values of the result matrix.
 */
void generateValues(SparseMatrix* firstMatrix, SparseMatrix* secondMatrix, SparseMatrix* result)
{
    int maxMNL = firstMatrix->m; //maximum number of lines or columns
    if(maxMNL < firstMatrix->n) maxMNL = firstMatrix->n;
    if(maxMNL < secondMatrix->n) maxMNL = secondMatrix->n;
    
    //Init temp
    int* temp = (int*)malloc(sizeof(int)*maxMNL);
    if(!temp)
        return;
    for(int i = 0; i < maxMNL; i++)
        temp[i] = 0;
    
    for(int i = 0; i < firstMatrix->m; i++)
    {
        for(ValueColLinkedListNode* fmNode = firstMatrix->lineStart[i]; fmNode != firstMatrix->lineStart[i+1]; fmNode = fmNode->next)
        {
            for(ValueColLinkedListNode* smNode = secondMatrix->lineStart[fmNode->column]; smNode != secondMatrix->lineStart[fmNode->column+1]; smNode = smNode->next)
            {
                temp[smNode->column] = temp[smNode->column] + fmNode->value * smNode->value;
            }
        }
        
        for(ValueColLinkedListNode* rmNode = result->lineStart[i]; rmNode != result->lineStart[i+1]; rmNode = rmNode->next)
        {
            rmNode->value = temp[rmNode->column];
            temp[rmNode->column] = 0;
        }
    }
    free(temp);
}

SparseMatrix* createMatrix(int m, int n)
{
    SparseMatrix* matrix = (SparseMatrix*)malloc(sizeof(SparseMatrix));
    if(!matrix)
        return NULL;
    matrix->m = m;
    matrix->n = n;
    matrix->lineStart = (ValueColLinkedListNode**)malloc(sizeof(ValueColLinkedListNode*)*(m+1));
    if(!matrix->lineStart)
    {
        free(matrix);
        return NULL;
    }
    
    matrix->valueInfo = createValueColLinkedList();
    if(!matrix->valueInfo)
    {
        free(matrix->valueInfo);
        free(matrix);
        return NULL;
    }
    
    for(int i = 0; i <= m; i++)
        matrix->lineStart[i] = NULL;
    
    return matrix;
}

void freeMatrix(SparseMatrix* matrix)
{
    freeValueColLinkedList(matrix->valueInfo);
    free(matrix->lineStart);
    free(matrix);
}

SparseMatrix* multiplyMatrixes(SparseMatrix* left, SparseMatrix* right)
{
    if(!left || !right)
        return NULL;
    if(left->n != right->m)
        return NULL;
    
    SparseMatrix* result = createMatrix(left->m, right->n);
    if(!result)
        return NULL;
    
    determinePositions(left, right, result);
    generateValues(left, right, result);
    
    int countZeros = 0;
    int count = 0;
    long size = 0;
    float ratio = result->m*result->n;
    for(ValueColLinkedListNode* node = result->valueInfo->first; node != NULL; node = node->next)
    {
        if(node->value == 0)
            countZeros++;
        count++;
        size += sizeof(*node);
    }
    ratio/=count;
    printf("Has %d zeros, count %d (ratio %f), size %lu\n", countZeros, count, ratio, size);
    return result;
}

int getIntegerDisplaySize(int integer)
{
    int size = 0;
    
    do
    {
        size++;
        integer/=10;
    } while(integer);
    
    return size;
}

void printMatrix(FILE * out, SparseMatrix* matrix, int mode)
{
    //Help us to reorder line components
    int* line = (int*)malloc(sizeof(int)*matrix->n);
    if(!line)
        return;
    
    //Beautiful
    int* lineWidth = NULL;
    int totalLineWidth = 0;
    if(mode)
    {
        lineWidth = (int*)malloc(sizeof(int)*matrix->n);
        for(int j = 0; j < matrix->n; j++)
            lineWidth[j] = 1;
        
        for(int i = 0; i < matrix->m; i++)
        {
            for(ValueColLinkedListNode* node = matrix->lineStart[i]; node != matrix->lineStart[i+1]; node = node->next)
            {
                int size = getIntegerDisplaySize(node->value);
                if(size > lineWidth[node->column])
                    lineWidth[node->column] = size;
            }
        }
        
        totalLineWidth = 1;
        for(int j = 0; j < matrix->n; j++)
            totalLineWidth += lineWidth[j]+1;
    }

    for(int i = 0; i < matrix->m; i++)
    {
        for(int j = 0; j < matrix->n; j++)
            line[j] = 0;
        
        for(ValueColLinkedListNode* node = matrix->lineStart[i]; node != matrix->lineStart[i+1]; node = node->next)
            line[node->column] = node->value;
        
        if(mode >= 3)
        {
            for(int j = 0; j < totalLineWidth; j++)
                fprintf(out, "-");
            fprintf(out, "\n");
        }
        
        if(mode >= 2)
            fprintf(out, "|");
        for(int j = 0; j < matrix->n; j++)
        {
            if(mode)
                for(int spaces = lineWidth[j]-getIntegerDisplaySize(line[j]); spaces > 0; spaces--)
                    fprintf(out, " ");
            fprintf(out, "%i", line[j]);
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
    free(line);
}







