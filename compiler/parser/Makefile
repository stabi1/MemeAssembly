all:
	flex -d MemeAssembly.l
	bison -d MemeAssembly.y
	gcc -o test lex.yy.c MemeAssembly.tab.c ../logger/log.c