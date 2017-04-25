%{
    /*
     * Korean Automata Lex File
     */
#include <iostream>
#include <list>
#include <sstream>
#include <termios.h>
#include <unistd.h>
#include <string>
#include "korean_chars.hpp"

#define yychar yytext[0]

int getch(void);
const std::string g_korean(int mode=0);
void g_fill_buf(int pos, char c);
void g_empty_buf(void);
int g_jung_sep(void);

int g_char_buf[3];
%}

SPACE   [ \t]
DOT     [,\.]
NEWLINE [\n]
ANYCHAR [^\0]

CONSONANT   [qwertasdfgzxcvQWERT]
VOWEL       [yuiophjklbnmOP]
WORDEND     {SPACE}|{DOT}|{NEWLINE}|{ANYCHAR}

%s STATE_INITIAL_O
%s STATE_INITIAL_U
%s STATE_INITIAL_E
%s STATE_V
%s STATE_O
%s STATE_U
%s STATE_E
%s STATE_A
%s STATE_K
%s STATE_N
%s STATE_R
%s STATE_L

%%

<INITIAL>{CONSONANT}    { BEGIN STATE_V; g_fill_buf(0, yychar); }
<INITIAL>h              { BEGIN STATE_INITIAL_O; g_fill_buf(1, yychar); }
<INITIAL>n              { BEGIN STATE_INITIAL_U; g_fill_buf(1, yychar); }
<INITIAL>m              { BEGIN STATE_INITIAL_E; g_fill_buf(1, yychar); }
<INITIAL>[yuiopjklbOP]   { g_fill_buf(1, yychar); std::cout << g_korean(); }
<INITIAL>{WORDEND}      { std::cout << yytext; }
<INITIAL>\0             ;

<STATE_INITIAL_O>{CONSONANT}    { BEGIN STATE_V; std::cout << g_korean(); g_fill_buf(0, yychar); }
<STATE_INITIAL_O>[klo]          { BEGIN INITIAL; g_fill_buf(1, yychar); std::cout << g_korean(); }
<STATE_INITIAL_O>h              { std::cout << g_korean(); g_fill_buf(1, yychar); }
<STATE_INITIAL_O>n              { BEGIN STATE_INITIAL_U; std::cout << g_korean(); g_fill_buf(1, yychar); }
<STATE_INITIAL_O>m              { BEGIN STATE_INITIAL_E; std::cout << g_korean(); g_fill_buf(1, yychar); }
<STATE_INITIAL_O>[yuipjbOP]      { BEGIN INITIAL; std::cout << g_korean(); g_fill_buf(1, yychar); std::cout << g_korean(); }
<STATE_INITIAL_O>{WORDEND}      { BEGIN INITIAL; std::cout << g_korean() << yytext; }
<STATE_INITIAL_O>\0             { BEGIN INITIAL; std::cout << g_korean(); }

<STATE_INITIAL_U>{CONSONANT}    { BEGIN STATE_V; std::cout << g_korean(); g_fill_buf(0, yychar); }
<STATE_INITIAL_U>[jlp]          { BEGIN INITIAL; g_fill_buf(1, yychar); std::cout << g_korean(); }
<STATE_INITIAL_U>h              { BEGIN STATE_INITIAL_O; std::cout << g_korean(); g_fill_buf(1, yychar); }
<STATE_INITIAL_U>n              { std::cout << g_korean(); g_fill_buf(1, yychar); }
<STATE_INITIAL_U>m              { BEGIN STATE_INITIAL_E; std::cout << g_korean(); g_fill_buf(1, yychar); }
<STATE_INITIAL_U>[yuiokbOP]      { BEGIN INITIAL; std::cout << g_korean(); g_fill_buf(1, yychar); std::cout << g_korean(); }
<STATE_INITIAL_U>{WORDEND}      { BEGIN INITIAL; std::cout << g_korean() << yytext; }
<STATE_INITIAL_U>\0             { BEGIN INITIAL; std::cout << g_korean(); }

