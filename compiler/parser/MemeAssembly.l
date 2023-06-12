%option batch
%option noyywrap

%{
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include "../logger/log.h"
#include "MemeAssembly.tab.h"
%}

COMMENT_START "What the hell happened here?"

%%
    /* Comments */
{COMMENT_START}.*   { }
"Why? Why? Why?"    { return MULTILINE_COMMENT_START; }
"Oh, that's why."   { return MULTILINE_COMMENT_END; }

\t          { return TAB; }
" "         { return SPACE; }
\n          { return NEWLINE; }
:           { return COLON; }
,           { return COMMA; }

    /* Words for commands */
do          { return DO; }
you         { return YOU; }
know        { return KNOW; }
de          { return DE; }
wey         { return WEY; }
I           { return I; }
like        { return LIKE; }
to          { return TO; }
have        { return HAVE; }
fun         { return FUN; }
right       { return RIGHT; }
back        { return BACK; }
at          { return AT; }
ya          { return YA; }
buckaroo    { return BUCKAROO; }
no          { return NO; }
don't       { return DONT; }
think       { return THINK; }
will        { return WILL; }
see         { return SEE; }
this        { return THIS; }
as          { return AS; }
an          { return AN; }
absolute    { return ABSOLUTE; }
win         { return WIN; }
whomst      { return WHOMST; }
has         { return HAS; }
summoned    { return SUMMONED; }
the         { return THE; }
almighty    { return ALMIGHTY; }
one         { return ONE; }
stonks      { return STONKS; }
not         { return NOT; }
or          { return OR; }
"draw 25"   { return DRAW_25; }
bitconneeeeeeect { return BITCONNEEEEEEECT; }
\s          { return BACKSLASH_S; }
"sneak 100" { return SNEAK_100; }
is          { return IS; }
brilliant   { return BRILLIANT; }
but         { return BUT; }

    /* 64 Bit Registers */
rax   { return RAX; }
rbx   { return RBX; }
rcx   { return RCX; }
rdx   { return RDX; }
rdi   { return RDI; }
rsi   { return RSI; }
rsp   { return RSP; }
rbp   { return RBP; }
r8    { return R8; }
r9    { return R9; }
r10   { return R10; }
r11   { return R11; }
r12   { return R12; }
r13   { return R13; }
r14   { return R14; }
r15   { return R15; }


    /* 32 Bit Registers */
eax   { return EAX; }
ebx   { return EBX; }
ecx   { return ECX; }
edx   { return EDX; }
edi   { return EDI; }
esi   { return ESI; }
esp   { return ESP; }
ebp   { return EBP; }
r8d   { return R8D; }
r9d   { return R9D; }
r10d  { return R10D; }
r11d  { return R11D; }
r12d  { return R12D; }
r13d  { return R13D; }
r14d  { return R14D; }
r15d  { return R15D; }

    /* 16 Bit Registers */
ax    { return AX; }
bx    { return BX; }
cx    { return CX; }
dx    { return DX; }
di    { return DI; }
si    { return SI; }
sp    { return SP; }
bp    { return BP; }
r8w   { return R8W; }
r9w   { return R9W; }
r10w  { return R10W; }
r11w  { return R11W; }
r12w  { return R12W; }
r13w  { return R13W; }
r14w  { return R14W; }
r15w  { return R15W; }

    /* 8 Bit Registers */
al    { return AL; }
ah    { return AH; }
bl    { return BL; }
bh    { return BH; }
cl    { return CL; }
ch    { return CH; }
dl    { return DL; }
dh    { return DH; }
dil   { return DIL; }
sil   { return SIL; }
spl   { return SPL; }
bpl   { return BPL; }
r8b   { return R8B; }
r9b   { return R9B; }
r10b  { return R10B; }
r11b  { return R11B; }
r12b  { return R12B; }
r13b  { return R13B; }
r14b  { return R14B; }
r15b  { return R15B; }


    /* Other parameter types */
[0-9]+ {
    errno = 0;
    yylval.dval = strtoll(yytext, NULL, 10);
    //TODO errno handling
    return DECIMAL_NUMBER;
}
[ua][ua]* {
    yylval.label = strdup(yytext);
    CHECK_ALLOC(yylval.label);
    return MONKE_LABEL;
}
[_$\.a-zA-Z][[_$\.a-zA-Z0-9]* {
    yylval.label = strdup(yytext);
    CHECK_ALLOC(yylval.label);
    return FUNCTION_NAME;
}
%%
