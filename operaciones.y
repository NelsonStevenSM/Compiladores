%{
#include<ctype.h>
#include<stdio.h>
#include<string.h>
char lexema[255];
void yyerror(char *);
#define api.value.type {int}
int yylex();
%}
%token INI VAR IGUAL NUM FIN

%%

raiz: 
		| INI exp FIN raiz;

exp: 
	 | VAR IGUAL ope exp { printf( "Resultado: %d\n", $3);};

ope: term {$$ = $1;}
	| ope '-' term {$$ = $1 - $3;}
	| ope '+'  term {$$ = $1 + $3;};

term: fact {$$ = $1;}
	| term '*' fact {$$ = $1 * $3;}
	| term '/' fact {$$ = $1 / $3;};

fact: NUM;

%%
void yyerror(char *mgs){
    printf("... Error: %s ",mgs);
    }

int yylex(){
 char c;
 while(1){
    c=getchar();
    if(c=='\n') continue;
    if(isspace(c)) continue;
    if(c=='[') return INI;
    if(c==']') return FIN;
    if(c=='=') return IGUAL;

    if(isalpha(c)){
        int i=0;
				do{
        	lexema[i++]=c;
	        c=getchar();
  	  	}while(isalnum(c));

     		ungetc(c,stdin);
     		lexema[i]=0;

     		return VAR;
    }

    if( c >= 48 && c<= 57){
        int i=0;
    		do{
        	lexema[i++]=c;
	        c=getchar();
  		  }while(isdigit(c));

     		ungetc(c,stdin);
     		lexema[i]=0;
				yylval = atoi(lexema);
				
     return NUM;
		}

    return c;
  } 
}
int main(){
 if(!yyparse()) printf("cadena valida \n ");
 else printf (" Cadena invalida \n");
 return 0;
}