<STATE_INITIAL_E>{CONSONANT}    { BEGIN STATE_V; std::cout << g_korean(); g_fill_buf(0, yychar); }
<STATE_INITIAL_E>l              { BEGIN INITIAL; g_fill_buf(1, yychar); std::cout << g_korean(); }
<STATE_INITIAL_E>h              { BEGIN STATE_INITIAL_O; std::cout << g_korean(); g_fill_buf(1, yychar); }
<STATE_INITIAL_E>n              { BEGIN STATE_INITIAL_U; std::cout << g_korean(); g_fill_buf(1, yychar); }
<STATE_INITIAL_E>m              { std::cout << g_korean(); g_fill_buf(1, yychar); }
<STATE_INITIAL_E>[yuiopjkbOP]    { BEGIN INITIAL; std::cout << g_korean(); g_fill_buf(1, yychar); std::cout << g_korean(); }
<STATE_INITIAL_E>{WORDEND}      { BEGIN INITIAL; std::cout << g_korean() << yytext; }
<STATE_INITIAL_E>\0             { BEGIN INITIAL; std::cout << g_korean(); }

<STATE_V>{CONSONANT}    { std::cout << g_korean(); g_fill_buf(0, yychar); }
<STATE_V>h              { BEGIN STATE_O; g_fill_buf(1, yychar); }
<STATE_V>n              { BEGIN STATE_U; g_fill_buf(1, yychar); }
<STATE_V>m              { BEGIN STATE_E; g_fill_buf(1, yychar); }
<STATE_V>[yuiopjklbOP]   { BEGIN STATE_A; g_fill_buf(1, yychar); }
<STATE_V>{WORDEND}      { BEGIN INITIAL; std::cout << g_korean() << yytext; }
<STATE_V>\0             { BEGIN INITIAL; std::cout << g_korean(); }

<STATE_O>[rq]           { BEGIN STATE_K; g_fill_buf(2, yychar); }
<STATE_O>s              { BEGIN STATE_N; g_fill_buf(2, yychar); }
<STATE_O>f              { BEGIN STATE_R; g_fill_buf(2, yychar); }
<STATE_O>[wetadgzxcvRT] { BEGIN STATE_L; g_fill_buf(2, yychar); }
<STATE_O>[QWE]          { BEGIN STATE_V; std::cout << g_korean(); g_fill_buf(0, yychar); }
<STATE_O>[klo]          { BEGIN STATE_A; g_fill_buf(1, yychar); }
<STATE_O>h              { BEGIN STATE_INITIAL_O; std::cout << g_korean(); g_fill_buf(1, yychar); }
<STATE_O>n              { BEGIN STATE_INITIAL_U; std::cout << g_korean(); g_fill_buf(1, yychar); }
<STATE_O>m              { BEGIN STATE_INITIAL_E; std::cout << g_korean(); g_fill_buf(1, yychar); }
<STATE_O>[yuipjbOP]      { BEGIN INITIAL; std::cout << g_korean(); g_fill_buf(1, yychar); std::cout << g_korean(); }
<STATE_O>{WORDEND}      { BEGIN INITIAL; std::cout << g_korean() << yytext; }
<STATE_O>\0             { BEGIN INITIAL; std::cout << g_korean(); }

<STATE_U>[rq]           { BEGIN STATE_K; g_fill_buf(2, yychar); }
<STATE_U>s              { BEGIN STATE_N; g_fill_buf(2, yychar); }
<STATE_U>f              { BEGIN STATE_R; g_fill_buf(2, yychar); }
<STATE_U>[wetadgzxcvRT] { BEGIN STATE_L; g_fill_buf(2, yychar); }
<STATE_U>[QWE]          { BEGIN STATE_V; std::cout << g_korean(); g_fill_buf(0, yychar); }
<STATE_U>[jlp]          { BEGIN STATE_A; g_fill_buf(1, yychar); }
<STATE_U>h              { BEGIN STATE_INITIAL_O; std::cout << g_korean(); g_fill_buf(1, yychar); }
<STATE_U>n              { BEGIN STATE_INITIAL_U; std::cout << g_korean(); g_fill_buf(1, yychar); }
<STATE_U>m              { BEGIN STATE_INITIAL_E; std::cout << g_korean(); g_fill_buf(1, yychar); }
<STATE_U>[yuiokbOP]      { BEGIN INITIAL; std::cout << g_korean(); g_fill_buf(1, yychar); std::cout << g_korean(); }
<STATE_U>{WORDEND}      { BEGIN INITIAL; std::cout << g_korean() << yytext; }
<STATE_U>\0             { BEGIN INITIAL; std::cout << g_korean(); }

