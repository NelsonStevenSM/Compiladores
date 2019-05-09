%{
#include<ctype.h>
#include<stdio.h>
#include<string.h>
char lexema[255];
void yyerror(char *);
int yylex();
%}

%token ID IGUAL NUM PUNTOCOM MAS MENOS MULT DIV
%token INICIO FINAL
%left '-' '+'
%left '*' '/'
%right '^'

%%
raiz: INICIO exp FINAL;

exp: 
	 | exp ID IGUAL bi PUNTOCOM;

bi: NUM | suma | resta | mult | divi;

suma: NUM MAS bi;

resta: NUM MENOS bi;

mult: NUM MULT bi;

divi: NUM DIV bi;

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
    if(c=='+') return MAS;
    if(c=='-') return MENOS;
    if(c=='*') return MULT;
    if(c=='/') return DIV;
    if(c==';') return PUNTOCOM;
    if(c=='=') return IGUAL;
    if(c=='[') return INICIO;
    if(c==']') return FINAL;

    if(isalpha(c)){
        int i=0;
		    do{

    	    lexema[i++]=c;
      	  c=getchar();

		    } while(isalnum(c));

    		ungetc(c,stdin);
     		lexema[i]=0;
     		return ID;
    }

    if(isdigit(c)){
        int i=0;
		    do{

     	   	lexema[i++]=c;
      	  c=getchar();

    		} while(isdigit(c));

     		ungetc(c,stdin);
		    lexema[i]=0;
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
