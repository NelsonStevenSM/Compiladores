%{
#include<ctype.h>
#include<stdio.h>
#include<string.h>
char lexema[255];
void yyerror(char *);
int yylex();
%}

%token SIMB

%%
raiz: 
		| SIMB;

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

    if(isupper(c)){
        int i=0;
				int digit = 2;
				int caract = 2;
    		do{
        	lexema[i++]=c;
	        c=getchar();
					if ( i == 5 ) break;
					if (isdigit(c)) digit--;
					if (c == '*' || c == '@') caract--;
					printf("%d",i);
  		  }while((isdigit(c) || c == '*' || c == '@') && digit >= 0 && caract >= 0);

				if (i==5){
				 	ungetc(c,stdin);
		    	lexema[i]=0;
  		  	return SIMB;
				}
    }

     return c;
   }
}
int main(){
 if(!yyparse()) printf("cadena valida \n ");
 else printf (" Cadena invalida \n");
 return 0;
}