<STATE_E>[rq]           { BEGIN STATE_K; g_fill_buf(2, yychar); }
<STATE_E>s              { BEGIN STATE_N; g_fill_buf(2, yychar); }
<STATE_E>f              { BEGIN STATE_R; g_fill_buf(2, yychar); }
<STATE_E>[wetadgzxcvRT] { BEGIN STATE_L; g_fill_buf(2, yychar); }
<STATE_E>[QWE]          { BEGIN STATE_V; std::cout << g_korean(); g_fill_buf(0, yychar); }
<STATE_E>l              { BEGIN STATE_A; g_fill_buf(1, yychar); }
<STATE_E>h              { BEGIN STATE_INITIAL_O; std::cout << g_korean(); g_fill_buf(1, yychar); }
<STATE_E>n              { BEGIN STATE_INITIAL_U; std::cout << g_korean(); g_fill_buf(1, yychar); }
<STATE_E>m              { BEGIN STATE_INITIAL_E; std::cout << g_korean(); g_fill_buf(1, yychar); }
<STATE_E>[yuiopjkbOP]    { BEGIN INITIAL; std::cout << g_korean(); g_fill_buf(1, yychar); std::cout << g_korean(); }
<STATE_E>{WORDEND}      { BEGIN INITIAL; std::cout << g_korean() << yytext; }
<STATE_E>\0             { BEGIN INITIAL; std::cout << g_korean(); }

<STATE_A>[rq]           { BEGIN STATE_K; g_fill_buf(2, yychar); }
<STATE_A>s              { BEGIN STATE_N; g_fill_buf(2, yychar); }
<STATE_A>f              { BEGIN STATE_R; g_fill_buf(2, yychar); }
<STATE_A>[wetadgzxcvRT] { BEGIN STATE_L; g_fill_buf(2, yychar); }
<STATE_A>[QWE]          { BEGIN STATE_V; std::cout << g_korean(); g_fill_buf(0, yychar); }
<STATE_A>h              { BEGIN STATE_INITIAL_O; std::cout << g_korean(); g_fill_buf(1, yychar); }
<STATE_A>n              { BEGIN STATE_INITIAL_U; std::cout << g_korean(); g_fill_buf(1, yychar); }
<STATE_A>m              { BEGIN STATE_INITIAL_E; std::cout << g_korean(); g_fill_buf(1, yychar); }
<STATE_A>[yuiopjklbOP]   { BEGIN INITIAL; std::cout << g_korean(); g_fill_buf(1, yychar); std::cout << g_korean(); }
<STATE_A>{WORDEND}      { BEGIN INITIAL; std::cout << g_korean() << yytext; }
<STATE_A>\0             { BEGIN INITIAL; std::cout << g_korean(); }

<STATE_K>t                      { BEGIN STATE_L; g_fill_buf(2, yychar); }
<STATE_K>[qwerasdfgzxcvQWERT]   { BEGIN STATE_V; std::cout << g_korean(); g_fill_buf(0, yychar); }
<STATE_K>h                      { BEGIN STATE_O; int next_cho = g_jung_sep(); std::cout << g_korean(); g_char_buf[0] = next_cho; g_fill_buf(1, yychar); }
<STATE_K>n                      { BEGIN STATE_U; int next_cho = g_jung_sep(); std::cout << g_korean(); g_char_buf[0] = next_cho; g_fill_buf(1, yychar); }
<STATE_K>m                      { BEGIN STATE_E; int next_cho = g_jung_sep(); std::cout << g_korean(); g_char_buf[0] = next_cho; g_fill_buf(1, yychar); }
<STATE_K>[yuiopjklbOP]           { BEGIN STATE_A; int next_cho = g_jung_sep(); std::cout << g_korean(); g_char_buf[0] = next_cho; g_fill_buf(1, yychar); }
<STATE_K>{WORDEND}              { BEGIN INITIAL; std::cout << g_korean() << yytext; }
<STATE_K>\0                     { BEGIN INITIAL; std::cout << g_korean(1); }

