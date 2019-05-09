%{
#include<stdio.h>
#include<math.h>
char lexema[255];
#define YYSTYPE double
void yyerror(char * );
int yylex(void);
%}

%token NUM

%%
exp: 
   NUM
   | exp exp '+'
   | exp exp '-'
   | exp exp '*'
   | exp exp '/'
   | exp exp '^';
%%
#include<ctype.h>

int yylex(void){
	char c;
	while(1){
		c = getchar();
		if (isspace(c)) continue;
		if (c == '\n' ) continue;
		if (isdigit(c)){
			int i = 0;
			do{
				lexema[i++] = c;
				c = getchar();
			}while(isdigit(c));
	
			ungetc(c, stdin);
			lexema[i] = 0;
			return NUM;
		}

		return c;
	}
}

void yyerror(char *s){
	printf("%s\n",s);

}

int main(){
	if(!yyparse()) printf("Cadena Valida \n");
	else printf("Cadena no Valida \n");
	return 0;
}

