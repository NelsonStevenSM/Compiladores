%{
#include<ctype.h>
#include<stdio.h>
#include<string.h>
#include<stdbool.h>
char lexema[255];
void yyerror(char *);
int yylex();
%}
%token PROGRAM EXAMPLE LIBRERIA UNO DOS INICIO FIN REAL VAR 
%token LETRA SEN NUM RAIZ
%left NEG
%%

raiz:
		| PROGRAM EXAMPLE librerias;

librerias: 
				 | '#' LIBRERIA '<' name '>' librerias 
				 | cuerpo librerias;

name: UNO | DOS;

cuerpo: VAR letra ':' REAL cuerpo
		 | INICIO operando;


letra: LETRA
		 | LETRA ',' letra;

operando: 
				| FIN
				| LETRA ':' '=' numero operando ;

numero: NUM
			| '-' NUM %prec NEG
			| NUM '+' numero
			| NUM '-' numero
			| NUM '^' numero
			| NUM '*' numero
			| NUM '/' numero
			| SEN '(' numero ')'
			| RAIZ '(' numero ')'; 

%%
void yyerror(char *mgs){
    printf("... Error: %s\n",mgs);
    }

int yylex(){
 char c;
 while(1){
		memset(lexema,0,sizeof(lexema));

    c=getchar();

    if(c=='\n') continue;
    if(isspace(c)) continue;

    if(isalpha(c)){
        int i=0;
				do{
        	lexema[i++]=c;
	        c=getchar();
  	  	}while(isalnum(c) || c == '.');

	     		ungetc(c,stdin);
					lexema[i] = 0;
					if(!strcmp(lexema,"Program")) return PROGRAM;
					if(!strcmp(lexema,"Ejemplo")) return EXAMPLE;
					if(!strcmp(lexema,"libreria")) return LIBRERIA;
					if(!strcmp(lexema,"uno.h")) return UNO;
					if(!strcmp(lexema,"dos.h")) return DOS;
					if(!strcmp(lexema,"Var")) return VAR;
					if(!strcmp(lexema,"real")) return REAL;
					if(!strcmp(lexema,"sen")) return SEN;
					if(!strcmp(lexema,"Inicio")) return INICIO;
					if(!strcmp(lexema,"raiz")) return RAIZ;
					if(!strcmp(lexema,"Fin")) return FIN;

     			return LETRA;

    }	

		if (c >= 48 && c <= 57){
			int i =0;
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
int main(){
 if(!yyparse()) printf("cadena valida \n ");
 else printf(" Cadena invalida \n");
 return 0;
}