<STATE_N>[wg]                   { BEGIN STATE_L; g_fill_buf(2, yychar); }
<STATE_N>[qertasdfzxcvQWERT]    { BEGIN STATE_V; std::cout << g_korean(); g_fill_buf(0, yychar); }
<STATE_N>h                      { BEGIN STATE_O; int next_cho = g_jung_sep(); std::cout << g_korean(); g_char_buf[0] = next_cho; g_fill_buf(1, yychar); }
<STATE_N>n                      { BEGIN STATE_U; int next_cho = g_jung_sep(); std::cout << g_korean(); g_char_buf[0] = next_cho; g_fill_buf(1, yychar); }
<STATE_N>m                      { BEGIN STATE_E; int next_cho = g_jung_sep(); std::cout << g_korean(); g_char_buf[0] = next_cho; g_fill_buf(1, yychar); }
<STATE_N>[yuiopjklbOP]           { BEGIN STATE_A; int next_cho = g_jung_sep(); std::cout << g_korean(); g_char_buf[0] = next_cho; g_fill_buf(1, yychar); }
<STATE_N>{WORDEND}              { BEGIN INITIAL; std::cout << g_korean() << yytext; }
<STATE_N>\0                     { BEGIN INITIAL; std::cout << g_korean(1); }

<STATE_R>[qrtagxv]              { BEGIN STATE_L; g_fill_buf(2, yychar); }
<STATE_R>[wesdfzcQWERT]         { BEGIN STATE_V; std::cout << g_korean(); g_fill_buf(0, yychar); }
<STATE_R>h                      { BEGIN STATE_O; int next_cho = g_jung_sep(); std::cout << g_korean(); g_char_buf[0] = next_cho; g_fill_buf(1, yychar); }
<STATE_R>n                      { BEGIN STATE_U; int next_cho = g_jung_sep(); std::cout << g_korean(); g_char_buf[0] = next_cho; g_fill_buf(1, yychar); }
<STATE_R>m                      { BEGIN STATE_E; int next_cho = g_jung_sep(); std::cout << g_korean(); g_char_buf[0] = next_cho; g_fill_buf(1, yychar); }
<STATE_R>[yuiopjklbOP]           { BEGIN STATE_A; int next_cho = g_jung_sep(); std::cout << g_korean(); g_char_buf[0] = next_cho; g_fill_buf(1, yychar); }
<STATE_R>{WORDEND}              { BEGIN INITIAL; std::cout << g_korean() << yytext; }
<STATE_R>\0                     { BEGIN INITIAL; std::cout << g_korean(1); }

<STATE_L>{CONSONANT}            { BEGIN STATE_V; std::cout << g_korean(); g_fill_buf(0, yychar); }
<STATE_L>h                      { BEGIN STATE_O; int next_cho = g_jung_sep(); std::cout << g_korean(); g_char_buf[0] = next_cho; g_fill_buf(1, yychar); }
<STATE_L>n                      { BEGIN STATE_U; int next_cho = g_jung_sep(); std::cout << g_korean(); g_char_buf[0] = next_cho; g_fill_buf(1, yychar); }
<STATE_L>m                      { BEGIN STATE_E; int next_cho = g_jung_sep(); std::cout << g_korean(); g_char_buf[0] = next_cho; g_fill_buf(1, yychar); }
<STATE_L>[yuiopjklbOP]           { BEGIN STATE_A; int next_cho = g_jung_sep(); std::cout << g_korean(); g_char_buf[0] = next_cho; g_fill_buf(1, yychar); }
<STATE_L>{WORDEND}              { BEGIN INITIAL; std::cout << g_korean() << yytext; }
<STATE_L>\0                     { BEGIN INITIAL; std::cout << g_korean(1); }

%%

int main(int argc, char **argv) {
    char c;
    std::stringstream stream;
    std::list<char> buffer;
    std::list<char>::iterator it;
    yyFlexLexer* lexer = new yyFlexLexer(stream, std::cout);
    g_empty_buf();
    std::cout << "\x1B[2J\x1B[H" << std::flush;
    while ((c = getch()) != EOF){
        std::cout << "\x1B[2J\x1B[H" << std::flush;
        if (c == 127) { // backspace
            if (!buffer.empty()) buffer.pop_back();
        }
        else buffer.push_back(c);
        for (it = buffer.begin(); it != buffer.end(); it++) {
            stream << *it;
        }
        stream << '\0'; // EOStream
        lexer->yylex();
    };
    return 0;
}

