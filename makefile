calc: main.o lex.yy.o y.tab.o
	gcc $^ -o $@

lex.yy.o: lex.yy.c y.tab.h
	gcc $< -c

%.o: %.c
	gcc $< -c

lex.yy.c: calc.l
	lex $<

y.tab.h y.tab.c: calc.y
	yacc -d $<

clean:
	rm -rf calc *.o lex.yy.c y.tab.c y.tab.h
