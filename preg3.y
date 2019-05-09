%{
#include<ctype.h>
#include<stdio.h>
#include<string.h>
char lexema[255];
void yyerror(char *);
int yylex();
%}
%token ID MAYOR MENOR VAR NUM IF IGUAL COMA THEN BEGIN MAS MENOS SQR MUL PUNTCOM END ALG INIA ENDA
%token PI PF LLI LLC
%%

raiz: 
		| ALG MENOR ID MAYOR raiz
		| INIA raiz
		| ID IGUAL NUM COMA ID IGUAL NUM COMA ID IGUAL NUM COMA ID IGUAL NUM raiz
		| IF ID MENOR IGUAL NUM THEN BEGIN raiz
		| ID IGUAL ID MAS ID MENOS SQR PI ID PF MUL ID PUNTCOM END ENDA;

%%

int r=0,a=0,i=0,z=0;
int alg=1;

void yyerror(char *mgs){
    printf("... Error: %s ",mgs);
    }

int yylex(){
 char c;
 while(1){
    memset( lexema, 0, sizeof(lexema));
    c=getchar();
    if(c=='\n') continue;
    if(isspace(c)) continue;
    if(c=='.') continue;
    if(c=='-'){
      alg=0;
      return MENOS;
    } 
    if(c=='>') return MAYOR;
    if(c=='=') return IGUAL;
    if(c==',') return COMA;
    if(c==';') return PUNTCOM;
    if(c=='+') return MAS;
    if(c=='<') return MENOR;
    if(c=='*') return MUL;
    if(c=='(') return PI;
    if(c==')') return PF;
    
    if(isalpha(c)){
        int i=0;
				do{
        	lexema[i++]=c;
	        c=getchar();
	        if(alg==0){
	          if(c=='r') r=1;
	          if(c=='a') a=1;
	          if(c=='i') i=1;
	          if(c=='z') z=1;
	        }
  	  	}while(isalnum(c));
				
				if(alg==0){
				  if(r,a,i,z){
	          r=0;a=0;i=0;z=0;
	          ungetc(c,stdin);
	          alg=1;
	          return SQR;
				  }
				}
				
				
				if(!strcmp(lexema,"Algoritmo")){
	     		return ALG;
				}
				if(!strcmp(lexema,"fin")){ 
	     		return END;
				}
				if(!strcmp(lexema,"inicioAlgoritmo")){
	     		return INIA;
				}
				if(!strcmp(lexema,"inicio")){
	     		return BEGIN;
				}
				if(!strcmp(lexema,"finAlgoritmo")){
	     		return ENDA;
				}
				if(!strcmp(lexema,"Si")){
	     		return IF;
				}
				if(!strcmp(lexema,"entonces")){
	     		return THEN;
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
