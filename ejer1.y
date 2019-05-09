%{
#include<ctype.h>
#include<stdio.h>
#include<string.h>
char lexema[255];
void yyerror(char *);
int yylex();
%}
%token ID GUION MAYOR VAR NUM IF ELSE
%token PI PF CAD
%%

raiz: 
		| CAD raiz
		| term raiz
		| IF PI cond raiz | ELSE term raiz ;

cond: ID MAYOR var PF term;

term: ID GUION MAYOR var;

var: ID | NUM;

%%
void yyerror(char *mgs){
    printf("... Error: %s ",mgs);
    }

int yylex(){
 char c;
	int cont = 0;
	int conti = 0;
	int bo = 1;
	int bi = 1;
 while(1){
    c=getchar();
    if(c=='\n') continue;
    if(isspace(c)) continue;
    if(c=='.') continue;
    if(c=='-') return GUION;
    if(c=='>') return MAYOR;
    if(c=='(') return PI;
    if(c==')') return PF;

    if(isalpha(c)){
        int i=0;
				int j = 0;
				int cont = 0;
				do{
        	lexema[i++]=c;
	        c=getchar();
  	  	}while(isalnum(c));
				
				if(!strcmp(lexema,"Algoritmo")){
     			memset( lexema, 0, sizeof(lexema));
	     		return CAD;
				}
				if(!strcmp(lexema,"Demo")){ 
     			memset( lexema, 0, sizeof(lexema));
	     		return CAD;
				}
				if(!strcmp(lexema,"inicioAlgoritmo")){
     			memset( lexema, 0, sizeof(lexema));
	     		return CAD;
				}
				if(!strcmp(lexema,"FinAlgoritmo")){
     			memset( lexema, 0, sizeof(lexema));
	     		return CAD;
				}
				if(!strcmp(lexema,"if")){
     			memset( lexema, 0, sizeof(lexema));
	     		return IF;
				}
				if(!strcmp(lexema,"else")){
     			memset( lexema, 0, sizeof(lexema));
	     		return ELSE;
				}

     		ungetc(c,stdin);
     		return ID;
    }

    if( c >= 48 && c<= 57){
        int i=0;
    		do{
        	lexema[i++]=c;
	        c=getchar();
  		  }while(isdigit(c));

     		ungetc(c,stdin);
     		memset( lexema, 0, sizeof(lexema));
				
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
