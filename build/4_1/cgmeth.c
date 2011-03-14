/* Generated by Nimrod Compiler v0.8.11 */
/*   (c) 2011 Andreas Rumpf */

typedef long int NI;
typedef unsigned long int NU;
#include "nimbase.h"

typedef struct TY163157 TY163157;
typedef struct TY56528 TY56528;
typedef struct TY56548 TY56548;
typedef struct TGenericSeq TGenericSeq;
typedef struct TNimType TNimType;
typedef struct TNimNode TNimNode;
typedef struct TY10802 TY10802;
typedef struct TY10818 TY10818;
typedef struct TY11196 TY11196;
typedef struct TY10814 TY10814;
typedef struct TY10810 TY10810;
typedef struct TY11194 TY11194;
typedef struct TY56552 TY56552;
typedef struct TY55005 TY55005;
typedef struct TNimObject TNimObject;
typedef struct TY55011 TY55011;
typedef struct TY48538 TY48538;
typedef struct TY56530 TY56530;
typedef struct TY56526 TY56526;
typedef struct TY56540 TY56540;
typedef struct TY53008 TY53008;
typedef struct TY56544 TY56544;
typedef struct NimStringDesc NimStringDesc;
typedef struct TY56550 TY56550;
typedef struct TY56520 TY56520;
typedef struct TY56895 TY56895;
typedef struct TY56891 TY56891;
typedef struct TY56893 TY56893;
typedef struct TY44013 TY44013;
struct TGenericSeq {
NI len;
NI space;
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
struct TNimObject {
TNimType* m_type;
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
typedef NIM_CHAR TY245[100000001];
struct NimStringDesc {
  TGenericSeq Sup;
TY245 data;
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
typedef TY56548* TY163282[1];
struct TY56895 {
NI Counter;
NI Max;
TY56891* Head;
TY56893* Data;
};
typedef NI TY8814[16];
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
struct TY56891 {
TY56891* Next;
NI Key;
TY8814 Bits;
};
struct TY56528 {
  TGenericSeq Sup;
  TY56548* data[SEQ_DECL_SIZE];
};
struct TY163157 {
  TGenericSeq Sup;
  TY56528* data[SEQ_DECL_SIZE];
};
struct TY56550 {
  TGenericSeq Sup;
  TY56552* data[SEQ_DECL_SIZE];
};
struct TY56520 {
  TGenericSeq Sup;
  TY56526* data[SEQ_DECL_SIZE];
};
struct TY56893 {
  TGenericSeq Sup;
  TY56891* data[SEQ_DECL_SIZE];
};
N_NIMCALL(void*, newSeq)(TNimType* Typ_14404, NI Len_14405);
static N_INLINE(void, asgnRefNoCycle)(void** Dest_13218, void* Src_13219);
static N_INLINE(TY10802*, Usrtocell_11612)(void* Usr_11614);
static N_INLINE(NI, Atomicinc_3221)(NI* Memloc_3224, NI X_3225);
static N_INLINE(NI, Atomicdec_3226)(NI* Memloc_3229, NI X_3230);
static N_INLINE(void, Rtladdzct_12601)(TY10802* C_12603);
N_NOINLINE(void, Addzct_11601)(TY10818* S_11604, TY10802* C_11605);
N_NIMCALL(NIM_BOOL, Samemethodbucket_163159)(TY56548* A_163161, TY56548* B_163162);
static N_INLINE(NI, Sonslen_56807)(TY56552* N_56809);
N_NIMCALL(NIM_BOOL, Sametypeornil_98052)(TY56552* A_98054, TY56552* B_98055);
N_NIMCALL(TY56552*, Skiptypes_98087)(TY56552* T_98089, NU64 Kinds_98090);
N_NIMCALL(NIM_BOOL, Sametype_98048)(TY56552* X_98050, TY56552* Y_98051);
N_NIMCALL(NI, Inheritancediff_98121)(TY56552* A_98123, TY56552* B_98124);
N_NIMCALL(TGenericSeq*, incrSeq)(TGenericSeq* Seq_18842, NI Elemsize_18843);
static N_INLINE(void, asgnRef)(void** Dest_13214, void* Src_13215);
static N_INLINE(void, Incref_13202)(TY10802* C_13204);
static N_INLINE(NIM_BOOL, Canbecycleroot_11616)(TY10802* C_11618);
static N_INLINE(void, Rtladdcycleroot_12252)(TY10802* C_12254);
N_NOINLINE(void, Incl_11080)(TY10814* S_11083, TY10802* Cell_11084);
static N_INLINE(void, Decref_13001)(TY10802* C_13003);
N_NIMCALL(void, Addson_56824)(TY56526* Father_56826, TY56526* Son_56827);
static N_INLINE(TY56526*, Lastson_56810)(TY56526* N_56812);
static N_INLINE(NI, Sonslen_56804)(TY56526* N_56806);
N_NIMCALL(void, genericSeqAssign)(void* Dest_19657, void* Src_19658, TNimType* Mt_19659);
N_NIMCALL(TY56548*, Copysym_56776)(TY56548* S_56778, NIM_BOOL Keepid_56779);
N_NIMCALL(TY56552*, Copytype_56771)(TY56552* T_56773, TY56548* Owner_56774, NIM_BOOL Keepid_56775);
N_NIMCALL(TY56526*, Copytree_56852)(TY56526* Src_56854);
N_NIMCALL(TY56526*, Newsymnode_56735)(TY56548* Sym_56737);
N_NIMCALL(TY56526*, Genconv_163004)(TY56526* N_163006, TY56552* D_163007, NIM_BOOL Downcast_163008);
N_NIMCALL(void, Internalerror_49208)(TY48538 Info_49210, NimStringDesc* Errmsg_49211);
N_NIMCALL(TY56526*, Newnodeit_56742)(NU8 Kind_56744, TY48538 Info_56745, TY56552* Typ_56746);
N_NIMCALL(void, genericReset)(void* Dest_19728, TNimType* Mt_19729);
N_NIMCALL(TY56526*, Newnode_56711)(NU8 Kind_56713);
N_NIMCALL(void, Intsetinit_56919)(TY56895* S_56922);
N_NIMCALL(NIM_BOOL, Relevantcol_163385)(TY56528* Methods_163387, NI Col_163388);
N_NIMCALL(void, Intsetincl_56909)(TY56895* S_56912, NI Key_56913);
N_NIMCALL(void, Sortbucket_163435)(TY56528** A_163438, TY56895 Relevantcols_163439);
N_NIMCALL(NI, Cmpsignatures_163412)(TY56548* A_163414, TY56548* B_163415, TY56895 Relevantcols_163416);
N_NIMCALL(NIM_BOOL, Intsetcontains_56905)(TY56895 S_56907, NI Key_56908);
N_NIMCALL(TY56548*, Gendispatcher_163478)(TY56528* Methods_163480, TY56895 Relevantcols_163481);
N_NIMCALL(TY56526*, Newnodei_56738)(NU8 Kind_56740, TY48538 Info_56741);
N_NIMCALL(TY56548*, Getsyssym_103024)(NimStringDesc* Name_103026);
N_NIMCALL(TY56552*, Getsystype_103008)(NU8 Kind_103010);
STRING_LITERAL(TMP198275, "cgmeth.genConv", 14);
STRING_LITERAL(TMP198276, "cgmeth.genConv: no upcast allowed", 33);
STRING_LITERAL(TMP198277, "cgmeth.genConv: no downcast allowed", 35);
STRING_LITERAL(TMP198810, "and", 3);
STRING_LITERAL(TMP198811, "is", 2);
TY163157* Gmethods_163158;
extern TNimType* NTI163157; /* seq[TSymSeq] */
extern TY11196 Gch_11214;
extern TNimType* NTI56528; /* TSymSeq */
extern TY56526* Emptynode_56858;
extern TNimType* NTI56895; /* TIntSet */
static N_INLINE(TY10802*, Usrtocell_11612)(void* Usr_11614) {
TY10802* Result_11615;
Result_11615 = 0;
Result_11615 = ((TY10802*) ((NI32)((NU32)(((NI) (Usr_11614))) - (NU32)(((NI) (((NI)sizeof(TY10802))))))));
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
if (!((NU32)(LOC9) < (NU32)(8))) goto LA10;
Rtladdzct_12601(C_13222);
LA10: ;
LA6: ;
(*Dest_13218) = Src_13219;
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
N_NIMCALL(NIM_BOOL, Samemethodbucket_163159)(TY56548* A_163161, TY56548* B_163162) {
NIM_BOOL Result_163163;
TY56552* Aa_163164;
TY56552* Bb_163165;
NI LOC5;
NI LOC6;
NIM_BOOL LOC10;
NI I_163178;
NI HEX3Atmp_163224;
NI LOC13;
NI Res_163226;
NIM_BOOL LOC17;
NIM_BOOL LOC22;
NIM_BOOL LOC24;
NIM_BOOL LOC25;
NI LOC28;
Aa_163164 = 0;
Bb_163165 = 0;
Result_163163 = 0;
Aa_163164 = NIM_NIL;
Bb_163165 = NIM_NIL;
Result_163163 = NIM_FALSE;
if (!!(((*(*A_163161).Name).Sup.Id == (*(*B_163162).Name).Sup.Id))) goto LA2;
goto BeforeRet;
LA2: ;
LOC5 = Sonslen_56807((*A_163161).Typ);
LOC6 = Sonslen_56807((*B_163162).Typ);
if (!!((LOC5 == LOC6))) goto LA7;
goto BeforeRet;
LA7: ;
LOC10 = Sametypeornil_98052((*(*A_163161).Typ).Sons->data[0], (*(*B_163162).Typ).Sons->data[0]);
if (!!(LOC10)) goto LA11;
goto BeforeRet;
LA11: ;
I_163178 = 0;
HEX3Atmp_163224 = 0;
LOC13 = Sonslen_56807((*A_163161).Typ);
HEX3Atmp_163224 = (NI32)(LOC13 - 1);
Res_163226 = 0;
Res_163226 = 1;
while (1) {
if (!(Res_163226 <= HEX3Atmp_163224)) goto LA14;
I_163178 = Res_163226;
Aa_163164 = (*(*A_163161).Typ).Sons->data[I_163178];
Bb_163165 = (*(*B_163162).Typ).Sons->data[I_163178];
while (1) {
Aa_163164 = Skiptypes_98087(Aa_163164, 2048);
Bb_163165 = Skiptypes_98087(Bb_163165, 2048);
LOC17 = ((*Aa_163164).Kind == (*Bb_163165).Kind);
if (!(LOC17)) goto LA18;
LOC17 = ((*Aa_163164).Kind == ((NU8) 23) || (*Aa_163164).Kind == ((NU8) 21) || (*Aa_163164).Kind == ((NU8) 22));
LA18: ;
if (!LOC17) goto LA19;
Aa_163164 = (*Aa_163164).Sons->data[0];
Bb_163165 = (*Bb_163165).Sons->data[0];
goto LA16;
LA19: ;
goto LA15;
LA16: ;
} LA15: ;
LOC22 = Sametype_98048(Aa_163164, Bb_163165);
if (LOC22) goto LA23;
LOC25 = ((*Aa_163164).Kind == ((NU8) 17));
if (!(LOC25)) goto LA26;
LOC25 = ((*Bb_163165).Kind == ((NU8) 17));
LA26: ;
LOC24 = LOC25;
if (!(LOC24)) goto LA27;
LOC28 = Inheritancediff_98121(Bb_163165, Aa_163164);
LOC24 = (LOC28 < 0);
LA27: ;
LOC22 = LOC24;
LA23: ;
if (!LOC22) goto LA29;
goto LA21;
LA29: ;
goto BeforeRet;
LA21: ;
Res_163226 += 1;
} LA14: ;
Result_163163 = NIM_TRUE;
BeforeRet: ;
return Result_163163;
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
static N_INLINE(TY56526*, Lastson_56810)(TY56526* N_56812) {
TY56526* Result_58916;
NI LOC1;
Result_58916 = 0;
Result_58916 = NIM_NIL;
LOC1 = Sonslen_56804(N_56812);
Result_58916 = (*N_56812).KindU.S6.Sons->data[(NI32)(LOC1 - 1)];
return Result_58916;
}
N_NIMCALL(void, Methoddef_163227)(TY56548* S_163229) {
NI L_163230;
NI Q_163231;
TY56548* Disp_163232;
NI I_163251;
NI HEX3Atmp_163382;
NI Res_163384;
NIM_BOOL LOC3;
TY56526* LOC6;
TY56528* LOC7;
TY163282 LOC8;
TY56526* LOC15;
Disp_163232 = 0;
L_163230 = 0;
Q_163231 = 0;
Disp_163232 = NIM_NIL;
L_163230 = Gmethods_163158->Sup.len;
I_163251 = 0;
HEX3Atmp_163382 = 0;
HEX3Atmp_163382 = (NI32)(L_163230 - 1);
Res_163384 = 0;
Res_163384 = 0;
while (1) {
if (!(Res_163384 <= HEX3Atmp_163382)) goto LA1;
I_163251 = Res_163384;
LOC3 = Samemethodbucket_163159(Gmethods_163158->data[I_163251]->data[0], S_163229);
if (!LOC3) goto LA4;
Gmethods_163158->data[I_163251] = (TY56528*) incrSeq(&(Gmethods_163158->data[I_163251])->Sup, sizeof(TY56548*));
asgnRef((void**) &Gmethods_163158->data[I_163251]->data[Gmethods_163158->data[I_163251]->Sup.len-1], S_163229);
LOC6 = 0;
LOC6 = Lastson_56810((*Gmethods_163158->data[I_163251]->data[0]).Ast);
Addson_56824((*S_163229).Ast, LOC6);
goto BeforeRet;
LA4: ;
Res_163384 += 1;
} LA1: ;
LOC7 = 0;
LOC7 = (TY56528*) newSeq(NTI56528, 1);
memset((void*)&LOC8, 0, sizeof(LOC8));
LOC8[0] = S_163229;
asgnRef((void**) &LOC7->data[0], LOC8[0]);
Gmethods_163158 = (TY163157*) incrSeq(&(Gmethods_163158)->Sup, sizeof(TY56528*));
genericSeqAssign(&Gmethods_163158->data[Gmethods_163158->Sup.len-1], LOC7, NTI56528);
Disp_163232 = Copysym_56776(S_163229, NIM_FALSE);
asgnRef((void**) &(*Disp_163232).Typ, Copytype_56771((*Disp_163232).Typ, (*(*Disp_163232).Typ).Owner, NIM_FALSE));
if (!((*(*Disp_163232).Typ).Callconv == ((NU8) 5))) goto LA10;
(*(*Disp_163232).Typ).Callconv = ((NU8) 0);
LA10: ;
asgnRefNoCycle((void**) &(*Disp_163232).Ast, Copytree_56852((*S_163229).Ast));
asgnRefNoCycle((void**) &(*(*Disp_163232).Ast).KindU.S6.Sons->data[4], Emptynode_56858);
if (!!(((*(*S_163229).Typ).Sons->data[0] == NIM_NIL))) goto LA13;
asgnRef((void**) &(*(*(*Disp_163232).Ast).KindU.S6.Sons->data[5]).KindU.S4.Sym, Copysym_56776((*(*(*S_163229).Ast).KindU.S6.Sons->data[5]).KindU.S4.Sym, NIM_FALSE));
LA13: ;
LOC15 = 0;
LOC15 = Newsymnode_56735(Disp_163232);
Addson_56824((*S_163229).Ast, LOC15);
BeforeRet: ;
}
N_NIMCALL(TY56526*, Genconv_163004)(TY56526* N_163006, TY56552* D_163007, NIM_BOOL Downcast_163008) {
TY56526* Result_163009;
TY56552* Dest_163010;
TY56552* Source_163011;
NI Diff_163012;
NIM_BOOL LOC2;
Result_163009 = 0;
Dest_163010 = 0;
Source_163011 = 0;
Result_163009 = NIM_NIL;
Dest_163010 = NIM_NIL;
Source_163011 = NIM_NIL;
Diff_163012 = 0;
Dest_163010 = Skiptypes_98087(D_163007, 14723072);
Source_163011 = Skiptypes_98087((*N_163006).Typ, 14723072);
LOC2 = ((*Source_163011).Kind == ((NU8) 17));
if (!(LOC2)) goto LA3;
LOC2 = ((*Dest_163010).Kind == ((NU8) 17));
LA3: ;
if (!LOC2) goto LA4;
Diff_163012 = Inheritancediff_98121(Dest_163010, Source_163011);
if (!(Diff_163012 == 2147483647)) goto LA7;
Internalerror_49208((*N_163006).Info, ((NimStringDesc*) &TMP198275));
LA7: ;
if (!(Diff_163012 < 0)) goto LA10;
Result_163009 = Newnodeit_56742(((NU8) 56), (*N_163006).Info, D_163007);
Addson_56824(Result_163009, N_163006);
if (!Downcast_163008) goto LA13;
Internalerror_49208((*N_163006).Info, ((NimStringDesc*) &TMP198276));
LA13: ;
goto LA9;
LA10: ;
if (!(0 < Diff_163012)) goto LA15;
Result_163009 = Newnodeit_56742(((NU8) 55), (*N_163006).Info, D_163007);
Addson_56824(Result_163009, N_163006);
if (!!(Downcast_163008)) goto LA18;
Internalerror_49208((*N_163006).Info, ((NimStringDesc*) &TMP198277));
LA18: ;
goto LA9;
LA15: ;
Result_163009 = N_163006;
LA9: ;
goto LA1;
LA4: ;
Result_163009 = N_163006;
LA1: ;
return Result_163009;
}
N_NIMCALL(TY56526*, Methodcall_163041)(TY56526* N_163043) {
TY56526* Result_163044;
TY56548* Disp_163045;
TY56526* LOC1;
NI I_163129;
NI HEX3Atmp_163154;
NI LOC2;
NI Res_163156;
Result_163044 = 0;
Disp_163045 = 0;
Result_163044 = NIM_NIL;
Disp_163045 = NIM_NIL;
Result_163044 = N_163043;
LOC1 = 0;
LOC1 = Lastson_56810((*(*(*Result_163044).KindU.S6.Sons->data[0]).KindU.S4.Sym).Ast);
Disp_163045 = (*LOC1).KindU.S4.Sym;
asgnRef((void**) &(*(*Result_163044).KindU.S6.Sons->data[0]).KindU.S4.Sym, Disp_163045);
I_163129 = 0;
HEX3Atmp_163154 = 0;
LOC2 = Sonslen_56804(Result_163044);
HEX3Atmp_163154 = (NI32)(LOC2 - 1);
Res_163156 = 0;
Res_163156 = 1;
while (1) {
if (!(Res_163156 <= HEX3Atmp_163154)) goto LA3;
I_163129 = Res_163156;
asgnRefNoCycle((void**) &(*Result_163044).KindU.S6.Sons->data[I_163129], Genconv_163004((*Result_163044).KindU.S6.Sons->data[I_163129], (*(*Disp_163045).Typ).Sons->data[I_163129], NIM_TRUE));
Res_163156 += 1;
} LA3: ;
return Result_163044;
}
N_NIMCALL(NIM_BOOL, Relevantcol_163385)(TY56528* Methods_163387, NI Col_163388) {
NIM_BOOL Result_163389;
TY56552* T_163390;
TY56552* LOC2;
NI I_163408;
NI HEX3Atmp_163409;
NI Res_163411;
NIM_BOOL LOC7;
T_163390 = 0;
Result_163389 = 0;
T_163390 = NIM_NIL;
T_163390 = (*(*Methods_163387->data[0]).Typ).Sons->data[Col_163388];
Result_163389 = NIM_FALSE;
LOC2 = 0;
LOC2 = Skiptypes_98087(T_163390, 14682112);
if (!((*LOC2).Kind == ((NU8) 17))) goto LA3;
I_163408 = 0;
HEX3Atmp_163409 = 0;
HEX3Atmp_163409 = (Methods_163387->Sup.len-1);
Res_163411 = 0;
Res_163411 = 1;
while (1) {
if (!(Res_163411 <= HEX3Atmp_163409)) goto LA5;
I_163408 = Res_163411;
LOC7 = Sametype_98048((*(*Methods_163387->data[I_163408]).Typ).Sons->data[Col_163388], T_163390);
if (!!(LOC7)) goto LA8;
Result_163389 = NIM_TRUE;
goto BeforeRet;
LA8: ;
Res_163411 += 1;
} LA5: ;
LA3: ;
BeforeRet: ;
return Result_163389;
}
N_NIMCALL(NI, Cmpsignatures_163412)(TY56548* A_163414, TY56548* B_163415, TY56895 Relevantcols_163416) {
NI Result_163417;
NI D_163418;
TY56552* Aa_163419;
TY56552* Bb_163420;
NI Col_163429;
NI HEX3Atmp_163432;
NI LOC1;
NI Res_163434;
NIM_BOOL LOC4;
Aa_163419 = 0;
Bb_163420 = 0;
Result_163417 = 0;
D_163418 = 0;
Aa_163419 = NIM_NIL;
Bb_163420 = NIM_NIL;
Result_163417 = 0;
Col_163429 = 0;
HEX3Atmp_163432 = 0;
LOC1 = Sonslen_56807((*A_163414).Typ);
HEX3Atmp_163432 = (NI32)(LOC1 - 1);
Res_163434 = 0;
Res_163434 = 1;
while (1) {
if (!(Res_163434 <= HEX3Atmp_163432)) goto LA2;
Col_163429 = Res_163434;
LOC4 = Intsetcontains_56905(Relevantcols_163416, Col_163429);
if (!LOC4) goto LA5;
Aa_163419 = Skiptypes_98087((*(*A_163414).Typ).Sons->data[Col_163429], 14682112);
Bb_163420 = Skiptypes_98087((*(*B_163415).Typ).Sons->data[Col_163429], 14682112);
D_163418 = Inheritancediff_98121(Aa_163419, Bb_163420);
if (!!((D_163418 == 2147483647))) goto LA8;
Result_163417 = D_163418;
goto BeforeRet;
LA8: ;
LA5: ;
Res_163434 += 1;
} LA2: ;
BeforeRet: ;
return Result_163417;
}
N_NIMCALL(void, Sortbucket_163435)(TY56528** A_163438, TY56895 Relevantcols_163439) {
NI N_163440;
NI J_163441;
NI H_163442;
TY56548* V_163443;
NI I_163466;
NI HEX3Atmp_163475;
NI Res_163477;
NI LOC8;
V_163443 = 0;
N_163440 = 0;
J_163441 = 0;
H_163442 = 0;
V_163443 = NIM_NIL;
N_163440 = (*A_163438)->Sup.len;
H_163442 = 1;
while (1) {
H_163442 = (NI32)((NI32)(3 * H_163442) + 1);
if (!(N_163440 < H_163442)) goto LA3;
goto LA1;
LA3: ;
} LA1: ;
while (1) {
H_163442 = (NI32)(H_163442 / 3);
I_163466 = 0;
HEX3Atmp_163475 = 0;
HEX3Atmp_163475 = (NI32)(N_163440 - 1);
Res_163477 = 0;
Res_163477 = H_163442;
while (1) {
if (!(Res_163477 <= HEX3Atmp_163475)) goto LA6;
I_163466 = Res_163477;
V_163443 = (*A_163438)->data[I_163466];
J_163441 = I_163466;
while (1) {
LOC8 = Cmpsignatures_163412((*A_163438)->data[(NI32)(J_163441 - H_163442)], V_163443, Relevantcols_163439);
if (!(0 <= LOC8)) goto LA7;
asgnRef((void**) &(*A_163438)->data[J_163441], (*A_163438)->data[(NI32)(J_163441 - H_163442)]);
J_163441 = (NI32)(J_163441 - H_163442);
if (!(J_163441 < H_163442)) goto LA10;
goto LA7;
LA10: ;
} LA7: ;
asgnRef((void**) &(*A_163438)->data[J_163441], V_163443);
Res_163477 += 1;
} LA6: ;
if (!(H_163442 == 1)) goto LA13;
goto LA5;
LA13: ;
} LA5: ;
}
N_NIMCALL(TY56548*, Gendispatcher_163478)(TY56528* Methods_163480, TY56895 Relevantcols_163481) {
TY56548* Result_163482;
TY56526* Disp_163483;
TY56526* Cond_163484;
TY56526* Call_163485;
TY56526* Ret_163486;
TY56526* A_163487;
TY56526* Isn_163488;
TY56548* Base_163489;
TY56548* Curr_163490;
TY56548* Ands_163491;
TY56548* Iss_163492;
NI Paramlen_163493;
TY56526* LOC1;
NI Meth_163514;
NI HEX3Atmp_163645;
NI Res_163647;
NI Col_163523;
NI HEX3Atmp_163639;
NI Res_163641;
NIM_BOOL LOC5;
TY56552* LOC8;
TY56526* LOC9;
TY56526* LOC10;
TY56526* LOC11;
TY56552* LOC15;
TY56526* LOC16;
TY56526* LOC17;
NI Col_163567;
NI HEX3Atmp_163642;
NI Res_163644;
TY56526* LOC19;
TY56526* LOC20;
TY56526* LOC24;
Result_163482 = 0;
Disp_163483 = 0;
Cond_163484 = 0;
Call_163485 = 0;
Ret_163486 = 0;
A_163487 = 0;
Isn_163488 = 0;
Base_163489 = 0;
Curr_163490 = 0;
Ands_163491 = 0;
Iss_163492 = 0;
Result_163482 = NIM_NIL;
Disp_163483 = NIM_NIL;
Cond_163484 = NIM_NIL;
Call_163485 = NIM_NIL;
Ret_163486 = NIM_NIL;
A_163487 = NIM_NIL;
Isn_163488 = NIM_NIL;
Base_163489 = NIM_NIL;
Curr_163490 = NIM_NIL;
Ands_163491 = NIM_NIL;
Iss_163492 = NIM_NIL;
Paramlen_163493 = 0;
LOC1 = 0;
LOC1 = Lastson_56810((*Methods_163480->data[0]).Ast);
Base_163489 = (*LOC1).KindU.S4.Sym;
Result_163482 = Base_163489;
Paramlen_163493 = Sonslen_56807((*Base_163489).Typ);
Disp_163483 = Newnodei_56738(((NU8) 82), (*Base_163489).Info);
Ands_163491 = Getsyssym_103024(((NimStringDesc*) &TMP198810));
Iss_163492 = Getsyssym_103024(((NimStringDesc*) &TMP198811));
Meth_163514 = 0;
HEX3Atmp_163645 = 0;
HEX3Atmp_163645 = (Methods_163480->Sup.len-1);
Res_163647 = 0;
Res_163647 = 0;
while (1) {
if (!(Res_163647 <= HEX3Atmp_163645)) goto LA2;
Meth_163514 = Res_163647;
Curr_163490 = Methods_163480->data[Meth_163514];
Cond_163484 = NIM_NIL;
Col_163523 = 0;
HEX3Atmp_163639 = 0;
HEX3Atmp_163639 = (NI32)(Paramlen_163493 - 1);
Res_163641 = 0;
Res_163641 = 1;
while (1) {
if (!(Res_163641 <= HEX3Atmp_163639)) goto LA3;
Col_163523 = Res_163641;
LOC5 = Intsetcontains_56905(Relevantcols_163481, Col_163523);
if (!LOC5) goto LA6;
LOC8 = 0;
LOC8 = Getsystype_103008(((NU8) 1));
Isn_163488 = Newnodeit_56742(((NU8) 21), (*Base_163489).Info, LOC8);
LOC9 = 0;
LOC9 = Newsymnode_56735(Iss_163492);
Addson_56824(Isn_163488, LOC9);
LOC10 = 0;
LOC10 = Newsymnode_56735((*(*(*(*Base_163489).Typ).N).KindU.S6.Sons->data[Col_163523]).KindU.S4.Sym);
Addson_56824(Isn_163488, LOC10);
LOC11 = 0;
LOC11 = Newnodeit_56742(((NU8) 4), (*Base_163489).Info, (*(*Curr_163490).Typ).Sons->data[Col_163523]);
Addson_56824(Isn_163488, LOC11);
if (!!((Cond_163484 == NIM_NIL))) goto LA13;
LOC15 = 0;
LOC15 = Getsystype_103008(((NU8) 1));
A_163487 = Newnodeit_56742(((NU8) 21), (*Base_163489).Info, LOC15);
LOC16 = 0;
LOC16 = Newsymnode_56735(Ands_163491);
Addson_56824(A_163487, LOC16);
Addson_56824(A_163487, Cond_163484);
Addson_56824(A_163487, Isn_163488);
Cond_163484 = A_163487;
goto LA12;
LA13: ;
Cond_163484 = Isn_163488;
LA12: ;
LA6: ;
Res_163641 += 1;
} LA3: ;
Call_163485 = Newnodei_56738(((NU8) 21), (*Base_163489).Info);
LOC17 = 0;
LOC17 = Newsymnode_56735(Curr_163490);
Addson_56824(Call_163485, LOC17);
Col_163567 = 0;
HEX3Atmp_163642 = 0;
HEX3Atmp_163642 = (NI32)(Paramlen_163493 - 1);
Res_163644 = 0;
Res_163644 = 1;
while (1) {
if (!(Res_163644 <= HEX3Atmp_163642)) goto LA18;
Col_163567 = Res_163644;
LOC19 = 0;
LOC19 = Newsymnode_56735((*(*(*(*Base_163489).Typ).N).KindU.S6.Sons->data[Col_163567]).KindU.S4.Sym);
LOC20 = 0;
LOC20 = Genconv_163004(LOC19, (*(*Curr_163490).Typ).Sons->data[Col_163567], NIM_FALSE);
Addson_56824(Call_163485, LOC20);
Res_163644 += 1;
} LA18: ;
if (!!(((*(*Base_163489).Typ).Sons->data[0] == NIM_NIL))) goto LA22;
A_163487 = Newnodei_56738(((NU8) 63), (*Base_163489).Info);
LOC24 = 0;
LOC24 = Newsymnode_56735((*(*(*Base_163489).Ast).KindU.S6.Sons->data[5]).KindU.S4.Sym);
Addson_56824(A_163487, LOC24);
Addson_56824(A_163487, Call_163485);
Ret_163486 = Newnodei_56738(((NU8) 96), (*Base_163489).Info);
Addson_56824(Ret_163486, A_163487);
goto LA21;
LA22: ;
Ret_163486 = Call_163485;
LA21: ;
A_163487 = Newnodei_56738(((NU8) 76), (*Base_163489).Info);
Addson_56824(A_163487, Cond_163484);
Addson_56824(A_163487, Ret_163486);
Addson_56824(Disp_163483, A_163487);
Res_163647 += 1;
} LA2: ;
asgnRefNoCycle((void**) &(*(*Result_163482).Ast).KindU.S6.Sons->data[4], Disp_163483);
return Result_163482;
}
N_NIMCALL(TY56526*, Generatemethoddispatchers_163648)(void) {
TY56526* Result_163650;
TY56895 Relevantcols_163651;
NI Bucket_163670;
NI HEX3Atmp_163686;
NI Res_163688;
NI Col_163680;
NI HEX3Atmp_163683;
NI LOC2;
NI Res_163685;
NIM_BOOL LOC5;
TY56548* LOC8;
TY56526* LOC9;
Result_163650 = 0;
memset((void*)&Relevantcols_163651, 0, sizeof(Relevantcols_163651));
Result_163650 = NIM_NIL;
genericReset((void*)&Relevantcols_163651, NTI56895);
Result_163650 = Newnode_56711(((NU8) 101));
Bucket_163670 = 0;
HEX3Atmp_163686 = 0;
HEX3Atmp_163686 = (NI32)(Gmethods_163158->Sup.len - 1);
Res_163688 = 0;
Res_163688 = 0;
while (1) {
if (!(Res_163688 <= HEX3Atmp_163686)) goto LA1;
Bucket_163670 = Res_163688;
Intsetinit_56919(&Relevantcols_163651);
Col_163680 = 0;
HEX3Atmp_163683 = 0;
LOC2 = Sonslen_56807((*Gmethods_163158->data[Bucket_163670]->data[0]).Typ);
HEX3Atmp_163683 = (NI32)(LOC2 - 1);
Res_163685 = 0;
Res_163685 = 1;
while (1) {
if (!(Res_163685 <= HEX3Atmp_163683)) goto LA3;
Col_163680 = Res_163685;
LOC5 = Relevantcol_163385(Gmethods_163158->data[Bucket_163670], Col_163680);
if (!LOC5) goto LA6;
Intsetincl_56909(&Relevantcols_163651, Col_163680);
LA6: ;
Res_163685 += 1;
} LA3: ;
Sortbucket_163435(&Gmethods_163158->data[Bucket_163670], Relevantcols_163651);
LOC8 = 0;
LOC8 = Gendispatcher_163478(Gmethods_163158->data[Bucket_163670], Relevantcols_163651);
LOC9 = 0;
LOC9 = Newsymnode_56735(LOC8);
Addson_56824(Result_163650, LOC9);
Res_163688 += 1;
} LA1: ;
return Result_163650;
}
N_NOINLINE(void, cgmethInit)(void) {
asgnRefNoCycle((void**) &Gmethods_163158, (TY163157*) newSeq(NTI163157, 0));
}

