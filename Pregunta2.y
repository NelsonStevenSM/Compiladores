%{
#include<ctype.h>
#include<stdio.h>
#include<string.h>
char lexema[255];
void yyerror(char *);
int yylex();
%}
%token VAR NUM SUPER SYS HEREDAR
%token DEF PRINT SELF CLASS IF NAME MAIN
%token SINTLIB LIBRERIA INIT
%token APP APPLICAT ARG EXIT EXE
%%
include:
			| libreria include
			| clase include
			| foot include;

libreria: SINTLIB LIBRERIA;

clase: CLASS VAR '(' HEREDAR ')'':' metodos1;

metodos1: DEF '_''_' INIT '_' '_' '(' SELF ')' ':' herencia;
				

herencia: SUPER '.' '_''_' INIT '_' '_' '('HEREDAR')' cuerpo;

cuerpo: 
			| metodos2 cuerpo
			| SELF '.' VAR '(' ')' cuerpo;

metodos2: DEF VAR '(' SELF ')' ':'
				| variables;

variables: VAR '=' NUM;

foot: IF '_''_' NAME '_' '_' '=''=' '"''_''_' MAIN '_''_''"' ':' objeto;

objeto: APP '=' APPLICAT '(' SYS '.' ARG ')' objeto2;
			
objeto2: VAR '=' VAR '('')' ejecutar;

ejecutar: SYS '.' EXIT '(' APP '.' EXE '(' ')'')'

%%

int yylex(){
 char c;
 while(1){
    memset( lexema, 0, sizeof(lexema));
    c=getchar();
    if(c=='\n') continue;
    if(isspace(c)) continue;

    if(isalpha(c)){
        int i=0;
				do{
        	lexema[i++]=c;
	        c=getchar();
  	  	}while(isalnum(c));

     		ungetc(c,stdin);
				lexema[i] = 0;

				if(!strcmp(lexema,"class")) return CLASS;
				if(!strcmp(lexema,"import")) return SINTLIB;
				if(!strcmp(lexema,"numpy")) return LIBRERIA;
				if(!strcmp(lexema,"sys")) return SYS;
				if(!strcmp(lexema,"os")) return LIBRERIA;
				if(!strcmp(lexema,"self")) return SELF;
				if(!strcmp(lexema,"def")) return DEF;
				if(!strcmp(lexema,"init")) return INIT;
				if(!strcmp(lexema,"name")) return NAME;
				if(!strcmp(lexema,"main")) return MAIN;
				if(!strcmp(lexema,"if")) return IF;
				if(!strcmp(lexema,"QWidget")) return HEREDAR;
				if(!strcmp(lexema,"super")) return SUPER;
				if(!strcmp(lexema,"exit")) return EXIT;
				if(!strcmp(lexema,"arg")) return ARG;
				if(!strcmp(lexema,"app")) return APP;
				if(!strcmp(lexema,"QApplication")) return APPLICAT;
				if(!strcmp(lexema,"exec")) return EXE;
			
     		return VAR;
    }
    if( c >= 48 && c <= 57){
        int i=0;
				do{
        	lexema[i++]=c;
	        c=getchar();
  	  	}while((isdigit(c)));
				
     		ungetc(c,stdin);
				lexema[i]=0;
				return NUM;
		}

    return c;
  } 
}
void yyerror(char *mgs){
    printf("\n... Error: %s ",mgs);
    }
int main(){
 if(!yyparse()) printf("cadena valida\n");
 else printf("cadena invalida\n");
 return 0;
}
