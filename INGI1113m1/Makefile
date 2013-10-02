EXEC=matrixprod
CFLAGS=-I $(HOME)/local/include -Wall -Werror -g -std=gnu99
LDFLAGS=-L $(HOME)/local/lib -lm -lrt
SRC=$(wildcard *.c)
OBJ=$(SRC:.c=.o)

all: $(EXEC)

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $< 

$(EXEC): $(OBJ)
	$(CC) -o $@ $(OBJ) $(LDFLAGS)

clean:
	rm -rf *.o matrixprod
