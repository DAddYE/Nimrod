/* Generated by Nimrod Compiler v0.8.9 */
/*   (c) 2010 Andreas Rumpf */

typedef long long int NI;
typedef unsigned long long int NU;
#include "nimbase.h"

typedef struct NimStringDesc NimStringDesc;
typedef struct TGenericSeq TGenericSeq;
typedef struct TY54547 TY54547;
typedef struct TY53005 TY53005;
typedef struct TNimObject TNimObject;
typedef struct TNimType TNimType;
typedef struct TNimNode TNimNode;
typedef struct TY54551 TY54551;
typedef struct TY53011 TY53011;
typedef struct TY46532 TY46532;
typedef struct TY54529 TY54529;
typedef struct TY54527 TY54527;
typedef struct TY54525 TY54525;
typedef struct TY54539 TY54539;
typedef struct TY51008 TY51008;
typedef struct TY54543 TY54543;
typedef struct TY58107 TY58107;
typedef struct TY58079 TY58079;
typedef struct TY58109 TY58109;
typedef struct TY105012 TY105012;
typedef struct TY103002 TY103002;
typedef struct TY105006 TY105006;
typedef struct TY54900 TY54900;
typedef struct TY54896 TY54896;
typedef struct TY54898 TY54898;
typedef struct TY42019 TY42019;
typedef struct TY42013 TY42013;
typedef struct TY54519 TY54519;
typedef struct TY106004 TY106004;
typedef struct TY58092 TY58092;
typedef struct TY54549 TY54549;
struct TGenericSeq {
NI len;
NI space;
};
typedef NIM_CHAR TY239[100000001];
struct NimStringDesc {
  TGenericSeq Sup;
TY239 data;
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
struct TY53005 {
  TNimObject Sup;
NI Id;
};
struct TY46532 {
NI16 Line;
NI16 Col;
int Fileindex;
};
struct TY54529 {
TNimType* m_type;
NI Counter;
TY54527* Data;
};
struct TY54539 {
NU8 K;
NU8 S;
NU8 Flags;
TY54551* T;
TY51008* R;
NI A;
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
struct TY58079 {
NI H;
};
struct TY58107 {
NI Tos;
TY58109* Stack;
};
struct TY103002 {
  TNimObject Sup;
};
struct TY54900 {
NI Counter;
NI Max;
TY54896* Head;
TY54898* Data;
};
struct TY42019 {
TNimType* m_type;
TY42013* Head;
TY42013* Tail;
NI Counter;
};
typedef N_NIMCALL_PTR(TY54525*, TY105032) (TY105012* C_105033, TY54525* N_105034);
typedef N_NIMCALL_PTR(TY54525*, TY105037) (TY105012* C_105038, TY54525* N_105039);
struct TY105012 {
  TY103002 Sup;
TY54547* Module;
TY105006* P;
NI Instcounter;
TY54525* Generics;
NI Lastgenericidx;
TY58107 Tab;
TY54900 Ambiguoussymbols;
TY54527* Converters;
TY42019 Optionstack;
TY42019 Libs;
NIM_BOOL Fromcache;
TY105032 Semconstexpr;
TY105037 Semexpr;
TY54900 Includedfiles;
NimStringDesc* Filename;
TY54529 Userpragmas;
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
typedef NU8 TY54999[16];
struct TY58092 {
NI H;
TY53011* Name;
};
struct TY106004 {
NI Stackptr;
TY58092 It;
TY54547* M;
NU8 Mode;
};
struct TNimNode {
NU8 kind;
NI offset;
TNimType* typ;
NCSTRING name;
NI len;
TNimNode** sons;
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
struct TY105006 {
TY54547* Owner;
TY54547* Resultsym;
NI Nestedloopcounter;
NI Nestedblockcounter;
};
typedef NI TY8614[8];
struct TY54896 {
TY54896* Next;
NI Key;
TY8614 Bits;
};
struct TY54527 {
  TGenericSeq Sup;
  TY54547* data[SEQ_DECL_SIZE];
};
struct TY58109 {
  TGenericSeq Sup;
  TY54529 data[SEQ_DECL_SIZE];
};
struct TY54898 {
  TGenericSeq Sup;
  TY54896* data[SEQ_DECL_SIZE];
};
struct TY54519 {
  TGenericSeq Sup;
  TY54525* data[SEQ_DECL_SIZE];
};
struct TY54549 {
  TGenericSeq Sup;
  TY54551* data[SEQ_DECL_SIZE];
};
N_NIMCALL(NimStringDesc*, Getsymrepr_106014)(TY54547* S_106016);
N_NIMCALL(NimStringDesc*, Getprocheader_95018)(TY54547* Sym_95020);
N_NIMCALL(NimStringDesc*, copyString)(NimStringDesc* Src_17308);
N_NIMCALL(void, Closescope_106017)(TY58107* Tab_106020);
N_NIMCALL(void, Internalerror_46571)(NimStringDesc* Errmsg_46573);
N_NIMCALL(TY54547*, Inittabiter_58081)(TY58079* Ti_58084, TY54529* Tab_58085);
static N_INLINE(NI, subInt)(NI A_5803, NI B_5804);
N_NOINLINE(void, raiseOverflow)(void);
N_NOINLINE(void, raiseIndexError)(void);
N_NIMCALL(void, Limessage_46562)(TY46532 Info_46564, NU8 Msg_46565, NimStringDesc* Arg_46566);
N_NIMCALL(TY54547*, Nextiter_58086)(TY58079* Ti_58089, TY54529* Tab_58090);
N_NIMCALL(void, Rawclosescope_58153)(TY58107* Tab_58156);
N_NIMCALL(void, Addsym_106021)(TY54529* T_106024, TY54547* N_106025);
N_NIMCALL(NIM_BOOL, Strtableincl_58073)(TY54529* T_58076, TY54547* N_58077);
N_NIMCALL(void, Adddecl_106026)(TY105012* C_106028, TY54547* Sym_106029);
N_NIMCALL(NU8, Symtabaddunique_58138)(TY58107* Tab_58141, TY54547* E_58142);
N_NIMCALL(void, Adddeclat_106030)(TY105012* C_106032, TY54547* Sym_106033, NI At_106034);
N_NIMCALL(NU8, Symtabadduniqueat_58143)(TY58107* Tab_58146, TY54547* E_58147, NI At_58148);
N_NIMCALL(void, Addinterfacedeclaux_106199)(TY105012* C_106201, TY54547* Sym_106202);
N_NIMCALL(void, Internalerror_46567)(TY46532 Info_46569, NimStringDesc* Errmsg_46570);
N_NIMCALL(void, Strtableadd_58064)(TY54529* T_58067, TY54547* N_58068);
N_NIMCALL(TY54547*, Getcurrowner_105107)(void);
N_NIMCALL(void, Addinterfacedeclat_106248)(TY105012* C_106250, TY54547* Sym_106251, NI At_106252);
N_NIMCALL(void, Addoverloadablesymat_106035)(TY105012* C_106037, TY54547* Fn_106038, NI At_106039);
N_NIMCALL(TY54547*, Strtableget_58069)(TY54529* T_58071, TY53011* Name_58072);
N_NIMCALL(void, Symtabaddat_58132)(TY58107* Tab_58135, TY54547* E_58136, NI At_58137);
N_NIMCALL(void, Addinterfacedecl_106040)(TY105012* C_106042, TY54547* Sym_106043);
N_NIMCALL(void, Addinterfaceoverloadablesymat_106044)(TY105012* C_106046, TY54547* Sym_106047, NI At_106048);
N_NIMCALL(TY54547*, Lookup_106049)(TY105012* C_106051, TY54525* N_106052);
N_NOINLINE(void, raiseFieldError)(NimStringDesc* F_5275);
N_NIMCALL(TY54547*, Symtabget_58119)(TY58107 Tab_58121, TY53011* S_58122);
N_NIMCALL(NIM_BOOL, Intsetcontains_54910)(TY54900* S_54912, NI Key_54913);
N_NIMCALL(void, Loadstub_91070)(TY54547* S_91072);
N_NIMCALL(TY54547*, Qualifiedlookup_106053)(TY105012* C_106055, TY54525* N_106056, NIM_BOOL Ambiguouscheck_106057);
N_NIMCALL(NimStringDesc*, Rendertree_83042)(TY54525* N_83044, NU8 Renderflags_83047);
N_NIMCALL(TY54547*, Initoverloaditer_106058)(TY106004* O_106061, TY105012* C_106062, TY54525* N_106063);
N_NIMCALL(TY54547*, Initidentiter_58095)(TY58092* Ti_58098, TY54529* Tab_58099, TY53011* S_58100);
N_NIMCALL(void, unsureAsgnRef)(void** Dest_11826, void* Src_11827);
N_NIMCALL(TY54547*, Nextoverloaditer_106064)(TY106004* O_106067, TY105012* C_106068, TY54525* N_106069);
N_NIMCALL(TY54547*, Nextidentiter_58101)(TY58092* Ti_58104, TY54529* Tab_58105);
N_NIMCALL(NI, Sonslen_54803)(TY54525* N_54805);
static N_INLINE(NI, addInt)(NI A_5603, NI B_5604);
STRING_LITERAL(TMP106164, "CloseScope", 10);
STRING_LITERAL(TMP106247, "AddInterfaceDeclAux", 19);
STRING_LITERAL(TMP106293, "addOverloadableSymAt", 20);
static NIM_CONST TY54999 TMP106376 = {
0xEC, 0xFF, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}
;STRING_LITERAL(TMP106377, "sons", 4);
static NIM_CONST TY54999 TMP106378 = {
0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}
;STRING_LITERAL(TMP106379, "sym", 3);
static NIM_CONST TY54999 TMP106380 = {
0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}
;STRING_LITERAL(TMP106381, "ident", 5);
STRING_LITERAL(TMP106382, "lookUp", 6);
N_NIMCALL(NimStringDesc*, Getsymrepr_106014)(TY54547* S_106016) {
NimStringDesc* Result_106073;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "getSymRepr";
F.prev = framePtr;
F.filename = "rod/lookups.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
Result_106073 = 0;
F.line = 41;F.filename = "lookups.nim";
switch ((*S_106016).Kind) {
case ((NU8) 9):
case ((NU8) 10):
case ((NU8) 12):
case ((NU8) 11):
F.line = 42;F.filename = "lookups.nim";
Result_106073 = Getprocheader_95018(S_106016);
break;
default:
F.line = 43;F.filename = "lookups.nim";
Result_106073 = copyString((*(*S_106016).Name).S);
break;
}
framePtr = framePtr->prev;
return Result_106073;
}
static N_INLINE(NI, subInt)(NI A_5803, NI B_5804) {
NI Result_5805;
NIM_BOOL LOC2;
Result_5805 = 0;
Result_5805 = (NI64)((NU64)(A_5803) - (NU64)(B_5804));
LOC2 = (0 <= (NI64)(Result_5805 ^ A_5803));
if (LOC2) goto LA3;
LOC2 = (0 <= (NI64)(Result_5805 ^ (NI64)((NU64) ~(B_5804))));
LA3: ;
if (!LOC2) goto LA4;
goto BeforeRet;
LA4: ;
raiseOverflow();
BeforeRet: ;
return Result_5805;
}
N_NIMCALL(void, Closescope_106017)(TY58107* Tab_106020) {
TY58079 It_106078;
TY54547* S_106079;
NimStringDesc* LOC8;
NIM_BOOL LOC9;
NimStringDesc* LOC16;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "CloseScope";
F.prev = framePtr;
F.filename = "rod/lookups.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
memset((void*)&It_106078, 0, sizeof(It_106078));
S_106079 = 0;
F.line = 50;F.filename = "lookups.nim";
if (!((*Tab_106020).Stack->Sup.len < ((NI) ((*Tab_106020).Tos)))) goto LA2;
F.line = 50;F.filename = "lookups.nim";
Internalerror_46571(((NimStringDesc*) &TMP106164));
LA2: ;
F.line = 51;F.filename = "lookups.nim";
if ((NU)(subInt(((NI) ((*Tab_106020).Tos)), 1)) >= (NU)((*Tab_106020).Stack->Sup.len)) raiseIndexError();
S_106079 = Inittabiter_58081(&It_106078, &(*Tab_106020).Stack->data[subInt(((NI) ((*Tab_106020).Tos)), 1)]);
F.line = 52;F.filename = "lookups.nim";
while (1) {
if (!!((S_106079 == NIM_NIL))) goto LA4;
F.line = 53;F.filename = "lookups.nim";
if (!(((*S_106079).Flags &(1<<((((NU8) 6))&31)))!=0)) goto LA6;
F.line = 54;F.filename = "lookups.nim";
LOC8 = 0;
LOC8 = Getsymrepr_106014(S_106079);
Limessage_46562((*S_106079).Info, ((NU8) 135), LOC8);
goto LA5;
LA6: ;
LOC9 = ((9 & (*S_106079).Flags) == 0);
if (!(LOC9)) goto LA10;
LOC9 = (((*S_106079).Options &(1<<((((NU8) 12))&31)))!=0);
LA10: ;
if (!LOC9) goto LA11;
F.line = 57;F.filename = "lookups.nim";
if (!!(((132105 &(1<<(((*S_106079).Kind)&31)))!=0))) goto LA14;
F.line = 58;F.filename = "lookups.nim";
LOC16 = 0;
LOC16 = Getsymrepr_106014(S_106079);
Limessage_46562((*S_106079).Info, ((NU8) 225), LOC16);
LA14: ;
goto LA5;
LA11: ;
LA5: ;
F.line = 59;F.filename = "lookups.nim";
if ((NU)(subInt(((NI) ((*Tab_106020).Tos)), 1)) >= (NU)((*Tab_106020).Stack->Sup.len)) raiseIndexError();
S_106079 = Nextiter_58086(&It_106078, &(*Tab_106020).Stack->data[subInt(((NI) ((*Tab_106020).Tos)), 1)]);
} LA4: ;
F.line = 60;F.filename = "lookups.nim";
Rawclosescope_58153(Tab_106020);
framePtr = framePtr->prev;
}
N_NIMCALL(void, Addsym_106021)(TY54529* T_106024, TY54547* N_106025) {
NIM_BOOL LOC2;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "AddSym";
F.prev = framePtr;
F.filename = "rod/lookups.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
F.line = 63;F.filename = "lookups.nim";
LOC2 = Strtableincl_58073(T_106024, N_106025);
if (!LOC2) goto LA3;
F.line = 63;F.filename = "lookups.nim";
Limessage_46562((*N_106025).Info, ((NU8) 37), (*(*N_106025).Name).S);
LA3: ;
framePtr = framePtr->prev;
}
N_NIMCALL(void, Adddecl_106026)(TY105012* C_106028, TY54547* Sym_106029) {
NU8 LOC2;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "addDecl";
F.prev = framePtr;
F.filename = "rod/lookups.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
F.line = 66;F.filename = "lookups.nim";
LOC2 = Symtabaddunique_58138(&(*C_106028).Tab, Sym_106029);
if (!(LOC2 == ((NU8) 0))) goto LA3;
F.line = 67;F.filename = "lookups.nim";
Limessage_46562((*Sym_106029).Info, ((NU8) 37), (*(*Sym_106029).Name).S);
LA3: ;
framePtr = framePtr->prev;
}
N_NIMCALL(void, Adddeclat_106030)(TY105012* C_106032, TY54547* Sym_106033, NI At_106034) {
NU8 LOC2;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "addDeclAt";
F.prev = framePtr;
F.filename = "rod/lookups.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
F.line = 70;F.filename = "lookups.nim";
LOC2 = Symtabadduniqueat_58143(&(*C_106032).Tab, Sym_106033, At_106034);
if (!(LOC2 == ((NU8) 0))) goto LA3;
F.line = 71;F.filename = "lookups.nim";
Limessage_46562((*Sym_106033).Info, ((NU8) 37), (*(*Sym_106033).Name).S);
LA3: ;
framePtr = framePtr->prev;
}
N_NIMCALL(void, Addinterfacedeclaux_106199)(TY105012* C_106201, TY54547* Sym_106202) {
TY54547* LOC8;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "AddInterfaceDeclAux";
F.prev = framePtr;
F.filename = "rod/lookups.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
F.line = 74;F.filename = "lookups.nim";
if (!(((*Sym_106202).Flags &(1<<((((NU8) 3))&31)))!=0)) goto LA2;
F.line = 76;F.filename = "lookups.nim";
if (!((*C_106201).Module == NIM_NIL)) goto LA5;
F.line = 76;F.filename = "lookups.nim";
Internalerror_46567((*Sym_106202).Info, ((NimStringDesc*) &TMP106247));
LA5: ;
F.line = 77;F.filename = "lookups.nim";
Strtableadd_58064(&(*(*C_106201).Module).Tab, Sym_106202);
LA2: ;
F.line = 78;F.filename = "lookups.nim";
LOC8 = 0;
LOC8 = Getcurrowner_105107();
if (!((*LOC8).Kind == ((NU8) 18))) goto LA9;
F.line = 78;F.filename = "lookups.nim";
(*Sym_106202).Flags |=(1<<((NI32)(((NU8) 5))%(sizeof(NI32)*8)));
LA9: ;
framePtr = framePtr->prev;
}
N_NIMCALL(void, Addinterfacedeclat_106248)(TY105012* C_106250, TY54547* Sym_106251, NI At_106252) {
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "addInterfaceDeclAt";
F.prev = framePtr;
F.filename = "rod/lookups.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
F.line = 81;F.filename = "lookups.nim";
Adddeclat_106030(C_106250, Sym_106251, At_106252);
F.line = 82;F.filename = "lookups.nim";
Addinterfacedeclaux_106199(C_106250, Sym_106251);
framePtr = framePtr->prev;
}
N_NIMCALL(void, Addoverloadablesymat_106035)(TY105012* C_106037, TY54547* Fn_106038, NI At_106039) {
TY54547* Check_106269;
NIM_BOOL LOC5;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "addOverloadableSymAt";
F.prev = framePtr;
F.filename = "rod/lookups.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
F.line = 85;F.filename = "lookups.nim";
if (!!(((269824 &(1<<(((*Fn_106038).Kind)&31)))!=0))) goto LA2;
F.line = 86;F.filename = "lookups.nim";
Internalerror_46567((*Fn_106038).Info, ((NimStringDesc*) &TMP106293));
LA2: ;
Check_106269 = 0;
F.line = 87;F.filename = "lookups.nim";
if ((NU)(At_106039) >= (NU)((*C_106037).Tab.Stack->Sup.len)) raiseIndexError();
Check_106269 = Strtableget_58069(&(*C_106037).Tab.Stack->data[At_106039], (*Fn_106038).Name);
F.line = 88;F.filename = "lookups.nim";
LOC5 = !((Check_106269 == NIM_NIL));
if (!(LOC5)) goto LA6;
LOC5 = !(((269824 &(1<<(((*Check_106269).Kind)&31)))!=0));
LA6: ;
if (!LOC5) goto LA7;
F.line = 89;F.filename = "lookups.nim";
Limessage_46562((*Fn_106038).Info, ((NU8) 37), (*(*Fn_106038).Name).S);
LA7: ;
F.line = 90;F.filename = "lookups.nim";
Symtabaddat_58132(&(*C_106037).Tab, Fn_106038, At_106039);
framePtr = framePtr->prev;
}
N_NIMCALL(void, Addinterfacedecl_106040)(TY105012* C_106042, TY54547* Sym_106043) {
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "addInterfaceDecl";
F.prev = framePtr;
F.filename = "rod/lookups.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
F.line = 94;F.filename = "lookups.nim";
Adddecl_106026(C_106042, Sym_106043);
F.line = 95;F.filename = "lookups.nim";
Addinterfacedeclaux_106199(C_106042, Sym_106043);
framePtr = framePtr->prev;
}
N_NIMCALL(void, Addinterfaceoverloadablesymat_106044)(TY105012* C_106046, TY54547* Sym_106047, NI At_106048) {
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "addInterfaceOverloadableSymAt";
F.prev = framePtr;
F.filename = "rod/lookups.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
F.line = 99;F.filename = "lookups.nim";
Addoverloadablesymat_106035(C_106046, Sym_106047, ((NI) (At_106048)));
F.line = 100;F.filename = "lookups.nim";
Addinterfacedeclaux_106199(C_106046, Sym_106047);
framePtr = framePtr->prev;
}
N_NIMCALL(TY54547*, Lookup_106049)(TY105012* C_106051, TY54525* N_106052) {
TY54547* Result_106307;
NIM_BOOL LOC5;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "lookUp";
F.prev = framePtr;
F.filename = "rod/lookups.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
Result_106307 = 0;
F.line = 104;F.filename = "lookups.nim";
switch ((*N_106052).Kind) {
case ((NU8) 43):
F.line = 106;F.filename = "lookups.nim";
if (((TMP106376[(*N_106052).Kind/8] &(1<<((*N_106052).Kind%8)))!=0)) raiseFieldError(((NimStringDesc*) &TMP106377));
if ((NU)(0) >= (NU)((*N_106052).KindU.S6.Sons->Sup.len)) raiseIndexError();
Result_106307 = Lookup_106049(C_106051, (*N_106052).KindU.S6.Sons->data[0]);
break;
case ((NU8) 3):
F.line = 112;F.filename = "lookups.nim";
if (!(((TMP106378[(*N_106052).Kind/8] &(1<<((*N_106052).Kind%8)))!=0))) raiseFieldError(((NimStringDesc*) &TMP106379));
Result_106307 = (*N_106052).KindU.S4.Sym;
break;
case ((NU8) 2):
F.line = 114;F.filename = "lookups.nim";
if (!(((TMP106380[(*N_106052).Kind/8] &(1<<((*N_106052).Kind%8)))!=0))) raiseFieldError(((NimStringDesc*) &TMP106381));
Result_106307 = Symtabget_58119((*C_106051).Tab, (*N_106052).KindU.S5.Ident);
F.line = 115;F.filename = "lookups.nim";
if (!(Result_106307 == NIM_NIL)) goto LA2;
F.line = 115;F.filename = "lookups.nim";
if (!(((TMP106380[(*N_106052).Kind/8] &(1<<((*N_106052).Kind%8)))!=0))) raiseFieldError(((NimStringDesc*) &TMP106381));
Limessage_46562((*N_106052).Info, ((NU8) 58), (*(*N_106052).KindU.S5.Ident).S);
LA2: ;
break;
default:
F.line = 116;F.filename = "lookups.nim";
Internalerror_46567((*N_106052).Info, ((NimStringDesc*) &TMP106382));
break;
}
F.line = 117;F.filename = "lookups.nim";
LOC5 = Intsetcontains_54910(&(*C_106051).Ambiguoussymbols, (*Result_106307).Sup.Id);
if (!LOC5) goto LA6;
F.line = 118;F.filename = "lookups.nim";
Limessage_46562((*N_106052).Info, ((NU8) 59), (*(*Result_106307).Name).S);
LA6: ;
F.line = 119;F.filename = "lookups.nim";
if (!((*Result_106307).Kind == ((NU8) 20))) goto LA9;
F.line = 119;F.filename = "lookups.nim";
Loadstub_91070(Result_106307);
LA9: ;
framePtr = framePtr->prev;
return Result_106307;
}
N_NIMCALL(TY54547*, Qualifiedlookup_106053)(TY105012* C_106055, TY54525* N_106056, NIM_BOOL Ambiguouscheck_106057) {
TY54547* Result_106388;
NIM_BOOL LOC4;
NIM_BOOL LOC9;
TY54547* M_106472;
NIM_BOOL LOC14;
TY53011* Ident_106493;
NIM_BOOL LOC21;
NimStringDesc* LOC34;
NIM_BOOL LOC36;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "QualifiedLookUp";
F.prev = framePtr;
F.filename = "rod/lookups.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
Result_106388 = 0;
F.line = 122;F.filename = "lookups.nim";
switch ((*N_106056).Kind) {
case ((NU8) 2):
F.line = 124;F.filename = "lookups.nim";
if (!(((TMP106380[(*N_106056).Kind/8] &(1<<((*N_106056).Kind%8)))!=0))) raiseFieldError(((NimStringDesc*) &TMP106381));
Result_106388 = Symtabget_58119((*C_106055).Tab, (*N_106056).KindU.S5.Ident);
F.line = 125;F.filename = "lookups.nim";
if (!(Result_106388 == NIM_NIL)) goto LA2;
F.line = 126;F.filename = "lookups.nim";
if (!(((TMP106380[(*N_106056).Kind/8] &(1<<((*N_106056).Kind%8)))!=0))) raiseFieldError(((NimStringDesc*) &TMP106381));
Limessage_46562((*N_106056).Info, ((NU8) 58), (*(*N_106056).KindU.S5.Ident).S);
goto LA1;
LA2: ;
LOC4 = Ambiguouscheck_106057;
if (!(LOC4)) goto LA5;
LOC4 = Intsetcontains_54910(&(*C_106055).Ambiguoussymbols, (*Result_106388).Sup.Id);
LA5: ;
if (!LOC4) goto LA6;
F.line = 128;F.filename = "lookups.nim";
if (!(((TMP106380[(*N_106056).Kind/8] &(1<<((*N_106056).Kind%8)))!=0))) raiseFieldError(((NimStringDesc*) &TMP106381));
Limessage_46562((*N_106056).Info, ((NU8) 59), (*(*N_106056).KindU.S5.Ident).S);
goto LA1;
LA6: ;
LA1: ;
break;
case ((NU8) 3):
F.line = 135;F.filename = "lookups.nim";
if (!(((TMP106378[(*N_106056).Kind/8] &(1<<((*N_106056).Kind%8)))!=0))) raiseFieldError(((NimStringDesc*) &TMP106379));
Result_106388 = (*N_106056).KindU.S4.Sym;
F.line = 136;F.filename = "lookups.nim";
LOC9 = Ambiguouscheck_106057;
if (!(LOC9)) goto LA10;
LOC9 = Intsetcontains_54910(&(*C_106055).Ambiguoussymbols, (*Result_106388).Sup.Id);
LA10: ;
if (!LOC9) goto LA11;
F.line = 137;F.filename = "lookups.nim";
if (!(((TMP106378[(*N_106056).Kind/8] &(1<<((*N_106056).Kind%8)))!=0))) raiseFieldError(((NimStringDesc*) &TMP106379));
Limessage_46562((*N_106056).Info, ((NU8) 59), (*(*(*N_106056).KindU.S4.Sym).Name).S);
LA11: ;
break;
case ((NU8) 36):
F.line = 139;F.filename = "lookups.nim";
Result_106388 = NIM_NIL;
M_106472 = 0;
F.line = 140;F.filename = "lookups.nim";
if (((TMP106376[(*N_106056).Kind/8] &(1<<((*N_106056).Kind%8)))!=0)) raiseFieldError(((NimStringDesc*) &TMP106377));
if ((NU)(0) >= (NU)((*N_106056).KindU.S6.Sons->Sup.len)) raiseIndexError();
M_106472 = Qualifiedlookup_106053(C_106055, (*N_106056).KindU.S6.Sons->data[0], NIM_FALSE);
F.line = 141;F.filename = "lookups.nim";
LOC14 = !((M_106472 == NIM_NIL));
if (!(LOC14)) goto LA15;
LOC14 = ((*M_106472).Kind == ((NU8) 18));
LA15: ;
if (!LOC14) goto LA16;
Ident_106493 = 0;
F.line = 142;F.filename = "lookups.nim";
Ident_106493 = NIM_NIL;
F.line = 143;F.filename = "lookups.nim";
if (((TMP106376[(*N_106056).Kind/8] &(1<<((*N_106056).Kind%8)))!=0)) raiseFieldError(((NimStringDesc*) &TMP106377));
if ((NU)(1) >= (NU)((*N_106056).KindU.S6.Sons->Sup.len)) raiseIndexError();
if (!((*(*N_106056).KindU.S6.Sons->data[1]).Kind == ((NU8) 2))) goto LA19;
F.line = 144;F.filename = "lookups.nim";
if (((TMP106376[(*N_106056).Kind/8] &(1<<((*N_106056).Kind%8)))!=0)) raiseFieldError(((NimStringDesc*) &TMP106377));
if ((NU)(1) >= (NU)((*N_106056).KindU.S6.Sons->Sup.len)) raiseIndexError();
if (!(((TMP106380[(*(*N_106056).KindU.S6.Sons->data[1]).Kind/8] &(1<<((*(*N_106056).KindU.S6.Sons->data[1]).Kind%8)))!=0))) raiseFieldError(((NimStringDesc*) &TMP106381));
Ident_106493 = (*(*N_106056).KindU.S6.Sons->data[1]).KindU.S5.Ident;
goto LA18;
LA19: ;
if (((TMP106376[(*N_106056).Kind/8] &(1<<((*N_106056).Kind%8)))!=0)) raiseFieldError(((NimStringDesc*) &TMP106377));
if ((NU)(1) >= (NU)((*N_106056).KindU.S6.Sons->Sup.len)) raiseIndexError();
LOC21 = ((*(*N_106056).KindU.S6.Sons->data[1]).Kind == ((NU8) 43));
if (!(LOC21)) goto LA22;
if (((TMP106376[(*N_106056).Kind/8] &(1<<((*N_106056).Kind%8)))!=0)) raiseFieldError(((NimStringDesc*) &TMP106377));
if ((NU)(1) >= (NU)((*N_106056).KindU.S6.Sons->Sup.len)) raiseIndexError();
if (((TMP106376[(*(*N_106056).KindU.S6.Sons->data[1]).Kind/8] &(1<<((*(*N_106056).KindU.S6.Sons->data[1]).Kind%8)))!=0)) raiseFieldError(((NimStringDesc*) &TMP106377));
if ((NU)(0) >= (NU)((*(*N_106056).KindU.S6.Sons->data[1]).KindU.S6.Sons->Sup.len)) raiseIndexError();
LOC21 = ((*(*(*N_106056).KindU.S6.Sons->data[1]).KindU.S6.Sons->data[0]).Kind == ((NU8) 2));
LA22: ;
if (!LOC21) goto LA23;
F.line = 147;F.filename = "lookups.nim";
if (((TMP106376[(*N_106056).Kind/8] &(1<<((*N_106056).Kind%8)))!=0)) raiseFieldError(((NimStringDesc*) &TMP106377));
if ((NU)(1) >= (NU)((*N_106056).KindU.S6.Sons->Sup.len)) raiseIndexError();
if (((TMP106376[(*(*N_106056).KindU.S6.Sons->data[1]).Kind/8] &(1<<((*(*N_106056).KindU.S6.Sons->data[1]).Kind%8)))!=0)) raiseFieldError(((NimStringDesc*) &TMP106377));
if ((NU)(0) >= (NU)((*(*N_106056).KindU.S6.Sons->data[1]).KindU.S6.Sons->Sup.len)) raiseIndexError();
if (!(((TMP106380[(*(*(*N_106056).KindU.S6.Sons->data[1]).KindU.S6.Sons->data[0]).Kind/8] &(1<<((*(*(*N_106056).KindU.S6.Sons->data[1]).KindU.S6.Sons->data[0]).Kind%8)))!=0))) raiseFieldError(((NimStringDesc*) &TMP106381));
Ident_106493 = (*(*(*N_106056).KindU.S6.Sons->data[1]).KindU.S6.Sons->data[0]).KindU.S5.Ident;
goto LA18;
LA23: ;
LA18: ;
F.line = 148;F.filename = "lookups.nim";
if (!!((Ident_106493 == NIM_NIL))) goto LA26;
F.line = 149;F.filename = "lookups.nim";
if (!(M_106472 == (*C_106055).Module)) goto LA29;
F.line = 150;F.filename = "lookups.nim";
if ((NU)(1) >= (NU)((*C_106055).Tab.Stack->Sup.len)) raiseIndexError();
Result_106388 = Strtableget_58069(&(*C_106055).Tab.Stack->data[1], Ident_106493);
goto LA28;
LA29: ;
F.line = 152;F.filename = "lookups.nim";
Result_106388 = Strtableget_58069(&(*M_106472).Tab, Ident_106493);
LA28: ;
F.line = 153;F.filename = "lookups.nim";
if (!(Result_106388 == NIM_NIL)) goto LA32;
F.line = 154;F.filename = "lookups.nim";
if (((TMP106376[(*N_106056).Kind/8] &(1<<((*N_106056).Kind%8)))!=0)) raiseFieldError(((NimStringDesc*) &TMP106377));
if ((NU)(1) >= (NU)((*N_106056).KindU.S6.Sons->Sup.len)) raiseIndexError();
Limessage_46562((*(*N_106056).KindU.S6.Sons->data[1]).Info, ((NU8) 58), (*Ident_106493).S);
LA32: ;
goto LA25;
LA26: ;
F.line = 156;F.filename = "lookups.nim";
if (((TMP106376[(*N_106056).Kind/8] &(1<<((*N_106056).Kind%8)))!=0)) raiseFieldError(((NimStringDesc*) &TMP106377));
if ((NU)(1) >= (NU)((*N_106056).KindU.S6.Sons->Sup.len)) raiseIndexError();
if (((TMP106376[(*N_106056).Kind/8] &(1<<((*N_106056).Kind%8)))!=0)) raiseFieldError(((NimStringDesc*) &TMP106377));
if ((NU)(1) >= (NU)((*N_106056).KindU.S6.Sons->Sup.len)) raiseIndexError();
LOC34 = 0;
LOC34 = Rendertree_83042((*N_106056).KindU.S6.Sons->data[1], 0);
Limessage_46562((*(*N_106056).KindU.S6.Sons->data[1]).Info, ((NU8) 19), LOC34);
LA25: ;
LA16: ;
break;
case ((NU8) 43):
F.line = 158;F.filename = "lookups.nim";
if (((TMP106376[(*N_106056).Kind/8] &(1<<((*N_106056).Kind%8)))!=0)) raiseFieldError(((NimStringDesc*) &TMP106377));
if ((NU)(0) >= (NU)((*N_106056).KindU.S6.Sons->Sup.len)) raiseIndexError();
Result_106388 = Qualifiedlookup_106053(C_106055, (*N_106056).KindU.S6.Sons->data[0], Ambiguouscheck_106057);
break;
default:
F.line = 160;F.filename = "lookups.nim";
Result_106388 = NIM_NIL;
break;
}
F.line = 161;F.filename = "lookups.nim";
LOC36 = !((Result_106388 == NIM_NIL));
if (!(LOC36)) goto LA37;
LOC36 = ((*Result_106388).Kind == ((NU8) 20));
LA37: ;
if (!LOC36) goto LA38;
F.line = 161;F.filename = "lookups.nim";
Loadstub_91070(Result_106388);
LA38: ;
framePtr = framePtr->prev;
return Result_106388;
}
N_NIMCALL(TY54547*, Initoverloaditer_106058)(TY106004* O_106061, TY105012* C_106062, TY54525* N_106063) {
TY54547* Result_106734;
TY53011* Ident_106735;
NIM_BOOL LOC6;
NIM_BOOL LOC13;
NimStringDesc* LOC23;
NIM_BOOL LOC25;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "InitOverloadIter";
F.prev = framePtr;
F.filename = "rod/lookups.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
Result_106734 = 0;
Ident_106735 = 0;
F.line = 165;F.filename = "lookups.nim";
Result_106734 = NIM_NIL;
F.line = 166;F.filename = "lookups.nim";
switch ((*N_106063).Kind) {
case ((NU8) 2):
F.line = 168;F.filename = "lookups.nim";
(*O_106061).Stackptr = ((NI) ((*C_106062).Tab.Tos));
F.line = 169;F.filename = "lookups.nim";
(*O_106061).Mode = ((NU8) 1);
F.line = 170;F.filename = "lookups.nim";
while (1) {
if (!(Result_106734 == NIM_NIL)) goto LA1;
F.line = 171;F.filename = "lookups.nim";
(*O_106061).Stackptr = subInt((*O_106061).Stackptr, 1);
F.line = 172;F.filename = "lookups.nim";
if (!((*O_106061).Stackptr < 0)) goto LA3;
F.line = 172;F.filename = "lookups.nim";
goto LA1;
LA3: ;
F.line = 173;F.filename = "lookups.nim";
if ((NU)((*O_106061).Stackptr) >= (NU)((*C_106062).Tab.Stack->Sup.len)) raiseIndexError();
if (!(((TMP106380[(*N_106063).Kind/8] &(1<<((*N_106063).Kind%8)))!=0))) raiseFieldError(((NimStringDesc*) &TMP106381));
Result_106734 = Initidentiter_58095(&(*O_106061).It, &(*C_106062).Tab.Stack->data[(*O_106061).Stackptr], (*N_106063).KindU.S5.Ident);
} LA1: ;
break;
case ((NU8) 3):
F.line = 175;F.filename = "lookups.nim";
if (!(((TMP106378[(*N_106063).Kind/8] &(1<<((*N_106063).Kind%8)))!=0))) raiseFieldError(((NimStringDesc*) &TMP106379));
Result_106734 = (*N_106063).KindU.S4.Sym;
F.line = 176;F.filename = "lookups.nim";
(*O_106061).Mode = ((NU8) 0);
break;
case ((NU8) 36):
F.line = 185;F.filename = "lookups.nim";
(*O_106061).Mode = ((NU8) 3);
F.line = 186;F.filename = "lookups.nim";
if (((TMP106376[(*N_106063).Kind/8] &(1<<((*N_106063).Kind%8)))!=0)) raiseFieldError(((NimStringDesc*) &TMP106377));
if ((NU)(0) >= (NU)((*N_106063).KindU.S6.Sons->Sup.len)) raiseIndexError();
unsureAsgnRef((void**) &(*O_106061).M, Qualifiedlookup_106053(C_106062, (*N_106063).KindU.S6.Sons->data[0], NIM_FALSE));
F.line = 187;F.filename = "lookups.nim";
LOC6 = !(((*O_106061).M == NIM_NIL));
if (!(LOC6)) goto LA7;
LOC6 = ((*(*O_106061).M).Kind == ((NU8) 18));
LA7: ;
if (!LOC6) goto LA8;
F.line = 188;F.filename = "lookups.nim";
Ident_106735 = NIM_NIL;
F.line = 189;F.filename = "lookups.nim";
if (((TMP106376[(*N_106063).Kind/8] &(1<<((*N_106063).Kind%8)))!=0)) raiseFieldError(((NimStringDesc*) &TMP106377));
if ((NU)(1) >= (NU)((*N_106063).KindU.S6.Sons->Sup.len)) raiseIndexError();
if (!((*(*N_106063).KindU.S6.Sons->data[1]).Kind == ((NU8) 2))) goto LA11;
F.line = 190;F.filename = "lookups.nim";
if (((TMP106376[(*N_106063).Kind/8] &(1<<((*N_106063).Kind%8)))!=0)) raiseFieldError(((NimStringDesc*) &TMP106377));
if ((NU)(1) >= (NU)((*N_106063).KindU.S6.Sons->Sup.len)) raiseIndexError();
if (!(((TMP106380[(*(*N_106063).KindU.S6.Sons->data[1]).Kind/8] &(1<<((*(*N_106063).KindU.S6.Sons->data[1]).Kind%8)))!=0))) raiseFieldError(((NimStringDesc*) &TMP106381));
Ident_106735 = (*(*N_106063).KindU.S6.Sons->data[1]).KindU.S5.Ident;
goto LA10;
LA11: ;
if (((TMP106376[(*N_106063).Kind/8] &(1<<((*N_106063).Kind%8)))!=0)) raiseFieldError(((NimStringDesc*) &TMP106377));
if ((NU)(1) >= (NU)((*N_106063).KindU.S6.Sons->Sup.len)) raiseIndexError();
LOC13 = ((*(*N_106063).KindU.S6.Sons->data[1]).Kind == ((NU8) 43));
if (!(LOC13)) goto LA14;
if (((TMP106376[(*N_106063).Kind/8] &(1<<((*N_106063).Kind%8)))!=0)) raiseFieldError(((NimStringDesc*) &TMP106377));
if ((NU)(1) >= (NU)((*N_106063).KindU.S6.Sons->Sup.len)) raiseIndexError();
if (((TMP106376[(*(*N_106063).KindU.S6.Sons->data[1]).Kind/8] &(1<<((*(*N_106063).KindU.S6.Sons->data[1]).Kind%8)))!=0)) raiseFieldError(((NimStringDesc*) &TMP106377));
if ((NU)(0) >= (NU)((*(*N_106063).KindU.S6.Sons->data[1]).KindU.S6.Sons->Sup.len)) raiseIndexError();
LOC13 = ((*(*(*N_106063).KindU.S6.Sons->data[1]).KindU.S6.Sons->data[0]).Kind == ((NU8) 2));
LA14: ;
if (!LOC13) goto LA15;
F.line = 193;F.filename = "lookups.nim";
if (((TMP106376[(*N_106063).Kind/8] &(1<<((*N_106063).Kind%8)))!=0)) raiseFieldError(((NimStringDesc*) &TMP106377));
if ((NU)(1) >= (NU)((*N_106063).KindU.S6.Sons->Sup.len)) raiseIndexError();
if (((TMP106376[(*(*N_106063).KindU.S6.Sons->data[1]).Kind/8] &(1<<((*(*N_106063).KindU.S6.Sons->data[1]).Kind%8)))!=0)) raiseFieldError(((NimStringDesc*) &TMP106377));
if ((NU)(0) >= (NU)((*(*N_106063).KindU.S6.Sons->data[1]).KindU.S6.Sons->Sup.len)) raiseIndexError();
if (!(((TMP106380[(*(*(*N_106063).KindU.S6.Sons->data[1]).KindU.S6.Sons->data[0]).Kind/8] &(1<<((*(*(*N_106063).KindU.S6.Sons->data[1]).KindU.S6.Sons->data[0]).Kind%8)))!=0))) raiseFieldError(((NimStringDesc*) &TMP106381));
Ident_106735 = (*(*(*N_106063).KindU.S6.Sons->data[1]).KindU.S6.Sons->data[0]).KindU.S5.Ident;
goto LA10;
LA15: ;
LA10: ;
F.line = 194;F.filename = "lookups.nim";
if (!!((Ident_106735 == NIM_NIL))) goto LA18;
F.line = 195;F.filename = "lookups.nim";
if (!((*O_106061).M == (*C_106062).Module)) goto LA21;
F.line = 197;F.filename = "lookups.nim";
if ((NU)(1) >= (NU)((*C_106062).Tab.Stack->Sup.len)) raiseIndexError();
Result_106734 = Initidentiter_58095(&(*O_106061).It, &(*C_106062).Tab.Stack->data[1], Ident_106735);
F.line = 198;F.filename = "lookups.nim";
(*O_106061).Mode = ((NU8) 2);
goto LA20;
LA21: ;
F.line = 200;F.filename = "lookups.nim";
Result_106734 = Initidentiter_58095(&(*O_106061).It, &(*(*O_106061).M).Tab, Ident_106735);
LA20: ;
goto LA17;
LA18: ;
F.line = 202;F.filename = "lookups.nim";
if (((TMP106376[(*N_106063).Kind/8] &(1<<((*N_106063).Kind%8)))!=0)) raiseFieldError(((NimStringDesc*) &TMP106377));
if ((NU)(1) >= (NU)((*N_106063).KindU.S6.Sons->Sup.len)) raiseIndexError();
if (((TMP106376[(*N_106063).Kind/8] &(1<<((*N_106063).Kind%8)))!=0)) raiseFieldError(((NimStringDesc*) &TMP106377));
if ((NU)(1) >= (NU)((*N_106063).KindU.S6.Sons->Sup.len)) raiseIndexError();
LOC23 = 0;
LOC23 = Rendertree_83042((*N_106063).KindU.S6.Sons->data[1], 0);
Limessage_46562((*(*N_106063).KindU.S6.Sons->data[1]).Info, ((NU8) 19), LOC23);
LA17: ;
LA8: ;
break;
case ((NU8) 43):
F.line = 204;F.filename = "lookups.nim";
if (((TMP106376[(*N_106063).Kind/8] &(1<<((*N_106063).Kind%8)))!=0)) raiseFieldError(((NimStringDesc*) &TMP106377));
if ((NU)(0) >= (NU)((*N_106063).KindU.S6.Sons->Sup.len)) raiseIndexError();
Result_106734 = Initoverloaditer_106058(O_106061, C_106062, (*N_106063).KindU.S6.Sons->data[0]);
break;
case ((NU8) 46):
F.line = 206;F.filename = "lookups.nim";
(*O_106061).Mode = ((NU8) 4);
F.line = 207;F.filename = "lookups.nim";
if (((TMP106376[(*N_106063).Kind/8] &(1<<((*N_106063).Kind%8)))!=0)) raiseFieldError(((NimStringDesc*) &TMP106377));
if ((NU)(0) >= (NU)((*N_106063).KindU.S6.Sons->Sup.len)) raiseIndexError();
if (!(((TMP106378[(*(*N_106063).KindU.S6.Sons->data[0]).Kind/8] &(1<<((*(*N_106063).KindU.S6.Sons->data[0]).Kind%8)))!=0))) raiseFieldError(((NimStringDesc*) &TMP106379));
Result_106734 = (*(*N_106063).KindU.S6.Sons->data[0]).KindU.S4.Sym;
F.line = 208;F.filename = "lookups.nim";
(*O_106061).Stackptr = 1;
break;
default:
break;
}
F.line = 211;F.filename = "lookups.nim";
LOC25 = !((Result_106734 == NIM_NIL));
if (!(LOC25)) goto LA26;
LOC25 = ((*Result_106734).Kind == ((NU8) 20));
LA26: ;
if (!LOC25) goto LA27;
F.line = 211;F.filename = "lookups.nim";
Loadstub_91070(Result_106734);
LA27: ;
framePtr = framePtr->prev;
return Result_106734;
}
static N_INLINE(NI, addInt)(NI A_5603, NI B_5604) {
NI Result_5605;
NIM_BOOL LOC2;
Result_5605 = 0;
Result_5605 = (NI64)((NU64)(A_5603) + (NU64)(B_5604));
LOC2 = (0 <= (NI64)(Result_5605 ^ A_5603));
if (LOC2) goto LA3;
LOC2 = (0 <= (NI64)(Result_5605 ^ B_5604));
LA3: ;
if (!LOC2) goto LA4;
goto BeforeRet;
LA4: ;
raiseOverflow();
BeforeRet: ;
return Result_5605;
}
N_NIMCALL(TY54547*, Nextoverloaditer_106064)(TY106004* O_106067, TY105012* C_106068, TY54525* N_106069) {
TY54547* Result_107062;
NI LOC11;
NIM_BOOL LOC15;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "nextOverloadIter";
F.prev = framePtr;
F.filename = "rod/lookups.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
Result_107062 = 0;
F.line = 214;F.filename = "lookups.nim";
switch ((*O_106067).Mode) {
case ((NU8) 0):
F.line = 216;F.filename = "lookups.nim";
Result_107062 = NIM_NIL;
break;
case ((NU8) 1):
F.line = 218;F.filename = "lookups.nim";
if (!((*N_106069).Kind == ((NU8) 43))) goto LA2;
F.line = 219;F.filename = "lookups.nim";
if (((TMP106376[(*N_106069).Kind/8] &(1<<((*N_106069).Kind%8)))!=0)) raiseFieldError(((NimStringDesc*) &TMP106377));
if ((NU)(0) >= (NU)((*N_106069).KindU.S6.Sons->Sup.len)) raiseIndexError();
Result_107062 = Nextoverloaditer_106064(O_106067, C_106068, (*N_106069).KindU.S6.Sons->data[0]);
goto LA1;
LA2: ;
if (!(0 <= (*O_106067).Stackptr)) goto LA4;
F.line = 221;F.filename = "lookups.nim";
if ((NU)((*O_106067).Stackptr) >= (NU)((*C_106068).Tab.Stack->Sup.len)) raiseIndexError();
Result_107062 = Nextidentiter_58101(&(*O_106067).It, &(*C_106068).Tab.Stack->data[(*O_106067).Stackptr]);
F.line = 222;F.filename = "lookups.nim";
while (1) {
if (!(Result_107062 == NIM_NIL)) goto LA6;
F.line = 223;F.filename = "lookups.nim";
(*O_106067).Stackptr = subInt((*O_106067).Stackptr, 1);
F.line = 224;F.filename = "lookups.nim";
if (!((*O_106067).Stackptr < 0)) goto LA8;
F.line = 224;F.filename = "lookups.nim";
goto LA6;
LA8: ;
F.line = 225;F.filename = "lookups.nim";
if ((NU)((*O_106067).Stackptr) >= (NU)((*C_106068).Tab.Stack->Sup.len)) raiseIndexError();
Result_107062 = Initidentiter_58095(&(*O_106067).It, &(*C_106068).Tab.Stack->data[(*O_106067).Stackptr], (*O_106067).It.Name);
} LA6: ;
goto LA1;
LA4: ;
F.line = 228;F.filename = "lookups.nim";
Result_107062 = NIM_NIL;
LA1: ;
break;
case ((NU8) 2):
F.line = 230;F.filename = "lookups.nim";
if ((NU)(1) >= (NU)((*C_106068).Tab.Stack->Sup.len)) raiseIndexError();
Result_107062 = Nextidentiter_58101(&(*O_106067).It, &(*C_106068).Tab.Stack->data[1]);
break;
case ((NU8) 3):
F.line = 232;F.filename = "lookups.nim";
Result_107062 = Nextidentiter_58101(&(*O_106067).It, &(*(*O_106067).M).Tab);
break;
case ((NU8) 4):
F.line = 234;F.filename = "lookups.nim";
LOC11 = Sonslen_54803(N_106069);
if (!((*O_106067).Stackptr < LOC11)) goto LA12;
F.line = 235;F.filename = "lookups.nim";
if (((TMP106376[(*N_106069).Kind/8] &(1<<((*N_106069).Kind%8)))!=0)) raiseFieldError(((NimStringDesc*) &TMP106377));
if ((NU)((*O_106067).Stackptr) >= (NU)((*N_106069).KindU.S6.Sons->Sup.len)) raiseIndexError();
if (!(((TMP106378[(*(*N_106069).KindU.S6.Sons->data[(*O_106067).Stackptr]).Kind/8] &(1<<((*(*N_106069).KindU.S6.Sons->data[(*O_106067).Stackptr]).Kind%8)))!=0))) raiseFieldError(((NimStringDesc*) &TMP106379));
Result_107062 = (*(*N_106069).KindU.S6.Sons->data[(*O_106067).Stackptr]).KindU.S4.Sym;
F.line = 236;F.filename = "lookups.nim";
(*O_106067).Stackptr = addInt((*O_106067).Stackptr, 1);
goto LA10;
LA12: ;
F.line = 238;F.filename = "lookups.nim";
Result_107062 = NIM_NIL;
LA10: ;
break;
}
F.line = 239;F.filename = "lookups.nim";
LOC15 = !((Result_107062 == NIM_NIL));
if (!(LOC15)) goto LA16;
LOC15 = ((*Result_107062).Kind == ((NU8) 20));
LA16: ;
if (!LOC15) goto LA17;
F.line = 239;F.filename = "lookups.nim";
Loadstub_91070(Result_107062);
LA17: ;
framePtr = framePtr->prev;
return Result_107062;
}
N_NOINLINE(void, lookupsInit)(void) {
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "lookups";
F.prev = framePtr;
F.filename = "rod/lookups.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
framePtr = framePtr->prev;
}
