#include <stdlib.h>
#include <stdio.h>
#include <getopt.h>
#include <time.h>
#include "LinkedList.h"
#include "SparseMatrix.h"
#include "DummyMatrix.h"

#ifdef __MACH__
#include <sys/time.h>
#define CLOCK_REALTIME 0
    //clock_gettime is not implemented on OSX
    int clock_gettime(int clk_id, struct timespec* t)
    {
        struct timeval now;
        int rv = gettimeofday(&now, NULL);
        if (rv) return rv;
        t->tv_sec  = now.tv_sec;
        t->tv_nsec = now.tv_usec * 1000;
        return 0;
    }
#endif

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
    int sparse = 1;
    
    // Check for the output file
    int c;
    while ((c = getopt (argc, argv, "no:")) != -1)
    {
        if(c == 'o')outfname = optarg;
        else if(c == 'n')sparse = 0;
        else return -1;
    }
    
    // Check for the input file
    if (optind < argc)
        infname =  argv[optind++];
    else
    {
        printf("Input file missing !\n");
        return -1;
    }
    
    printf("Input file : %s\nOutput file : %s\n", infname, outfname);
    
    FILE * inputfile = fopen(infname, "r");
    FILE *outputfile;
    // Select if output is stdout or a file
    if(outfname != NULL)
        outputfile = fopen(outfname, "w");
    else
        outputfile = stdout;
    
    if(sparse)
    {
        SparseMatrix *first = NULL, *second = NULL;
        int m = 0, n = 0;
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
                    if(value != 0) // Adds the last zero position if lines contains only zeros
                    {
                        pushBackValueCol(second->valueInfo, value, j);
                        if(fvalue == 0) // We found the first non-zero value
                        {
                            fvalue = value;
                            for(int k = i; k >= 0 && second->lineStart[k] == NULL; k--)
                                second->lineStart[k] = second->valueInfo->last;
                        }
                    }
                }
            }
            second->lineStart[m] = NULL;
            
            if(first == NULL)
                first = second;
            else
            {
                SparseMatrix *tmp = multiplyMatrixes(first, second);
                freeMatrix(first);
                first = tmp;
                freeMatrix(second);
                second = NULL;
            }
        }
        
        if (outputfile!=NULL)
        {
            fprintf(outputfile, "%dx%d\n", first->m, first->n);
            printMatrix(outputfile, first, 0);
            fclose (outputfile);
        }
        freeMatrix(first);
    }
    else
    {
        DummyMatrix first, second;
        first.n = first.m = 0;
        int m = 0, n = 0;
        while( fscanf(inputfile, "%dx%d", &m, &n) == 2)
        {
            printf("Reaching matrix : %d per %d\n", m, n);
            second = createDummyMatrix(m, n);
            for(int i=0; i<m; i++)
            {
                for(int j=0; j<n; j++)
                {
                    int value;
                    fscanf(inputfile, "%d", &value);
                    second.matrix[i][j] = value;
                }
            }
            if(first.n == 0)
                first = second;
            else
            {
                DummyMatrix nfirst = multiplyDummyMatrixes(first, second);
                freeDummyMatrix(first);
                freeDummyMatrix(second);
                first = nfirst;
            }
        }
        
        if (outputfile!=NULL)
        {
            fprintf(outputfile, "%dx%d\n", first.m, first.n);
            printDummyMatrix(outputfile, first, 0);
            fclose (outputfile);
        }
        freeDummyMatrix(first);
        
    }
    fclose(inputfile);

    clock_gettime(CLOCK_REALTIME, &end);

    struct timespec result = diff(start, end);
    
    printf("Elapsed time : %lfs\n", (double) (result.tv_sec *1000000000+ result.tv_nsec)/1000000000);
    
    return 0;
}
