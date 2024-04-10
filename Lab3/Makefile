all: build run
build:
	as -o c32_advance.o c32_advance.s
	ld -o c32_advance c32_advance.o
run:
	./c32_advance
clean:
	rm -f c32_advance  c32_advance.o