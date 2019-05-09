%{
#include<stdio.h>
#include<string.h>
void yyerror(char *);
#define YYSTYPE double /*double type for YACC stack*/
%}

%token NUM

%%
prog:	/* vacio */
	|	prog line;
	
line:	'\n'
	|	expr '\n' {printf("Resultado: %g\n", $1);};

expr:	expr '+' term {$$ = $1 + $3;}
	|	expr '-' term {$$ = $1 - $3;}
	|	term {$$ = $1;};

term:	term '*' fact {$$ = $1 * $3;}
	|	term '/' fact {$$ = $1 / $3;}
	|	fact {$$ = $1;};

fact: NUM;
%%

void yyerror(char *mgs){
    printf("error:%s",mgs);
}

int yylex(void){
	int c;

	/* Descartando los caracteres inutiles (como yo) */
	int continueFlag = 1;
	
	while(continueFlag){
		c = getchar();
		if(!(c == ' ' || c == '\t')){
			continueFlag = 0;
		}
	}

	/* Leyendo caracteres utiles */
	if(c == '.' || isdigit(c)){
		ungetc(c, stdin);
		scanf("%lf", &yylval);
		return NUM;
	}
	return c;
}

int main(){
	return yyparse();
}

