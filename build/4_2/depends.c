/* Generated by Nimrod Compiler v0.8.11 */
/*   (c) 2011 Andreas Rumpf */

typedef long long int NI;
typedef unsigned long long int NU;
#include "nimbase.h"

typedef struct TY53008 TY53008;
typedef struct TY106006 TY106006;
typedef struct TY106002 TY106002;
typedef struct TY56548 TY56548;
typedef struct NimStringDesc NimStringDesc;
typedef struct TGenericSeq TGenericSeq;
typedef struct TY94031 TY94031;
typedef struct TY56526 TY56526;
typedef struct TY189010 TY189010;
typedef struct TNimType TNimType;
typedef struct TNimNode TNimNode;
typedef struct TNimObject TNimObject;
typedef struct TY10802 TY10802;
typedef struct TY10814 TY10814;
typedef struct TY11196 TY11196;
typedef struct TY10818 TY10818;
typedef struct TY10810 TY10810;
typedef struct TY11194 TY11194;
typedef struct TY56552 TY56552;
typedef struct TY48538 TY48538;
typedef struct TY55011 TY55011;
typedef struct TY56520 TY56520;
typedef struct TY38661 TY38661;
typedef struct TY55005 TY55005;
typedef struct TY56530 TY56530;
typedef struct TY56528 TY56528;
typedef struct TY56540 TY56540;
typedef struct TY56544 TY56544;
typedef struct TY39221 TY39221;
typedef struct TY94029 TY94029;
typedef struct TY61215 TY61215;
typedef struct TY61213 TY61213;
typedef struct TY61211 TY61211;
typedef struct TY56564 TY56564;
typedef struct TY56562 TY56562;
typedef struct TY56560 TY56560;
typedef struct TY56550 TY56550;
typedef struct TY44013 TY44013;
struct TGenericSeq {
NI len;
NI space;
};
typedef NIM_CHAR TY245[100000001];
struct NimStringDesc {
  TGenericSeq Sup;
TY245 data;
};
typedef N_NIMCALL_PTR(TY106002*, TY106007) (TY56548* Module_106008, NimStringDesc* Filename_106009);
typedef N_NIMCALL_PTR(TY106002*, TY106012) (TY56548* Module_106013, NimStringDesc* Filename_106014, TY94031* Rd_106015);
typedef N_NIMCALL_PTR(TY56526*, TY106018) (TY106002* P_106019, TY56526* N_106020);
typedef N_NIMCALL_PTR(TY56526*, TY106023) (TY106002* P_106024, TY56526* Toplevelstmt_106025);
struct TY106006 {
TY106007 Open;
TY106012 Opencached;
TY106018 Close;
TY106023 Process;
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
struct TNimObject {
TNimType* m_type;
};
struct TY106002 {
  TNimObject Sup;
};
struct TY189010 {
  TY106002 Sup;
TY56548* Module;
NimStringDesc* Filename;
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
struct TY38661 {
NimStringDesc* Dir;
NimStringDesc* Name;
NimStringDesc* Ext;
};
typedef TY53008* TY179695[2];
struct TY55005 {
  TNimObject Sup;
NI Id;
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
struct TY55011 {
  TY55005 Sup;
NimStringDesc* S;
TY55011* Next;
NI H;
};
struct TY53008 {
  TNimObject Sup;
TY53008* Left;
TY53008* Right;
NI Length;
NimStringDesc* Data;
};
struct TY61211 {
NI Key;
NI Val;
};
struct TY61215 {
NI Counter;
TY61213* Data;
};
struct TY94029 {
NI Lastidxkey;
NI Lastidxval;
TY61215 Tab;
TY53008* R;
NI Offset;
};
struct TY56560 {
TY55005* Key;
TNimObject* Val;
};
struct TY56564 {
NI Counter;
TY56562* Data;
};
struct TY94031 {
  TNimObject Sup;
NI Pos;
NimStringDesc* S;
NU32 Options;
NU8 Reason;
TY39221* Moddeps;
TY39221* Files;
NI Dataidx;
NI Convertersidx;
NI Initidx;
NI Interfidx;
NI Compilerprocsidx;
NI Cgenidx;
NimStringDesc* Filename;
TY94029 Index;
TY94029 Imports;
NI Readerindex;
NI Line;
NI Moduleid;
TY56564 Syms;
};
typedef NI TY8814[8];
struct TY10810 {
TY10810* Next;
NI Key;
TY8814 Bits;
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
struct TY56520 {
  TGenericSeq Sup;
  TY56526* data[SEQ_DECL_SIZE];
};
struct TY56528 {
  TGenericSeq Sup;
  TY56548* data[SEQ_DECL_SIZE];
};
struct TY39221 {
  TGenericSeq Sup;
  NimStringDesc* data[SEQ_DECL_SIZE];
};
struct TY61213 {
  TGenericSeq Sup;
  TY61211 data[SEQ_DECL_SIZE];
};
struct TY56562 {
  TGenericSeq Sup;
  TY56560 data[SEQ_DECL_SIZE];
};
struct TY56550 {
  TGenericSeq Sup;
  TY56552* data[SEQ_DECL_SIZE];
};
N_NIMCALL(void, Initpass_106031)(TY106006* P_106034);
N_NIMCALL(TY106002*, Myopen_189115)(TY56548* Module_189117, NimStringDesc* Filename_189118);
N_NIMCALL(void*, newObj)(TNimType* Typ_13910, NI Size_13911);
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
static N_INLINE(void, asgnRefNoCycle)(void** Dest_13218, void* Src_13219);
N_NIMCALL(NimStringDesc*, copyString)(NimStringDesc* Src_18712);
N_NIMCALL(TY56526*, Adddotdependency_189025)(TY106002* C_189027, TY56526* N_189028);
static N_INLINE(NI, Sonslen_56804)(TY56526* N_56806);
N_NIMCALL(void, nossplitFile)(NimStringDesc* Path_38660, TY38661* Result);
N_NIMCALL(NimStringDesc*, Getmodulefile_111013)(TY56526* N_111015);
N_NIMCALL(void, Adddependencyaux_189016)(NimStringDesc* Importing_189018, NimStringDesc* Imported_189019);
N_NIMCALL(void, Appf_53071)(TY53008** C_53074, NimStringDesc* Frmt_53075, TY53008** Args_53077, NI Args_53077Len0);
N_NIMCALL(TY53008*, Torope_53046)(NimStringDesc* S_53048);
N_NIMCALL(void, Writerope_53055)(TY53008* Head_53057, NimStringDesc* Filename_53058);
N_NIMCALL(TY53008*, Ropef_53066)(NimStringDesc* Frmt_53068, TY53008** Args_53070, NI Args_53070Len0);
N_NIMCALL(NimStringDesc*, nosChangeFileExt)(NimStringDesc* Filename_38820, NimStringDesc* Ext_38821);
N_NIMCALL(NimStringDesc*, nosextractFilename)(NimStringDesc* Path_38730);
STRING_LITERAL(TMP199542, "$1 -> $2;$n", 11);
STRING_LITERAL(TMP199543, "digraph $1 {$n$2}$n", 19);
STRING_LITERAL(TMP199544, "", 0);
STRING_LITERAL(TMP199545, "dot", 3);
TY53008* Gdotgraph_189015;
extern TNimType* NTI189012; /* PGen */
extern TNimType* NTI189010; /* TGen */
extern TY11196 Gch_11214;
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
N_NIMCALL(TY106002*, Myopen_189115)(TY56548* Module_189117, NimStringDesc* Filename_189118) {
TY106002* Result_189119;
TY189010* G_189120;
Result_189119 = 0;
G_189120 = 0;
Result_189119 = NIM_NIL;
G_189120 = NIM_NIL;
G_189120 = (TY189010*) newObj(NTI189012, sizeof(TY189010));
(*G_189120).Sup.Sup.m_type = NTI189010;
asgnRef((void**) &(*G_189120).Module, Module_189117);
asgnRefNoCycle((void**) &(*G_189120).Filename, copyString(Filename_189118));
Result_189119 = &G_189120->Sup;
return Result_189119;
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
N_NIMCALL(void, Adddependencyaux_189016)(NimStringDesc* Importing_189018, NimStringDesc* Imported_189019) {
TY179695 LOC1;
memset((void*)&LOC1, 0, sizeof(LOC1));
LOC1[0] = Torope_53046(Importing_189018);
LOC1[1] = Torope_53046(Imported_189019);
Appf_53071(&Gdotgraph_189015, ((NimStringDesc*) &TMP199542), LOC1, 2);
}
N_NIMCALL(TY56526*, Adddotdependency_189025)(TY106002* C_189027, TY56526* N_189028) {
TY56526* Result_189029;
TY189010* G_189030;
NI I_189054;
NI HEX3Atmp_189102;
NI LOC1;
NI Res_189104;
NimStringDesc* Imported_189067;
NimStringDesc* LOC3;
TY38661 LOC4;
NimStringDesc* Imported_189080;
NimStringDesc* LOC5;
TY38661 LOC6;
NI I_189089;
NI HEX3Atmp_189105;
NI LOC7;
NI Res_189107;
TY56526* LOC9;
Result_189029 = 0;
G_189030 = 0;
Imported_189067 = 0;
Imported_189080 = 0;
Result_189029 = NIM_NIL;
Result_189029 = N_189028;
G_189030 = NIM_NIL;
G_189030 = ((TY189010*) (C_189027));
switch ((*N_189028).Kind) {
case ((NU8) 102):
I_189054 = 0;
HEX3Atmp_189102 = 0;
LOC1 = Sonslen_56804(N_189028);
HEX3Atmp_189102 = (NI64)(LOC1 - 1);
Res_189104 = 0;
Res_189104 = 0;
while (1) {
if (!(Res_189104 <= HEX3Atmp_189102)) goto LA2;
I_189054 = Res_189104;
Imported_189067 = NIM_NIL;
LOC3 = 0;
LOC3 = Getmodulefile_111013((*N_189028).KindU.S6.Sons->data[I_189054]);
memset((void*)&LOC4, 0, sizeof(LOC4));
nossplitFile(LOC3, &LOC4);
Imported_189067 = copyString(LOC4.Name);
Adddependencyaux_189016((*(*(*G_189030).Module).Name).S, Imported_189067);
Res_189104 += 1;
} LA2: ;
break;
case ((NU8) 103):
Imported_189080 = NIM_NIL;
LOC5 = 0;
LOC5 = Getmodulefile_111013((*N_189028).KindU.S6.Sons->data[0]);
memset((void*)&LOC6, 0, sizeof(LOC6));
nossplitFile(LOC5, &LOC6);
Imported_189080 = copyString(LOC6.Name);
Adddependencyaux_189016((*(*(*G_189030).Module).Name).S, Imported_189080);
break;
case ((NU8) 101):
case ((NU8) 99):
case ((NU8) 106):
case ((NU8) 107):
I_189089 = 0;
HEX3Atmp_189105 = 0;
LOC7 = Sonslen_56804(N_189028);
HEX3Atmp_189105 = (NI64)(LOC7 - 1);
Res_189107 = 0;
Res_189107 = 0;
while (1) {
if (!(Res_189107 <= HEX3Atmp_189105)) goto LA8;
I_189089 = Res_189107;
LOC9 = 0;
LOC9 = Adddotdependency_189025(C_189027, (*N_189028).KindU.S6.Sons->data[I_189089]);
Res_189107 += 1;
} LA8: ;
break;
default:
break;
}
return Result_189029;
}
N_NIMCALL(TY106006, Gendependpass_189004)(void) {
TY106006 Result_189138;
memset((void*)&Result_189138, 0, sizeof(Result_189138));
Initpass_106031(&Result_189138);
Result_189138.Open = Myopen_189115;
Result_189138.Process = Adddotdependency_189025;
return Result_189138;
}
N_NIMCALL(void, Generatedot_189006)(NimStringDesc* Project_189008) {
TY179695 LOC1;
NimStringDesc* LOC2;
NimStringDesc* LOC3;
TY53008* LOC4;
NimStringDesc* LOC5;
memset((void*)&LOC1, 0, sizeof(LOC1));
LOC2 = 0;
LOC2 = nosextractFilename(Project_189008);
LOC3 = 0;
LOC3 = nosChangeFileExt(LOC2, ((NimStringDesc*) &TMP199544));
LOC1[0] = Torope_53046(LOC3);
LOC1[1] = Gdotgraph_189015;
LOC4 = 0;
LOC4 = Ropef_53066(((NimStringDesc*) &TMP199543), LOC1, 2);
LOC5 = 0;
LOC5 = nosChangeFileExt(Project_189008, ((NimStringDesc*) &TMP199545));
Writerope_53055(LOC4, LOC5);
}
N_NOINLINE(void, dependsInit)(void) {
}

