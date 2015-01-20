%option noyywrap
%{
#include <iostream>
#include <string>

using namespace std;
#define YY_DECL extern "C" int yylex()

%}

%x incl
%%
#include { BEGIN(incl); cout<< yytext; }
[A-Za-z\t\n]*	   { cout << yytext; }
" "		   { cout << yytext; }
<incl>[ \t]*"<"
<incl>[^ \t\n>]+ { yyin = fopen(yytext, "r");
		if(!yyin)
		{
			cout << "ERROR opening file";
			yyterminate();
		}
		else
		{
			cout <<endl<< "Reading file : "<<yytext<<endl;
			yypush_buffer_state(yy_create_buffer( yyin, YY_BUF_SIZE));
		}
		BEGIN(INITIAL);
		 }
     
<<EOF>> {
     			yypop_buffer_state();
     
                 if ( !YY_CURRENT_BUFFER )
                     {
                     yyterminate();
                     }
                 }

. ;
%%

int main()
{
	FILE *myfile = fopen("sample.txt", "r");
	
	if (!myfile) {
		cout << "not opened!"<<endl;
	}
	yyin = myfile;
	yylex();
}
	
