#include <stdlib.h>
#include <stdio.h>
#include <getopt.h>
#include <time.h>
#include "LinkedList.h"
#include "SparseMatrix.h"

struct timespec diff(struct timespec start, struct timespec end)
{
        struct timespec temp;
        if ((end.tv_nsec - start.tv_nsec) < 0) 
        {
                temp.tv_sec = end.tv_sec - start.tv_sec - 1;
                temp.tv_nsec = 1000000000 + end.tv_nsec - start.tv_nsec;
        } 
        else 
        {
                temp.tv_sec = end.tv_sec - start.tv_sec;
                temp.tv_nsec = end.tv_nsec - start.tv_nsec;
        }
        return temp;
}

int main(int argc, char * argv[])
{
    struct timespec start, end;
    clock_gettime(CLOCK_REALTIME, &start);

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
                if(value != 0 || (value==0 && j==n-1)) // Adds the last zero position if lines contains only zeros
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

    FILE *outputfile;
    // Select if output is stdout or a file
    if(outfname != NULL) outputfile = fopen(outfname, "w");
    else outputfile = stdout;
        
    if (outputfile!=NULL)
    {
        fprintf(outputfile, "%dx%d\n", first->m, first->n);
        printMatrix(outputfile, first, 0);
        fclose (outputfile);
    }
    
    freeMatrix(first);

    clock_gettime(CLOCK_REALTIME, &end);

    struct timespec result = diff(start, end);
    
    printf("Elapsed time : %lfs\n", (double) (result.tv_sec *1000000000+ result.tv_nsec)/1000000000);
    
    return 0;
}
