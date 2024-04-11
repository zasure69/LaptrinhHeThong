all: build run
build:
	as -o c34.o c34.s
	ld -o c34 c34.o
run:
	./c34
clean:
	rm -f c34  c34.o