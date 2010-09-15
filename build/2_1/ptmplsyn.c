/* Generated by Nimrod Compiler v0.8.9 */
/*   (c) 2010 Andreas Rumpf */

typedef long int NI;
typedef unsigned long int NU;
#include "nimbase.h"

typedef struct TY89009 TY89009;
typedef struct TY73013 TY73013;
typedef struct NimStringDesc NimStringDesc;
typedef struct TGenericSeq TGenericSeq;
typedef struct TY46532 TY46532;
typedef struct TY54525 TY54525;
typedef struct TNimObject TNimObject;
typedef struct TNimType TNimType;
typedef struct TNimNode TNimNode;
typedef struct TY54551 TY54551;
typedef struct TY54547 TY54547;
typedef struct TY53011 TY53011;
typedef struct TY54519 TY54519;
typedef struct TY53005 TY53005;
typedef struct TY54549 TY54549;
typedef struct TY54539 TY54539;
typedef struct TY51008 TY51008;
typedef struct TY54529 TY54529;
typedef struct TY54527 TY54527;
typedef struct TY54543 TY54543;
typedef struct TY42013 TY42013;
typedef NU8 TY21402[32];
struct TGenericSeq {
NI len;
NI space;
};
typedef NIM_CHAR TY239[100000001];
struct NimStringDesc {
  TGenericSeq Sup;
TY239 data;
};
struct TY46532 {
NI16 Line;
NI16 Col;
int Fileindex;
};
struct TY89009 {
TY73013* Inp;
NU8 State;
TY46532 Info;
NI Indent;
NI Par;
NimStringDesc* X;
TY73013* Outp;
NIM_CHAR Subschar;
NIM_CHAR Nimdirective;
NimStringDesc* Emit;
NimStringDesc* Conc;
NimStringDesc* Tostr;
};
struct TNimType {
NI size;
NU8 kind;
NU8 flags;
TNimType* base;
TNimNode* node;
void* finalizer;
};
struct TNimObject {
TNimType* m_type;
};
struct TY73013 {
  TNimObject Sup;
NU8 Kind;
FILE* F;
NimStringDesc* S;
NI Rd;
NI Wr;
};
struct TY54525 {
TY54551* Typ;
NimStringDesc* Comment;
TY46532 Info;
NU8 Flags;
NU8 Kind;
union {
struct {NI64 Intval;
} S1;
struct {NF64 Floatval;
} S2;
struct {NimStringDesc* Strval;
} S3;
struct {TY54547* Sym;
} S4;
struct {TY53011* Ident;
} S5;
struct {TY54519* Sons;
} S6;
} KindU;
};
struct TNimNode {
NU8 kind;
NI offset;
TNimType* typ;
NCSTRING name;
NI len;
TNimNode** sons;
};
struct TY53005 {
  TNimObject Sup;
NI Id;
};
struct TY54539 {
NU8 K;
NU8 S;
NU8 Flags;
TY54551* T;
TY51008* R;
NI A;
};
struct TY54551 {
  TY53005 Sup;
NU8 Kind;
TY54549* Sons;
TY54525* N;
NU8 Flags;
NU8 Callconv;
TY54547* Owner;
TY54547* Sym;
NI64 Size;
NI Align;
NI Containerid;
TY54539 Loc;
};
struct TY54529 {
TNimType* m_type;
NI Counter;
TY54527* Data;
};
struct TY54547 {
  TY53005 Sup;
NU8 Kind;
NU8 Magic;
TY54551* Typ;
TY53011* Name;
TY46532 Info;
TY54547* Owner;
NU32 Flags;
TY54529 Tab;
TY54525* Ast;
NU32 Options;
NI Position;
NI Offset;
TY54539 Loc;
TY54543* Annex;
};
struct TY53011 {
  TY53005 Sup;
NimStringDesc* S;
TY53011* Next;
NI H;
};
struct TY51008 {
  TNimObject Sup;
TY51008* Left;
TY51008* Right;
NI Length;
NimStringDesc* Data;
};
struct TY42013 {
  TNimObject Sup;
TY42013* Prev;
TY42013* Next;
};
struct TY54543 {
  TY42013 Sup;
NU8 Kind;
NIM_BOOL Generated;
TY51008* Name;
TY54525* Path;
};
struct TY54519 {
  TGenericSeq Sup;
  TY54525* data[SEQ_DECL_SIZE];
};
struct TY54549 {
  TGenericSeq Sup;
  TY54551* data[SEQ_DECL_SIZE];
};
struct TY54527 {
  TGenericSeq Sup;
  TY54547* data[SEQ_DECL_SIZE];
};
N_NIMCALL(void, Newline_89026)(TY89009* P_89029);
N_NIMCALL(void, Llstreamwrite_73054)(TY73013* S_73056, NimStringDesc* Data_73057);
N_NIMCALL(NimStringDesc*, nsuRepeatChar)(NI Count_24750, NIM_CHAR C_24751);
N_NIMCALL(void, Parseline_89033)(TY89009* P_89036);
N_NOINLINE(void, raiseIndexError)(void);
static N_INLINE(NI, addInt)(NI A_5603, NI B_5604);
N_NOINLINE(void, raiseOverflow)(void);
N_NIMCALL(NimStringDesc*, copyString)(NimStringDesc* Src_17308);
N_NIMCALL(NimStringDesc*, addChar)(NimStringDesc* S_1603, NIM_CHAR C_1604);
N_NIMCALL(NU8, Whichkeyword_70468)(NimStringDesc* Id_70470);
static N_INLINE(NI, subInt)(NI A_5803, NI B_5804);
static N_INLINE(NI, chckRange)(NI I_4410, NI A_4411, NI B_4412);
N_NOINLINE(void, raiseRangeError)(NI64 Val_5218);
N_NIMCALL(void, Limessage_46562)(TY46532 Info_46564, NU8 Msg_46565, NimStringDesc* Arg_46566);
N_NIMCALL(NimStringDesc*, copyStr)(NimStringDesc* S_1748, NI First_1749);
N_NIMCALL(NimStringDesc*, nsuToHex)(NI64 X_24450, NI Len_24451);
N_NIMCALL(void, Llstreamwrite_73058)(TY73013* S_73060, NIM_CHAR Data_73061);
N_NIMCALL(TY73013*, Filtertmpl_89001)(TY73013* Stdin_89003, NimStringDesc* Filename_89004, TY54525* Call_89005);
N_NIMCALL(TY46532, Newlineinfo_46574)(NimStringDesc* Filename_46576, NI Line_46577, NI Col_46578);
N_NIMCALL(TY73013*, Llstreamopen_73025)(NimStringDesc* Data_73027);
N_NIMCALL(NIM_CHAR, Chararg_88014)(TY54525* N_88016, NimStringDesc* Name_88017, NI Pos_88018, NIM_CHAR Default_88019);
N_NIMCALL(NimStringDesc*, Strarg_88020)(TY54525* N_88022, NimStringDesc* Name_88023, NI Pos_88024, NimStringDesc* Default_88025);
N_NIMCALL(NIM_BOOL, Llstreamatend_73071)(TY73013* S_73073);
N_NIMCALL(NimStringDesc*, Llstreamreadline_73048)(TY73013* S_73050);
N_NIMCALL(void, Llstreamclose_73040)(TY73013* S_73042);
NIM_CONST TY21402 Patternchars_89024 = {
0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0xFF, 0x03,
0xFE, 0xFF, 0xFF, 0x87, 0xFE, 0xFF, 0xFF, 0x07,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF}
;
STRING_LITERAL(TMP89032, "\012", 1);
STRING_LITERAL(TMP89346, "", 0);
STRING_LITERAL(TMP89347, "end", 3);
STRING_LITERAL(TMP89348, "#end", 4);
STRING_LITERAL(TMP89349, "\"", 1);
STRING_LITERAL(TMP89350, "(\"", 2);
STRING_LITERAL(TMP89351, "\\x", 2);
STRING_LITERAL(TMP89352, "\\\\", 2);
STRING_LITERAL(TMP89353, "\\\'", 2);
STRING_LITERAL(TMP89354, "\\\"", 2);
STRING_LITERAL(TMP89355, "}", 1);
STRING_LITERAL(TMP89356, "$", 1);
STRING_LITERAL(TMP89357, "\\n\"", 3);
STRING_LITERAL(TMP89368, "subschar", 8);
STRING_LITERAL(TMP89369, "metachar", 8);
STRING_LITERAL(TMP89370, "emit", 4);
STRING_LITERAL(TMP89371, "result.add", 10);
STRING_LITERAL(TMP89372, "conc", 4);
STRING_LITERAL(TMP89373, " & ", 3);
STRING_LITERAL(TMP89374, "tostring", 8);
N_NIMCALL(void, Newline_89026)(TY89009* P_89029) {
NimStringDesc* LOC1;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "newLine";
F.prev = framePtr;
F.filename = "rod/ptmplsyn.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
F.line = 38;F.filename = "ptmplsyn.nim";
LOC1 = 0;
LOC1 = nsuRepeatChar((*P_89029).Par, 41);
Llstreamwrite_73054((*P_89029).Outp, LOC1);
F.line = 39;F.filename = "ptmplsyn.nim";
(*P_89029).Par = 0;
F.line = 40;F.filename = "ptmplsyn.nim";
if (!(((NI16) 1) < (*P_89029).Info.Line)) goto LA3;
F.line = 40;F.filename = "ptmplsyn.nim";
Llstreamwrite_73054((*P_89029).Outp, ((NimStringDesc*) &TMP89032));
LA3: ;
framePtr = framePtr->prev;
}
static N_INLINE(NI, addInt)(NI A_5603, NI B_5604) {
NI Result_5605;
NIM_BOOL LOC2;
Result_5605 = 0;
Result_5605 = (NI32)((NU32)(A_5603) + (NU32)(B_5604));
LOC2 = (0 <= (NI32)(Result_5605 ^ A_5603));
if (LOC2) goto LA3;
LOC2 = (0 <= (NI32)(Result_5605 ^ B_5604));
LA3: ;
if (!LOC2) goto LA4;
goto BeforeRet;
LA4: ;
raiseOverflow();
BeforeRet: ;
return Result_5605;
}
static N_INLINE(NI, subInt)(NI A_5803, NI B_5804) {
NI Result_5805;
NIM_BOOL LOC2;
Result_5805 = 0;
Result_5805 = (NI32)((NU32)(A_5803) - (NU32)(B_5804));
LOC2 = (0 <= (NI32)(Result_5805 ^ A_5803));
if (LOC2) goto LA3;
LOC2 = (0 <= (NI32)(Result_5805 ^ (NI32)((NU32) ~(B_5804))));
LA3: ;
if (!LOC2) goto LA4;
goto BeforeRet;
LA4: ;
raiseOverflow();
BeforeRet: ;
return Result_5805;
}
static N_INLINE(NI, chckRange)(NI I_4410, NI A_4411, NI B_4412) {
NI Result_5316;
NIM_BOOL LOC2;
Result_5316 = 0;
LOC2 = (A_4411 <= I_4410);
if (!(LOC2)) goto LA3;
LOC2 = (I_4410 <= B_4412);
LA3: ;
if (!LOC2) goto LA4;
Result_5316 = I_4410;
goto BeforeRet;
goto LA1;
LA4: ;
raiseRangeError(((NI64) (I_4410)));
LA1: ;
BeforeRet: ;
return Result_5316;
}
N_NIMCALL(void, Parseline_89033)(TY89009* P_89036) {
NI D_89037;
NI J_89038;
NI Curly_89039;
NimStringDesc* Keyw_89040;
NIM_BOOL LOC3;
NU8 LOC11;
NimStringDesc* LOC15;
NimStringDesc* LOC16;
NimStringDesc* LOC17;
NimStringDesc* LOC18;
NimStringDesc* LOC19;
NimStringDesc* LOC20;
NimStringDesc* LOC21;
NimStringDesc* LOC22;
NimStringDesc* LOC23;
NimStringDesc* LOC25;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "parseLine";
F.prev = framePtr;
F.filename = "rod/ptmplsyn.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
D_89037 = 0;
J_89038 = 0;
Curly_89039 = 0;
Keyw_89040 = 0;
F.line = 46;F.filename = "ptmplsyn.nim";
J_89038 = 0;
F.line = 47;F.filename = "ptmplsyn.nim";
while (1) {
if ((NU)(J_89038) > (NU)((*P_89036).X->Sup.len)) raiseIndexError();
if (!((NU8)((*P_89036).X->data[J_89038]) == (NU8)(32))) goto LA1;
F.line = 47;F.filename = "ptmplsyn.nim";
J_89038 = addInt(J_89038, 1);
} LA1: ;
F.line = 48;F.filename = "ptmplsyn.nim";
if ((NU)(0) > (NU)((*P_89036).X->Sup.len)) raiseIndexError();
LOC3 = ((NU8)((*P_89036).X->data[0]) == (NU8)((*P_89036).Nimdirective));
if (!(LOC3)) goto LA4;
if ((NU)(1) > (NU)((*P_89036).X->Sup.len)) raiseIndexError();
LOC3 = ((NU8)((*P_89036).X->data[1]) == (NU8)(33));
LA4: ;
if (!LOC3) goto LA5;
F.line = 49;F.filename = "ptmplsyn.nim";
Newline_89026(P_89036);
goto LA2;
LA5: ;
if ((NU)(J_89038) > (NU)((*P_89036).X->Sup.len)) raiseIndexError();
if (!((NU8)((*P_89036).X->data[J_89038]) == (NU8)((*P_89036).Nimdirective))) goto LA7;
F.line = 51;F.filename = "ptmplsyn.nim";
Newline_89026(P_89036);
F.line = 52;F.filename = "ptmplsyn.nim";
J_89038 = addInt(J_89038, 1);
F.line = 53;F.filename = "ptmplsyn.nim";
while (1) {
if ((NU)(J_89038) > (NU)((*P_89036).X->Sup.len)) raiseIndexError();
if (!((NU8)((*P_89036).X->data[J_89038]) == (NU8)(32))) goto LA9;
F.line = 53;F.filename = "ptmplsyn.nim";
J_89038 = addInt(J_89038, 1);
} LA9: ;
F.line = 54;F.filename = "ptmplsyn.nim";
D_89037 = J_89038;
F.line = 55;F.filename = "ptmplsyn.nim";
Keyw_89040 = copyString(((NimStringDesc*) &TMP89346));
F.line = 56;F.filename = "ptmplsyn.nim";
while (1) {
if ((NU)(J_89038) > (NU)((*P_89036).X->Sup.len)) raiseIndexError();
if (!(((NU8)((*P_89036).X->data[J_89038])) >= ((NU8)(97)) && ((NU8)((*P_89036).X->data[J_89038])) <= ((NU8)(122)) || ((NU8)((*P_89036).X->data[J_89038])) >= ((NU8)(65)) && ((NU8)((*P_89036).X->data[J_89038])) <= ((NU8)(90)) || ((NU8)((*P_89036).X->data[J_89038])) >= ((NU8)(48)) && ((NU8)((*P_89036).X->data[J_89038])) <= ((NU8)(57)) || ((NU8)((*P_89036).X->data[J_89038])) >= ((NU8)(128)) && ((NU8)((*P_89036).X->data[J_89038])) <= ((NU8)(255)) || ((NU8)((*P_89036).X->data[J_89038])) == ((NU8)(46)) || ((NU8)((*P_89036).X->data[J_89038])) == ((NU8)(95)))) goto LA10;
F.line = 57;F.filename = "ptmplsyn.nim";
if ((NU)(J_89038) > (NU)((*P_89036).X->Sup.len)) raiseIndexError();
Keyw_89040 = addChar(Keyw_89040, (*P_89036).X->data[J_89038]);
F.line = 58;F.filename = "ptmplsyn.nim";
J_89038 = addInt(J_89038, 1);
} LA10: ;
F.line = 59;F.filename = "ptmplsyn.nim";
LOC11 = Whichkeyword_70468(Keyw_89040);
switch (LOC11) {
case ((NU8) 19):
F.line = 61;F.filename = "ptmplsyn.nim";
if (!(2 <= (*P_89036).Indent)) goto LA13;
F.line = 62;F.filename = "ptmplsyn.nim";
(*P_89036).Indent = subInt((*P_89036).Indent, 2);
goto LA12;
LA13: ;
F.line = 64;F.filename = "ptmplsyn.nim";
(*P_89036).Info.Col = ((NI16)chckRange(J_89038, ((NI16) -32768), ((NI16) 32767)));
F.line = 65;F.filename = "ptmplsyn.nim";
Limessage_46562((*P_89036).Info, ((NU8) 159), ((NimStringDesc*) &TMP89347));
LA12: ;
F.line = 66;F.filename = "ptmplsyn.nim";
LOC15 = 0;
LOC15 = nsuRepeatChar((*P_89036).Indent, 32);
Llstreamwrite_73054((*P_89036).Outp, LOC15);
F.line = 67;F.filename = "ptmplsyn.nim";
Llstreamwrite_73054((*P_89036).Outp, ((NimStringDesc*) &TMP89348));
break;
case ((NU8) 26):
case ((NU8) 58):
case ((NU8) 54):
case ((NU8) 59):
case ((NU8) 23):
case ((NU8) 7):
case ((NU8) 9):
case ((NU8) 46):
case ((NU8) 33):
case ((NU8) 13):
case ((NU8) 36):
case ((NU8) 53):
case ((NU8) 37):
F.line = 70;F.filename = "ptmplsyn.nim";
LOC16 = 0;
LOC16 = nsuRepeatChar((*P_89036).Indent, 32);
Llstreamwrite_73054((*P_89036).Outp, LOC16);
F.line = 71;F.filename = "ptmplsyn.nim";
LOC17 = 0;
LOC17 = copyStr((*P_89036).X, D_89037);
Llstreamwrite_73054((*P_89036).Outp, LOC17);
F.line = 72;F.filename = "ptmplsyn.nim";
(*P_89036).Indent = addInt((*P_89036).Indent, 2);
break;
case ((NU8) 17):
case ((NU8) 43):
case ((NU8) 18):
case ((NU8) 21):
case ((NU8) 22):
F.line = 74;F.filename = "ptmplsyn.nim";
LOC18 = 0;
LOC18 = nsuRepeatChar(subInt((*P_89036).Indent, 2), 32);
Llstreamwrite_73054((*P_89036).Outp, LOC18);
F.line = 75;F.filename = "ptmplsyn.nim";
LOC19 = 0;
LOC19 = copyStr((*P_89036).X, D_89037);
Llstreamwrite_73054((*P_89036).Outp, LOC19);
break;
default:
F.line = 77;F.filename = "ptmplsyn.nim";
LOC20 = 0;
LOC20 = nsuRepeatChar((*P_89036).Indent, 32);
Llstreamwrite_73054((*P_89036).Outp, LOC20);
F.line = 78;F.filename = "ptmplsyn.nim";
LOC21 = 0;
LOC21 = copyStr((*P_89036).X, D_89037);
Llstreamwrite_73054((*P_89036).Outp, LOC21);
break;
}
F.line = 79;F.filename = "ptmplsyn.nim";
(*P_89036).State = ((NU8) 0);
goto LA2;
LA7: ;
F.line = 82;F.filename = "ptmplsyn.nim";
J_89038 = 0;
F.line = 83;F.filename = "ptmplsyn.nim";
switch ((*P_89036).State) {
case ((NU8) 1):
F.line = 86;F.filename = "ptmplsyn.nim";
Llstreamwrite_73054((*P_89036).Outp, (*P_89036).Conc);
F.line = 87;F.filename = "ptmplsyn.nim";
Llstreamwrite_73054((*P_89036).Outp, ((NimStringDesc*) &TMP89032));
F.line = 88;F.filename = "ptmplsyn.nim";
LOC22 = 0;
LOC22 = nsuRepeatChar(addInt((*P_89036).Indent, 2), 32);
Llstreamwrite_73054((*P_89036).Outp, LOC22);
F.line = 89;F.filename = "ptmplsyn.nim";
Llstreamwrite_73054((*P_89036).Outp, ((NimStringDesc*) &TMP89349));
break;
case ((NU8) 0):
F.line = 91;F.filename = "ptmplsyn.nim";
Newline_89026(P_89036);
F.line = 92;F.filename = "ptmplsyn.nim";
LOC23 = 0;
LOC23 = nsuRepeatChar((*P_89036).Indent, 32);
Llstreamwrite_73054((*P_89036).Outp, LOC23);
F.line = 93;F.filename = "ptmplsyn.nim";
Llstreamwrite_73054((*P_89036).Outp, (*P_89036).Emit);
F.line = 94;F.filename = "ptmplsyn.nim";
Llstreamwrite_73054((*P_89036).Outp, ((NimStringDesc*) &TMP89350));
F.line = 95;F.filename = "ptmplsyn.nim";
(*P_89036).Par = addInt((*P_89036).Par, 1);
break;
}
F.line = 96;F.filename = "ptmplsyn.nim";
(*P_89036).State = ((NU8) 1);
F.line = 97;F.filename = "ptmplsyn.nim";
while (1) {
F.line = 98;F.filename = "ptmplsyn.nim";
if ((NU)(J_89038) > (NU)((*P_89036).X->Sup.len)) raiseIndexError();
switch (((NU8)((*P_89036).X->data[J_89038]))) {
case 0:
F.line = 100;F.filename = "ptmplsyn.nim";
goto LA24;
break;
case 1 ... 31:
case 128 ... 255:
F.line = 102;F.filename = "ptmplsyn.nim";
Llstreamwrite_73054((*P_89036).Outp, ((NimStringDesc*) &TMP89351));
F.line = 103;F.filename = "ptmplsyn.nim";
if ((NU)(J_89038) > (NU)((*P_89036).X->Sup.len)) raiseIndexError();
LOC25 = 0;
LOC25 = nsuToHex(((NI64) (((NU8)((*P_89036).X->data[J_89038])))), 2);
Llstreamwrite_73054((*P_89036).Outp, LOC25);
F.line = 104;F.filename = "ptmplsyn.nim";
J_89038 = addInt(J_89038, 1);
break;
case 92:
F.line = 106;F.filename = "ptmplsyn.nim";
Llstreamwrite_73054((*P_89036).Outp, ((NimStringDesc*) &TMP89352));
F.line = 107;F.filename = "ptmplsyn.nim";
J_89038 = addInt(J_89038, 1);
break;
case 39:
F.line = 109;F.filename = "ptmplsyn.nim";
Llstreamwrite_73054((*P_89036).Outp, ((NimStringDesc*) &TMP89353));
F.line = 110;F.filename = "ptmplsyn.nim";
J_89038 = addInt(J_89038, 1);
break;
case 34:
F.line = 112;F.filename = "ptmplsyn.nim";
Llstreamwrite_73054((*P_89036).Outp, ((NimStringDesc*) &TMP89354));
F.line = 113;F.filename = "ptmplsyn.nim";
J_89038 = addInt(J_89038, 1);
break;
default:
F.line = 115;F.filename = "ptmplsyn.nim";
if ((NU)(J_89038) > (NU)((*P_89036).X->Sup.len)) raiseIndexError();
if (!((NU8)((*P_89036).X->data[J_89038]) == (NU8)((*P_89036).Subschar))) goto LA27;
F.line = 117;F.filename = "ptmplsyn.nim";
J_89038 = addInt(J_89038, 1);
F.line = 118;F.filename = "ptmplsyn.nim";
if ((NU)(J_89038) > (NU)((*P_89036).X->Sup.len)) raiseIndexError();
switch (((NU8)((*P_89036).X->data[J_89038]))) {
case 123:
F.line = 120;F.filename = "ptmplsyn.nim";
(*P_89036).Info.Col = ((NI16)chckRange(J_89038, ((NI16) -32768), ((NI16) 32767)));
F.line = 121;F.filename = "ptmplsyn.nim";
Llstreamwrite_73058((*P_89036).Outp, 34);
F.line = 122;F.filename = "ptmplsyn.nim";
Llstreamwrite_73054((*P_89036).Outp, (*P_89036).Conc);
F.line = 123;F.filename = "ptmplsyn.nim";
Llstreamwrite_73054((*P_89036).Outp, (*P_89036).Tostr);
F.line = 124;F.filename = "ptmplsyn.nim";
Llstreamwrite_73058((*P_89036).Outp, 40);
F.line = 125;F.filename = "ptmplsyn.nim";
J_89038 = addInt(J_89038, 1);
F.line = 126;F.filename = "ptmplsyn.nim";
Curly_89039 = 0;
F.line = 127;F.filename = "ptmplsyn.nim";
while (1) {
F.line = 128;F.filename = "ptmplsyn.nim";
if ((NU)(J_89038) > (NU)((*P_89036).X->Sup.len)) raiseIndexError();
switch (((NU8)((*P_89036).X->data[J_89038]))) {
case 0:
F.line = 130;F.filename = "ptmplsyn.nim";
Limessage_46562((*P_89036).Info, ((NU8) 182), ((NimStringDesc*) &TMP89355));
break;
case 123:
F.line = 132;F.filename = "ptmplsyn.nim";
J_89038 = addInt(J_89038, 1);
F.line = 133;F.filename = "ptmplsyn.nim";
Curly_89039 = addInt(Curly_89039, 1);
F.line = 134;F.filename = "ptmplsyn.nim";
Llstreamwrite_73058((*P_89036).Outp, 123);
break;
case 125:
F.line = 136;F.filename = "ptmplsyn.nim";
J_89038 = addInt(J_89038, 1);
F.line = 137;F.filename = "ptmplsyn.nim";
if (!(Curly_89039 == 0)) goto LA31;
F.line = 137;F.filename = "ptmplsyn.nim";
goto LA29;
LA31: ;
F.line = 138;F.filename = "ptmplsyn.nim";
if (!(0 < Curly_89039)) goto LA34;
F.line = 138;F.filename = "ptmplsyn.nim";
Curly_89039 = subInt(Curly_89039, 1);
LA34: ;
F.line = 139;F.filename = "ptmplsyn.nim";
Llstreamwrite_73058((*P_89036).Outp, 125);
break;
default:
F.line = 141;F.filename = "ptmplsyn.nim";
if ((NU)(J_89038) > (NU)((*P_89036).X->Sup.len)) raiseIndexError();
Llstreamwrite_73058((*P_89036).Outp, (*P_89036).X->data[J_89038]);
F.line = 142;F.filename = "ptmplsyn.nim";
J_89038 = addInt(J_89038, 1);
break;
}
} LA29: ;
F.line = 143;F.filename = "ptmplsyn.nim";
Llstreamwrite_73058((*P_89036).Outp, 41);
F.line = 144;F.filename = "ptmplsyn.nim";
Llstreamwrite_73054((*P_89036).Outp, (*P_89036).Conc);
F.line = 145;F.filename = "ptmplsyn.nim";
Llstreamwrite_73058((*P_89036).Outp, 34);
break;
case 97 ... 122:
case 65 ... 90:
case 128 ... 255:
F.line = 147;F.filename = "ptmplsyn.nim";
Llstreamwrite_73058((*P_89036).Outp, 34);
F.line = 148;F.filename = "ptmplsyn.nim";
Llstreamwrite_73054((*P_89036).Outp, (*P_89036).Conc);
F.line = 149;F.filename = "ptmplsyn.nim";
Llstreamwrite_73054((*P_89036).Outp, (*P_89036).Tostr);
F.line = 150;F.filename = "ptmplsyn.nim";
Llstreamwrite_73058((*P_89036).Outp, 40);
F.line = 151;F.filename = "ptmplsyn.nim";
while (1) {
if ((NU)(J_89038) > (NU)((*P_89036).X->Sup.len)) raiseIndexError();
if (!(((NU8)((*P_89036).X->data[J_89038])) >= ((NU8)(97)) && ((NU8)((*P_89036).X->data[J_89038])) <= ((NU8)(122)) || ((NU8)((*P_89036).X->data[J_89038])) >= ((NU8)(65)) && ((NU8)((*P_89036).X->data[J_89038])) <= ((NU8)(90)) || ((NU8)((*P_89036).X->data[J_89038])) >= ((NU8)(48)) && ((NU8)((*P_89036).X->data[J_89038])) <= ((NU8)(57)) || ((NU8)((*P_89036).X->data[J_89038])) >= ((NU8)(128)) && ((NU8)((*P_89036).X->data[J_89038])) <= ((NU8)(255)) || ((NU8)((*P_89036).X->data[J_89038])) == ((NU8)(46)) || ((NU8)((*P_89036).X->data[J_89038])) == ((NU8)(95)))) goto LA36;
F.line = 152;F.filename = "ptmplsyn.nim";
if ((NU)(J_89038) > (NU)((*P_89036).X->Sup.len)) raiseIndexError();
Llstreamwrite_73058((*P_89036).Outp, (*P_89036).X->data[J_89038]);
F.line = 153;F.filename = "ptmplsyn.nim";
J_89038 = addInt(J_89038, 1);
} LA36: ;
F.line = 154;F.filename = "ptmplsyn.nim";
Llstreamwrite_73058((*P_89036).Outp, 41);
F.line = 155;F.filename = "ptmplsyn.nim";
Llstreamwrite_73054((*P_89036).Outp, (*P_89036).Conc);
F.line = 156;F.filename = "ptmplsyn.nim";
Llstreamwrite_73058((*P_89036).Outp, 34);
break;
default:
F.line = 158;F.filename = "ptmplsyn.nim";
if ((NU)(J_89038) > (NU)((*P_89036).X->Sup.len)) raiseIndexError();
if (!((NU8)((*P_89036).X->data[J_89038]) == (NU8)((*P_89036).Subschar))) goto LA38;
F.line = 159;F.filename = "ptmplsyn.nim";
Llstreamwrite_73058((*P_89036).Outp, (*P_89036).Subschar);
F.line = 160;F.filename = "ptmplsyn.nim";
J_89038 = addInt(J_89038, 1);
goto LA37;
LA38: ;
F.line = 162;F.filename = "ptmplsyn.nim";
(*P_89036).Info.Col = ((NI16)chckRange(J_89038, ((NI16) -32768), ((NI16) 32767)));
F.line = 163;F.filename = "ptmplsyn.nim";
Limessage_46562((*P_89036).Info, ((NU8) 164), ((NimStringDesc*) &TMP89356));
LA37: ;
break;
}
goto LA26;
LA27: ;
F.line = 165;F.filename = "ptmplsyn.nim";
if ((NU)(J_89038) > (NU)((*P_89036).X->Sup.len)) raiseIndexError();
Llstreamwrite_73058((*P_89036).Outp, (*P_89036).X->data[J_89038]);
F.line = 166;F.filename = "ptmplsyn.nim";
J_89038 = addInt(J_89038, 1);
LA26: ;
break;
}
} LA24: ;
F.line = 167;F.filename = "ptmplsyn.nim";
Llstreamwrite_73054((*P_89036).Outp, ((NimStringDesc*) &TMP89357));
LA2: ;
framePtr = framePtr->prev;
}
N_NIMCALL(TY73013*, Filtertmpl_89001)(TY73013* Stdin_89003, NimStringDesc* Filename_89004, TY54525* Call_89005) {
TY73013* Result_89363;
TY89009 P_89364;
NIM_BOOL LOC2;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "filterTmpl";
F.prev = framePtr;
F.filename = "rod/ptmplsyn.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
Result_89363 = 0;
memset((void*)&P_89364, 0, sizeof(P_89364));
F.line = 171;F.filename = "ptmplsyn.nim";
P_89364.Info = Newlineinfo_46574(Filename_89004, 0, 0);
F.line = 172;F.filename = "ptmplsyn.nim";
P_89364.Outp = Llstreamopen_73025(((NimStringDesc*) &TMP89346));
F.line = 173;F.filename = "ptmplsyn.nim";
P_89364.Inp = Stdin_89003;
F.line = 174;F.filename = "ptmplsyn.nim";
P_89364.Subschar = Chararg_88014(Call_89005, ((NimStringDesc*) &TMP89368), 1, 36);
F.line = 175;F.filename = "ptmplsyn.nim";
P_89364.Nimdirective = Chararg_88014(Call_89005, ((NimStringDesc*) &TMP89369), 2, 35);
F.line = 176;F.filename = "ptmplsyn.nim";
P_89364.Emit = Strarg_88020(Call_89005, ((NimStringDesc*) &TMP89370), 3, ((NimStringDesc*) &TMP89371));
F.line = 177;F.filename = "ptmplsyn.nim";
P_89364.Conc = Strarg_88020(Call_89005, ((NimStringDesc*) &TMP89372), 4, ((NimStringDesc*) &TMP89373));
F.line = 178;F.filename = "ptmplsyn.nim";
P_89364.Tostr = Strarg_88020(Call_89005, ((NimStringDesc*) &TMP89374), 5, ((NimStringDesc*) &TMP89356));
F.line = 179;F.filename = "ptmplsyn.nim";
while (1) {
LOC2 = Llstreamatend_73071(P_89364.Inp);
if (!!(LOC2)) goto LA1;
F.line = 180;F.filename = "ptmplsyn.nim";
P_89364.X = Llstreamreadline_73048(P_89364.Inp);
F.line = 181;F.filename = "ptmplsyn.nim";
P_89364.Info.Line = ((NI)(P_89364.Info.Line) + (NI)(((NI16) 1)));
if (P_89364.Info.Line < -32768 || P_89364.Info.Line > 32767) raiseOverflow();
F.line = 182;F.filename = "ptmplsyn.nim";
Parseline_89033(&P_89364);
} LA1: ;
F.line = 183;F.filename = "ptmplsyn.nim";
Newline_89026(&P_89364);
F.line = 184;F.filename = "ptmplsyn.nim";
Result_89363 = P_89364.Outp;
F.line = 185;F.filename = "ptmplsyn.nim";
Llstreamclose_73040(P_89364.Inp);
framePtr = framePtr->prev;
return Result_89363;
}
N_NOINLINE(void, ptmplsynInit)(void) {
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "ptmplsyn";
F.prev = framePtr;
F.filename = "rod/ptmplsyn.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
framePtr = framePtr->prev;
}
