%{
#include<ctype.h>
#include<stdio.h>
#include<string.h>
char lexema[255];
void yyerror(char *);
int yylex();
%}
%token VAR ENTIDAD DOMINIO ARR DOT
%%

raiz: 
		| raiz VAR subcad;

subcad: ARR dom;

dom: ENTIDAD DOT DOMINIO;

%%
void yyerror(char *mgs){
    printf("... Error: %s\n",mgs);
    }

int yylex(){
 char c;
 while(1){
    memset( lexema, 0, sizeof(lexema));
    c=getchar();
    if(c=='\n') continue;
    if(isspace(c)) continue;
    if(c=='@') return ARR;
    if(c=='.') return DOT;

    if(isalpha(c)){
        int i=0;
				do{
        	lexema[i++]=c;
	        c=getchar();
  	  	}while(isalnum(c));
     		ungetc(c,stdin);

				if(!strcmp(lexema,"uni")) return ENTIDAD;

				if(!strcmp(lexema,"pe")) return DOMINIO;

     		return VAR;
    }

    return c;
  } 
}
int main(){
 if(!yyparse()) printf("cadena valida \n ");
 else printf(" Cadena invalida \n");
 return 0;
}
