/* Generated by Nimrod Compiler v0.8.11 */
/*   (c) 2011 Andreas Rumpf */

typedef long int NI;
typedef unsigned long int NU;
#include "nimbase.h"

typedef struct TY108012 TY108012;
typedef struct TY56526 TY56526;
typedef struct TY48538 TY48538;
typedef struct TY56552 TY56552;
typedef struct NimStringDesc NimStringDesc;
typedef struct TGenericSeq TGenericSeq;
typedef struct TY56548 TY56548;
typedef struct TY55011 TY55011;
typedef struct TY56520 TY56520;
typedef struct E_Base E_Base;
typedef struct TNimObject TNimObject;
typedef struct TNimType TNimType;
typedef struct TNimNode TNimNode;
typedef struct TSafePoint TSafePoint;
typedef struct TY106002 TY106002;
typedef struct TY108006 TY108006;
typedef struct TY61099 TY61099;
typedef struct TY61101 TY61101;
typedef struct TY56530 TY56530;
typedef struct TY56528 TY56528;
typedef struct TY56895 TY56895;
typedef struct TY56891 TY56891;
typedef struct TY56893 TY56893;
typedef struct TY44019 TY44019;
typedef struct TY44013 TY44013;
typedef struct TY10802 TY10802;
typedef struct TY10814 TY10814;
typedef struct TY11196 TY11196;
typedef struct TY10818 TY10818;
typedef struct TY10810 TY10810;
typedef struct TY11194 TY11194;
typedef struct TY55005 TY55005;
typedef struct TY56540 TY56540;
typedef struct TY53008 TY53008;
typedef struct TY56544 TY56544;
typedef struct TY61071 TY61071;
typedef struct TY56550 TY56550;
typedef struct TY127007 TY127007;
typedef struct TY56564 TY56564;
typedef struct TY56562 TY56562;
typedef struct TY56560 TY56560;
typedef NU8 TY130741[16];
struct TY48538 {
NI16 Line;
NI16 Col;
int Fileindex;
};
struct TGenericSeq {
NI len;
NI space;
};
typedef NIM_CHAR TY245[100000001];
struct NimStringDesc {
  TGenericSeq Sup;
TY245 data;
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
struct E_Base {
  TNimObject Sup;
E_Base* parent;
NCSTRING name;
NimStringDesc* message;
};
struct TSafePoint {
TSafePoint* prev;
NI status;
E_Base* exc;
jmp_buf context;
};
struct TY106002 {
  TNimObject Sup;
};
struct TY56530 {
TNimType* m_type;
NI Counter;
TY56528* Data;
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
struct TNimNode {
NU8 kind;
NI offset;
TNimType* typ;
NCSTRING name;
NI len;
TNimNode** sons;
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
struct TY55005 {
  TNimObject Sup;
NI Id;
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
struct TY61071 {
NI H;
};
struct TY55011 {
  TY55005 Sup;
NimStringDesc* S;
TY55011* Next;
NI H;
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
struct TY56560 {
TY55005* Key;
TNimObject* Val;
};
struct TY56564 {
NI Counter;
TY56562* Data;
};
struct TY127007 {
NI Exactmatches;
NI Subtypematches;
NI Intconvmatches;
NI Convmatches;
NI Genericmatches;
NU8 State;
TY56552* Callee;
TY56548* Calleesym;
TY56526* Call;
TY56564 Bindings;
NIM_BOOL Basetypematch;
};
struct TY108006 {
TY56548* Owner;
TY56548* Resultsym;
NI Nestedloopcounter;
NI Nestedblockcounter;
};
typedef NI TY8814[16];
struct TY56891 {
TY56891* Next;
NI Key;
TY8814 Bits;
};
struct TY44013 {
  TNimObject Sup;
TY44013* Prev;
TY44013* Next;
};
struct TY10810 {
TY10810* Next;
NI Key;
TY8814 Bits;
};
struct TY53008 {
  TNimObject Sup;
TY53008* Left;
TY53008* Right;
NI Length;
NimStringDesc* Data;
};
struct TY56544 {
  TY44013 Sup;
NU8 Kind;
NIM_BOOL Generated;
TY53008* Name;
TY56526* Path;
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
struct TY56562 {
  TGenericSeq Sup;
  TY56560 data[SEQ_DECL_SIZE];
};
N_NIMCALL(NU8, Incheckpoint_48850)(TY48538 Current_48852);
N_NIMCALL(TY56526*, Findclosestdot_130649)(TY56526* N_130651);
static N_INLINE(NI, Sonslen_56804)(TY56526* N_56806);
N_NIMCALL(TY56526*, Safesemexpr_130915)(TY108012* C_130917, TY56526* N_130918);
static N_INLINE(void, pushSafePoint)(TSafePoint* S_5035);
static N_INLINE(void, popSafePoint)(void);
static N_INLINE(E_Base*, getCurrentException)(void);
static N_INLINE(void, popCurrentException)(void);
static N_INLINE(void, asgnRef)(void** Dest_13214, void* Src_13215);
static N_INLINE(void, Incref_13202)(TY10802* C_13204);
static N_INLINE(NI, Atomicinc_3221)(NI* Memloc_3224, NI X_3225);
static N_INLINE(NIM_BOOL, Canbecycleroot_11616)(TY10802* C_11618);
static N_INLINE(void, Rtladdcycleroot_12252)(TY10802* C_12254);
N_NOINLINE(void, Incl_11080)(TY10814* S_11083, TY10802* Cell_11084);
static N_INLINE(TY10802*, Usrtocell_11612)(void* Usr_11614);
static N_INLINE(void, Decref_13001)(TY10802* C_13003);
static N_INLINE(NI, Atomicdec_3226)(NI* Memloc_3229, NI X_3230);
static N_INLINE(void, Rtladdzct_12601)(TY10802* C_12603);
N_NOINLINE(void, Addzct_11601)(TY10818* S_11604, TY10802* C_11605);
N_NIMCALL(void, reraiseException)(void);
N_NIMCALL(void, Suggestfieldaccess_130460)(TY108012* C_130462, TY56526* N_130463);
N_NIMCALL(void, genericReset)(void* Dest_19728, TNimType* Mt_19729);
N_NIMCALL(void, genericAssign)(void* Dest_19652, void* Src_19653, TNimType* Mt_19654);
N_NIMCALL(TY56548*, Inittabiter_61073)(TY61071* Ti_61076, TY56530* Tab_61077);
static N_INLINE(NIM_BOOL, Filtersym_130057)(TY56548* S_130059);
N_NIMCALL(void, Outwriteln_48783)(NimStringDesc* S_48785);
N_NIMCALL(NimStringDesc*, Symtostr_130008)(TY56548* S_130010, NIM_BOOL Islocal_130011, NimStringDesc* Section_130012);
N_NIMCALL(NimStringDesc*, copyString)(NimStringDesc* Src_18712);
N_NIMCALL(NimStringDesc*, addChar)(NimStringDesc* S_1803, NIM_CHAR C_1804);
N_NIMCALL(NimStringDesc*, reprEnum)(NI E_19832, TNimType* Typ_19833);
static N_INLINE(void, appendString)(NimStringDesc* Dest_18799, NimStringDesc* Src_18800);
N_NIMCALL(NimStringDesc*, resizeString)(NimStringDesc* Dest_18789, NI Addlen_18790);
N_NIMCALL(NimStringDesc*, Typetostring_98014)(TY56552* Typ_98016, NU8 Prefer_98017);
N_NIMCALL(NimStringDesc*, Tofilename_48724)(TY48538 Info_48726);
static N_INLINE(NI, Tolinenumber_48732)(TY48538 Info_48734);
N_NIMCALL(NimStringDesc*, nimIntToStr)(NI X_19403);
static N_INLINE(NI, Tocolumn_48736)(TY48538 Info_48738);
N_NIMCALL(TY56548*, Nextiter_61078)(TY61071* Ti_61081, TY56530* Tab_61082);
N_NIMCALL(void, Suggesteverything_130433)(TY108012* C_130435, TY56526* N_130436);
N_NIMCALL(void, Suggestsymlist_130080)(TY56526* List_130082);
N_NIMCALL(void, Internalerror_49208)(TY48538 Info_49210, NimStringDesc* Errmsg_49211);
N_NIMCALL(void, Suggestfield_130072)(TY56548* S_130074);
N_NIMCALL(void, Suggestoperations_130394)(TY108012* C_130396, TY56526* N_130397, TY56552* Typ_130398);
static N_INLINE(NIM_BOOL, Typefits_130362)(TY108012* C_130364, TY56548* S_130365, TY56552* Firstarg_130366);
static N_INLINE(NI, Sonslen_56807)(TY56552* N_56809);
N_NIMCALL(NIM_BOOL, Argtypematches_128914)(TY108012* C_128916, TY56552* F_128917, TY56552* A_128918);
N_NIMCALL(TY56552*, Skiptypes_98087)(TY56552* T_98089, NU64 Kinds_98090);
N_NIMCALL(void, Suggestobject_130155)(TY56526* N_130157);
static N_INLINE(TY56526*, Lastson_56810)(TY56526* N_56812);
N_NIMCALL(TY56526*, Findclosestcall_130742)(TY56526* N_130744);
N_NIMCALL(TY56526*, Copynode_56849)(TY56526* Src_56851);
N_NIMCALL(void, Addson_56824)(TY56526* Father_56826, TY56526* Son_56827);
N_NIMCALL(void, Suggestcall_130320)(TY108012* C_130322, TY56526* N_130323);
N_NIMCALL(NIM_BOOL, Namefits_130235)(TY108012* C_130237, TY56548* S_130238, TY56526* N_130239);
N_NIMCALL(NIM_BOOL, Argsfit_130302)(TY108012* C_130304, TY56548* Candidate_130305, TY56526* N_130306);
N_NIMCALL(void, Initcandidate_127041)(TY127007* C_127044, TY56548* Callee_127045, TY56526* Binding_127046);
N_NIMCALL(void, Partialmatch_129474)(TY108012* C_129476, TY56526* N_129477, TY127007* M_129479);
N_NIMCALL(TY56526*, Findclosestsym_130835)(TY56526* N_130837);
N_NIMCALL(TY56526*, Fuzzysemcheck_130920)(TY108012* C_130922, TY56526* N_130923);
N_NIMCALL(TY56526*, Newnodei_56738)(NU8 Kind_56740, TY48538 Info_56741);
N_NIMCALL(void, Suggestexpr_130991)(TY108012* C_130993, TY56526* Node_130994);
NIM_CONST TY130741 Callnodes_130740 = {
0x00, 0x00, 0x70, 0x38, 0x00, 0x00, 0x00, 0x00,
0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}
;
STRING_LITERAL(TMP198023, "sug", 3);
STRING_LITERAL(TMP198024, "getSymFromList", 14);
STRING_LITERAL(TMP198070, "con", 3);
STRING_LITERAL(TMP198071, "def", 3);
NI Recursivecheck_130914;
extern NU32 Gglobaloptions_47084;
extern TSafePoint* excHandler;
extern TNimType* NTI48540; /* ERecoverableError */
extern E_Base* Currexception_5032;
extern TY56526* Emptynode_56858;
extern TY11196 Gch_11214;
extern TNimType* NTI56530; /* TStrTable */
extern TNimType* NTI56174; /* TSymKind */
extern TNimType* NTI127007; /* TCandidate */
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
N_NIMCALL(TY56526*, Findclosestdot_130649)(TY56526* N_130651) {
TY56526* Result_130652;
NU8 LOC2;
NI I_130692;
NI HEX3Atmp_130737;
NI LOC7;
NI Res_130739;
Result_130652 = 0;
Result_130652 = NIM_NIL;
LOC2 = Incheckpoint_48850((*N_130651).Info);
if (!(LOC2 == ((NU8) 2))) goto LA3;
Result_130652 = N_130651;
goto LA1;
LA3: ;
if (!!(((*N_130651).Kind >= ((NU8) 0) && (*N_130651).Kind <= ((NU8) 18)))) goto LA5;
I_130692 = 0;
HEX3Atmp_130737 = 0;
LOC7 = Sonslen_56804(N_130651);
HEX3Atmp_130737 = LOC7 - 1;
Res_130739 = 0;
Res_130739 = 0;
while (1) {
if (!(Res_130739 <= HEX3Atmp_130737)) goto LA8;
I_130692 = Res_130739;
if (!((*(*N_130651).KindU.S6.Sons->data[I_130692]).Kind == ((NU8) 36))) goto LA10;
Result_130652 = Findclosestdot_130649((*N_130651).KindU.S6.Sons->data[I_130692]);
if (!!((Result_130652 == NIM_NIL))) goto LA13;
goto BeforeRet;
LA13: ;
LA10: ;
Res_130739 += 1;
} LA8: ;
goto LA1;
LA5: ;
LA1: ;
BeforeRet: ;
return Result_130652;
}
static N_INLINE(void, pushSafePoint)(TSafePoint* S_5035) {
(*S_5035).prev = excHandler;
excHandler = S_5035;
}
static N_INLINE(void, popSafePoint)(void) {
excHandler = (*excHandler).prev;
}
static N_INLINE(E_Base*, getCurrentException)(void) {
E_Base* Result_20604;
Result_20604 = 0;
Result_20604 = NIM_NIL;
Result_20604 = Currexception_5032;
return Result_20604;
}
static N_INLINE(NI, Atomicinc_3221)(NI* Memloc_3224, NI X_3225) {
NI Result_7807;
Result_7807 = 0;
(*Memloc_3224) += X_3225;
Result_7807 = (*Memloc_3224);
return Result_7807;
}
static N_INLINE(NIM_BOOL, Canbecycleroot_11616)(TY10802* C_11618) {
NIM_BOOL Result_11619;
Result_11619 = 0;
Result_11619 = !((((*(*C_11618).Typ).flags &(1<<((((NU8) 1))&7)))!=0));
return Result_11619;
}
static N_INLINE(void, Rtladdcycleroot_12252)(TY10802* C_12254) {
Incl_11080(&Gch_11214.Cycleroots, C_12254);
}
static N_INLINE(void, Incref_13202)(TY10802* C_13204) {
NI LOC1;
NIM_BOOL LOC3;
LOC1 = Atomicinc_3221(&(*C_13204).Refcount, 8);
LOC3 = Canbecycleroot_11616(C_13204);
if (!LOC3) goto LA4;
Rtladdcycleroot_12252(C_13204);
LA4: ;
}
static N_INLINE(TY10802*, Usrtocell_11612)(void* Usr_11614) {
TY10802* Result_11615;
Result_11615 = 0;
Result_11615 = ((TY10802*) ((NI32)((NU32)(((NI) (Usr_11614))) - (NU32)(((NI) (((NI)sizeof(TY10802))))))));
return Result_11615;
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
static N_INLINE(void, Decref_13001)(TY10802* C_13003) {
NI LOC2;
NIM_BOOL LOC5;
LOC2 = Atomicdec_3226(&(*C_13003).Refcount, 8);
if (!((NU32)(LOC2) < (NU32)(8))) goto LA3;
Rtladdzct_12601(C_13003);
goto LA1;
LA3: ;
LOC5 = Canbecycleroot_11616(C_13003);
if (!LOC5) goto LA6;
Rtladdcycleroot_12252(C_13003);
goto LA1;
LA6: ;
LA1: ;
}
static N_INLINE(void, asgnRef)(void** Dest_13214, void* Src_13215) {
TY10802* LOC4;
TY10802* LOC8;
if (!!((Src_13215 == NIM_NIL))) goto LA2;
LOC4 = Usrtocell_11612(Src_13215);
Incref_13202(LOC4);
LA2: ;
if (!!(((*Dest_13214) == NIM_NIL))) goto LA6;
LOC8 = Usrtocell_11612((*Dest_13214));
Decref_13001(LOC8);
LA6: ;
(*Dest_13214) = Src_13215;
}
static N_INLINE(void, popCurrentException)(void) {
asgnRef((void**) &Currexception_5032, (*Currexception_5032).parent);
}
N_NIMCALL(TY56526*, Safesemexpr_130915)(TY108012* C_130917, TY56526* N_130918) {
TY56526* Result_130919;
TSafePoint TMP197964;
Result_130919 = 0;
Result_130919 = NIM_NIL;
pushSafePoint(&TMP197964);
TMP197964.status = setjmp(TMP197964.context);
if (TMP197964.status == 0) {
Result_130919 = (*C_130917).Semexpr(C_130917, N_130918);
popSafePoint();
} else {
popSafePoint();
if (getCurrentException()->Sup.m_type == NTI48540) {
Result_130919 = Emptynode_56858;
TMP197964.status = 0;popCurrentException();}
}
if (TMP197964.status != 0) reraiseException();
return Result_130919;
}
static N_INLINE(NIM_BOOL, Filtersym_130057)(TY56548* S_130059) {
NIM_BOOL Result_130060;
Result_130060 = 0;
Result_130060 = (((NU8)((*(*S_130059).Name).S->data[0])) >= ((NU8)(97)) && ((NU8)((*(*S_130059).Name).S->data[0])) <= ((NU8)(122)) || ((NU8)((*(*S_130059).Name).S->data[0])) >= ((NU8)(65)) && ((NU8)((*(*S_130059).Name).S->data[0])) <= ((NU8)(90)) || ((NU8)((*(*S_130059).Name).S->data[0])) >= ((NU8)(48)) && ((NU8)((*(*S_130059).Name).S->data[0])) <= ((NU8)(57)) || ((NU8)((*(*S_130059).Name).S->data[0])) >= ((NU8)(128)) && ((NU8)((*(*S_130059).Name).S->data[0])) <= ((NU8)(255)));
return Result_130060;
}
static N_INLINE(void, appendString)(NimStringDesc* Dest_18799, NimStringDesc* Src_18800) {
memcpy(((NCSTRING) (&(*Dest_18799).data[((*Dest_18799).Sup.len)-0])), ((NCSTRING) ((*Src_18800).data)), ((int) ((NI32)((NI32)((*Src_18800).Sup.len + 1) * 1))));
(*Dest_18799).Sup.len += (*Src_18800).Sup.len;
}
static N_INLINE(NI, Tolinenumber_48732)(TY48538 Info_48734) {
NI Result_48735;
Result_48735 = 0;
Result_48735 = ((NI) (Info_48734.Line));
return Result_48735;
}
static N_INLINE(NI, Tocolumn_48736)(TY48538 Info_48738) {
NI Result_48739;
Result_48739 = 0;
Result_48739 = ((NI) (Info_48738.Col));
return Result_48739;
}
N_NIMCALL(NimStringDesc*, Symtostr_130008)(TY56548* S_130010, NIM_BOOL Islocal_130011, NimStringDesc* Section_130012) {
NimStringDesc* Result_130013;
NIM_BOOL LOC5;
NimStringDesc* LOC12;
NimStringDesc* LOC13;
NI LOC14;
NimStringDesc* LOC15;
NI LOC16;
NimStringDesc* LOC17;
Result_130013 = 0;
Result_130013 = NIM_NIL;
Result_130013 = copyString(Section_130012);
Result_130013 = addChar(Result_130013, 9);
Result_130013 = resizeString(Result_130013, reprEnum((*S_130010).Kind, NTI56174)->Sup.len + 0);
appendString(Result_130013, reprEnum((*S_130010).Kind, NTI56174));
Result_130013 = addChar(Result_130013, 9);
if (!!(Islocal_130011)) goto LA2;
LOC5 = !(((*S_130010).Kind == ((NU8) 6)));
if (!(LOC5)) goto LA6;
LOC5 = !(((*S_130010).Owner == NIM_NIL));
LA6: ;
if (!LOC5) goto LA7;
Result_130013 = resizeString(Result_130013, (*(*(*S_130010).Owner).Name).S->Sup.len + 0);
appendString(Result_130013, (*(*(*S_130010).Owner).Name).S);
Result_130013 = addChar(Result_130013, 46);
LA7: ;
LA2: ;
Result_130013 = resizeString(Result_130013, (*(*S_130010).Name).S->Sup.len + 0);
appendString(Result_130013, (*(*S_130010).Name).S);
Result_130013 = addChar(Result_130013, 9);
if (!!(((*S_130010).Typ == NIM_NIL))) goto LA10;
LOC12 = 0;
LOC12 = Typetostring_98014((*S_130010).Typ, ((NU8) 0));
Result_130013 = resizeString(Result_130013, LOC12->Sup.len + 0);
appendString(Result_130013, LOC12);
LA10: ;
Result_130013 = addChar(Result_130013, 9);
LOC13 = 0;
LOC13 = Tofilename_48724((*S_130010).Info);
Result_130013 = resizeString(Result_130013, LOC13->Sup.len + 0);
appendString(Result_130013, LOC13);
Result_130013 = addChar(Result_130013, 9);
LOC14 = Tolinenumber_48732((*S_130010).Info);
LOC15 = 0;
LOC15 = nimIntToStr(LOC14);
Result_130013 = resizeString(Result_130013, LOC15->Sup.len + 0);
appendString(Result_130013, LOC15);
Result_130013 = addChar(Result_130013, 9);
LOC16 = Tocolumn_48736((*S_130010).Info);
LOC17 = 0;
LOC17 = nimIntToStr(LOC16);
Result_130013 = resizeString(Result_130013, LOC17->Sup.len + 0);
appendString(Result_130013, LOC17);
return Result_130013;
}
N_NIMCALL(void, Suggesteverything_130433)(TY108012* C_130435, TY56526* N_130436) {
NI I_130444;
NI HEX3Atmp_130457;
NI Res_130459;
TY56548* It_130447;
TY56530 HEX3Atmp_130452;
TY61071 It_130454;
TY56548* S_130456;
NIM_BOOL LOC4;
NimStringDesc* LOC7;
It_130447 = 0;
memset((void*)&HEX3Atmp_130452, 0, sizeof(HEX3Atmp_130452));
HEX3Atmp_130452.m_type = NTI56530;
S_130456 = 0;
I_130444 = 0;
HEX3Atmp_130457 = 0;
HEX3Atmp_130457 = (NI32)(((NI) ((*C_130435).Tab.Tos)) - 1);
Res_130459 = 0;
Res_130459 = HEX3Atmp_130457;
while (1) {
if (!(0 <= Res_130459)) goto LA1;
I_130444 = Res_130459;
It_130447 = NIM_NIL;
genericReset((void*)&HEX3Atmp_130452, NTI56530);
genericAssign((void*)&HEX3Atmp_130452, (void*)&(*C_130435).Tab.Stack->data[I_130444], NTI56530);
memset((void*)&It_130454, 0, sizeof(It_130454));
S_130456 = NIM_NIL;
S_130456 = Inittabiter_61073(&It_130454, &HEX3Atmp_130452);
while (1) {
if (!!((S_130456 == NIM_NIL))) goto LA2;
It_130447 = S_130456;
LOC4 = Filtersym_130057(It_130447);
if (!LOC4) goto LA5;
LOC7 = 0;
LOC7 = Symtostr_130008(It_130447, (1 < I_130444), ((NimStringDesc*) &TMP198023));
Outwriteln_48783(LOC7);
LA5: ;
S_130456 = Nextiter_61078(&It_130454, &HEX3Atmp_130452);
} LA2: ;
Res_130459 -= 1;
} LA1: ;
}
N_NIMCALL(void, Suggestfield_130072)(TY56548* S_130074) {
NIM_BOOL LOC2;
NimStringDesc* LOC5;
LOC2 = Filtersym_130057(S_130074);
if (!LOC2) goto LA3;
LOC5 = 0;
LOC5 = Symtostr_130008(S_130074, NIM_TRUE, ((NimStringDesc*) &TMP198023));
Outwriteln_48783(LOC5);
LA3: ;
}
N_NIMCALL(void, Suggestsymlist_130080)(TY56526* List_130082) {
NI I_130106;
NI HEX3Atmp_130152;
NI LOC1;
NI Res_130154;
I_130106 = 0;
HEX3Atmp_130152 = 0;
LOC1 = Sonslen_56804(List_130082);
HEX3Atmp_130152 = (NI32)(LOC1 - 1);
Res_130154 = 0;
Res_130154 = 0;
while (1) {
if (!(Res_130154 <= HEX3Atmp_130152)) goto LA2;
I_130106 = Res_130154;
if (!!(((*(*List_130082).KindU.S6.Sons->data[I_130106]).Kind == ((NU8) 3)))) goto LA4;
Internalerror_49208((*List_130082).Info, ((NimStringDesc*) &TMP198024));
LA4: ;
Suggestfield_130072((*(*List_130082).KindU.S6.Sons->data[I_130106]).KindU.S4.Sym);
Res_130154 += 1;
} LA2: ;
}
static N_INLINE(NI, Sonslen_56807)(TY56552* N_56809) {
NI Result_57761;
Result_57761 = 0;
if (!(*N_56809).Sons == 0) goto LA2;
Result_57761 = 0;
goto LA1;
LA2: ;
Result_57761 = (*N_56809).Sons->Sup.len;
LA1: ;
return Result_57761;
}
static N_INLINE(NIM_BOOL, Typefits_130362)(TY108012* C_130364, TY56548* S_130365, TY56552* Firstarg_130366) {
NIM_BOOL Result_130367;
NIM_BOOL LOC2;
NIM_BOOL LOC3;
NI LOC5;
Result_130367 = 0;
LOC3 = !(((*S_130365).Typ == NIM_NIL));
if (!(LOC3)) goto LA4;
LOC5 = Sonslen_56807((*S_130365).Typ);
LOC3 = (1 < LOC5);
LA4: ;
LOC2 = LOC3;
if (!(LOC2)) goto LA6;
LOC2 = !(((*(*S_130365).Typ).Sons->data[1] == NIM_NIL));
LA6: ;
if (!LOC2) goto LA7;
Result_130367 = Argtypematches_128914(C_130364, (*(*S_130365).Typ).Sons->data[1], Firstarg_130366);
LA7: ;
return Result_130367;
}
N_NIMCALL(void, Suggestoperations_130394)(TY108012* C_130396, TY56526* N_130397, TY56552* Typ_130398) {
NI I_130417;
NI HEX3Atmp_130430;
NI Res_130432;
TY56548* It_130420;
TY56530 HEX3Atmp_130425;
TY61071 It_130427;
TY56548* S_130429;
NIM_BOOL LOC4;
NimStringDesc* LOC8;
It_130420 = 0;
memset((void*)&HEX3Atmp_130425, 0, sizeof(HEX3Atmp_130425));
HEX3Atmp_130425.m_type = NTI56530;
S_130429 = 0;
I_130417 = 0;
HEX3Atmp_130430 = 0;
HEX3Atmp_130430 = (NI32)(((NI) ((*C_130396).Tab.Tos)) - 1);
Res_130432 = 0;
Res_130432 = HEX3Atmp_130430;
while (1) {
if (!(0 <= Res_130432)) goto LA1;
I_130417 = Res_130432;
It_130420 = NIM_NIL;
genericReset((void*)&HEX3Atmp_130425, NTI56530);
genericAssign((void*)&HEX3Atmp_130425, (void*)&(*C_130396).Tab.Stack->data[I_130417], NTI56530);
memset((void*)&It_130427, 0, sizeof(It_130427));
S_130429 = NIM_NIL;
S_130429 = Inittabiter_61073(&It_130427, &HEX3Atmp_130425);
while (1) {
if (!!((S_130429 == NIM_NIL))) goto LA2;
It_130420 = S_130429;
LOC4 = Filtersym_130057(It_130420);
if (!(LOC4)) goto LA5;
LOC4 = Typefits_130362(C_130396, It_130420, Typ_130398);
LA5: ;
if (!LOC4) goto LA6;
LOC8 = 0;
LOC8 = Symtostr_130008(It_130420, (1 < I_130417), ((NimStringDesc*) &TMP198023));
Outwriteln_48783(LOC8);
LA6: ;
S_130429 = Nextiter_61078(&It_130427, &HEX3Atmp_130425);
} LA2: ;
Res_130432 -= 1;
} LA1: ;
}
static N_INLINE(TY56526*, Lastson_56810)(TY56526* N_56812) {
TY56526* Result_58916;
NI LOC1;
Result_58916 = 0;
Result_58916 = NIM_NIL;
LOC1 = Sonslen_56804(N_56812);
Result_58916 = (*N_56812).KindU.S6.Sons->data[(NI32)(LOC1 - 1)];
return Result_58916;
}
N_NIMCALL(void, Suggestobject_130155)(TY56526* N_130157) {
NI I_130166;
NI HEX3Atmp_130229;
NI LOC1;
NI Res_130231;
NI L_130179;
NI I_130204;
NI HEX3Atmp_130232;
NI Res_130234;
TY56526* LOC7;
switch ((*N_130157).Kind) {
case ((NU8) 113):
I_130166 = 0;
HEX3Atmp_130229 = 0;
LOC1 = Sonslen_56804(N_130157);
HEX3Atmp_130229 = (NI32)(LOC1 - 1);
Res_130231 = 0;
Res_130231 = 0;
while (1) {
if (!(Res_130231 <= HEX3Atmp_130229)) goto LA2;
I_130166 = Res_130231;
Suggestobject_130155((*N_130157).KindU.S6.Sons->data[I_130166]);
Res_130231 += 1;
} LA2: ;
break;
case ((NU8) 114):
L_130179 = 0;
L_130179 = Sonslen_56804(N_130157);
if (!(0 < L_130179)) goto LA4;
Suggestobject_130155((*N_130157).KindU.S6.Sons->data[0]);
I_130204 = 0;
HEX3Atmp_130232 = 0;
HEX3Atmp_130232 = (NI32)(L_130179 - 1);
Res_130234 = 0;
Res_130234 = 1;
while (1) {
if (!(Res_130234 <= HEX3Atmp_130232)) goto LA6;
I_130204 = Res_130234;
LOC7 = 0;
LOC7 = Lastson_56810((*N_130157).KindU.S6.Sons->data[I_130204]);
Suggestobject_130155(LOC7);
Res_130234 += 1;
} LA6: ;
LA4: ;
break;
case ((NU8) 3):
Suggestfield_130072((*N_130157).KindU.S4.Sym);
break;
default:
break;
}
}
N_NIMCALL(void, Suggestfieldaccess_130460)(TY108012* C_130462, TY56526* N_130463) {
TY56552* Typ_130464;
NIM_BOOL LOC5;
TY56548* It_130529;
TY56530 HEX3Atmp_130639;
TY61071 It_130641;
TY56548* S_130643;
NIM_BOOL LOC14;
NimStringDesc* LOC17;
TY56548* It_130544;
TY56530 HEX3Atmp_130644;
TY61071 It_130646;
TY56548* S_130648;
NIM_BOOL LOC20;
NimStringDesc* LOC23;
NIM_BOOL LOC24;
NIM_BOOL LOC25;
TY56552* T_130584;
TY56552* T_130606;
NIM_BOOL LOC38;
Typ_130464 = 0;
It_130529 = 0;
memset((void*)&HEX3Atmp_130639, 0, sizeof(HEX3Atmp_130639));
HEX3Atmp_130639.m_type = NTI56530;
S_130643 = 0;
It_130544 = 0;
memset((void*)&HEX3Atmp_130644, 0, sizeof(HEX3Atmp_130644));
HEX3Atmp_130644.m_type = NTI56530;
S_130648 = 0;
T_130584 = 0;
T_130606 = 0;
Typ_130464 = NIM_NIL;
Typ_130464 = (*N_130463).Typ;
if (!(Typ_130464 == NIM_NIL)) goto LA2;
LOC5 = ((*N_130463).Kind == ((NU8) 3));
if (!(LOC5)) goto LA6;
LOC5 = ((*(*N_130463).KindU.S4.Sym).Kind == ((NU8) 6));
LA6: ;
if (!LOC5) goto LA7;
if (!((*N_130463).KindU.S4.Sym == (*C_130462).Module)) goto LA10;
It_130529 = NIM_NIL;
genericReset((void*)&HEX3Atmp_130639, NTI56530);
genericAssign((void*)&HEX3Atmp_130639, (void*)&(*C_130462).Tab.Stack->data[1], NTI56530);
memset((void*)&It_130641, 0, sizeof(It_130641));
S_130643 = NIM_NIL;
S_130643 = Inittabiter_61073(&It_130641, &HEX3Atmp_130639);
while (1) {
if (!!((S_130643 == NIM_NIL))) goto LA12;
It_130529 = S_130643;
LOC14 = Filtersym_130057(It_130529);
if (!LOC14) goto LA15;
LOC17 = 0;
LOC17 = Symtostr_130008(It_130529, NIM_FALSE, ((NimStringDesc*) &TMP198023));
Outwriteln_48783(LOC17);
LA15: ;
S_130643 = Nextiter_61078(&It_130641, &HEX3Atmp_130639);
} LA12: ;
goto LA9;
LA10: ;
It_130544 = NIM_NIL;
genericReset((void*)&HEX3Atmp_130644, NTI56530);
genericAssign((void*)&HEX3Atmp_130644, (void*)&(*(*N_130463).KindU.S4.Sym).Tab, NTI56530);
memset((void*)&It_130646, 0, sizeof(It_130646));
S_130648 = NIM_NIL;
S_130648 = Inittabiter_61073(&It_130646, &HEX3Atmp_130644);
while (1) {
if (!!((S_130648 == NIM_NIL))) goto LA18;
It_130544 = S_130648;
LOC20 = Filtersym_130057(It_130544);
if (!LOC20) goto LA21;
LOC23 = 0;
LOC23 = Symtostr_130008(It_130544, NIM_FALSE, ((NimStringDesc*) &TMP198023));
Outwriteln_48783(LOC23);
LA21: ;
S_130648 = Nextiter_61078(&It_130646, &HEX3Atmp_130644);
} LA18: ;
LA9: ;
goto LA4;
LA7: ;
Suggesteverything_130433(C_130462, N_130463);
LA4: ;
goto LA1;
LA2: ;
LOC25 = ((*Typ_130464).Kind == ((NU8) 14));
if (!(LOC25)) goto LA26;
LOC25 = ((*N_130463).Kind == ((NU8) 3));
LA26: ;
LOC24 = LOC25;
if (!(LOC24)) goto LA27;
LOC24 = ((*(*N_130463).KindU.S4.Sym).Kind == ((NU8) 7));
LA27: ;
if (!LOC24) goto LA28;
T_130584 = NIM_NIL;
T_130584 = Typ_130464;
while (1) {
if (!!((T_130584 == NIM_NIL))) goto LA30;
Suggestsymlist_130080((*T_130584).N);
T_130584 = (*T_130584).Sons->data[0];
} LA30: ;
Suggestoperations_130394(C_130462, N_130463, Typ_130464);
goto LA1;
LA28: ;
Typ_130464 = Skiptypes_98087(Typ_130464, 14682112);
if (!((*Typ_130464).Kind == ((NU8) 17))) goto LA32;
T_130606 = NIM_NIL;
T_130606 = Typ_130464;
while (1) {
Suggestobject_130155((*T_130606).N);
if (!((*T_130606).Sons->data[0] == NIM_NIL)) goto LA36;
goto LA34;
LA36: ;
T_130606 = Skiptypes_98087((*T_130606).Sons->data[0], 2048);
} LA34: ;
Suggestoperations_130394(C_130462, N_130463, Typ_130464);
goto LA31;
LA32: ;
LOC38 = ((*Typ_130464).Kind == ((NU8) 18));
if (!(LOC38)) goto LA39;
LOC38 = !(((*Typ_130464).N == NIM_NIL));
LA39: ;
if (!LOC38) goto LA40;
Suggestsymlist_130080((*Typ_130464).N);
Suggestoperations_130394(C_130462, N_130463, Typ_130464);
goto LA31;
LA40: ;
Suggesteverything_130433(C_130462, N_130463);
LA31: ;
LA1: ;
}
N_NIMCALL(TY56526*, Findclosestcall_130742)(TY56526* N_130744) {
TY56526* Result_130745;
NU8 LOC2;
NI I_130785;
NI HEX3Atmp_130832;
NI LOC7;
NI Res_130834;
Result_130745 = 0;
Result_130745 = NIM_NIL;
LOC2 = Incheckpoint_48850((*N_130744).Info);
if (!(LOC2 == ((NU8) 2))) goto LA3;
Result_130745 = N_130744;
goto LA1;
LA3: ;
if (!!(((*N_130744).Kind >= ((NU8) 0) && (*N_130744).Kind <= ((NU8) 18)))) goto LA5;
I_130785 = 0;
HEX3Atmp_130832 = 0;
LOC7 = Sonslen_56804(N_130744);
HEX3Atmp_130832 = LOC7 - 1;
Res_130834 = 0;
Res_130834 = 0;
while (1) {
if (!(Res_130834 <= HEX3Atmp_130832)) goto LA8;
I_130785 = Res_130834;
if (!((*(*N_130744).KindU.S6.Sons->data[I_130785]).Kind == ((NU8) 21) || (*(*N_130744).KindU.S6.Sons->data[I_130785]).Kind == ((NU8) 27) || (*(*N_130744).KindU.S6.Sons->data[I_130785]).Kind == ((NU8) 28) || (*(*N_130744).KindU.S6.Sons->data[I_130785]).Kind == ((NU8) 29) || (*(*N_130744).KindU.S6.Sons->data[I_130785]).Kind == ((NU8) 20) || (*(*N_130744).KindU.S6.Sons->data[I_130785]).Kind == ((NU8) 22) || (*(*N_130744).KindU.S6.Sons->data[I_130785]).Kind == ((NU8) 79))) goto LA10;
Result_130745 = Findclosestcall_130742((*N_130744).KindU.S6.Sons->data[I_130785]);
if (!!((Result_130745 == NIM_NIL))) goto LA13;
goto BeforeRet;
LA13: ;
LA10: ;
Res_130834 += 1;
} LA8: ;
goto LA1;
LA5: ;
LA1: ;
BeforeRet: ;
return Result_130745;
}
N_NIMCALL(NIM_BOOL, Namefits_130235)(TY108012* C_130237, TY56548* S_130238, TY56526* N_130239) {
NIM_BOOL Result_130240;
TY56526* Op_130253;
TY55011* Opr_130275;
Op_130253 = 0;
Opr_130275 = 0;
Result_130240 = 0;
Op_130253 = NIM_NIL;
Op_130253 = (*N_130239).KindU.S6.Sons->data[0];
if (!((*Op_130253).Kind == ((NU8) 46))) goto LA2;
Op_130253 = (*Op_130253).KindU.S6.Sons->data[0];
LA2: ;
Opr_130275 = NIM_NIL;
switch ((*Op_130253).Kind) {
case ((NU8) 3):
Opr_130275 = (*(*Op_130253).KindU.S4.Sym).Name;
break;
case ((NU8) 2):
Opr_130275 = (*Op_130253).KindU.S5.Ident;
break;
default:
Result_130240 = NIM_FALSE;
goto BeforeRet;
break;
}
Result_130240 = ((*Opr_130275).Sup.Id == (*(*S_130238).Name).Sup.Id);
BeforeRet: ;
return Result_130240;
}
N_NIMCALL(NIM_BOOL, Argsfit_130302)(TY108012* C_130304, TY56548* Candidate_130305, TY56526* N_130306) {
NIM_BOOL Result_130307;
TY127007 M_130308;
memset((void*)&M_130308, 0, sizeof(M_130308));
Result_130307 = 0;
switch ((*Candidate_130305).Kind) {
case ((NU8) 10):
case ((NU8) 12):
case ((NU8) 11):
genericReset((void*)&M_130308, NTI127007);
Initcandidate_127041(&M_130308, Candidate_130305, NIM_NIL);
Partialmatch_129474(C_130304, N_130306, &M_130308);
Result_130307 = !((M_130308.State == ((NU8) 2)));
break;
case ((NU8) 15):
case ((NU8) 14):
Result_130307 = NIM_TRUE;
break;
default:
Result_130307 = NIM_FALSE;
break;
}
return Result_130307;
}
N_NIMCALL(void, Suggestcall_130320)(TY108012* C_130322, TY56526* N_130323) {
NI I_130346;
NI HEX3Atmp_130359;
NI Res_130361;
TY56548* It_130349;
TY56530 HEX3Atmp_130354;
TY61071 It_130356;
TY56548* S_130358;
NIM_BOOL LOC4;
NIM_BOOL LOC5;
NimStringDesc* LOC10;
It_130349 = 0;
memset((void*)&HEX3Atmp_130354, 0, sizeof(HEX3Atmp_130354));
HEX3Atmp_130354.m_type = NTI56530;
S_130358 = 0;
I_130346 = 0;
HEX3Atmp_130359 = 0;
HEX3Atmp_130359 = (NI32)(((NI) ((*C_130322).Tab.Tos)) - 1);
Res_130361 = 0;
Res_130361 = HEX3Atmp_130359;
while (1) {
if (!(0 <= Res_130361)) goto LA1;
I_130346 = Res_130361;
It_130349 = NIM_NIL;
genericReset((void*)&HEX3Atmp_130354, NTI56530);
genericAssign((void*)&HEX3Atmp_130354, (void*)&(*C_130322).Tab.Stack->data[I_130346], NTI56530);
memset((void*)&It_130356, 0, sizeof(It_130356));
S_130358 = NIM_NIL;
S_130358 = Inittabiter_61073(&It_130356, &HEX3Atmp_130354);
while (1) {
if (!!((S_130358 == NIM_NIL))) goto LA2;
It_130349 = S_130358;
LOC5 = Filtersym_130057(It_130349);
if (!(LOC5)) goto LA6;
LOC5 = Namefits_130235(C_130322, It_130349, N_130323);
LA6: ;
LOC4 = LOC5;
if (!(LOC4)) goto LA7;
LOC4 = Argsfit_130302(C_130322, It_130349, N_130323);
LA7: ;
if (!LOC4) goto LA8;
LOC10 = 0;
LOC10 = Symtostr_130008(It_130349, (1 < I_130346), ((NimStringDesc*) &TMP198070));
Outwriteln_48783(LOC10);
LA8: ;
S_130358 = Nextiter_61078(&It_130356, &HEX3Atmp_130354);
} LA2: ;
Res_130361 -= 1;
} LA1: ;
}
N_NIMCALL(TY56526*, Findclosestsym_130835)(TY56526* N_130837) {
TY56526* Result_130838;
NIM_BOOL LOC2;
NU8 LOC4;
NI I_130887;
NI HEX3Atmp_130911;
NI LOC9;
NI Res_130913;
Result_130838 = 0;
Result_130838 = NIM_NIL;
LOC2 = ((*N_130837).Kind == ((NU8) 3));
if (!(LOC2)) goto LA3;
LOC4 = Incheckpoint_48850((*N_130837).Info);
LOC2 = (LOC4 == ((NU8) 2));
LA3: ;
if (!LOC2) goto LA5;
Result_130838 = N_130837;
goto LA1;
LA5: ;
if (!!(((*N_130837).Kind >= ((NU8) 0) && (*N_130837).Kind <= ((NU8) 18)))) goto LA7;
I_130887 = 0;
HEX3Atmp_130911 = 0;
LOC9 = Sonslen_56804(N_130837);
HEX3Atmp_130911 = LOC9 - 1;
Res_130913 = 0;
Res_130913 = 0;
while (1) {
if (!(Res_130913 <= HEX3Atmp_130911)) goto LA10;
I_130887 = Res_130913;
Result_130838 = Findclosestsym_130835((*N_130837).KindU.S6.Sons->data[I_130887]);
if (!!((Result_130838 == NIM_NIL))) goto LA12;
goto BeforeRet;
LA12: ;
Res_130913 += 1;
} LA10: ;
goto LA1;
LA7: ;
LA1: ;
BeforeRet: ;
return Result_130838;
}
N_NIMCALL(TY56526*, Fuzzysemcheck_130920)(TY108012* C_130922, TY56526* N_130923) {
TY56526* Result_130924;
NIM_BOOL LOC2;
NI I_130975;
NI HEX3Atmp_130988;
NI LOC9;
NI Res_130990;
TY56526* LOC11;
Result_130924 = 0;
Result_130924 = NIM_NIL;
Result_130924 = Safesemexpr_130915(C_130922, N_130923);
LOC2 = (Result_130924 == NIM_NIL);
if (LOC2) goto LA3;
LOC2 = ((*Result_130924).Kind == ((NU8) 1));
LA3: ;
if (!LOC2) goto LA4;
Result_130924 = Newnodei_56738((*N_130923).Kind, (*N_130923).Info);
if (!!(((*N_130923).Kind >= ((NU8) 0) && (*N_130923).Kind <= ((NU8) 18)))) goto LA7;
I_130975 = 0;
HEX3Atmp_130988 = 0;
LOC9 = Sonslen_56804(N_130923);
HEX3Atmp_130988 = LOC9 - 1;
Res_130990 = 0;
Res_130990 = 0;
while (1) {
if (!(Res_130990 <= HEX3Atmp_130988)) goto LA10;
I_130975 = Res_130990;
LOC11 = 0;
LOC11 = Fuzzysemcheck_130920(C_130922, (*N_130923).KindU.S6.Sons->data[I_130975]);
Addson_56824(Result_130924, LOC11);
Res_130990 += 1;
} LA10: ;
LA7: ;
LA4: ;
return Result_130924;
}
N_NIMCALL(void, Suggestexpr_130991)(TY108012* C_130993, TY56526* Node_130994) {
NU8 Cp_130995;
TY56526* N_131032;
NIM_BOOL LOC14;
TY56526* Obj_131074;
TY56526* N_131086;
TY56526* A_131109;
TY56526* X_131122;
NIM_BOOL LOC28;
NI I_131163;
NI HEX3Atmp_131232;
NI LOC32;
NI Res_131234;
TY56526* X_131176;
NIM_BOOL LOC35;
TY56526* N_131208;
TY56526* LOC42;
NimStringDesc* LOC46;
N_131032 = 0;
Obj_131074 = 0;
N_131086 = 0;
A_131109 = 0;
X_131122 = 0;
X_131176 = 0;
N_131208 = 0;
Cp_130995 = 0;
Cp_130995 = Incheckpoint_48850((*Node_130994).Info);
if (!(Cp_130995 == ((NU8) 0))) goto LA2;
goto BeforeRet;
LA2: ;
if (!(0 < Recursivecheck_130914)) goto LA5;
goto BeforeRet;
LA5: ;
Recursivecheck_130914 += 1;
if (!((Gglobaloptions_47084 &(1<<((((NU8) 21))&31)))!=0)) goto LA8;
N_131032 = NIM_NIL;
N_131032 = Findclosestdot_130649(Node_130994);
if (!(N_131032 == NIM_NIL)) goto LA11;
N_131032 = Node_130994;
goto LA10;
LA11: ;
Cp_130995 = ((NU8) 2);
LA10: ;
LOC14 = ((*N_131032).Kind == ((NU8) 36));
if (!(LOC14)) goto LA15;
LOC14 = (Cp_130995 == ((NU8) 2));
LA15: ;
if (!LOC14) goto LA16;
Obj_131074 = NIM_NIL;
Obj_131074 = Safesemexpr_130915(C_130993, (*N_131032).KindU.S6.Sons->data[0]);
Suggestfieldaccess_130460(C_130993, Obj_131074);
goto LA13;
LA16: ;
Suggesteverything_130433(C_130993, N_131032);
LA13: ;
LA8: ;
if (!((Gglobaloptions_47084 &(1<<((((NU8) 22))&31)))!=0)) goto LA19;
N_131086 = NIM_NIL;
N_131086 = Findclosestcall_130742(Node_130994);
if (!(N_131086 == NIM_NIL)) goto LA22;
N_131086 = Node_130994;
goto LA21;
LA22: ;
Cp_130995 = ((NU8) 2);
LA21: ;
if (!((*N_131086).Kind == ((NU8) 21) || (*N_131086).Kind == ((NU8) 27) || (*N_131086).Kind == ((NU8) 28) || (*N_131086).Kind == ((NU8) 29) || (*N_131086).Kind == ((NU8) 20) || (*N_131086).Kind == ((NU8) 22) || (*N_131086).Kind == ((NU8) 79))) goto LA25;
A_131109 = NIM_NIL;
A_131109 = Copynode_56849(N_131086);
X_131122 = NIM_NIL;
X_131122 = Safesemexpr_130915(C_130993, (*N_131086).KindU.S6.Sons->data[0]);
LOC28 = ((*X_131122).Kind == ((NU8) 1));
if (LOC28) goto LA29;
LOC28 = ((*X_131122).Typ == NIM_NIL);
LA29: ;
if (!LOC28) goto LA30;
X_131122 = (*N_131086).KindU.S6.Sons->data[0];
LA30: ;
Addson_56824(A_131109, X_131122);
I_131163 = 0;
HEX3Atmp_131232 = 0;
LOC32 = Sonslen_56804(N_131086);
HEX3Atmp_131232 = (NI32)(LOC32 - 1);
Res_131234 = 0;
Res_131234 = 1;
while (1) {
if (!(Res_131234 <= HEX3Atmp_131232)) goto LA33;
I_131163 = Res_131234;
X_131176 = NIM_NIL;
X_131176 = Safesemexpr_130915(C_130993, (*N_131086).KindU.S6.Sons->data[I_131163]);
LOC35 = ((*X_131176).Kind == ((NU8) 1));
if (LOC35) goto LA36;
LOC35 = ((*X_131176).Typ == NIM_NIL);
LA36: ;
if (!LOC35) goto LA37;
goto LA33;
LA37: ;
Addson_56824(A_131109, X_131176);
Res_131234 += 1;
} LA33: ;
Suggestcall_130320(C_130993, A_131109);
LA25: ;
LA19: ;
if (!((Gglobaloptions_47084 &(1<<((((NU8) 23))&31)))!=0)) goto LA40;
N_131208 = NIM_NIL;
LOC42 = 0;
LOC42 = Fuzzysemcheck_130920(C_130993, Node_130994);
N_131208 = Findclosestsym_130835(LOC42);
if (!!((N_131208 == NIM_NIL))) goto LA44;
LOC46 = 0;
LOC46 = Symtostr_130008((*N_131208).KindU.S4.Sym, NIM_FALSE, ((NimStringDesc*) &TMP198071));
Outwriteln_48783(LOC46);
LA44: ;
LA40: ;
exit(0);
BeforeRet: ;
}
N_NIMCALL(void, Suggeststmt_131235)(TY108012* C_131237, TY56526* N_131238) {
Suggestexpr_130991(C_131237, N_131238);
}
N_NOINLINE(void, suggestInit)(void) {
Recursivecheck_130914 = 0;
}