int yyFlexLexer::yywrap() {
    return 1; // MUST BE 1!!!!!
}

int g_jung_sep(void) {
    int tmp = g_char_buf[2];
    // hanpsy.tistory.com/2 : Unicode index of cho, jung, jong
    switch (g_char_buf[2]) {
        case 1:  g_char_buf[2] = 0; return 0; break;
        case 2:  g_char_buf[2] = 0; return 1; break;
        case 3:  g_char_buf[2] = 1; return 9; break;
        case 4:  g_char_buf[2] = 0; return 2; break;
        case 5:  g_char_buf[2] = 4; return 12; break;
        case 6:  g_char_buf[2] = 4; return 18; break;
        case 7:  g_char_buf[2] = 0; return 3; break;
        case 8:  g_char_buf[2] = 0; return 5; break;
        case 9:  g_char_buf[2] = 8; return 0; break;
        case 10: g_char_buf[2] = 8; return 6; break;
        case 11: g_char_buf[2] = 8; return 7; break;
        case 12: g_char_buf[2] = 8; return 9; break;
        case 13: g_char_buf[2] = 8; return 16; break;
        case 14: g_char_buf[2] = 8; return 17; break;
        case 15: g_char_buf[2] = 8; return 18; break;
        case 16: g_char_buf[2] = 0; return 6; break;
        case 17: g_char_buf[2] = 0; return 7; break;
        case 18: g_char_buf[2] = 17;return 9; break;
        case 19: g_char_buf[2] = 0; return 9; break;
        case 20: g_char_buf[2] = 0; return 10; break;
        case 21: g_char_buf[2] = 0; return 11; break;
        case 22: g_char_buf[2] = 0; return 12; break;
        default: g_char_buf[2] = 0; return tmp - 9;
    }    
}

const std::string g_korean(int mode) { // When mode is 0, simply print korean, when mode is 1, print jongsung as next character's chosung
    std::string result;

    if (g_char_buf[0] == -1 && g_char_buf[1] == -1){
        result = "Error! No character!";
    }
    else if (g_char_buf[0] == -1 && g_char_buf[1] != -1) {
        result = jungsung[g_char_buf[1]];
    }
    else if (g_char_buf[0] != -1 && g_char_buf[1] == -1) {
        // only consonant
        result = chosung[g_char_buf[0]];
    }
    else if (g_char_buf[0] != -1 && g_char_buf[1] != -1) {
        if (mode == 0 || g_char_buf[2] == 0) {
            result = korean_chars[g_char_buf[0] * 21 * 28 + g_char_buf[1] * 28 + g_char_buf[2]];
        }
        else {
            std::string cho = chosung[g_jung_sep()];
            result = korean_chars[g_char_buf[0] * 21 * 28 + g_char_buf[1] * 28 + g_char_buf[2]] + cho;
        }
    }
    g_empty_buf();
    return result;
}

