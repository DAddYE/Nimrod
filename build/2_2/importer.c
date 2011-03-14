/* Generated by Nimrod Compiler v0.8.11 */
/*   (c) 2011 Andreas Rumpf */

typedef long long int NI;
typedef unsigned long long int NU;
#include "nimbase.h"

typedef struct TY56526 TY56526;
typedef struct TY108012 TY108012;
typedef struct TY56552 TY56552;
typedef struct NimStringDesc NimStringDesc;
typedef struct TGenericSeq TGenericSeq;
typedef struct TY48538 TY48538;
typedef struct TY56548 TY56548;
typedef struct TY55011 TY55011;
typedef struct TY56520 TY56520;
typedef struct TY55005 TY55005;
typedef struct TNimObject TNimObject;
typedef struct TNimType TNimType;
typedef struct TNimNode TNimNode;
typedef struct TY56530 TY56530;
typedef struct TY56528 TY56528;
typedef struct TY56540 TY56540;
typedef struct TY53008 TY53008;
typedef struct TY56544 TY56544;
typedef struct TY61071 TY61071;
typedef struct TY106002 TY106002;
typedef struct TY108006 TY108006;
typedef struct TY61099 TY61099;
typedef struct TY61101 TY61101;
typedef struct TY56895 TY56895;
typedef struct TY56891 TY56891;
typedef struct TY56893 TY56893;
typedef struct TY44019 TY44019;
typedef struct TY44013 TY44013;
typedef struct TY56550 TY56550;
typedef struct TY61084 TY61084;
typedef struct TY10802 TY10802;
typedef struct TY10818 TY10818;
typedef struct TY11196 TY11196;
typedef struct TY10814 TY10814;
typedef struct TY10810 TY10810;
typedef struct TY11194 TY11194;
struct TGenericSeq {
NI len;
NI space;
};
typedef NIM_CHAR TY245[100000001];
struct NimStringDesc {
  TGenericSeq Sup;
TY245 data;
};
struct TY48538 {
NI16 Line;
NI16 Col;
int Fileindex;
};
struct TY56526 {
TY56552* Typ;
NimStringDesc* Comment;
TY48538 Info;
NU8 Flags;
NU8 Kind;
union {
struct {NI64 Intval;
} S1;
struct {NF64 Floatval;
} S2;
struct {NimStringDesc* Strval;
} S3;
struct {TY56548* Sym;
} S4;
struct {TY55011* Ident;
} S5;
struct {TY56520* Sons;
} S6;
} KindU;
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
struct TY55005 {
  TNimObject Sup;
NI Id;
};
struct TY55011 {
  TY55005 Sup;
NimStringDesc* S;
TY55011* Next;
NI H;
};
struct TY56530 {
TNimType* m_type;
NI Counter;
TY56528* Data;
};
struct TY56540 {
NU8 K;
NU8 S;
NU8 Flags;
TY56552* T;
TY53008* R;
NI A;
};
struct TY56548 {
  TY55005 Sup;
NU8 Kind;
NU8 Magic;
TY56552* Typ;
TY55011* Name;
TY48538 Info;
TY56548* Owner;
NU32 Flags;
TY56530 Tab;
TY56526* Ast;
NU32 Options;
NI Position;
NI Offset;
TY56540 Loc;
TY56544* Annex;
};
typedef N_NIMCALL_PTR(TY56548*, TY106041) (NimStringDesc* Filename_106042);
struct TY61071 {
NI H;
};
struct TNimNode {
NU8 kind;
NI offset;
TNimType* typ;
NCSTRING name;
NI len;
TNimNode** sons;
};
struct TY106002 {
  TNimObject Sup;
};
struct TY61099 {
NI Tos;
TY61101* Stack;
};
struct TY56895 {
NI Counter;
NI Max;
TY56891* Head;
TY56893* Data;
};
struct TY44019 {
TNimType* m_type;
TY44013* Head;
TY44013* Tail;
NI Counter;
};
typedef N_NIMCALL_PTR(TY56526*, TY108032) (TY108012* C_108033, TY56526* N_108034);
typedef N_NIMCALL_PTR(TY56526*, TY108037) (TY108012* C_108038, TY56526* N_108039);
struct TY108012 {
  TY106002 Sup;
TY56548* Module;
TY108006* P;
NI Instcounter;
TY56526* Generics;
NI Lastgenericidx;
TY61099 Tab;
TY56895 Ambiguoussymbols;
TY56528* Converters;
TY44019 Optionstack;
TY44019 Libs;
NIM_BOOL Fromcache;
TY108032 Semconstexpr;
TY108037 Semexpr;
TY56895 Includedfiles;
NimStringDesc* Filename;
TY56530 Userpragmas;
};
struct TY56552 {
  TY55005 Sup;
NU8 Kind;
TY56550* Sons;
TY56526* N;
NU8 Flags;
NU8 Callconv;
TY56548* Owner;
TY56548* Sym;
NI64 Size;
NI Align;
NI Containerid;
TY56540 Loc;
};
struct TY61084 {
NI H;
TY55011* Name;
};
struct TY10802 {
NI Refcount;
TNimType* Typ;
};
struct TY10818 {
NI Len;
NI Cap;
TY10802** D;
};
struct TY10814 {
NI Counter;
NI Max;
TY10810* Head;
TY10810** Data;
};
struct TY11194 {
NI Stackscans;
NI Cyclecollections;
NI Maxthreshold;
NI Maxstacksize;
NI Maxstackcells;
NI Cycletablesize;
};
struct TY11196 {
TY10818 Zct;
TY10818 Decstack;
TY10814 Cycleroots;
TY10818 Tempstack;
TY11194 Stat;
};
struct TY53008 {
  TNimObject Sup;
TY53008* Left;
TY53008* Right;
NI Length;
NimStringDesc* Data;
};
struct TY44013 {
  TNimObject Sup;
TY44013* Prev;
TY44013* Next;
};
struct TY56544 {
  TY44013 Sup;
NU8 Kind;
NIM_BOOL Generated;
TY53008* Name;
TY56526* Path;
};
struct TY108006 {
TY56548* Owner;
TY56548* Resultsym;
NI Nestedloopcounter;
NI Nestedblockcounter;
};
typedef NI TY8814[8];
struct TY56891 {
TY56891* Next;
NI Key;
TY8814 Bits;
};
struct TY10810 {
TY10810* Next;
NI Key;
TY8814 Bits;
};
struct TY56520 {
  TGenericSeq Sup;
  TY56526* data[SEQ_DECL_SIZE];
};
struct TY56528 {
  TGenericSeq Sup;
  TY56548* data[SEQ_DECL_SIZE];
};
struct TY61101 {
  TGenericSeq Sup;
  TY56530 data[SEQ_DECL_SIZE];
};
struct TY56893 {
  TGenericSeq Sup;
  TY56891* data[SEQ_DECL_SIZE];
};
struct TY56550 {
  TGenericSeq Sup;
  TY56552* data[SEQ_DECL_SIZE];
};
static N_INLINE(NI, Sonslen_56804)(TY56526* N_56806);
N_NIMCALL(NimStringDesc*, Getmodulefile_111013)(TY56526* N_111015);
N_NIMCALL(NimStringDesc*, Findmodule_111016)(TY48538 Info_111018, NimStringDesc* Modulename_111019);
N_NIMCALL(NimStringDesc*, Findfile_47095)(NimStringDesc* F_47097);
N_NIMCALL(NimStringDesc*, nosaddFileExt)(NimStringDesc* Filename_38830, NimStringDesc* Ext_38831);
N_NIMCALL(void, Fatal_49183)(TY48538 Info_49185, NU8 Msg_49186, NimStringDesc* Arg_49187);
N_NIMCALL(NimStringDesc*, nosUnixToNativePath)(NimStringDesc* Path_36856);
N_NIMCALL(void, Internalerror_49208)(TY48538 Info_49210, NimStringDesc* Errmsg_49211);
N_NIMCALL(NimStringDesc*, copyString)(NimStringDesc* Src_18712);
N_NIMCALL(void, Message_49198)(TY48538 Info_49200, NU8 Msg_49201, NimStringDesc* Arg_49202);
N_NIMCALL(void, Adddecl_109114)(TY108012* C_109116, TY56548* Sym_109117);
N_NIMCALL(void, Importallsymbols_111009)(TY108012* C_111011, TY56548* Frommod_111012);
N_NIMCALL(TY56548*, Inittabiter_61073)(TY61071* Ti_61076, TY56530* Tab_61077);
static N_INLINE(void, appendString)(NimStringDesc* Dest_18799, NimStringDesc* Src_18800);
N_NIMCALL(NimStringDesc*, reprEnum)(NI E_19832, TNimType* Typ_19833);
N_NIMCALL(NimStringDesc*, rawNewString)(NI Space_18689);
N_NIMCALL(void, Rawimportsymbol_111061)(TY108012* C_111063, TY56548* S_111064);
N_NIMCALL(TY56548*, Strtableget_61066)(TY56530* T_61068, TY55011* Name_61069);
N_NIMCALL(void, Intsetincl_56909)(TY56895* S_56912, NI Key_56913);
N_NIMCALL(void, Strtableadd_61061)(TY56530* T_61064, TY56548* N_61065);
N_NIMCALL(void, genericReset)(void* Dest_19728, TNimType* Mt_19729);
N_NIMCALL(TY56548*, Initidentiter_61087)(TY61084* Ti_61090, TY56530* Tab_61091, TY55011* S_61092);
N_NIMCALL(TY56548*, Nextidentiter_61093)(TY61084* Ti_61096, TY56530* Tab_61097);
N_NIMCALL(void, Addconverter_108058)(TY108012* C_108060, TY56548* Conv_108061);
N_NIMCALL(TY56548*, Nextiter_61078)(TY61071* Ti_61081, TY56530* Tab_61082);
N_NIMCALL(void, Checkminsonslen_108440)(TY56526* N_108442, NI Length_108443);
N_NIMCALL(TY56526*, Newsymnode_56735)(TY56548* Sym_56737);
static N_INLINE(void, asgnRefNoCycle)(void** Dest_13218, void* Src_13219);
static N_INLINE(TY10802*, Usrtocell_11612)(void* Usr_11614);
static N_INLINE(NI, Atomicinc_3221)(NI* Memloc_3224, NI X_3225);
static N_INLINE(NI, Atomicdec_3226)(NI* Memloc_3229, NI X_3230);
static N_INLINE(void, Rtladdzct_12601)(TY10802* C_12603);
N_NOINLINE(void, Addzct_11601)(TY10818* S_11604, TY10802* C_11605);
N_NIMCALL(void, Importsymbol_111213)(TY108012* C_111215, TY56526* Ident_111216, TY56548* Frommod_111217);
N_NIMCALL(void, Globalerror_49188)(TY48538 Info_49190, NU8 Msg_49191, NimStringDesc* Arg_49192);
N_NIMCALL(void, Loadstub_94070)(TY56548* S_94072);
STRING_LITERAL(TMP198234, "nim", 3);
STRING_LITERAL(TMP198235, "getModuleFile()", 15);
STRING_LITERAL(TMP198236, "", 0);
STRING_LITERAL(TMP198237, "importAllSymbols: ", 18);
STRING_LITERAL(TMP198238, "rawImportSymbol", 15);
STRING_LITERAL(TMP198240, "importSymbol", 12);
STRING_LITERAL(TMP198241, "importSymbol: 2", 15);
STRING_LITERAL(TMP198242, "importSymbol: 3", 15);
extern TY106041 Gimportmodule_106044;
extern TNimType* NTI56174; /* TSymKind */
extern TNimType* NTI61084; /* TIdentIter */
extern TY11196 Gch_11214;
static N_INLINE(NI, Sonslen_56804)(TY56526* N_56806) {
NI Result_57897;
Result_57897 = 0;
if (!(*N_56806).KindU.S6.Sons == 0) goto LA2;
Result_57897 = 0;
goto LA1;
LA2: ;
Result_57897 = (*N_56806).KindU.S6.Sons->Sup.len;
LA1: ;
return Result_57897;
}
N_NIMCALL(NimStringDesc*, Findmodule_111016)(TY48538 Info_111018, NimStringDesc* Modulename_111019) {
NimStringDesc* Result_111020;
NimStringDesc* LOC1;
Result_111020 = 0;
Result_111020 = NIM_NIL;
LOC1 = 0;
LOC1 = nosaddFileExt(Modulename_111019, ((NimStringDesc*) &TMP198234));
Result_111020 = Findfile_47095(LOC1);
if (!((Result_111020) && (Result_111020)->Sup.len == 0)) goto LA3;
Fatal_49183(Info_111018, ((NU8) 2), Modulename_111019);
LA3: ;
return Result_111020;
}
N_NIMCALL(NimStringDesc*, Getmodulefile_111013)(TY56526* N_111015) {
NimStringDesc* Result_111024;
NimStringDesc* LOC1;
Result_111024 = 0;
Result_111024 = NIM_NIL;
switch ((*N_111015).Kind) {
case ((NU8) 14):
case ((NU8) 15):
case ((NU8) 16):
LOC1 = 0;
LOC1 = nosUnixToNativePath((*N_111015).KindU.S3.Strval);
Result_111024 = Findmodule_111016((*N_111015).Info, LOC1);
break;
case ((NU8) 2):
Result_111024 = Findmodule_111016((*N_111015).Info, (*(*N_111015).KindU.S5.Ident).S);
break;
case ((NU8) 3):
Result_111024 = Findmodule_111016((*N_111015).Info, (*(*(*N_111015).KindU.S4.Sym).Name).S);
break;
default:
Internalerror_49208((*N_111015).Info, ((NimStringDesc*) &TMP198235));
Result_111024 = copyString(((NimStringDesc*) &TMP198236));
break;
}
return Result_111024;
}
static N_INLINE(void, appendString)(NimStringDesc* Dest_18799, NimStringDesc* Src_18800) {
memcpy(((NCSTRING) (&(*Dest_18799).data[((*Dest_18799).Sup.len)-0])), ((NCSTRING) ((*Src_18800).data)), ((int) ((NI64)((NI64)((*Src_18800).Sup.len + 1) * 1))));
(*Dest_18799).Sup.len += (*Src_18800).Sup.len;
}
N_NIMCALL(void, Rawimportsymbol_111061)(TY108012* C_111063, TY56548* S_111064) {
TY56548* Copy_111065;
TY56548* Check_111066;
NIM_BOOL LOC2;
TY56552* Etyp_111103;
NI J_111139;
NI HEX3Atmp_111210;
NI LOC15;
NI Res_111212;
TY56548* E_111164;
TY61084 It_111174;
Copy_111065 = 0;
Check_111066 = 0;
Etyp_111103 = 0;
E_111164 = 0;
memset((void*)&It_111174, 0, sizeof(It_111174));
Copy_111065 = NIM_NIL;
Copy_111065 = S_111064;
Check_111066 = NIM_NIL;
Check_111066 = Strtableget_61066(&(*C_111063).Tab.Stack->data[0], (*S_111064).Name);
LOC2 = !((Check_111066 == NIM_NIL));
if (!(LOC2)) goto LA3;
LOC2 = !(((*Check_111066).Sup.Id == (*Copy_111065).Sup.Id));
LA3: ;
if (!LOC2) goto LA4;
if (!!(((15424 &(1<<(((*S_111064).Kind)&31)))!=0))) goto LA7;
Intsetincl_56909(&(*C_111063).Ambiguoussymbols, (*Copy_111065).Sup.Id);
Intsetincl_56909(&(*C_111063).Ambiguoussymbols, (*Check_111066).Sup.Id);
LA7: ;
LA4: ;
Strtableadd_61061(&(*C_111063).Tab.Stack->data[0], Copy_111065);
if (!((*S_111064).Kind == ((NU8) 7))) goto LA10;
Etyp_111103 = NIM_NIL;
Etyp_111103 = (*S_111064).Typ;
if (!((16386 &(IL64(1)<<(((*Etyp_111103).Kind)&IL64(63))))!=0)) goto LA13;
J_111139 = 0;
HEX3Atmp_111210 = 0;
LOC15 = Sonslen_56804((*Etyp_111103).N);
HEX3Atmp_111210 = (NI64)(LOC15 - 1);
Res_111212 = 0;
Res_111212 = 0;
while (1) {
if (!(Res_111212 <= HEX3Atmp_111210)) goto LA16;
J_111139 = Res_111212;
E_111164 = NIM_NIL;
E_111164 = (*(*(*Etyp_111103).N).KindU.S6.Sons->data[J_111139]).KindU.S4.Sym;
if (!!(((*E_111164).Kind == ((NU8) 17)))) goto LA18;
Internalerror_49208((*S_111064).Info, ((NimStringDesc*) &TMP198238));
LA18: ;
genericReset((void*)&It_111174, NTI61084);
Check_111066 = Initidentiter_61087(&It_111174, &(*C_111063).Tab.Stack->data[0], (*E_111164).Name);
while (1) {
if (!!((Check_111066 == NIM_NIL))) goto LA20;
if (!((*Check_111066).Sup.Id == (*E_111164).Sup.Id)) goto LA22;
E_111164 = NIM_NIL;
goto LA20;
LA22: ;
Check_111066 = Nextidentiter_61093(&It_111174, &(*C_111063).Tab.Stack->data[0]);
} LA20: ;
if (!!((E_111164 == NIM_NIL))) goto LA25;
Rawimportsymbol_111061(C_111063, E_111164);
LA25: ;
Res_111212 += 1;
} LA16: ;
LA13: ;
goto LA9;
LA10: ;
if (!((*S_111064).Kind == ((NU8) 13))) goto LA27;
Addconverter_108058(C_111063, S_111064);
goto LA9;
LA27: ;
LA9: ;
}
N_NIMCALL(void, Importallsymbols_111009)(TY108012* C_111011, TY56548* Frommod_111012) {
TY61071 I_111304;
TY56548* S_111306;
NimStringDesc* LOC11;
S_111306 = 0;
memset((void*)&I_111304, 0, sizeof(I_111304));
S_111306 = NIM_NIL;
S_111306 = Inittabiter_61073(&I_111304, &(*Frommod_111012).Tab);
while (1) {
if (!!((S_111306 == NIM_NIL))) goto LA1;
if (!!(((*S_111306).Kind == ((NU8) 6)))) goto LA3;
if (!!(((*S_111306).Kind == ((NU8) 17)))) goto LA6;
if (!!(((1113984 &(1<<(((*S_111306).Kind)&31)))!=0))) goto LA9;
LOC11 = 0;
LOC11 = rawNewString(reprEnum((*S_111306).Kind, NTI56174)->Sup.len + 18);
appendString(LOC11, ((NimStringDesc*) &TMP198237));
appendString(LOC11, reprEnum((*S_111306).Kind, NTI56174));
Internalerror_49208((*S_111306).Info, LOC11);
LA9: ;
Rawimportsymbol_111061(C_111011, S_111306);
LA6: ;
LA3: ;
S_111306 = Nextiter_61078(&I_111304, &(*Frommod_111012).Tab);
} LA1: ;
}
N_NIMCALL(TY56526*, Evalimport_111001)(TY108012* C_111003, TY56526* N_111004) {
TY56526* Result_111360;
NI I_111369;
NI HEX3Atmp_111407;
NI LOC1;
NI Res_111409;
NimStringDesc* F_111382;
TY56548* M_111383;
Result_111360 = 0;
F_111382 = 0;
M_111383 = 0;
Result_111360 = NIM_NIL;
Result_111360 = N_111004;
I_111369 = 0;
HEX3Atmp_111407 = 0;
LOC1 = Sonslen_56804(N_111004);
HEX3Atmp_111407 = (NI64)(LOC1 - 1);
Res_111409 = 0;
Res_111409 = 0;
while (1) {
if (!(Res_111409 <= HEX3Atmp_111407)) goto LA2;
I_111369 = Res_111409;
F_111382 = NIM_NIL;
F_111382 = Getmodulefile_111013((*N_111004).KindU.S6.Sons->data[I_111369]);
M_111383 = NIM_NIL;
M_111383 = Gimportmodule_106044(F_111382);
if (!(((*M_111383).Flags &(1<<((((NU8) 22))&31)))!=0)) goto LA4;
Message_49198((*(*N_111004).KindU.S6.Sons->data[I_111369]).Info, ((NU8) 214), (*(*M_111383).Name).S);
LA4: ;
Adddecl_109114(C_111003, M_111383);
Importallsymbols_111009(C_111003, M_111383);
Res_111409 += 1;
} LA2: ;
return Result_111360;
}
static N_INLINE(TY10802*, Usrtocell_11612)(void* Usr_11614) {
TY10802* Result_11615;
Result_11615 = 0;
Result_11615 = ((TY10802*) ((NI64)((NU64)(((NI) (Usr_11614))) - (NU64)(((NI) (((NI)sizeof(TY10802))))))));
return Result_11615;
}
static N_INLINE(NI, Atomicinc_3221)(NI* Memloc_3224, NI X_3225) {
NI Result_7807;
Result_7807 = 0;
(*Memloc_3224) += X_3225;
Result_7807 = (*Memloc_3224);
return Result_7807;
}
static N_INLINE(NI, Atomicdec_3226)(NI* Memloc_3229, NI X_3230) {
NI Result_8006;
Result_8006 = 0;
(*Memloc_3229) -= X_3230;
Result_8006 = (*Memloc_3229);
return Result_8006;
}
static N_INLINE(void, Rtladdzct_12601)(TY10802* C_12603) {
Addzct_11601(&Gch_11214.Zct, C_12603);
}
static N_INLINE(void, asgnRefNoCycle)(void** Dest_13218, void* Src_13219) {
TY10802* C_13220;
NI LOC4;
TY10802* C_13222;
NI LOC9;
if (!!((Src_13219 == NIM_NIL))) goto LA2;
C_13220 = 0;
C_13220 = Usrtocell_11612(Src_13219);
LOC4 = Atomicinc_3221(&(*C_13220).Refcount, 8);
LA2: ;
if (!!(((*Dest_13218) == NIM_NIL))) goto LA6;
C_13222 = 0;
C_13222 = Usrtocell_11612((*Dest_13218));
LOC9 = Atomicdec_3226(&(*C_13222).Refcount, 8);
if (!((NU64)(LOC9) < (NU64)(8))) goto LA10;
Rtladdzct_12601(C_13222);
LA10: ;
LA6: ;
(*Dest_13218) = Src_13219;
}
N_NIMCALL(void, Importsymbol_111213)(TY108012* C_111215, TY56526* Ident_111216, TY56548* Frommod_111217) {
TY56548* S_111239;
TY61084 It_111283;
TY56548* E_111285;
S_111239 = 0;
memset((void*)&It_111283, 0, sizeof(It_111283));
E_111285 = 0;
if (!!(((*Ident_111216).Kind == ((NU8) 2)))) goto LA2;
Internalerror_49208((*Ident_111216).Info, ((NimStringDesc*) &TMP198240));
LA2: ;
S_111239 = NIM_NIL;
S_111239 = Strtableget_61066(&(*Frommod_111217).Tab, (*Ident_111216).KindU.S5.Ident);
if (!(S_111239 == NIM_NIL)) goto LA5;
Globalerror_49188((*Ident_111216).Info, ((NU8) 58), (*(*Ident_111216).KindU.S5.Ident).S);
LA5: ;
if (!((*S_111239).Kind == ((NU8) 20))) goto LA8;
Loadstub_94070(S_111239);
LA8: ;
if (!!(((1113984 &(1<<(((*S_111239).Kind)&31)))!=0))) goto LA11;
Internalerror_49208((*Ident_111216).Info, ((NimStringDesc*) &TMP198241));
LA11: ;
switch ((*S_111239).Kind) {
case ((NU8) 10):
case ((NU8) 11):
case ((NU8) 12):
case ((NU8) 14):
case ((NU8) 15):
case ((NU8) 13):
genericReset((void*)&It_111283, NTI61084);
E_111285 = NIM_NIL;
E_111285 = Initidentiter_61087(&It_111283, &(*Frommod_111217).Tab, (*S_111239).Name);
while (1) {
if (!!((E_111285 == NIM_NIL))) goto LA13;
if (!!(((*(*E_111285).Name).Sup.Id == (*(*S_111239).Name).Sup.Id))) goto LA15;
Internalerror_49208((*Ident_111216).Info, ((NimStringDesc*) &TMP198242));
LA15: ;
Rawimportsymbol_111061(C_111215, E_111285);
E_111285 = Nextidentiter_61093(&It_111283, &(*Frommod_111217).Tab);
} LA13: ;
break;
default:
Rawimportsymbol_111061(C_111215, S_111239);
break;
}
}
N_NIMCALL(TY56526*, Evalfrom_111005)(TY108012* C_111007, TY56526* N_111008) {
TY56526* Result_111414;
NimStringDesc* F_111427;
TY56548* M_111428;
NI I_111449;
NI HEX3Atmp_111462;
NI LOC1;
NI Res_111464;
Result_111414 = 0;
F_111427 = 0;
M_111428 = 0;
Result_111414 = NIM_NIL;
Result_111414 = N_111008;
Checkminsonslen_108440(N_111008, 2);
F_111427 = NIM_NIL;
F_111427 = Getmodulefile_111013((*N_111008).KindU.S6.Sons->data[0]);
M_111428 = NIM_NIL;
M_111428 = Gimportmodule_106044(F_111427);
asgnRefNoCycle((void**) &(*N_111008).KindU.S6.Sons->data[0], Newsymnode_56735(M_111428));
Adddecl_109114(C_111007, M_111428);
I_111449 = 0;
HEX3Atmp_111462 = 0;
LOC1 = Sonslen_56804(N_111008);
HEX3Atmp_111462 = (NI64)(LOC1 - 1);
Res_111464 = 0;
Res_111464 = 1;
while (1) {
if (!(Res_111464 <= HEX3Atmp_111462)) goto LA2;
I_111449 = Res_111464;
Importsymbol_111213(C_111007, (*N_111008).KindU.S6.Sons->data[I_111449], M_111428);
Res_111464 += 1;
} LA2: ;
return Result_111414;
}
N_NOINLINE(void, importerInit)(void) {
}

