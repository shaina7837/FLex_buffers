%{
#include <iostream>
#include <string>

using namespace std;
#define YY_DECL extern "C" int yylex()

string filename;
%}

%%
include[ \t\n]*"<" { cout<<"included"<<endl;}
[^ \t\n>]+	   { cout << yytext;
			 FILE *in = fopen( yytext, "r" );
     
                 if ( !in )
                     cout << "error found"<<endl;
     
     			yypush_buffer_state(yy_create_buffer( in, YY_BUF_SIZE ));
     
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
	  yypush_buffer_state(yy_create_buffer(yyin, YY_BUF_SIZE));

	yylex();
}
	
