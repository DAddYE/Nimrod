/* Generated by Nimrod Compiler v0.8.11 */
/*   (c) 2011 Andreas Rumpf */

typedef long long int NI;
typedef unsigned long long int NU;
#include "nimbase.h"

typedef struct TY56564 TY56564;
typedef struct TY56562 TY56562;
typedef struct TY56560 TY56560;
typedef struct TY55005 TY55005;
typedef struct TNimObject TNimObject;
typedef struct TGenericSeq TGenericSeq;
typedef struct TY56528 TY56528;
typedef struct TY56548 TY56548;
typedef struct TNimType TNimType;
typedef struct TNimNode TNimNode;
typedef struct TY10802 TY10802;
typedef struct TY10814 TY10814;
typedef struct TY11196 TY11196;
typedef struct TY10818 TY10818;
typedef struct TY10810 TY10810;
typedef struct TY11194 TY11194;
typedef struct TY108012 TY108012;
typedef struct NimStringDesc NimStringDesc;
typedef struct TY106002 TY106002;
typedef struct TY108006 TY108006;
typedef struct TY56526 TY56526;
typedef struct TY61099 TY61099;
typedef struct TY61101 TY61101;
typedef struct TY56530 TY56530;
typedef struct TY56895 TY56895;
typedef struct TY56891 TY56891;
typedef struct TY56893 TY56893;
typedef struct TY44019 TY44019;
typedef struct TY44013 TY44013;
typedef struct TY108002 TY108002;
typedef struct TY56544 TY56544;
typedef struct TY56552 TY56552;
typedef struct TY55011 TY55011;
typedef struct TY48538 TY48538;
typedef struct TY56540 TY56540;
typedef struct TY53008 TY53008;
typedef struct TY56520 TY56520;
typedef struct TY56550 TY56550;
struct TY56560 {
TY55005* Key;
TNimObject* Val;
};
struct TGenericSeq {
NI len;
NI space;
};
struct TY56564 {
NI Counter;
TY56562* Data;
};
struct TNimType {
NI size;
NU8 kind;
NU8 flags;
TNimType* base;
TNimNode* node;
void* finalizer;
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
typedef NIM_CHAR TY245[100000001];
struct NimStringDesc {
  TGenericSeq Sup;
TY245 data;
};
struct TNimObject {
TNimType* m_type;
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
struct TY44013 {
  TNimObject Sup;
TY44013* Prev;
TY44013* Next;
};
struct TY108002 {
  TY44013 Sup;
NU32 Options;
NU8 Defaultcc;
TY56544* Dynlib;
NU32 Notes;
};
struct TY55005 {
  TNimObject Sup;
NI Id;
};
struct TY48538 {
NI16 Line;
NI16 Col;
int Fileindex;
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
struct TY55011 {
  TY55005 Sup;
NimStringDesc* S;
TY55011* Next;
NI H;
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
typedef NI TY8814[8];
struct TY10810 {
TY10810* Next;
NI Key;
TY8814 Bits;
};
struct TY56891 {
TY56891* Next;
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
struct TY56562 {
  TGenericSeq Sup;
  TY56560 data[SEQ_DECL_SIZE];
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
struct TY56520 {
  TGenericSeq Sup;
  TY56526* data[SEQ_DECL_SIZE];
};
struct TY56550 {
  TGenericSeq Sup;
  TY56552* data[SEQ_DECL_SIZE];
};
N_NIMCALL(void*, newSeq)(TNimType* Typ_14404, NI Len_14405);
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
N_NIMCALL(void, Initidtable_56755)(TY56564* X_56758);
N_NIMCALL(void*, newObj)(TNimType* Typ_13910, NI Size_13911);
N_NIMCALL(void, objectInit)(void* Dest_19681, TNimType* Typ_19682);
N_NIMCALL(void, Initsymtab_61103)(TY61099* Tab_61106);
N_NIMCALL(void, Intsetinit_56919)(TY56895* S_56922);
N_NIMCALL(void, Initlinkedlist_44031)(TY44019* List_44034);
N_NIMCALL(void, Append_44035)(TY44019* List_44038, TY44013* Entry_44039);
N_NIMCALL(TY108002*, Newoptionentry_108056)(void);
static N_INLINE(void, asgnRefNoCycle)(void** Dest_13218, void* Src_13219);
N_NIMCALL(TY56526*, Newnode_56711)(NU8 Kind_56713);
N_NIMCALL(NimStringDesc*, copyString)(NimStringDesc* Src_18712);
N_NIMCALL(void, Initstrtable_56747)(TY56530* X_56750);
N_NIMCALL(void, Message_49198)(TY48538 Info_49200, NU8 Msg_49201, NimStringDesc* Arg_49202);
N_NIMCALL(TY56552*, Newtype_56707)(NU8 Kind_56709, TY56548* Owner_56710);
N_NIMCALL(TY56548*, Getcurrowner_108092)(void);
static N_INLINE(NI, Sonslen_56804)(TY56526* N_56806);
N_NIMCALL(void, Illformedast_108430)(TY56526* N_108432);
N_NIMCALL(void, Globalerror_49188)(TY48538 Info_49190, NU8 Msg_49191, NimStringDesc* Arg_49192);
N_NIMCALL(NimStringDesc*, Rendertree_86042)(TY56526* N_86044, NU8 Renderflags_86047);
N_NIMCALL(TGenericSeq*, incrSeq)(TGenericSeq* Seq_18842, NI Elemsize_18843);
N_NIMCALL(void, Localerror_49193)(TY48538 Info_49195, NU8 Msg_49196, NimStringDesc* Arg_49197);
N_NIMCALL(void, Internalerror_49212)(NimStringDesc* Errmsg_49214);
N_NIMCALL(TGenericSeq*, setLengthSeq)(TGenericSeq* Seq_19003, NI Elemsize_19004, NI Newlen_19005);
N_NIMCALL(TY56526*, Newnodei_56738)(NU8 Kind_56740, TY48538 Info_56741);
N_NIMCALL(void, Addson_56824)(TY56526* Father_56826, TY56526* Son_56827);
N_NIMCALL(TY56526*, Newintnode_56714)(NU8 Kind_56716, NI64 Intval_56717);
N_NIMCALL(TY56552*, Newtypes_108077)(NU8 Kind_108079, TY108012* C_108080);
N_NIMCALL(void, Addson_56828)(TY56552* Father_56830, TY56552* Son_56831);
N_NIMCALL(TY56552*, Getsystype_103008)(NU8 Kind_103010);
STRING_LITERAL(TMP198152, "", 0);
STRING_LITERAL(TMP198170, "owner is nil", 12);
STRING_LITERAL(TMP198172, "popOwner", 8);
STRING_LITERAL(TMP198180, "makeVarType", 11);
STRING_LITERAL(TMP198258, "makePtrType", 11);
TY56564 Ginsttypes_108045;
TY56528* Gowners_108116;
extern TNimType* NTI56528; /* TSymSeq */
extern TY11196 Gch_11214;
extern TNimType* NTI108010; /* PContext */
extern TNimType* NTI108012; /* TContext */
extern TNimType* NTI108004; /* POptionEntry */
extern TNimType* NTI108002; /* TOptionEntry */
extern NU32 Goptions_47082;
extern NU32 Gnotes_48564;
extern TNimType* NTI56546; /* PLib */
extern TNimType* NTI56544; /* TLib */
extern TNimType* NTI108008; /* PProcCon */
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
Result_11615 = ((TY10802*) ((NI64)((NU64)(((NI) (Usr_11614))) - (NU64)(((NI) (((NI)sizeof(TY10802))))))));
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
if (!((NU64)(LOC2) < (NU64)(8))) goto LA3;
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
N_NIMCALL(TY108002*, Newoptionentry_108056)(void) {
TY108002* Result_108204;
Result_108204 = 0;
Result_108204 = NIM_NIL;
Result_108204 = (TY108002*) newObj(NTI108004, sizeof(TY108002));
(*Result_108204).Sup.Sup.m_type = NTI108002;
(*Result_108204).Options = Goptions_47082;
(*Result_108204).Defaultcc = ((NU8) 0);
asgnRefNoCycle((void**) &(*Result_108204).Dynlib, NIM_NIL);
(*Result_108204).Notes = Gnotes_48564;
return Result_108204;
}
N_NIMCALL(TY108012*, Newcontext_108046)(TY56548* Module_108048, NimStringDesc* Nimfile_108049) {
TY108012* Result_108224;
TY108002* LOC1;
Result_108224 = 0;
Result_108224 = NIM_NIL;
Result_108224 = (TY108012*) newObj(NTI108010, sizeof(TY108012));
objectInit(Result_108224, NTI108012);
Initsymtab_61103(&(*Result_108224).Tab);
Intsetinit_56919(&(*Result_108224).Ambiguoussymbols);
Initlinkedlist_44031(&(*Result_108224).Optionstack);
Initlinkedlist_44031(&(*Result_108224).Libs);
LOC1 = 0;
LOC1 = Newoptionentry_108056();
Append_44035(&(*Result_108224).Optionstack, &LOC1->Sup);
asgnRef((void**) &(*Result_108224).Module, Module_108048);
asgnRefNoCycle((void**) &(*Result_108224).Generics, Newnode_56711(((NU8) 101)));
asgnRef((void**) &(*Result_108224).Converters, (TY56528*) newSeq(NTI56528, 0));
asgnRefNoCycle((void**) &(*Result_108224).Filename, copyString(Nimfile_108049));
Intsetinit_56919(&(*Result_108224).Includedfiles);
Initstrtable_56747(&(*Result_108224).Userpragmas);
return Result_108224;
}
N_NIMCALL(void, Markused_108403)(TY56526* N_108405, TY56548* S_108406) {
(*S_108406).Flags |=(1<<((NI32)(((NU8) 0))%(sizeof(NI32)*8)));
if (!(((*S_108406).Flags &(1<<((((NU8) 22))&31)))!=0)) goto LA2;
Message_49198((*N_108405).Info, ((NU8) 214), (*(*S_108406).Name).S);
LA2: ;
}
N_NIMCALL(TY56548*, Getcurrowner_108092)(void) {
TY56548* Result_108119;
Result_108119 = 0;
Result_108119 = NIM_NIL;
Result_108119 = Gowners_108116->data[(Gowners_108116->Sup.len-1)];
return Result_108119;
}
N_NIMCALL(TY56552*, Newtypes_108077)(NU8 Kind_108079, TY108012* C_108080) {
TY56552* Result_108389;
TY56548* LOC1;
Result_108389 = 0;
Result_108389 = NIM_NIL;
LOC1 = 0;
LOC1 = Getcurrowner_108092();
Result_108389 = Newtype_56707(Kind_108079, LOC1);
return Result_108389;
}
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
N_NIMCALL(void, Illformedast_108430)(TY56526* N_108432) {
NimStringDesc* LOC1;
LOC1 = 0;
LOC1 = Rendertree_86042(N_108432, 4);
Globalerror_49188((*N_108432).Info, ((NU8) 1), LOC1);
}
N_NIMCALL(void, Checksonslen_108434)(TY56526* N_108436, NI Length_108437) {
NI LOC2;
LOC2 = Sonslen_56804(N_108436);
if (!!((LOC2 == Length_108437))) goto LA3;
Illformedast_108430(N_108436);
LA3: ;
}
N_NIMCALL(void, Checkminsonslen_108440)(TY56526* N_108442, NI Length_108443) {
NI LOC2;
LOC2 = Sonslen_56804(N_108442);
if (!(LOC2 < Length_108443)) goto LA3;
Illformedast_108430(N_108442);
LA3: ;
}
N_NIMCALL(void, Pushowner_108094)(TY56548* Owner_108096) {
Gowners_108116 = (TY56528*) incrSeq(&(Gowners_108116)->Sup, sizeof(TY56548*));
asgnRef((void**) &Gowners_108116->data[Gowners_108116->Sup.len-1], Owner_108096);
}
N_NIMCALL(TY108002*, Lastoptionentry_108053)(TY108012* C_108055) {
TY108002* Result_108171;
Result_108171 = 0;
Result_108171 = NIM_NIL;
Result_108171 = ((TY108002*) ((*C_108055).Optionstack.Tail));
return Result_108171;
}
N_NIMCALL(TY56544*, Newlib_108062)(NU8 Kind_108064) {
TY56544* Result_108322;
Result_108322 = 0;
Result_108322 = NIM_NIL;
Result_108322 = (TY56544*) newObj(NTI56546, sizeof(TY56544));
(*Result_108322).Sup.Sup.m_type = NTI56544;
(*Result_108322).Kind = Kind_108064;
return Result_108322;
}
N_NIMCALL(void, Addtolib_108065)(TY56544* Lib_108067, TY56548* Sym_108068) {
if (!!(((*Sym_108068).Annex == NIM_NIL))) goto LA2;
Localerror_49193((*Sym_108068).Info, ((NU8) 26), ((NimStringDesc*) &TMP198152));
LA2: ;
asgnRefNoCycle((void**) &(*Sym_108068).Annex, Lib_108067);
}
N_NIMCALL(TY108006*, Newproccon_108050)(TY56548* Owner_108052) {
TY108006* Result_108175;
Result_108175 = 0;
Result_108175 = NIM_NIL;
if (!(Owner_108052 == NIM_NIL)) goto LA2;
Internalerror_49212(((NimStringDesc*) &TMP198170));
LA2: ;
Result_108175 = (TY108006*) newObj(NTI108008, sizeof(TY108006));
asgnRef((void**) &(*Result_108175).Owner, Owner_108052);
return Result_108175;
}
N_NIMCALL(void, Popowner_108097)(void) {
NI Length_108153;
Length_108153 = 0;
Length_108153 = Gowners_108116->Sup.len;
if (!(Length_108153 <= 0)) goto LA2;
Internalerror_49212(((NimStringDesc*) &TMP198172));
LA2: ;
Gowners_108116 = (TY56528*) setLengthSeq(&(Gowners_108116)->Sup, sizeof(TY56548*), (NI64)(Length_108153 - 1));
}
N_NIMCALL(TY56552*, Makerangetype_108086)(TY108012* C_108088, NI64 First_108089, NI64 Last_108090, TY48538 Info_108091) {
TY56552* Result_108401;
TY56526* N_108402;
TY56526* LOC1;
TY56526* LOC2;
TY56552* LOC3;
Result_108401 = 0;
N_108402 = 0;
Result_108401 = NIM_NIL;
N_108402 = NIM_NIL;
N_108402 = Newnodei_56738(((NU8) 35), Info_108091);
LOC1 = 0;
LOC1 = Newintnode_56714(((NU8) 6), First_108089);
Addson_56824(N_108402, LOC1);
LOC2 = 0;
LOC2 = Newintnode_56714(((NU8) 6), Last_108090);
Addson_56824(N_108402, LOC2);
Result_108401 = Newtypes_108077(((NU8) 20), C_108088);
asgnRefNoCycle((void**) &(*Result_108401).N, N_108402);
LOC3 = 0;
LOC3 = Getsystype_103008(((NU8) 31));
Addson_56828(Result_108401, LOC3);
return Result_108401;
}
N_NIMCALL(TY56552*, Makevartype_108073)(TY108012* C_108075, TY56552* Basetype_108076) {
TY56552* Result_108373;
Result_108373 = 0;
Result_108373 = NIM_NIL;
if (!(Basetype_108076 == NIM_NIL)) goto LA2;
Internalerror_49212(((NimStringDesc*) &TMP198180));
LA2: ;
Result_108373 = Newtypes_108077(((NU8) 23), C_108075);
Addson_56828(Result_108373, Basetype_108076);
return Result_108373;
}
N_NIMCALL(void, Addconverter_108058)(TY108012* C_108060, TY56548* Conv_108061) {
NI L_108277;
NI I_108301;
NI HEX3Atmp_108316;
NI Res_108318;
L_108277 = 0;
L_108277 = (*C_108060).Converters->Sup.len;
I_108301 = 0;
HEX3Atmp_108316 = 0;
HEX3Atmp_108316 = (NI64)(L_108277 - 1);
Res_108318 = 0;
Res_108318 = 0;
while (1) {
if (!(Res_108318 <= HEX3Atmp_108316)) goto LA1;
I_108301 = Res_108318;
if (!((*(*C_108060).Converters->data[I_108301]).Sup.Id == (*Conv_108061).Sup.Id)) goto LA3;
goto BeforeRet;
LA3: ;
Res_108318 += 1;
} LA1: ;
(*C_108060).Converters = (TY56528*) setLengthSeq(&((*C_108060).Converters)->Sup, sizeof(TY56548*), (NI64)(L_108277 + 1));
asgnRef((void**) &(*C_108060).Converters->data[L_108277], Conv_108061);
BeforeRet: ;
}
N_NIMCALL(TY56552*, Makeptrtype_108069)(TY108012* C_108071, TY56552* Basetype_108072) {
TY56552* Result_108357;
Result_108357 = 0;
Result_108357 = NIM_NIL;
if (!(Basetype_108072 == NIM_NIL)) goto LA2;
Internalerror_49212(((NimStringDesc*) &TMP198258));
LA2: ;
Result_108357 = Newtypes_108077(((NU8) 21), C_108071);
Addson_56828(Result_108357, Basetype_108072);
return Result_108357;
}
N_NOINLINE(void, semdataInit)(void) {
asgnRef((void**) &Gowners_108116, (TY56528*) newSeq(NTI56528, 0));
Initidtable_56755(&Ginsttypes_108045);
}

