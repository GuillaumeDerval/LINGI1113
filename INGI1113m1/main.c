#include <stdlib.h>
#include <stdio.h>
#include <getopt.h>
#include "LinkedList.h"
#include "SparseMatrix.h"

int main(int argc, char * argv[])
{
    char *outfname = NULL;
    char *infname = NULL;
    
    // Check for the output file
    int c;
    while ((c = getopt (argc, argv, "o:")) != -1)
    {
        if(c== 'o')outfname = optarg;
        else return -1;
    }
    
    // Check for the input file
	if (optind < argc) infname =  argv[optind++];
    else
    {
		printf("Input file missing !\n");
		return -1;
	}
	
	 printf("Input file : %s\nOutput file : %s\n", infname, outfname);
	
	FILE * inputfile = fopen(infname, "r");
	
	SparseMatrix *first = NULL, *second = NULL;
	
	int m= 0, n= 0;
	while( fscanf(inputfile, "%dx%d", &m, &n) == 2)
	{
		printf("Reaching matrix : %d per %d\n", m, n);
		
		second = createMatrix(m, n); // Init a new matrix
		for(int i=0; i<m; i++)
		{
			int fvalue = 0; // First non-zero value of the line
			for(int j=0; j<n; j++)
			{
				int value;
				fscanf(inputfile, "%d", &value);
				if(value != 0)
				{
					pushBackValueCol(second->valueInfo, value, j);
					if(fvalue ==0) // We found the first non-zero value
					{
						fvalue = value;
						second->lineStart[i] = second->valueInfo->last;
					}
				}
				
			}
		}
		second->lineStart[m] = NULL;
		
		if(first == NULL) first = second;
		else
		{
			SparseMatrix *tmp = multiplyMatrixes(first, second);
			freeMatrix(first);
			first = tmp;
			freeMatrix(second);
			second = NULL;
		}
	}
	
	fclose(inputfile);
	
    //SparseMatrix *third, *fourth, *fifth;
    
    //first = createMatrix(2, 2);
    //pushBackValueCol(first->valueInfo, 1, 0); pushBackValueCol(first->valueInfo, 2, 0); pushBackValueCol(first->valueInfo, 3, 1);
    //first->lineStart[0] = first->valueInfo->first; first->lineStart[1] = first->valueInfo->first->next; first->lineStart[2] = NULL;
    
    //second = createMatrix(2, 4);
    //pushBackValueCol(second->valueInfo, 4, 0); pushBackValueCol(second->valueInfo, 5, 2); pushBackValueCol(second->valueInfo, 6, 1); pushBackValueCol(second->valueInfo, 7, 3);
    //second->lineStart[0] = second->valueInfo->first; second->lineStart[1] = second->valueInfo->first->next->next; second->lineStart[2] = NULL;
    
    //third = multiplyMatrixes(first, second);
    
    //fourth = createMatrix(4, 2);
    //pushBackValueCol(fourth->valueInfo, 8, 0); pushBackValueCol(fourth->valueInfo, 9, 1); pushBackValueCol(fourth->valueInfo, 10, 0); pushBackValueCol(fourth->valueInfo, 11, 1);
    //fourth->lineStart[0] = fourth->valueInfo->first;
    //fourth->lineStart[1] = fourth->valueInfo->first->next;
    //fourth->lineStart[2] = fourth->valueInfo->first->next->next;
    //fourth->lineStart[3] = fourth->valueInfo->first->next->next->next;
    //fourth->lineStart[4] = NULL;
    
    //fifth = multiplyMatrixes(third, fourth);
    printf("Result :\n"); printMatrix(first, 1); printf("\n\n");
    //printf("Second:\n"); printMatrix(second, 1); printf("\n\n");
    //printf("Third:\n"); printMatrix(third, 1); printf("\n\n");
    //printf("Fourth:\n"); printMatrix(fourth, 1); printf("\n\n");
    //printf("Fifth:\n"); printMatrix(fifth, 1); printf("\n\n");
    
    freeMatrix(first);
    //freeMatrix(second);
    //freeMatrix(third);
    //freeMatrix(fourth);
    //freeMatrix(fifth);
    return 0;
}
