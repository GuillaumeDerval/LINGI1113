#include <stdlib.h>
#include <stdio.h>
#include <getopt.h>
#include "LinkedList.h"
#include "SparseMatrix.h"

int main(int argc, char * argv[])
{
    char *outfile = NULL;
    char *infile = NULL;
    
    // Check for the output file
    int c;
    while ((c = getopt (argc, argv, "o:")) != -1)
    {
        if(c== 'o')outfile = optarg;
        else return -1;
    }
    
    // Check for the input file
	if (optind < argc) infile =  argv[optind++];
    else
    {
		printf("Input file missing !\n");
		return -1;
	}
         
    printf("in : %s\nout : %s\n", infile, outfile);
	
    SparseMatrix* first, *second, *third, *fourth, *fifth;
    
    first = createMatrix(2, 2);
    pushBackValueCol(first->valueInfo, 1, 0); pushBackValueCol(first->valueInfo, 2, 0); pushBackValueCol(first->valueInfo, 3, 1);
    first->lineStart[0] = first->valueInfo->first; first->lineStart[1] = first->valueInfo->first->next; first->lineStart[2] = NULL;
    
    second = createMatrix(2, 4);
    pushBackValueCol(second->valueInfo, 4, 0); pushBackValueCol(second->valueInfo, 5, 2); pushBackValueCol(second->valueInfo, 6, 1); pushBackValueCol(second->valueInfo, 7, 3);
    second->lineStart[0] = second->valueInfo->first; second->lineStart[1] = second->valueInfo->first->next->next; second->lineStart[2] = NULL;
    
    third = multiplyMatrixes(first, second);
    
    fourth = createMatrix(4, 2);
    pushBackValueCol(fourth->valueInfo, 8, 0); pushBackValueCol(fourth->valueInfo, 9, 1); pushBackValueCol(fourth->valueInfo, 10, 0); pushBackValueCol(fourth->valueInfo, 11, 1);
    fourth->lineStart[0] = fourth->valueInfo->first;
    fourth->lineStart[1] = fourth->valueInfo->first->next;
    fourth->lineStart[2] = fourth->valueInfo->first->next->next;
    fourth->lineStart[3] = fourth->valueInfo->first->next->next->next;
    fourth->lineStart[4] = NULL;
    
    fifth = multiplyMatrixes(third, fourth);
    printf("First:\n"); printMatrix(first, 1); printf("\n\n");
    printf("Second:\n"); printMatrix(second, 1); printf("\n\n");
    printf("Third:\n"); printMatrix(third, 1); printf("\n\n");
    printf("Fourth:\n"); printMatrix(fourth, 1); printf("\n\n");
    printf("Fifth:\n"); printMatrix(fifth, 1); printf("\n\n");
    
    freeMatrix(first);
    freeMatrix(second);
    freeMatrix(third);
    freeMatrix(fourth);
    freeMatrix(fifth);
    return 0;
}
