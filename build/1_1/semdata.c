/* Generated by Nimrod Compiler v0.8.11 */
/*   (c) 2011 Andreas Rumpf */

typedef long int NI;
typedef unsigned long int NU;
#include "nimbase.h"

typedef struct TY51564 TY51564;
typedef struct TY51562 TY51562;
typedef struct TY51560 TY51560;
typedef struct TY50005 TY50005;
typedef struct TNimObject TNimObject;
typedef struct TGenericSeq TGenericSeq;
typedef struct TY51528 TY51528;
typedef struct TY51548 TY51548;
typedef struct TNimType TNimType;
typedef struct TNimNode TNimNode;
typedef struct TY10602 TY10602;
typedef struct TY10614 TY10614;
typedef struct TY10996 TY10996;
typedef struct TY10618 TY10618;
typedef struct TY10610 TY10610;
typedef struct TY10994 TY10994;
typedef struct TY104012 TY104012;
typedef struct NimStringDesc NimStringDesc;
typedef struct TY102002 TY102002;
typedef struct TY104006 TY104006;
typedef struct TY51526 TY51526;
typedef struct TY56099 TY56099;
typedef struct TY56101 TY56101;
typedef struct TY51530 TY51530;
typedef struct TY51895 TY51895;
typedef struct TY51891 TY51891;
typedef struct TY51893 TY51893;
typedef struct TY39019 TY39019;
typedef struct TY39013 TY39013;
typedef struct TY104002 TY104002;
typedef struct TY51544 TY51544;
typedef struct TY51552 TY51552;
typedef struct TY50011 TY50011;
typedef struct TY43538 TY43538;
typedef struct TY51540 TY51540;
typedef struct TY48008 TY48008;
typedef struct TY51520 TY51520;
typedef struct TY51550 TY51550;
struct TY51560 {
TY50005* Key;
TNimObject* Val;
};
struct TGenericSeq {
NI len;
NI space;
};
struct TY51564 {
NI Counter;
TY51562* Data;
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
typedef NIM_CHAR TY245[100000001];
struct NimStringDesc {
  TGenericSeq Sup;
TY245 data;
};
struct TNimObject {
TNimType* m_type;
};
struct TY102002 {
  TNimObject Sup;
};
struct TY51530 {
TNimType* m_type;
NI Counter;
TY51528* Data;
};
struct TY56099 {
NI Tos;
TY56101* Stack;
};
struct TY51895 {
NI Counter;
NI Max;
TY51891* Head;
TY51893* Data;
};
struct TY39019 {
TNimType* m_type;
TY39013* Head;
TY39013* Tail;
NI Counter;
};
typedef N_NIMCALL_PTR(TY51526*, TY104032) (TY104012* C_104033, TY51526* N_104034);
typedef N_NIMCALL_PTR(TY51526*, TY104037) (TY104012* C_104038, TY51526* N_104039);
struct TY104012 {
  TY102002 Sup;
TY51548* Module;
TY104006* P;
NI Instcounter;
TY51526* Generics;
NI Lastgenericidx;
TY56099 Tab;
TY51895 Ambiguoussymbols;
TY51528* Converters;
TY39019 Optionstack;
TY39019 Libs;
NIM_BOOL Fromcache;
TY104032 Semconstexpr;
TY104037 Semexpr;
TY51895 Includedfiles;
NimStringDesc* Filename;
TY51530 Userpragmas;
};
struct TY39013 {
  TNimObject Sup;
TY39013* Prev;
TY39013* Next;
};
struct TY104002 {
  TY39013 Sup;
NU32 Options;
NU8 Defaultcc;
TY51544* Dynlib;
NU32 Notes;
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
struct TY50011 {
  TY50005 Sup;
NimStringDesc* S;
TY50011* Next;
NI H;
};
struct TY51544 {
  TY39013 Sup;
NU8 Kind;
NIM_BOOL Generated;
TY48008* Name;
TY51526* Path;
};
struct TY104006 {
TY51548* Owner;
TY51548* Resultsym;
NI Nestedloopcounter;
NI Nestedblockcounter;
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
typedef NI TY8614[16];
struct TY10610 {
TY10610* Next;
NI Key;
TY8614 Bits;
};
struct TY51891 {
TY51891* Next;
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
struct TY51562 {
  TGenericSeq Sup;
  TY51560 data[SEQ_DECL_SIZE];
};
struct TY51528 {
  TGenericSeq Sup;
  TY51548* data[SEQ_DECL_SIZE];
};
struct TY56101 {
  TGenericSeq Sup;
  TY51530 data[SEQ_DECL_SIZE];
};
struct TY51893 {
  TGenericSeq Sup;
  TY51891* data[SEQ_DECL_SIZE];
};
struct TY51520 {
  TGenericSeq Sup;
  TY51526* data[SEQ_DECL_SIZE];
};
struct TY51550 {
  TGenericSeq Sup;
  TY51552* data[SEQ_DECL_SIZE];
};
N_NIMCALL(void*, newSeq)(TNimType* Typ_14204, NI Len_14205);
static N_INLINE(void, asgnRef)(void** Dest_13014, void* Src_13015);
static N_INLINE(void, Incref_13002)(TY10602* C_13004);
static N_INLINE(NI, Atomicinc_3221)(NI* Memloc_3224, NI X_3225);
static N_INLINE(NIM_BOOL, Canbecycleroot_11416)(TY10602* C_11418);
static N_INLINE(void, Rtladdcycleroot_12052)(TY10602* C_12054);
N_NOINLINE(void, Incl_10880)(TY10614* S_10883, TY10602* Cell_10884);
static N_INLINE(TY10602*, Usrtocell_11412)(void* Usr_11414);
static N_INLINE(void, Decref_12801)(TY10602* C_12803);
static N_INLINE(NI, Atomicdec_3226)(NI* Memloc_3229, NI X_3230);
static N_INLINE(void, Rtladdzct_12401)(TY10602* C_12403);
N_NOINLINE(void, Addzct_11401)(TY10618* S_11404, TY10602* C_11405);
N_NIMCALL(void, Initidtable_51755)(TY51564* X_51758);
N_NIMCALL(void*, newObj)(TNimType* Typ_13710, NI Size_13711);
N_NIMCALL(void, objectInit)(void* Dest_19481, TNimType* Typ_19482);
N_NIMCALL(void, Initsymtab_56103)(TY56099* Tab_56106);
N_NIMCALL(void, Intsetinit_51919)(TY51895* S_51922);
N_NIMCALL(void, Initlinkedlist_39031)(TY39019* List_39034);
N_NIMCALL(void, Append_39035)(TY39019* List_39038, TY39013* Entry_39039);
N_NIMCALL(TY104002*, Newoptionentry_104056)(void);
static N_INLINE(void, asgnRefNoCycle)(void** Dest_13018, void* Src_13019);
N_NIMCALL(TY51526*, Newnode_51711)(NU8 Kind_51713);
N_NIMCALL(NimStringDesc*, copyString)(NimStringDesc* Src_18512);
N_NIMCALL(void, Initstrtable_51747)(TY51530* X_51750);
N_NIMCALL(void, Message_44198)(TY43538 Info_44200, NU8 Msg_44201, NimStringDesc* Arg_44202);
N_NIMCALL(TY51552*, Newtype_51707)(NU8 Kind_51709, TY51548* Owner_51710);
N_NIMCALL(TY51548*, Getcurrowner_104092)(void);
static N_INLINE(NI, Sonslen_51804)(TY51526* N_51806);
N_NIMCALL(void, Illformedast_104430)(TY51526* N_104432);
N_NIMCALL(void, Globalerror_44188)(TY43538 Info_44190, NU8 Msg_44191, NimStringDesc* Arg_44192);
N_NIMCALL(NimStringDesc*, Rendertree_82042)(TY51526* N_82044, NU8 Renderflags_82047);
N_NIMCALL(TGenericSeq*, incrSeq)(TGenericSeq* Seq_18642, NI Elemsize_18643);
N_NIMCALL(void, Localerror_44193)(TY43538 Info_44195, NU8 Msg_44196, NimStringDesc* Arg_44197);
N_NIMCALL(void, Internalerror_44212)(NimStringDesc* Errmsg_44214);
N_NIMCALL(TGenericSeq*, setLengthSeq)(TGenericSeq* Seq_18803, NI Elemsize_18804, NI Newlen_18805);
N_NIMCALL(TY51526*, Newnodei_51738)(NU8 Kind_51740, TY43538 Info_51741);
N_NIMCALL(void, Addson_51824)(TY51526* Father_51826, TY51526* Son_51827);
N_NIMCALL(TY51526*, Newintnode_51714)(NU8 Kind_51716, NI64 Intval_51717);
N_NIMCALL(TY51552*, Newtypes_104077)(NU8 Kind_104079, TY104012* C_104080);
N_NIMCALL(void, Addson_51828)(TY51552* Father_51830, TY51552* Son_51831);
N_NIMCALL(TY51552*, Getsystype_99008)(NU8 Kind_99010);
STRING_LITERAL(TMP194158, "", 0);
STRING_LITERAL(TMP194176, "owner is nil", 12);
STRING_LITERAL(TMP194178, "popOwner", 8);
STRING_LITERAL(TMP194186, "makeVarType", 11);
STRING_LITERAL(TMP194264, "makePtrType", 11);
TY51564 Ginsttypes_104045;
TY51528* Gowners_104116;
extern TNimType* NTI51528; /* TSymSeq */
extern TY10996 Gch_11014;
extern TNimType* NTI104010; /* PContext */
extern TNimType* NTI104012; /* TContext */
extern TNimType* NTI104004; /* POptionEntry */
extern TNimType* NTI104002; /* TOptionEntry */
extern NU32 Goptions_42082;
extern NU32 Gnotes_43564;
extern TNimType* NTI51546; /* PLib */
extern TNimType* NTI51544; /* TLib */
extern TNimType* NTI104008; /* PProcCon */
static N_INLINE(NI, Atomicinc_3221)(NI* Memloc_3224, NI X_3225) {
NI Result_7807;
Result_7807 = 0;
(*Memloc_3224) += X_3225;
Result_7807 = (*Memloc_3224);
return Result_7807;
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
static N_INLINE(TY10602*, Usrtocell_11412)(void* Usr_11414) {
TY10602* Result_11415;
Result_11415 = 0;
Result_11415 = ((TY10602*) ((NI32)((NU32)(((NI) (Usr_11414))) - (NU32)(((NI) (((NI)sizeof(TY10602))))))));
return Result_11415;
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
static N_INLINE(void, Decref_12801)(TY10602* C_12803) {
NI LOC2;
NIM_BOOL LOC5;
LOC2 = Atomicdec_3226(&(*C_12803).Refcount, 8);
if (!((NU32)(LOC2) < (NU32)(8))) goto LA3;
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
if (!((NU32)(LOC9) < (NU32)(8))) goto LA10;
Rtladdzct_12401(C_13022);
LA10: ;
LA6: ;
(*Dest_13018) = Src_13019;
}
N_NIMCALL(TY104002*, Newoptionentry_104056)(void) {
TY104002* Result_104204;
Result_104204 = 0;
Result_104204 = NIM_NIL;
Result_104204 = (TY104002*) newObj(NTI104004, sizeof(TY104002));
(*Result_104204).Sup.Sup.m_type = NTI104002;
(*Result_104204).Options = Goptions_42082;
(*Result_104204).Defaultcc = ((NU8) 0);
asgnRefNoCycle((void**) &(*Result_104204).Dynlib, NIM_NIL);
(*Result_104204).Notes = Gnotes_43564;
return Result_104204;
}
N_NIMCALL(TY104012*, Newcontext_104046)(TY51548* Module_104048, NimStringDesc* Nimfile_104049) {
TY104012* Result_104224;
TY104002* LOC1;
Result_104224 = 0;
Result_104224 = NIM_NIL;
Result_104224 = (TY104012*) newObj(NTI104010, sizeof(TY104012));
objectInit(Result_104224, NTI104012);
Initsymtab_56103(&(*Result_104224).Tab);
Intsetinit_51919(&(*Result_104224).Ambiguoussymbols);
Initlinkedlist_39031(&(*Result_104224).Optionstack);
Initlinkedlist_39031(&(*Result_104224).Libs);
LOC1 = 0;
LOC1 = Newoptionentry_104056();
Append_39035(&(*Result_104224).Optionstack, &LOC1->Sup);
asgnRef((void**) &(*Result_104224).Module, Module_104048);
asgnRefNoCycle((void**) &(*Result_104224).Generics, Newnode_51711(((NU8) 101)));
asgnRef((void**) &(*Result_104224).Converters, (TY51528*) newSeq(NTI51528, 0));
asgnRefNoCycle((void**) &(*Result_104224).Filename, copyString(Nimfile_104049));
Intsetinit_51919(&(*Result_104224).Includedfiles);
Initstrtable_51747(&(*Result_104224).Userpragmas);
return Result_104224;
}
N_NIMCALL(void, Markused_104403)(TY51526* N_104405, TY51548* S_104406) {
(*S_104406).Flags |=(1<<((NI32)(((NU8) 0))%(sizeof(NI32)*8)));
if (!(((*S_104406).Flags &(1<<((((NU8) 22))&31)))!=0)) goto LA2;
Message_44198((*N_104405).Info, ((NU8) 214), (*(*S_104406).Name).S);
LA2: ;
}
N_NIMCALL(TY51548*, Getcurrowner_104092)(void) {
TY51548* Result_104119;
Result_104119 = 0;
Result_104119 = NIM_NIL;
Result_104119 = Gowners_104116->data[(Gowners_104116->Sup.len-1)];
return Result_104119;
}
N_NIMCALL(TY51552*, Newtypes_104077)(NU8 Kind_104079, TY104012* C_104080) {
TY51552* Result_104389;
TY51548* LOC1;
Result_104389 = 0;
Result_104389 = NIM_NIL;
LOC1 = 0;
LOC1 = Getcurrowner_104092();
Result_104389 = Newtype_51707(Kind_104079, LOC1);
return Result_104389;
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
N_NIMCALL(void, Illformedast_104430)(TY51526* N_104432) {
NimStringDesc* LOC1;
LOC1 = 0;
LOC1 = Rendertree_82042(N_104432, 4);
Globalerror_44188((*N_104432).Info, ((NU8) 1), LOC1);
}
N_NIMCALL(void, Checksonslen_104434)(TY51526* N_104436, NI Length_104437) {
NI LOC2;
LOC2 = Sonslen_51804(N_104436);
if (!!((LOC2 == Length_104437))) goto LA3;
Illformedast_104430(N_104436);
LA3: ;
}
N_NIMCALL(void, Checkminsonslen_104440)(TY51526* N_104442, NI Length_104443) {
NI LOC2;
LOC2 = Sonslen_51804(N_104442);
if (!(LOC2 < Length_104443)) goto LA3;
Illformedast_104430(N_104442);
LA3: ;
}
N_NIMCALL(void, Pushowner_104094)(TY51548* Owner_104096) {
Gowners_104116 = (TY51528*) incrSeq(&(Gowners_104116)->Sup, sizeof(TY51548*));
asgnRef((void**) &Gowners_104116->data[Gowners_104116->Sup.len-1], Owner_104096);
}
N_NIMCALL(TY104002*, Lastoptionentry_104053)(TY104012* C_104055) {
TY104002* Result_104171;
Result_104171 = 0;
Result_104171 = NIM_NIL;
Result_104171 = ((TY104002*) ((*C_104055).Optionstack.Tail));
return Result_104171;
}
N_NIMCALL(TY51544*, Newlib_104062)(NU8 Kind_104064) {
TY51544* Result_104322;
Result_104322 = 0;
Result_104322 = NIM_NIL;
Result_104322 = (TY51544*) newObj(NTI51546, sizeof(TY51544));
(*Result_104322).Sup.Sup.m_type = NTI51544;
(*Result_104322).Kind = Kind_104064;
return Result_104322;
}
N_NIMCALL(void, Addtolib_104065)(TY51544* Lib_104067, TY51548* Sym_104068) {
if (!!(((*Sym_104068).Annex == NIM_NIL))) goto LA2;
Localerror_44193((*Sym_104068).Info, ((NU8) 26), ((NimStringDesc*) &TMP194158));
LA2: ;
asgnRefNoCycle((void**) &(*Sym_104068).Annex, Lib_104067);
}
N_NIMCALL(TY104006*, Newproccon_104050)(TY51548* Owner_104052) {
TY104006* Result_104175;
Result_104175 = 0;
Result_104175 = NIM_NIL;
if (!(Owner_104052 == NIM_NIL)) goto LA2;
Internalerror_44212(((NimStringDesc*) &TMP194176));
LA2: ;
Result_104175 = (TY104006*) newObj(NTI104008, sizeof(TY104006));
asgnRef((void**) &(*Result_104175).Owner, Owner_104052);
return Result_104175;
}
N_NIMCALL(void, Popowner_104097)(void) {
NI Length_104153;
Length_104153 = 0;
Length_104153 = Gowners_104116->Sup.len;
if (!(Length_104153 <= 0)) goto LA2;
Internalerror_44212(((NimStringDesc*) &TMP194178));
LA2: ;
Gowners_104116 = (TY51528*) setLengthSeq(&(Gowners_104116)->Sup, sizeof(TY51548*), (NI32)(Length_104153 - 1));
}
N_NIMCALL(TY51552*, Makerangetype_104086)(TY104012* C_104088, NI64 First_104089, NI64 Last_104090, TY43538 Info_104091) {
TY51552* Result_104401;
TY51526* N_104402;
TY51526* LOC1;
TY51526* LOC2;
TY51552* LOC3;
Result_104401 = 0;
N_104402 = 0;
Result_104401 = NIM_NIL;
N_104402 = NIM_NIL;
N_104402 = Newnodei_51738(((NU8) 35), Info_104091);
LOC1 = 0;
LOC1 = Newintnode_51714(((NU8) 6), First_104089);
Addson_51824(N_104402, LOC1);
LOC2 = 0;
LOC2 = Newintnode_51714(((NU8) 6), Last_104090);
Addson_51824(N_104402, LOC2);
Result_104401 = Newtypes_104077(((NU8) 20), C_104088);
asgnRefNoCycle((void**) &(*Result_104401).N, N_104402);
LOC3 = 0;
LOC3 = Getsystype_99008(((NU8) 31));
Addson_51828(Result_104401, LOC3);
return Result_104401;
}
N_NIMCALL(TY51552*, Makevartype_104073)(TY104012* C_104075, TY51552* Basetype_104076) {
TY51552* Result_104373;
Result_104373 = 0;
Result_104373 = NIM_NIL;
if (!(Basetype_104076 == NIM_NIL)) goto LA2;
Internalerror_44212(((NimStringDesc*) &TMP194186));
LA2: ;
Result_104373 = Newtypes_104077(((NU8) 23), C_104075);
Addson_51828(Result_104373, Basetype_104076);
return Result_104373;
}
N_NIMCALL(void, Addconverter_104058)(TY104012* C_104060, TY51548* Conv_104061) {
NI L_104277;
NI I_104301;
NI HEX3Atmp_104316;
NI Res_104318;
L_104277 = 0;
L_104277 = (*C_104060).Converters->Sup.len;
I_104301 = 0;
HEX3Atmp_104316 = 0;
HEX3Atmp_104316 = (NI32)(L_104277 - 1);
Res_104318 = 0;
Res_104318 = 0;
while (1) {
if (!(Res_104318 <= HEX3Atmp_104316)) goto LA1;
I_104301 = Res_104318;
if (!((*(*C_104060).Converters->data[I_104301]).Sup.Id == (*Conv_104061).Sup.Id)) goto LA3;
goto BeforeRet;
LA3: ;
Res_104318 += 1;
} LA1: ;
(*C_104060).Converters = (TY51528*) setLengthSeq(&((*C_104060).Converters)->Sup, sizeof(TY51548*), (NI32)(L_104277 + 1));
asgnRef((void**) &(*C_104060).Converters->data[L_104277], Conv_104061);
BeforeRet: ;
}
N_NIMCALL(TY51552*, Makeptrtype_104069)(TY104012* C_104071, TY51552* Basetype_104072) {
TY51552* Result_104357;
Result_104357 = 0;
Result_104357 = NIM_NIL;
if (!(Basetype_104072 == NIM_NIL)) goto LA2;
Internalerror_44212(((NimStringDesc*) &TMP194264));
LA2: ;
Result_104357 = Newtypes_104077(((NU8) 21), C_104071);
Addson_51828(Result_104357, Basetype_104072);
return Result_104357;
}
N_NOINLINE(void, semdataInit)(void) {
asgnRef((void**) &Gowners_104116, (TY51528*) newSeq(NTI51528, 0));
Initidtable_51755(&Ginsttypes_104045);
}

