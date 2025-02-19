all: main.o
	gcc -o out main.o -lncurses

main.o: src/main.c
	gcc -c -g -Wall $< -o main.o

run:
	./out

clean:
	rm main.o out
