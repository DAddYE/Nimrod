/* Generated by Nimrod Compiler v0.8.11 */
/*   (c) 2011 Andreas Rumpf */

typedef long long int NI;
typedef unsigned long long int NU;
#include "nimbase.h"

typedef struct TY159157 TY159157;
typedef struct TY51528 TY51528;
typedef struct TY51548 TY51548;
typedef struct TGenericSeq TGenericSeq;
typedef struct TNimType TNimType;
typedef struct TNimNode TNimNode;
typedef struct TY10602 TY10602;
typedef struct TY10618 TY10618;
typedef struct TY10996 TY10996;
typedef struct TY10614 TY10614;
typedef struct TY10610 TY10610;
typedef struct TY10994 TY10994;
typedef struct TY51552 TY51552;
typedef struct TY50005 TY50005;
typedef struct TNimObject TNimObject;
typedef struct TY50011 TY50011;
typedef struct TY43538 TY43538;
typedef struct TY51530 TY51530;
typedef struct TY51526 TY51526;
typedef struct TY51540 TY51540;
typedef struct TY48008 TY48008;
typedef struct TY51544 TY51544;
typedef struct NimStringDesc NimStringDesc;
typedef struct TY51550 TY51550;
typedef struct TY51520 TY51520;
typedef struct TY51895 TY51895;
typedef struct TY51891 TY51891;
typedef struct TY51893 TY51893;
typedef struct TY39013 TY39013;
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
struct TY10602 {
NI Refcount;
TNimType* Typ;
};
struct TY10618 {
NI Len;
NI Cap;
TY10602** D;
};
struct TY10614 {
NI Counter;
NI Max;
TY10610* Head;
TY10610** Data;
};
struct TY10994 {
NI Stackscans;
NI Cyclecollections;
NI Maxthreshold;
NI Maxstacksize;
NI Maxstackcells;
NI Cycletablesize;
};
struct TY10996 {
TY10618 Zct;
TY10618 Decstack;
TY10614 Cycleroots;
TY10618 Tempstack;
TY10994 Stat;
};
struct TNimObject {
TNimType* m_type;
};
struct TY50005 {
  TNimObject Sup;
NI Id;
};
struct TY43538 {
NI16 Line;
NI16 Col;
NI32 Fileindex;
};
struct TY51530 {
TNimType* m_type;
NI Counter;
TY51528* Data;
};
struct TY51540 {
NU8 K;
NU8 S;
NU8 Flags;
TY51552* T;
TY48008* R;
NI A;
};
struct TY51548 {
  TY50005 Sup;
NU8 Kind;
NU8 Magic;
TY51552* Typ;
TY50011* Name;
TY43538 Info;
TY51548* Owner;
NU32 Flags;
TY51530 Tab;
TY51526* Ast;
NU32 Options;
NI Position;
NI Offset;
TY51540 Loc;
TY51544* Annex;
};
typedef NIM_CHAR TY245[100000001];
struct NimStringDesc {
  TGenericSeq Sup;
TY245 data;
};
struct TY50011 {
  TY50005 Sup;
NimStringDesc* S;
TY50011* Next;
NI H;
};
struct TY51552 {
  TY50005 Sup;
NU8 Kind;
TY51550* Sons;
TY51526* N;
NU8 Flags;
NU8 Callconv;
TY51548* Owner;
TY51548* Sym;
NI64 Size;
NI Align;
NI Containerid;
TY51540 Loc;
};
struct TY51526 {
TY51552* Typ;
NimStringDesc* Comment;
TY43538 Info;
NU8 Flags;
NU8 Kind;
union {
struct {NI64 Intval;
} S1;
struct {NF64 Floatval;
} S2;
struct {NimStringDesc* Strval;
} S3;
struct {TY51548* Sym;
} S4;
struct {TY50011* Ident;
} S5;
struct {TY51520* Sons;
} S6;
} KindU;
};
typedef TY51548* TY159282[1];
struct TY51895 {
NI Counter;
NI Max;
TY51891* Head;
TY51893* Data;
};
typedef NI TY8614[8];
struct TY10610 {
TY10610* Next;
NI Key;
TY8614 Bits;
};
struct TY48008 {
  TNimObject Sup;
TY48008* Left;
TY48008* Right;
NI Length;
NimStringDesc* Data;
};
struct TY39013 {
  TNimObject Sup;
TY39013* Prev;
TY39013* Next;
};
struct TY51544 {
  TY39013 Sup;
NU8 Kind;
NIM_BOOL Generated;
TY48008* Name;
TY51526* Path;
};
struct TY51891 {
TY51891* Next;
NI Key;
TY8614 Bits;
};
struct TY51528 {
  TGenericSeq Sup;
  TY51548* data[SEQ_DECL_SIZE];
};
struct TY159157 {
  TGenericSeq Sup;
  TY51528* data[SEQ_DECL_SIZE];
};
struct TY51550 {
  TGenericSeq Sup;
  TY51552* data[SEQ_DECL_SIZE];
};
struct TY51520 {
  TGenericSeq Sup;
  TY51526* data[SEQ_DECL_SIZE];
};
struct TY51893 {
  TGenericSeq Sup;
  TY51891* data[SEQ_DECL_SIZE];
};
N_NIMCALL(void*, newSeq)(TNimType* Typ_14204, NI Len_14205);
static N_INLINE(void, asgnRefNoCycle)(void** Dest_13018, void* Src_13019);
static N_INLINE(TY10602*, Usrtocell_11412)(void* Usr_11414);
static N_INLINE(NI, Atomicinc_3221)(NI* Memloc_3224, NI X_3225);
static N_INLINE(NI, Atomicdec_3226)(NI* Memloc_3229, NI X_3230);
static N_INLINE(void, Rtladdzct_12401)(TY10602* C_12403);
N_NOINLINE(void, Addzct_11401)(TY10618* S_11404, TY10602* C_11405);
N_NIMCALL(NIM_BOOL, Samemethodbucket_159159)(TY51548* A_159161, TY51548* B_159162);
static N_INLINE(NI, Sonslen_51807)(TY51552* N_51809);
N_NIMCALL(NIM_BOOL, Sametypeornil_94052)(TY51552* A_94054, TY51552* B_94055);
N_NIMCALL(TY51552*, Skiptypes_94087)(TY51552* T_94089, NU64 Kinds_94090);
N_NIMCALL(NIM_BOOL, Sametype_94048)(TY51552* X_94050, TY51552* Y_94051);
N_NIMCALL(NI, Inheritancediff_94121)(TY51552* A_94123, TY51552* B_94124);
N_NIMCALL(TGenericSeq*, incrSeq)(TGenericSeq* Seq_18642, NI Elemsize_18643);
static N_INLINE(void, asgnRef)(void** Dest_13014, void* Src_13015);
static N_INLINE(void, Incref_13002)(TY10602* C_13004);
static N_INLINE(NIM_BOOL, Canbecycleroot_11416)(TY10602* C_11418);
static N_INLINE(void, Rtladdcycleroot_12052)(TY10602* C_12054);
N_NOINLINE(void, Incl_10880)(TY10614* S_10883, TY10602* Cell_10884);
static N_INLINE(void, Decref_12801)(TY10602* C_12803);
N_NIMCALL(void, Addson_51824)(TY51526* Father_51826, TY51526* Son_51827);
static N_INLINE(TY51526*, Lastson_51810)(TY51526* N_51812);
static N_INLINE(NI, Sonslen_51804)(TY51526* N_51806);
N_NIMCALL(void, genericSeqAssign)(void* Dest_19457, void* Src_19458, TNimType* Mt_19459);
N_NIMCALL(TY51548*, Copysym_51776)(TY51548* S_51778, NIM_BOOL Keepid_51779);
N_NIMCALL(TY51552*, Copytype_51771)(TY51552* T_51773, TY51548* Owner_51774, NIM_BOOL Keepid_51775);
N_NIMCALL(TY51526*, Copytree_51852)(TY51526* Src_51854);
N_NIMCALL(TY51526*, Newsymnode_51735)(TY51548* Sym_51737);
N_NIMCALL(TY51526*, Genconv_159004)(TY51526* N_159006, TY51552* D_159007, NIM_BOOL Downcast_159008);
N_NIMCALL(void, Internalerror_44208)(TY43538 Info_44210, NimStringDesc* Errmsg_44211);
N_NIMCALL(TY51526*, Newnodeit_51742)(NU8 Kind_51744, TY43538 Info_51745, TY51552* Typ_51746);
N_NIMCALL(void, genericReset)(void* Dest_19528, TNimType* Mt_19529);
N_NIMCALL(TY51526*, Newnode_51711)(NU8 Kind_51713);
N_NIMCALL(void, Intsetinit_51919)(TY51895* S_51922);
N_NIMCALL(NIM_BOOL, Relevantcol_159385)(TY51528* Methods_159387, NI Col_159388);
N_NIMCALL(void, Intsetincl_51909)(TY51895* S_51912, NI Key_51913);
N_NIMCALL(void, Sortbucket_159435)(TY51528** A_159438, TY51895* Relevantcols_159439);
N_NIMCALL(NI, Cmpsignatures_159412)(TY51548* A_159414, TY51548* B_159415, TY51895* Relevantcols_159416);
N_NIMCALL(NIM_BOOL, Intsetcontains_51905)(TY51895* S_51907, NI Key_51908);
N_NIMCALL(TY51548*, Gendispatcher_159478)(TY51528* Methods_159480, TY51895* Relevantcols_159481);
N_NIMCALL(TY51526*, Newnodei_51738)(NU8 Kind_51740, TY43538 Info_51741);
N_NIMCALL(TY51548*, Getsyssym_99024)(NimStringDesc* Name_99026);
N_NIMCALL(TY51552*, Getsystype_99008)(NU8 Kind_99010);
STRING_LITERAL(TMP194279, "cgmeth.genConv", 14);
STRING_LITERAL(TMP194280, "cgmeth.genConv: no upcast allowed", 33);
STRING_LITERAL(TMP194281, "cgmeth.genConv: no downcast allowed", 35);
STRING_LITERAL(TMP194814, "and", 3);
STRING_LITERAL(TMP194815, "is", 2);
TY159157* Gmethods_159158;
extern TNimType* NTI159157; /* seq[TSymSeq] */
extern TY10996 Gch_11014;
extern TNimType* NTI51528; /* TSymSeq */
extern TY51526* Emptynode_51858;
extern TNimType* NTI51895; /* TIntSet */
static N_INLINE(TY10602*, Usrtocell_11412)(void* Usr_11414) {
TY10602* Result_11415;
Result_11415 = 0;
Result_11415 = ((TY10602*) ((NI64)((NU64)(((NI) (Usr_11414))) - (NU64)(((NI) (((NI)sizeof(TY10602))))))));
return Result_11415;
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
static N_INLINE(void, Rtladdzct_12401)(TY10602* C_12403) {
Addzct_11401(&Gch_11014.Zct, C_12403);
}
static N_INLINE(void, asgnRefNoCycle)(void** Dest_13018, void* Src_13019) {
TY10602* C_13020;
NI LOC4;
TY10602* C_13022;
NI LOC9;
if (!!((Src_13019 == NIM_NIL))) goto LA2;
C_13020 = 0;
C_13020 = Usrtocell_11412(Src_13019);
LOC4 = Atomicinc_3221(&(*C_13020).Refcount, 8);
LA2: ;
if (!!(((*Dest_13018) == NIM_NIL))) goto LA6;
C_13022 = 0;
C_13022 = Usrtocell_11412((*Dest_13018));
LOC9 = Atomicdec_3226(&(*C_13022).Refcount, 8);
if (!((NU64)(LOC9) < (NU64)(8))) goto LA10;
Rtladdzct_12401(C_13022);
LA10: ;
LA6: ;
(*Dest_13018) = Src_13019;
}
static N_INLINE(NI, Sonslen_51807)(TY51552* N_51809) {
NI Result_52761;
Result_52761 = 0;
if (!(*N_51809).Sons == 0) goto LA2;
Result_52761 = 0;
goto LA1;
LA2: ;
Result_52761 = (*N_51809).Sons->Sup.len;
LA1: ;
return Result_52761;
}
N_NIMCALL(NIM_BOOL, Samemethodbucket_159159)(TY51548* A_159161, TY51548* B_159162) {
NIM_BOOL Result_159163;
TY51552* Aa_159164;
TY51552* Bb_159165;
NI LOC5;
NI LOC6;
NIM_BOOL LOC10;
NI I_159178;
NI HEX3Atmp_159224;
NI LOC13;
NI Res_159226;
NIM_BOOL LOC17;
NIM_BOOL LOC22;
NIM_BOOL LOC24;
NIM_BOOL LOC25;
NI LOC28;
Aa_159164 = 0;
Bb_159165 = 0;
Result_159163 = 0;
Aa_159164 = NIM_NIL;
Bb_159165 = NIM_NIL;
Result_159163 = NIM_FALSE;
if (!!(((*(*A_159161).Name).Sup.Id == (*(*B_159162).Name).Sup.Id))) goto LA2;
goto BeforeRet;
LA2: ;
LOC5 = Sonslen_51807((*A_159161).Typ);
LOC6 = Sonslen_51807((*B_159162).Typ);
if (!!((LOC5 == LOC6))) goto LA7;
goto BeforeRet;
LA7: ;
LOC10 = Sametypeornil_94052((*(*A_159161).Typ).Sons->data[0], (*(*B_159162).Typ).Sons->data[0]);
if (!!(LOC10)) goto LA11;
goto BeforeRet;
LA11: ;
I_159178 = 0;
HEX3Atmp_159224 = 0;
LOC13 = Sonslen_51807((*A_159161).Typ);
HEX3Atmp_159224 = (NI64)(LOC13 - 1);
Res_159226 = 0;
Res_159226 = 1;
while (1) {
if (!(Res_159226 <= HEX3Atmp_159224)) goto LA14;
I_159178 = Res_159226;
Aa_159164 = (*(*A_159161).Typ).Sons->data[I_159178];
Bb_159165 = (*(*B_159162).Typ).Sons->data[I_159178];
while (1) {
Aa_159164 = Skiptypes_94087(Aa_159164, 2048);
Bb_159165 = Skiptypes_94087(Bb_159165, 2048);
LOC17 = ((*Aa_159164).Kind == (*Bb_159165).Kind);
if (!(LOC17)) goto LA18;
LOC17 = ((14680064 &(IL64(1)<<(((*Aa_159164).Kind)&IL64(63))))!=0);
LA18: ;
if (!LOC17) goto LA19;
Aa_159164 = (*Aa_159164).Sons->data[0];
Bb_159165 = (*Bb_159165).Sons->data[0];
goto LA16;
LA19: ;
goto LA15;
LA16: ;
} LA15: ;
LOC22 = Sametype_94048(Aa_159164, Bb_159165);
if (LOC22) goto LA23;
LOC25 = ((*Aa_159164).Kind == ((NU8) 17));
if (!(LOC25)) goto LA26;
LOC25 = ((*Bb_159165).Kind == ((NU8) 17));
LA26: ;
LOC24 = LOC25;
if (!(LOC24)) goto LA27;
LOC28 = Inheritancediff_94121(Bb_159165, Aa_159164);
LOC24 = (LOC28 < 0);
LA27: ;
LOC22 = LOC24;
LA23: ;
if (!LOC22) goto LA29;
goto LA21;
LA29: ;
goto BeforeRet;
LA21: ;
Res_159226 += 1;
} LA14: ;
Result_159163 = NIM_TRUE;
BeforeRet: ;
return Result_159163;
}
static N_INLINE(NIM_BOOL, Canbecycleroot_11416)(TY10602* C_11418) {
NIM_BOOL Result_11419;
Result_11419 = 0;
Result_11419 = !((((*(*C_11418).Typ).flags &(1<<((((NU8) 1))&7)))!=0));
return Result_11419;
}
static N_INLINE(void, Rtladdcycleroot_12052)(TY10602* C_12054) {
Incl_10880(&Gch_11014.Cycleroots, C_12054);
}
static N_INLINE(void, Incref_13002)(TY10602* C_13004) {
NI LOC1;
NIM_BOOL LOC3;
LOC1 = Atomicinc_3221(&(*C_13004).Refcount, 8);
LOC3 = Canbecycleroot_11416(C_13004);
if (!LOC3) goto LA4;
Rtladdcycleroot_12052(C_13004);
LA4: ;
}
static N_INLINE(void, Decref_12801)(TY10602* C_12803) {
NI LOC2;
NIM_BOOL LOC5;
LOC2 = Atomicdec_3226(&(*C_12803).Refcount, 8);
if (!((NU64)(LOC2) < (NU64)(8))) goto LA3;
Rtladdzct_12401(C_12803);
goto LA1;
LA3: ;
LOC5 = Canbecycleroot_11416(C_12803);
if (!LOC5) goto LA6;
Rtladdcycleroot_12052(C_12803);
goto LA1;
LA6: ;
LA1: ;
}
static N_INLINE(void, asgnRef)(void** Dest_13014, void* Src_13015) {
TY10602* LOC4;
TY10602* LOC8;
if (!!((Src_13015 == NIM_NIL))) goto LA2;
LOC4 = Usrtocell_11412(Src_13015);
Incref_13002(LOC4);
LA2: ;
if (!!(((*Dest_13014) == NIM_NIL))) goto LA6;
LOC8 = Usrtocell_11412((*Dest_13014));
Decref_12801(LOC8);
LA6: ;
(*Dest_13014) = Src_13015;
}
static N_INLINE(NI, Sonslen_51804)(TY51526* N_51806) {
NI Result_52897;
Result_52897 = 0;
if (!(*N_51806).KindU.S6.Sons == 0) goto LA2;
Result_52897 = 0;
goto LA1;
LA2: ;
Result_52897 = (*N_51806).KindU.S6.Sons->Sup.len;
LA1: ;
return Result_52897;
}
static N_INLINE(TY51526*, Lastson_51810)(TY51526* N_51812) {
TY51526* Result_53916;
NI LOC1;
Result_53916 = 0;
Result_53916 = NIM_NIL;
LOC1 = Sonslen_51804(N_51812);
Result_53916 = (*N_51812).KindU.S6.Sons->data[(NI64)(LOC1 - 1)];
return Result_53916;
}
N_NIMCALL(void, Methoddef_159227)(TY51548* S_159229) {
NI L_159230;
NI Q_159231;
TY51548* Disp_159232;
NI I_159251;
NI HEX3Atmp_159382;
NI Res_159384;
NIM_BOOL LOC3;
TY51526* LOC6;
TY51528* LOC7;
TY159282 LOC8;
TY51526* LOC15;
Disp_159232 = 0;
L_159230 = 0;
Q_159231 = 0;
Disp_159232 = NIM_NIL;
L_159230 = Gmethods_159158->Sup.len;
I_159251 = 0;
HEX3Atmp_159382 = 0;
HEX3Atmp_159382 = (NI64)(L_159230 - 1);
Res_159384 = 0;
Res_159384 = 0;
while (1) {
if (!(Res_159384 <= HEX3Atmp_159382)) goto LA1;
I_159251 = Res_159384;
LOC3 = Samemethodbucket_159159(Gmethods_159158->data[I_159251]->data[0], S_159229);
if (!LOC3) goto LA4;
Gmethods_159158->data[I_159251] = (TY51528*) incrSeq(&(Gmethods_159158->data[I_159251])->Sup, sizeof(TY51548*));
asgnRef((void**) &Gmethods_159158->data[I_159251]->data[Gmethods_159158->data[I_159251]->Sup.len-1], S_159229);
LOC6 = 0;
LOC6 = Lastson_51810((*Gmethods_159158->data[I_159251]->data[0]).Ast);
Addson_51824((*S_159229).Ast, LOC6);
goto BeforeRet;
LA4: ;
Res_159384 += 1;
} LA1: ;
LOC7 = 0;
LOC7 = (TY51528*) newSeq(NTI51528, 1);
memset((void*)&LOC8, 0, sizeof(LOC8));
LOC8[0] = S_159229;
asgnRef((void**) &LOC7->data[0], LOC8[0]);
Gmethods_159158 = (TY159157*) incrSeq(&(Gmethods_159158)->Sup, sizeof(TY51528*));
genericSeqAssign(&Gmethods_159158->data[Gmethods_159158->Sup.len-1], LOC7, NTI51528);
Disp_159232 = Copysym_51776(S_159229, NIM_FALSE);
asgnRef((void**) &(*Disp_159232).Typ, Copytype_51771((*Disp_159232).Typ, (*(*Disp_159232).Typ).Owner, NIM_FALSE));
if (!((*(*Disp_159232).Typ).Callconv == ((NU8) 5))) goto LA10;
(*(*Disp_159232).Typ).Callconv = ((NU8) 0);
LA10: ;
asgnRefNoCycle((void**) &(*Disp_159232).Ast, Copytree_51852((*S_159229).Ast));
asgnRefNoCycle((void**) &(*(*Disp_159232).Ast).KindU.S6.Sons->data[4], Emptynode_51858);
if (!!(((*(*S_159229).Typ).Sons->data[0] == NIM_NIL))) goto LA13;
asgnRef((void**) &(*(*(*Disp_159232).Ast).KindU.S6.Sons->data[5]).KindU.S4.Sym, Copysym_51776((*(*(*S_159229).Ast).KindU.S6.Sons->data[5]).KindU.S4.Sym, NIM_FALSE));
LA13: ;
LOC15 = 0;
LOC15 = Newsymnode_51735(Disp_159232);
Addson_51824((*S_159229).Ast, LOC15);
BeforeRet: ;
}
N_NIMCALL(TY51526*, Genconv_159004)(TY51526* N_159006, TY51552* D_159007, NIM_BOOL Downcast_159008) {
TY51526* Result_159009;
TY51552* Dest_159010;
TY51552* Source_159011;
NI Diff_159012;
NIM_BOOL LOC2;
Result_159009 = 0;
Dest_159010 = 0;
Source_159011 = 0;
Result_159009 = NIM_NIL;
Dest_159010 = NIM_NIL;
Source_159011 = NIM_NIL;
Diff_159012 = 0;
Dest_159010 = Skiptypes_94087(D_159007, 14723072);
Source_159011 = Skiptypes_94087((*N_159006).Typ, 14723072);
LOC2 = ((*Source_159011).Kind == ((NU8) 17));
if (!(LOC2)) goto LA3;
LOC2 = ((*Dest_159010).Kind == ((NU8) 17));
LA3: ;
if (!LOC2) goto LA4;
Diff_159012 = Inheritancediff_94121(Dest_159010, Source_159011);
if (!(Diff_159012 == IL64(9223372036854775807))) goto LA7;
Internalerror_44208((*N_159006).Info, ((NimStringDesc*) &TMP194279));
LA7: ;
if (!(Diff_159012 < 0)) goto LA10;
Result_159009 = Newnodeit_51742(((NU8) 56), (*N_159006).Info, D_159007);
Addson_51824(Result_159009, N_159006);
if (!Downcast_159008) goto LA13;
Internalerror_44208((*N_159006).Info, ((NimStringDesc*) &TMP194280));
LA13: ;
goto LA9;
LA10: ;
if (!(0 < Diff_159012)) goto LA15;
Result_159009 = Newnodeit_51742(((NU8) 55), (*N_159006).Info, D_159007);
Addson_51824(Result_159009, N_159006);
if (!!(Downcast_159008)) goto LA18;
Internalerror_44208((*N_159006).Info, ((NimStringDesc*) &TMP194281));
LA18: ;
goto LA9;
LA15: ;
Result_159009 = N_159006;
LA9: ;
goto LA1;
LA4: ;
Result_159009 = N_159006;
LA1: ;
return Result_159009;
}
N_NIMCALL(TY51526*, Methodcall_159041)(TY51526* N_159043) {
TY51526* Result_159044;
TY51548* Disp_159045;
TY51526* LOC1;
NI I_159129;
NI HEX3Atmp_159154;
NI LOC2;
NI Res_159156;
Result_159044 = 0;
Disp_159045 = 0;
Result_159044 = NIM_NIL;
Disp_159045 = NIM_NIL;
Result_159044 = N_159043;
LOC1 = 0;
LOC1 = Lastson_51810((*(*(*Result_159044).KindU.S6.Sons->data[0]).KindU.S4.Sym).Ast);
Disp_159045 = (*LOC1).KindU.S4.Sym;
asgnRef((void**) &(*(*Result_159044).KindU.S6.Sons->data[0]).KindU.S4.Sym, Disp_159045);
I_159129 = 0;
HEX3Atmp_159154 = 0;
LOC2 = Sonslen_51804(Result_159044);
HEX3Atmp_159154 = (NI64)(LOC2 - 1);
Res_159156 = 0;
Res_159156 = 1;
while (1) {
if (!(Res_159156 <= HEX3Atmp_159154)) goto LA3;
I_159129 = Res_159156;
asgnRefNoCycle((void**) &(*Result_159044).KindU.S6.Sons->data[I_159129], Genconv_159004((*Result_159044).KindU.S6.Sons->data[I_159129], (*(*Disp_159045).Typ).Sons->data[I_159129], NIM_TRUE));
Res_159156 += 1;
} LA3: ;
return Result_159044;
}
N_NIMCALL(NIM_BOOL, Relevantcol_159385)(TY51528* Methods_159387, NI Col_159388) {
NIM_BOOL Result_159389;
TY51552* T_159390;
TY51552* LOC2;
NI I_159408;
NI HEX3Atmp_159409;
NI Res_159411;
NIM_BOOL LOC7;
T_159390 = 0;
Result_159389 = 0;
T_159390 = NIM_NIL;
T_159390 = (*(*Methods_159387->data[0]).Typ).Sons->data[Col_159388];
Result_159389 = NIM_FALSE;
LOC2 = 0;
LOC2 = Skiptypes_94087(T_159390, 14682112);
if (!((*LOC2).Kind == ((NU8) 17))) goto LA3;
I_159408 = 0;
HEX3Atmp_159409 = 0;
HEX3Atmp_159409 = (Methods_159387->Sup.len-1);
Res_159411 = 0;
Res_159411 = 1;
while (1) {
if (!(Res_159411 <= HEX3Atmp_159409)) goto LA5;
I_159408 = Res_159411;
LOC7 = Sametype_94048((*(*Methods_159387->data[I_159408]).Typ).Sons->data[Col_159388], T_159390);
if (!!(LOC7)) goto LA8;
Result_159389 = NIM_TRUE;
goto BeforeRet;
LA8: ;
Res_159411 += 1;
} LA5: ;
LA3: ;
BeforeRet: ;
return Result_159389;
}
N_NIMCALL(NI, Cmpsignatures_159412)(TY51548* A_159414, TY51548* B_159415, TY51895* Relevantcols_159416) {
NI Result_159417;
NI D_159418;
TY51552* Aa_159419;
TY51552* Bb_159420;
NI Col_159429;
NI HEX3Atmp_159432;
NI LOC1;
NI Res_159434;
NIM_BOOL LOC4;
Aa_159419 = 0;
Bb_159420 = 0;
Result_159417 = 0;
D_159418 = 0;
Aa_159419 = NIM_NIL;
Bb_159420 = NIM_NIL;
Result_159417 = 0;
Col_159429 = 0;
HEX3Atmp_159432 = 0;
LOC1 = Sonslen_51807((*A_159414).Typ);
HEX3Atmp_159432 = (NI64)(LOC1 - 1);
Res_159434 = 0;
Res_159434 = 1;
while (1) {
if (!(Res_159434 <= HEX3Atmp_159432)) goto LA2;
Col_159429 = Res_159434;
LOC4 = Intsetcontains_51905(Relevantcols_159416, Col_159429);
if (!LOC4) goto LA5;
Aa_159419 = Skiptypes_94087((*(*A_159414).Typ).Sons->data[Col_159429], 14682112);
Bb_159420 = Skiptypes_94087((*(*B_159415).Typ).Sons->data[Col_159429], 14682112);
D_159418 = Inheritancediff_94121(Aa_159419, Bb_159420);
if (!!((D_159418 == IL64(9223372036854775807)))) goto LA8;
Result_159417 = D_159418;
goto BeforeRet;
LA8: ;
LA5: ;
Res_159434 += 1;
} LA2: ;
BeforeRet: ;
return Result_159417;
}
N_NIMCALL(void, Sortbucket_159435)(TY51528** A_159438, TY51895* Relevantcols_159439) {
NI N_159440;
NI J_159441;
NI H_159442;
TY51548* V_159443;
NI I_159466;
NI HEX3Atmp_159475;
NI Res_159477;
NI LOC8;
V_159443 = 0;
N_159440 = 0;
J_159441 = 0;
H_159442 = 0;
V_159443 = NIM_NIL;
N_159440 = (*A_159438)->Sup.len;
H_159442 = 1;
while (1) {
H_159442 = (NI64)((NI64)(3 * H_159442) + 1);
if (!(N_159440 < H_159442)) goto LA3;
goto LA1;
LA3: ;
} LA1: ;
while (1) {
H_159442 = (NI64)(H_159442 / 3);
I_159466 = 0;
HEX3Atmp_159475 = 0;
HEX3Atmp_159475 = (NI64)(N_159440 - 1);
Res_159477 = 0;
Res_159477 = H_159442;
while (1) {
if (!(Res_159477 <= HEX3Atmp_159475)) goto LA6;
I_159466 = Res_159477;
V_159443 = (*A_159438)->data[I_159466];
J_159441 = I_159466;
while (1) {
LOC8 = Cmpsignatures_159412((*A_159438)->data[(NI64)(J_159441 - H_159442)], V_159443, Relevantcols_159439);
if (!(0 <= LOC8)) goto LA7;
asgnRef((void**) &(*A_159438)->data[J_159441], (*A_159438)->data[(NI64)(J_159441 - H_159442)]);
J_159441 = (NI64)(J_159441 - H_159442);
if (!(J_159441 < H_159442)) goto LA10;
goto LA7;
LA10: ;
} LA7: ;
asgnRef((void**) &(*A_159438)->data[J_159441], V_159443);
Res_159477 += 1;
} LA6: ;
if (!(H_159442 == 1)) goto LA13;
goto LA5;
LA13: ;
} LA5: ;
}
N_NIMCALL(TY51548*, Gendispatcher_159478)(TY51528* Methods_159480, TY51895* Relevantcols_159481) {
TY51548* Result_159482;
TY51526* Disp_159483;
TY51526* Cond_159484;
TY51526* Call_159485;
TY51526* Ret_159486;
TY51526* A_159487;
TY51526* Isn_159488;
TY51548* Base_159489;
TY51548* Curr_159490;
TY51548* Ands_159491;
TY51548* Iss_159492;
NI Paramlen_159493;
TY51526* LOC1;
NI Meth_159514;
NI HEX3Atmp_159645;
NI Res_159647;
NI Col_159523;
NI HEX3Atmp_159639;
NI Res_159641;
NIM_BOOL LOC5;
TY51552* LOC8;
TY51526* LOC9;
TY51526* LOC10;
TY51526* LOC11;
TY51552* LOC15;
TY51526* LOC16;
TY51526* LOC17;
NI Col_159567;
NI HEX3Atmp_159642;
NI Res_159644;
TY51526* LOC19;
TY51526* LOC20;
TY51526* LOC24;
Result_159482 = 0;
Disp_159483 = 0;
Cond_159484 = 0;
Call_159485 = 0;
Ret_159486 = 0;
A_159487 = 0;
Isn_159488 = 0;
Base_159489 = 0;
Curr_159490 = 0;
Ands_159491 = 0;
Iss_159492 = 0;
Result_159482 = NIM_NIL;
Disp_159483 = NIM_NIL;
Cond_159484 = NIM_NIL;
Call_159485 = NIM_NIL;
Ret_159486 = NIM_NIL;
A_159487 = NIM_NIL;
Isn_159488 = NIM_NIL;
Base_159489 = NIM_NIL;
Curr_159490 = NIM_NIL;
Ands_159491 = NIM_NIL;
Iss_159492 = NIM_NIL;
Paramlen_159493 = 0;
LOC1 = 0;
LOC1 = Lastson_51810((*Methods_159480->data[0]).Ast);
Base_159489 = (*LOC1).KindU.S4.Sym;
Result_159482 = Base_159489;
Paramlen_159493 = Sonslen_51807((*Base_159489).Typ);
Disp_159483 = Newnodei_51738(((NU8) 82), (*Base_159489).Info);
Ands_159491 = Getsyssym_99024(((NimStringDesc*) &TMP194814));
Iss_159492 = Getsyssym_99024(((NimStringDesc*) &TMP194815));
Meth_159514 = 0;
HEX3Atmp_159645 = 0;
HEX3Atmp_159645 = (Methods_159480->Sup.len-1);
Res_159647 = 0;
Res_159647 = 0;
while (1) {
if (!(Res_159647 <= HEX3Atmp_159645)) goto LA2;
Meth_159514 = Res_159647;
Curr_159490 = Methods_159480->data[Meth_159514];
Cond_159484 = NIM_NIL;
Col_159523 = 0;
HEX3Atmp_159639 = 0;
HEX3Atmp_159639 = (NI64)(Paramlen_159493 - 1);
Res_159641 = 0;
Res_159641 = 1;
while (1) {
if (!(Res_159641 <= HEX3Atmp_159639)) goto LA3;
Col_159523 = Res_159641;
LOC5 = Intsetcontains_51905(Relevantcols_159481, Col_159523);
if (!LOC5) goto LA6;
LOC8 = 0;
LOC8 = Getsystype_99008(((NU8) 1));
Isn_159488 = Newnodeit_51742(((NU8) 21), (*Base_159489).Info, LOC8);
LOC9 = 0;
LOC9 = Newsymnode_51735(Iss_159492);
Addson_51824(Isn_159488, LOC9);
LOC10 = 0;
LOC10 = Newsymnode_51735((*(*(*(*Base_159489).Typ).N).KindU.S6.Sons->data[Col_159523]).KindU.S4.Sym);
Addson_51824(Isn_159488, LOC10);
LOC11 = 0;
LOC11 = Newnodeit_51742(((NU8) 4), (*Base_159489).Info, (*(*Curr_159490).Typ).Sons->data[Col_159523]);
Addson_51824(Isn_159488, LOC11);
if (!!((Cond_159484 == NIM_NIL))) goto LA13;
LOC15 = 0;
LOC15 = Getsystype_99008(((NU8) 1));
A_159487 = Newnodeit_51742(((NU8) 21), (*Base_159489).Info, LOC15);
LOC16 = 0;
LOC16 = Newsymnode_51735(Ands_159491);
Addson_51824(A_159487, LOC16);
Addson_51824(A_159487, Cond_159484);
Addson_51824(A_159487, Isn_159488);
Cond_159484 = A_159487;
goto LA12;
LA13: ;
Cond_159484 = Isn_159488;
LA12: ;
LA6: ;
Res_159641 += 1;
} LA3: ;
Call_159485 = Newnodei_51738(((NU8) 21), (*Base_159489).Info);
LOC17 = 0;
LOC17 = Newsymnode_51735(Curr_159490);
Addson_51824(Call_159485, LOC17);
Col_159567 = 0;
HEX3Atmp_159642 = 0;
HEX3Atmp_159642 = (NI64)(Paramlen_159493 - 1);
Res_159644 = 0;
Res_159644 = 1;
while (1) {
if (!(Res_159644 <= HEX3Atmp_159642)) goto LA18;
Col_159567 = Res_159644;
LOC19 = 0;
LOC19 = Newsymnode_51735((*(*(*(*Base_159489).Typ).N).KindU.S6.Sons->data[Col_159567]).KindU.S4.Sym);
LOC20 = 0;
LOC20 = Genconv_159004(LOC19, (*(*Curr_159490).Typ).Sons->data[Col_159567], NIM_FALSE);
Addson_51824(Call_159485, LOC20);
Res_159644 += 1;
} LA18: ;
if (!!(((*(*Base_159489).Typ).Sons->data[0] == NIM_NIL))) goto LA22;
A_159487 = Newnodei_51738(((NU8) 63), (*Base_159489).Info);
LOC24 = 0;
LOC24 = Newsymnode_51735((*(*(*Base_159489).Ast).KindU.S6.Sons->data[5]).KindU.S4.Sym);
Addson_51824(A_159487, LOC24);
Addson_51824(A_159487, Call_159485);
Ret_159486 = Newnodei_51738(((NU8) 96), (*Base_159489).Info);
Addson_51824(Ret_159486, A_159487);
goto LA21;
LA22: ;
Ret_159486 = Call_159485;
LA21: ;
A_159487 = Newnodei_51738(((NU8) 76), (*Base_159489).Info);
Addson_51824(A_159487, Cond_159484);
Addson_51824(A_159487, Ret_159486);
Addson_51824(Disp_159483, A_159487);
Res_159647 += 1;
} LA2: ;
asgnRefNoCycle((void**) &(*(*Result_159482).Ast).KindU.S6.Sons->data[4], Disp_159483);
return Result_159482;
}
N_NIMCALL(TY51526*, Generatemethoddispatchers_159648)(void) {
TY51526* Result_159650;
TY51895 Relevantcols_159651;
NI Bucket_159670;
NI HEX3Atmp_159686;
NI Res_159688;
NI Col_159680;
NI HEX3Atmp_159683;
NI LOC2;
NI Res_159685;
NIM_BOOL LOC5;
TY51548* LOC8;
TY51526* LOC9;
Result_159650 = 0;
memset((void*)&Relevantcols_159651, 0, sizeof(Relevantcols_159651));
Result_159650 = NIM_NIL;
genericReset((void*)&Relevantcols_159651, NTI51895);
Result_159650 = Newnode_51711(((NU8) 101));
Bucket_159670 = 0;
HEX3Atmp_159686 = 0;
HEX3Atmp_159686 = (NI64)(Gmethods_159158->Sup.len - 1);
Res_159688 = 0;
Res_159688 = 0;
while (1) {
if (!(Res_159688 <= HEX3Atmp_159686)) goto LA1;
Bucket_159670 = Res_159688;
Intsetinit_51919(&Relevantcols_159651);
Col_159680 = 0;
HEX3Atmp_159683 = 0;
LOC2 = Sonslen_51807((*Gmethods_159158->data[Bucket_159670]->data[0]).Typ);
HEX3Atmp_159683 = (NI64)(LOC2 - 1);
Res_159685 = 0;
Res_159685 = 1;
while (1) {
if (!(Res_159685 <= HEX3Atmp_159683)) goto LA3;
Col_159680 = Res_159685;
LOC5 = Relevantcol_159385(Gmethods_159158->data[Bucket_159670], Col_159680);
if (!LOC5) goto LA6;
Intsetincl_51909(&Relevantcols_159651, Col_159680);
LA6: ;
Res_159685 += 1;
} LA3: ;
Sortbucket_159435(&Gmethods_159158->data[Bucket_159670], &Relevantcols_159651);
LOC8 = 0;
LOC8 = Gendispatcher_159478(Gmethods_159158->data[Bucket_159670], &Relevantcols_159651);
LOC9 = 0;
LOC9 = Newsymnode_51735(LOC8);
Addson_51824(Result_159650, LOC9);
Res_159688 += 1;
} LA1: ;
return Result_159650;
}
N_NOINLINE(void, cgmethInit)(void) {
asgnRefNoCycle((void**) &Gmethods_159158, (TY159157*) newSeq(NTI159157, 0));
}

