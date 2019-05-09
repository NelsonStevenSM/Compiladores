%{
#include<ctype.h>
#include<stdio.h>
#include<string.h>
#include<stdbool.h>
char lexema[255];
void yyerror(char *);
int yylex();
%}
%token NUM
%left NEG
%%

raiz:exp;

exp: '(' number ',' number ')';

number: NUM
			| '-' NUM %prec NEG;

%%
void yyerror(char *mgs){
    printf("... Error: %s\n",mgs);
    }

int yylex(){
 char c;
 while(1){
    c=getchar();
    if(c=='\n') continue;
    if(isspace(c)) continue;

    if(isdigit(c)){
        int i=0;
				do{
        	lexema[i++]=c;
	        c=getchar();
  	  	}while(isdigit(c));

	     		ungetc(c,stdin);
					lexema[i] = 0;
     			return NUM;

    }	

    return c;
  } 
}
int main(){
 if(!yyparse()) printf("cadena valida \n ");
 else printf(" Cadena invalida \n");
 return 0;
}
