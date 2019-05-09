%{
//incluimos librerias y cabeceras
#include<stdio.h>
#include<string.h>
char lexema[64];
void yyerror(char *); 
%}

%token ALGORITMO INICIOALG FINALG INICIO FIN SI ENTONCES ID NUM IGUAL COMA PUNTCOM MAS MENOS RAIZ

%%
expresion: ALGORITMO '<' ID '>' INICIOALG declarar SI evaluar ENTONCES INICIO instr FIN FINALG;
declarar: ID IGUAL NUM listdeclarar;
listdeclarar: COMA ID IGUAL NUM  listdeclarar | ;
evaluar:ID '<' IGUAL NUM;
instr: ID IGUAL expr PUNTCOM;

expr:expr MAS term | term | expr MENOS term;
term: term '*' fact;
term: term '/' fact;
term: fact;
fact: NUM|ID|RAIZ '(' ID ')';
%%

// codigo, scanner, parser
void yyerror(char *mgs){ 
	printf("error:%s",mgs);
}

int PalabraReservada(char lexema[]){
	if (strcasecmp(lexema,"Algoritmo")==0) return ALGORITMO;
	if (strcasecmp(lexema,"inicioAlgoritmo")==0) return INICIOALG;
	if (strcasecmp(lexema,"finAlgoritmo")==0) return FINALG;
	if (strcasecmp(lexema,"inicio")==0) return INICIO;
	if (strcasecmp(lexema,"fin")==0) return FIN;
	if (strcasecmp(lexema,"Si")==0) return SI;
	if (strcasecmp(lexema,"entonces")==0) return ENTONCES;
	if (strcasecmp(lexema,"raiz")==0) return RAIZ;
	return ID;

}

int yylex(){ // esto retorna un token, es decir, numeros
//analizador lexico hecho a mano
	char c;

	while(1){
		c=getchar();
		if(c=='\n') 
			continue;

		if(isspace(c)){
			continue;
		}
		
		if(c=='=') 
			return IGUAL;

		if(c==',') 
			return COMA;
			
		if(c=='+') 
			return MAS;
			
		if(c=='-') 
			return MENOS;
			
		if(c==';') 
			return PUNTCOM;

		if (isalpha(c)){
	         int i=0;
	         do{
	      	 	lexema[i++]=c;
						c=getchar();			
   	         }while(isalnum(c));
		 	ungetc(c,stdin);
		 	lexema[i]='\0';
		 	//lexema[i]=0;
		 	return PalabraReservada(lexema);
		 	
	       }
		

		if(isdigit(c)){
			int i=0;
			do{
				lexema[i++] = c;
				c=getchar();
			} while(isdigit(c));
			
			ungetc(c,stdin); //devuelve el caracter a la entrada estandar
			lexema[i]=0; 
			return NUM; //devuelve el token
		}
		return c;
	}
}

int main(){
	if(!yyparse()) printf("cadena valida \n");
	else printf("cadena invalida\n");
	return 0;
}

