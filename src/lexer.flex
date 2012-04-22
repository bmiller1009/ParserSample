package parser;
import java_cup.runtime.*;
      
%%
   
   
/* -----------------Options and Declarations Section----------------- */
   
/* 
   The name of the class JFlex will create will be Lexer.
   Will write the code to the file Lexer.java. 
*/
%class Lexer

/*
  The current line number can be accessed with the variable yyline
  and the current column number with the variable yycolumn.
*/
%line
%column
    
/* 
   Will switch to a CUP compatibility mode to interface with a CUP
   generated parser.
*/
%cup
   
/*
  Declarations
   
  Code between %{ and %}, both of which must be at the beginning of a
  line, will be copied letter to letter into the lexer class source.
  Here you declare member variables and functions that are used inside
  scanner actions.  
*/
%{   
    /* To create a new java_cup.runtime.Symbol with information about
       the current token, the token will have no value in this
       case. */
    private Symbol symbol(int type) {
        return new LEXSymbol(type, yyline, yycolumn,yytext());
    }
    
    /* Also creates a new java_cup.runtime.Symbol with information
       about the current token, but this object has a value. */
    private Symbol symbol(int type, Object value) {
        return new LEXSymbol(type, yyline, yycolumn, value, yytext());
    }
%}
   

/*
  Macro Declarations
  
  These declarations are regular expressions that will be used latter
  in the Lexical Rules Section.  
*/
   
/* A line terminator is a \r (carriage return), \n (line feed), or
   \r\n. */
LineTerminator = \r|\n|\r\n
   
/* White space is a line terminator, space, tab, or line feed. */
WhiteSpace     = {LineTerminator} | [ \t\f]
   
/* A literal integer is is a number beginning with a number between
   one and nine followed by zero or more numbers between zero and nine
   or just a zero.  */
dec_int_lit = 0 | [1-9][0-9]*
   
/* A identifier integer is a word beginning a letter between A and
   Z, a and z, or an underscore followed by zero or more letters
   between A and Z, a and z, zero and nine, or an underscore. */
dec_int_id = [A-Za-z_][A-Za-z_0-9]*
   
   
CStart  = (\/\*)
CEnd    = (\*+\/)
CBody   = ([^\*]*|\*+[^\/\*])*
Comment = {CStart}{CBody}{CEnd}
   
%%
/* ------------------------Lexical Rules Section---------------------- */
   
/*
   This section contains regular expressions and actions, i.e. Java
   code, that will be executed when the scanner matches the associated
   regular expression. */
   
   /* YYINITIAL is the state at which the lexer begins scanning.  So
   these regular expressions will only be matched if the scanner is in
   the start state YYINITIAL. */
   
<YYINITIAL> {
   
    /* Print the token found that was declared in the class sym and then
       return it. */
    ";"                { return symbol(sym.SEMI); }
    "+"                { return symbol(sym.PLUS); }
    "-"                { return symbol(sym.MINUS); }
    "*"                { return symbol(sym.TIMES); }
    "/"                { return symbol(sym.DIVIDE); }
    "<"                { return symbol(sym.SMALLER); }
    ">"                { return symbol(sym.GREATER); }
    "<="               { return symbol(sym.SMEQ); }
    ">="               { return symbol(sym.GTEQ); }
    "=="               { return symbol(sym.EQL); }
    "!="               { return symbol(sym.NEQ); }
    "="                { return symbol(sym.ASSIGN); }
    "&&"               { return symbol(sym.AND); }
    "||"               { return symbol(sym.OR); }
    "!"                { return symbol(sym.NOT); }
    "%"                { return symbol(sym.MOD); }
    "("                { return symbol(sym.LPAREN); }
    ")"                { return symbol(sym.RPAREN); }
    "["                { return symbol(sym.LBRACKET); }
    "]"                { return symbol(sym.RBRACKET); }
    "[]"               { return symbol(sym.PBRACKET); }
    "{"                { return symbol(sym.LBRACE); }
    "}"                { return symbol(sym.RBRACE); }
    "."                { return symbol(sym.DOT); }
    ".."               { return symbol(sym.DOTDOT);}
    ","                { return symbol(sym.COMMA); }
    "int"              { return symbol(sym.TINT);}
    "bool"             { return symbol(sym.TBOOL);}
    "for"			   { return symbol(sym.FOR);}
    "void"             { return symbol(sym.TVOID);}
    "while"            { return symbol(sym.WHILE);}
    "if"               { return symbol(sym.IF);}   
    "else"             { return symbol(sym.ELSE);}
    "self"             { return symbol(sym.SELF);}
    "class"            { return symbol(sym.CLASS);}
    "extends"          { return symbol(sym.EXTENDS);}
    "new"              { return symbol(sym.NEW);}
    "return"           { return symbol(sym.RETURN);}

    /* If an integer is found print it out, return the token NUMBER
       that represents an integer and the value of the integer that is
       held in the string yytext which will get turned into an integer
       before returning */
    {dec_int_lit}      { return symbol(sym.NUMBER, new Integer(yytext())); }
   
    /* If an identifier is found print it out, return the token ID
       that represents an identifier and the default value one that is
       given to all identifiers. */
    {dec_int_id}       { return symbol(sym.ID, new String(yytext()));}
   
    /* Don't do anything if whitespace is found */
    {WhiteSpace}       { /* just skip what was found, do nothing */ }   
    {Comment}		   { System.out.println("Lexeme for comment [" + yytext()+"]"); }
}


/* No token was found for the input so through an error.  Print out an
   Illegal character message with the illegal character that was found. */
[^]                    { throw new Error("Illegal character <"+yytext()+">"); }
   