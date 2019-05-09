%{
#include<ctype.h>
#include<stdio.h>
#include<string.h>
char lexema[255];
void yyerror(char *);
int yylex();
%}
%token  VAR IGUAL NUM 
%token MENOS POR PI POT PF MAS DIV PUNTO COMA POTE
%%

raiz: {printf("Final\n");}
	 | VAR IGUAL ope COMA raiz;

ope:PI term PF ope 
	| term ope
	| term;

term:dec 
	| term MENOS dec | term MENOS PI term PF
	| term MAS  dec | term MAS PI term PF
	| term POR dec | term POR PI term PF
	| term DIV dec | term DIV PI term PF; 

dec:NUM
	 | VAR
	 | VAR POTE NUM
	 | NUM POTE NUM 
	 | NUM PUNTO NUM;

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
    if(c=='=') return IGUAL;
    if(c=='+') return MAS;
    if(c=='-') return MENOS;
    if(c=='*') return POR;
    if(c=='/') return DIV;
    if(c=='(') return PI;
    if(c==')') return PF;
    if(c=='.') return PUNTO;
    if(c==';') return COMA;
    if(c=='^') return POTE;

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

    if( (c >= 48 && c<= 57) || c == '.'){
        int i=0;
    		do{
        	lexema[i++]=c;
				//scanf("%lf",&yylval);
	        c=getchar();
  		  }while(isdigit(c));

     		ungetc(c,stdin);
     		lexema[i]=0;
//				yylval = atoi(lexema);
				
     return NUM;
		}

    return c;
  } 
}
int main(){
	printf("Programa Ejemplo;\n");
	printf("Inicio\n");
 if(!yyparse()) printf("cadena valida \n ");
 else printf (" Cadena invalida \n");
 return 0;
}
