#include <stdlib.h>
#include <stdio.h>
#include <getopt.h>
#include <time.h>
#include "LinkedList.h"
#include "SparseMatrix.h"
#include "DummyMatrix.h"
#include "test.h"

long nbOperations = 0;


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

long getAndReinit()
{
    long t = nbOperations;
    nbOperations = 0;
    return t;
}

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

void generateStatsTest(int m, int n, int nbMul, int percentZero)
{
    srand ((unsigned int)time(NULL));
    SparseMatrix *firstSparse = NULL;
    DummyMatrix firstDummy;
    getAndReinit();
    
    long opCountS = 0;
    long timeS = 0;
    long opCountD = 0;
    long timeD = 0;
    
    struct timespec start, end, result;
    for(int count = 0; count <= nbMul; count++)
    {
        SparseMatrix *nsparse = createMatrix(m,n);
        DummyMatrix ndummy = createDummyMatrix(m,n);
        for(int i = 0; i < m; i++)
        {
            int fvalue = 0; // First non-zero value of the line
            for(int j = 0; j < n; j++)
            {
                if((1+(rand()%100)) > percentZero)
                {
                    //Add to sparse
                    pushBackValueCol(nsparse->valueInfo, 1, j);
                    if(fvalue == 0) // We found the first non-zero value
                    {
                        fvalue = 1;
                        for(int k = i; k >= 0 && nsparse->lineStart[k] == NULL; k--)
                            nsparse->lineStart[k] = nsparse->valueInfo->last;
                    }
                    //Add to dummy
                    ndummy.matrix[i][j] = 1;
                }
                else
                    ndummy.matrix[i][j] = 0;
            }
        }
            
        if(firstSparse == NULL)
        {
            firstSparse = nsparse;
            firstDummy = ndummy;
        }
        else
        {
            SparseMatrix *tempS = firstSparse;
            DummyMatrix tempD = firstDummy;
            
            //Sparse
            clock_gettime(CLOCK_REALTIME, &start);
            firstSparse = multiplyMatrixes(firstSparse, nsparse);
            clock_gettime(CLOCK_REALTIME, &end);
            result = diff(start, end);
            timeS += result.tv_sec *1000000000+ result.tv_nsec;
            
            opCountS += getAndReinit();
            freeMatrix(tempS);
            freeMatrix(nsparse);
            
            //Dummy
            clock_gettime(CLOCK_REALTIME, &start);
            firstDummy = multiplyDummyMatrixes(firstDummy, ndummy);
            clock_gettime(CLOCK_REALTIME, &end);
            result = diff(start, end);
            timeD += result.tv_sec *1000000000+ result.tv_nsec;
            
            opCountD += getAndReinit();
            freeDummyMatrix(tempD);
            freeDummyMatrix(ndummy);
        }
    }
    
    freeMatrix(firstSparse);
    freeDummyMatrix(firstDummy);
    
    printf("%d,%lu,%lu,%lu,%lu\n",percentZero, opCountS, timeS, opCountD, timeD);
}

void generateStats()
{
    int m = 200;
    int n = 200;
    int count = 10;
    
    printf("Test for matrixes of size %dx%d, %d multiplications\n",m,n,count);
    printf("PercentOfZero,NbOperationSparse,TimeNanoSecSparse,NbOperationDummy,TimeNanoSecDummy\n");
    for(int i = 0; i <= 100; i+= 1)
    {
        generateStatsTest(m,n,count,i);
    }
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
    while ((c = getopt (argc, argv, "tdo:")) != -1)
    {
        if(c == 'o')outfname = optarg;
        else if(c == 'd')sparse = 0;
        else if(c == 't') //test
        {
            generateStats();
            return EXIT_SUCCESS;
        }
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
