%{
%}

%s ASTATE ESTATE

DIGIT [0-9]
ALPHA [A-Za-z]
VARNM [a-zA-Z][a-zA-Z0-9]*
OP    [-+\*\/\^]

%%

[\t]+   ;
<ASTATE>=   {BEGIN ESTATE; printf("Got assignment.\n"); }
<ESTATE>{DIGIT}+ { printf("Got number: %s\n", yytext); }
<ESTATE>{ALPHA}+ { printf("Got name: %s\n", yytext); }
<ESTATE>{OP}    {printf("Got op: %s\n", yytext); }
<ESTATE>\n  {BEGIN 0, printf(".\n"); }
quit    { exit(0); }
{VARNM}  {BEGIN ASTATE; printf("Got variable: %s\n", yytext);}
.\n ;

%%

int main(int c, char **argv) {
    yylex();
}
