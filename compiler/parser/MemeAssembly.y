%{
#include "../commands.h"
#include "../logger/log.h"

extern int lineno;
extern int yylex();
void yyerror(const char* e);
%}

%define parse.error verbose
%define api.value.type {
    union YYSTYPE {
      int64_t dval;
      char* label;
    }
}

%token <dval> DECIMAL_NUMBER
%token <label> FUNCTION_NAME
%token <label> MONKE_LABEL

%token TAB SPACE NEWLINE COLON COMMA

%token MULTILINE_COMMENT_START MULTILINE_COMMENT_END

%token DO YOU KNOW DE WEY
%token I LIKE TO HAVE FUN
%token RIGHT BACK AT YA BUCKAROO
%token NO DONT THINK WILL
%token SEE THIS AS AN ABSOLUTE WIN
%token WHOMST HAS SUMMONED THE ALMIGHTY ONE
%token NOT STONKS
%token OR DRAW_25
%token BITCONNEEEEEEECT
%token BACKSLASH_S
%token SNEAK_100
%token IS BRILLIANT BUT

/* 64 Bit Registers */
%token RAX RBX RCX RDX RDI RSI RSP RBP R8 R9 R10 R11 R12 R13 R14 R15

/* 32 Bit Registers */
%token EAX EBX ECX EDX EDI ESI ESP EBP R8D R9D R10D R11D R12D R13D R14D R15D

/* 16 Bit Registers */
%token AX BX CX DX DI SI SP BP R8W R9W R10W R11W R12W R13W R14W R15W

/* 8 Bit Registers */
%token AL AH BL BH CL CH DL DH DIL SIL SPL BPL R8B R9B R10B R11B R12B R13B R14B R15B

%start program
%%

program
    : function program
    | function
    /* | command { yyerror("Command does not belong to any function"); } */

/* What's allowed after a command. TL;DR: [SPACE | TAB]* NEWLINE */
trailing_chars
    : trailing_newline
    | SPACE trailing_chars
    | TAB trailing_chars
trailing_newline: NEWLINE

/* What's allowed before a command. TL;DR: [SPACE | TAB]* */
leading_chars
    : /* epsilon */
    | SPACE leading_chars
    | TAB leading_chars

function: leading_chars function_start function_body leading_chars function_ret
function_start: I SPACE LIKE SPACE TO SPACE HAVE SPACE FUN COMMA SPACE FUN COMMA SPACE FUN COMMA SPACE FUN COMMA SPACE FUN COMMA SPACE FUN COMMA SPACE FUN COMMA SPACE FUN COMMA SPACE FUN COMMA SPACE FUN SPACE FUNCTION_NAME trailing_chars
function_ret
    : RIGHT SPACE BACK SPACE AT SPACE YA SPACE COMMA SPACE BUCKAROO trailing_chars
    | NO COMMA SPACE I SPACE DONT SPACE THINK SPACE I SPACE WILL trailing_chars
    | I SPACE SEE SPACE THIS SPACE AS SPACE AN SPACE ABSOLUTE SPACE WIN trailing_chars
function_body
    : leading_chars command trailing_chars
    | leading_chars command trailing_chars function_body
    /* | function_start { yyerror("Expected a return statement, but got a new function definition"); } */

/* We don't need to suffix all commands with trailing_chars, since the usage in function_body already has that suffix. Same goes for the prefix */
command
    : cmd_func_call
    /* Stack Operations */
    | cmd_stonks
    | cmd_not_stonks
    /* Logical Operations */
    | cmd_bitconnect
    | cmd_not
    /* Register Manipulation */
    | cmd_zero_reg
    | cmd_mov
    /* Random commands */
    | cmd_or_draw_25

    /** Commands **/

cmd_func_call: FUNCTION_NAME COLON SPACE WHOMST SPACE HAS SPACE SUMMONED SPACE THE SPACE ALMIGHTY SPACE ONE func_name

/* Stack Operations */
cmd_stonks: STONKS SPACE reg64
cmd_not_stonks: NOT SPACE STONKS SPACE reg64

/* Logical Operations */
cmd_bitconnect: BITCONNEEEEEEECT SPACE reg
cmd_not: reg SPACE BACKSLASH_S

/* Register Manipulation */
cmd_zero_reg: SNEAK_100 SPACE reg
cmd_mov
    : reg64 IS SPACE BRILLIANT COMMA SPACE BUT SPACE I SPACE LIKE SPACE reg64
    | reg32 IS SPACE BRILLIANT COMMA SPACE BUT SPACE I SPACE LIKE SPACE reg32

/* Random Commands */
cmd_or_draw_25: command SPACE OR SPACE DRAW_25

    /** Parameters **/

/* Some parameters are hidden in multiple TOKENS, so we summarise them */
func_name: FUNCTION_NAME | MONKE_LABEL

pointer: reg SPACE DO SPACE YOU SPACE KNOW SPACE DE SPACE WEY
reg: reg64 | reg32
reg64: RAX | RBX | RCX | RDX | RDI | RSI | RSP | RBP | R8 | R9 | R10 | R11 | R12 | R13 | R14 | R15
reg32: EAX | EBX | ECX | EDX | EDI | ESI | ESP | EBP | R8D | R9D | R10D | R11D | R12D | R13D | R14D | R15D

%%

int main(){
    yyparse();
    return 0;
}

void yyerror(const char* e) {
    fprintf(stderr, "Error: %s\n", e);
}