void g_fill_buf(int pos, char c) {
    if (pos == 0) { // Chosung
        switch (c) {
            case 'r': g_char_buf[0] = 0; break;
            case 'R': g_char_buf[0] = 1; break;
            case 's': g_char_buf[0] = 2; break;
            case 'e': g_char_buf[0] = 3; break;
            case 'E': g_char_buf[0] = 4; break;
            case 'f': g_char_buf[0] = 5; break;
            case 'a': g_char_buf[0] = 6; break;
            case 'q': g_char_buf[0] = 7; break;
            case 'Q': g_char_buf[0] = 8; break;
            case 't': g_char_buf[0] = 9; break;
            case 'T': g_char_buf[0] = 10; break;
            case 'd': g_char_buf[0] = 11; break;
            case 'w': g_char_buf[0] = 12; break;
            case 'W': g_char_buf[0] = 13; break;
            case 'c': g_char_buf[0] = 14; break;
            case 'z': g_char_buf[0] = 15; break;
            case 'x': g_char_buf[0] = 16; break;
            case 'v': g_char_buf[0] = 17; break;
            case 'g': g_char_buf[0] = 18; break;
        }
    }
    else if (pos == 1) {
        if (g_char_buf[1] != -1) {
            if (g_char_buf[1] == 8) {
                switch (c) {
                    case 'k': g_char_buf[1] = 9; break;
                    case 'o': g_char_buf[1] = 10; break;
                    case 'l': g_char_buf[1] = 11; break;
                }
            }
            else if (g_char_buf[1] == 13) {
                switch (c) {
                    case 'j': g_char_buf[1] = 14; break;
                    case 'p': g_char_buf[1] = 15; break;
                    case 'l': g_char_buf[1] = 16; break;
                }
            }
            else if (g_char_buf[1] == 18) {
                switch (c) {
                    case 'l': g_char_buf[1] = 19; break;
                }
            }
        }
        else {
            switch (c) {
                case 'k': g_char_buf[1] = 0; break;
                case 'o': g_char_buf[1] = 1; break;
                case 'i': g_char_buf[1] = 2; break;
                case 'O': g_char_buf[1] = 3; break;
                case 'j': g_char_buf[1] = 4; break;
                case 'p': g_char_buf[1] = 5; break;
                case 'u': g_char_buf[1] = 6; break;
                case 'P': g_char_buf[1] = 7; break;
                case 'h': g_char_buf[1] = 8; break;
                case 'y': g_char_buf[1] = 12; break;
                case 'n': g_char_buf[1] = 13; break;
                case 'b': g_char_buf[1] = 17; break;
                case 'm': g_char_buf[1] = 18; break;
                case 'l': g_char_buf[1] = 20; break;
            }
        }
    }
    else if (pos == 2) {
        if (g_char_buf[2] != 0) {
            if (g_char_buf[2] == 1) {
                switch (c) {
                    case 't': g_char_buf[2] = 3; break;
                }
            }
            else if (g_char_buf[2] == 4) {
                switch (c) {
                    case 'w': g_char_buf[2] = 5; break;
                    case 'g': g_char_buf[2] = 6; break;
                }
            }
            else if (g_char_buf[2] == 8) {
                switch (c) {
                    case 'r': g_char_buf[2] = 9; break;
                    case 'a': g_char_buf[2] = 10; break;
                    case 'q': g_char_buf[2] = 11; break;
                    case 't': g_char_buf[2] = 12; break;
                    case 'x': g_char_buf[2] = 13; break;
                    case 'v': g_char_buf[2] = 14; break;
                    case 'g': g_char_buf[2] = 15; break;
                }
            }
            else if (g_char_buf[2] == 17) {
                switch (c) {
                    case 't': g_char_buf[2] = 18; break;
                }
            }
        }
        else {
            switch (c) {
                case 'r': g_char_buf[2] = 1; break;
                case 'R': g_char_buf[2] = 2; break;
                case 's': g_char_buf[2] = 4; break;
                case 'e': g_char_buf[2] = 7; break;
                case 'f': g_char_buf[2] = 8; break;
                case 'a': g_char_buf[2] = 16; break;
                case 'q': g_char_buf[2] = 17; break;
                case 't': g_char_buf[2] = 19; break;
                case 'T': g_char_buf[2] = 20; break;
                case 'd': g_char_buf[2] = 21; break;
                case 'w': g_char_buf[2] = 22; break;
                case 'c': g_char_buf[2] = 23; break;
                case 'z': g_char_buf[2] = 24; break;
                case 'x': g_char_buf[2] = 25; break;
                case 'v': g_char_buf[2] = 26; break;
                case 'g': g_char_buf[2] = 27; break;
            }
        }
    }
}

void g_empty_buf(void) {
    g_char_buf[0] = -1;
    g_char_buf[1] = -1;
    g_char_buf[2] = 0;
}

int getch(void) {
    struct termios oldt, newt;
    int ch;
    tcgetattr( STDIN_FILENO, &oldt );
    newt = oldt;
    newt.c_lflag &= ~( ICANON | ECHO );
    tcsetattr( STDIN_FILENO, TCSANOW, &newt);
    ch = getchar();
    tcsetattr( STDIN_FILENO, TCSANOW, &oldt);
    return ch;
}
