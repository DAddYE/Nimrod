/* Generated by Nimrod Compiler v0.8.9 */
/*   (c) 2010 Andreas Rumpf */

typedef long int NI;
typedef unsigned long int NU;
#include "nimbase.h"

typedef struct TY49563 TY49563;
typedef struct TY49561 TY49561;
typedef struct TY49559 TY49559;
typedef struct TY48005 TY48005;
typedef struct TNimObject TNimObject;
typedef struct TGenericSeq TGenericSeq;
typedef struct TY49527 TY49527;
typedef struct TY49547 TY49547;
typedef struct TNimType TNimType;
typedef struct TNimNode TNimNode;
typedef struct TY10402 TY10402;
typedef struct TY7804 TY7804;
typedef struct TY10790 TY10790;
typedef struct TY10418 TY10418;
typedef struct TY10414 TY10414;
typedef struct TY10410 TY10410;
typedef struct TY10788 TY10788;
typedef struct NimStringDesc NimStringDesc;
typedef struct TY101002 TY101002;
typedef struct TY101012 TY101012;
typedef struct TY99002 TY99002;
typedef struct TY101006 TY101006;
typedef struct TY49525 TY49525;
typedef struct TY53107 TY53107;
typedef struct TY53109 TY53109;
typedef struct TY49529 TY49529;
typedef struct TY49900 TY49900;
typedef struct TY49896 TY49896;
typedef struct TY49898 TY49898;
typedef struct TY37019 TY37019;
typedef struct TY37013 TY37013;
typedef struct TY49543 TY49543;
typedef struct TY49551 TY49551;
typedef struct TY48011 TY48011;
typedef struct TY41532 TY41532;
typedef struct TY49539 TY49539;
typedef struct TY46008 TY46008;
typedef struct TY49549 TY49549;
typedef struct TY49519 TY49519;
struct TY49559 {
TY48005* Key;
TNimObject* Val;
};
struct TGenericSeq {
NI len;
NI space;
};
struct TY49563 {
NI Counter;
TY49561* Data;
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
struct TY10402 {
NI Refcount;
TNimType* Typ;
};
typedef N_STDCALL_PTR(void, TY7816) (TY7804* L_7818);
struct TY10418 {
NI Len;
NI Cap;
TY10402** D;
};
struct TY10414 {
NI Counter;
NI Max;
TY10410* Head;
TY10410** Data;
};
struct TY7804 {
void* Debuginfo;
NI32 Lockcount;
NI32 Recursioncount;
NI Owningthread;
NI Locksemaphore;
NI32 Reserved;
};
struct TY10788 {
NI Stackscans;
NI Cyclecollections;
NI Maxthreshold;
NI Maxstacksize;
NI Maxstackcells;
NI Cycletablesize;
};
struct TY10790 {
TY10418 Zct;
TY10418 Decstack;
TY10414 Cycleroots;
TY10418 Tempstack;
TY7804 Cyclerootslock;
TY7804 Zctlock;
TY10788 Stat;
};
typedef N_STDCALL_PTR(void, TY7820) (TY7804* L_7822);
typedef NIM_CHAR TY239[100000001];
struct NimStringDesc {
  TGenericSeq Sup;
TY239 data;
};
struct TNimObject {
TNimType* m_type;
};
struct TY99002 {
  TNimObject Sup;
};
struct TY49529 {
TNimType* m_type;
NI Counter;
TY49527* Data;
};
struct TY53107 {
NI Tos;
TY53109* Stack;
};
struct TY49900 {
NI Counter;
NI Max;
TY49896* Head;
TY49898* Data;
};
struct TY37019 {
TNimType* m_type;
TY37013* Head;
TY37013* Tail;
NI Counter;
};
typedef N_NIMCALL_PTR(TY49525*, TY101032) (TY101012* C_101033, TY49525* N_101034);
typedef N_NIMCALL_PTR(TY49525*, TY101037) (TY101012* C_101038, TY49525* N_101039);
struct TY101012 {
  TY99002 Sup;
TY49547* Module;
TY101006* P;
NI Instcounter;
TY49525* Generics;
NI Lastgenericidx;
TY53107 Tab;
TY49900 Ambiguoussymbols;
TY49527* Converters;
TY37019 Optionstack;
TY37019 Libs;
NIM_BOOL Fromcache;
TY101032 Semconstexpr;
TY101037 Semexpr;
TY49900 Includedfiles;
NimStringDesc* Filename;
TY49529 Userpragmas;
};
struct TY101006 {
TY49547* Owner;
TY49547* Resultsym;
NI Nestedloopcounter;
NI Nestedblockcounter;
};
struct TY37013 {
  TNimObject Sup;
TY37013* Prev;
TY37013* Next;
};
struct TY101002 {
  TY37013 Sup;
NU32 Options;
NU8 Defaultcc;
TY49543* Dynlib;
NU32 Notes;
};
struct TY48005 {
  TNimObject Sup;
NI Id;
};
struct TY41532 {
NI16 Line;
NI16 Col;
NI32 Fileindex;
};
struct TY49539 {
NU8 K;
NU8 S;
NU8 Flags;
TY49551* T;
TY46008* R;
NI A;
};
struct TY49547 {
  TY48005 Sup;
NU8 Kind;
NU8 Magic;
TY49551* Typ;
TY48011* Name;
TY41532 Info;
TY49547* Owner;
NU32 Flags;
TY49529 Tab;
TY49525* Ast;
NU32 Options;
NI Position;
NI Offset;
TY49539 Loc;
TY49543* Annex;
};
struct TY49543 {
  TY37013 Sup;
NU8 Kind;
NIM_BOOL Generated;
TY46008* Name;
TY49525* Path;
};
struct TY49551 {
  TY48005 Sup;
NU8 Kind;
TY49549* Sons;
TY49525* N;
NU8 Flags;
NU8 Callconv;
TY49547* Owner;
TY49547* Sym;
NI64 Size;
NI Align;
NI Containerid;
TY49539 Loc;
};
struct TY49525 {
TY49551* Typ;
NimStringDesc* Comment;
TY41532 Info;
NU8 Flags;
NU8 Kind;
union {
struct {NI64 Intval;
} S1;
struct {NF64 Floatval;
} S2;
struct {NimStringDesc* Strval;
} S3;
struct {TY49547* Sym;
} S4;
struct {TY48011* Ident;
} S5;
struct {TY49519* Sons;
} S6;
} KindU;
};
typedef NU8 TY49999[16];
typedef NI TY8414[16];
struct TY10410 {
TY10410* Next;
NI Key;
TY8414 Bits;
};
struct TY49896 {
TY49896* Next;
NI Key;
TY8414 Bits;
};
struct TY48011 {
  TY48005 Sup;
NimStringDesc* S;
TY48011* Next;
NI H;
};
struct TY46008 {
  TNimObject Sup;
TY46008* Left;
TY46008* Right;
NI Length;
NimStringDesc* Data;
};
struct TY49561 {
  TGenericSeq Sup;
  TY49559 data[SEQ_DECL_SIZE];
};
struct TY49527 {
  TGenericSeq Sup;
  TY49547* data[SEQ_DECL_SIZE];
};
struct TY53109 {
  TGenericSeq Sup;
  TY49529 data[SEQ_DECL_SIZE];
};
struct TY49898 {
  TGenericSeq Sup;
  TY49896* data[SEQ_DECL_SIZE];
};
struct TY49549 {
  TGenericSeq Sup;
  TY49551* data[SEQ_DECL_SIZE];
};
struct TY49519 {
  TGenericSeq Sup;
  TY49525* data[SEQ_DECL_SIZE];
};
N_NIMCALL(void*, newSeq)(TNimType* Typ_12604, NI Len_12605);
static N_INLINE(void, asgnRef)(void** Dest_11614, void* Src_11615);
static N_INLINE(void, Incref_11602)(TY10402* C_11604);
static N_INLINE(NI, Atomicinc_2801)(NI* Memloc_2804, NI X_2805);
static N_INLINE(NIM_BOOL, Canbecycleroot_10840)(TY10402* C_10842);
static N_INLINE(void, Rtladdcycleroot_11452)(TY10402* C_11454);
N_NOINLINE(void, Incl_10674)(TY10414* S_10677, TY10402* Cell_10678);
static N_INLINE(TY10402*, Usrtocell_10836)(void* Usr_10838);
static N_INLINE(void, Decref_11464)(TY10402* C_11466);
static N_INLINE(NI, Atomicdec_2806)(NI* Memloc_2809, NI X_2810);
static N_INLINE(void, Rtladdzct_11458)(TY10402* C_11460);
N_NOINLINE(void, Addzct_10825)(TY10418* S_10828, TY10402* C_10829);
N_NIMCALL(TY49547*, Getcurrowner_101107)(void);
N_NOINLINE(void, raiseIndexError)(void);
N_NIMCALL(void, Pushowner_101109)(TY49547* Owner_101111);
N_NIMCALL(TGenericSeq*, incrSeq)(TGenericSeq* Seq_17235, NI Elemsize_17236);
N_NIMCALL(void, Popowner_101112)(void);
N_NIMCALL(void, Internalerror_41571)(NimStringDesc* Errmsg_41573);
static N_INLINE(NI, subInt)(NI A_5803, NI B_5804);
N_NOINLINE(void, raiseOverflow)(void);
N_NIMCALL(TGenericSeq*, setLengthSeq)(TGenericSeq* Seq_17403, NI Elemsize_17404, NI Newlen_17405);
N_NIMCALL(TY101002*, Lastoptionentry_101053)(TY101012* C_101055);
N_NIMCALL(void, chckObj)(TNimType* Obj_5375, TNimType* Subclass_5376);
N_NIMCALL(TY101006*, Newproccon_101050)(TY49547* Owner_101052);
N_NIMCALL(void*, newObj)(TNimType* Typ_12107, NI Size_12108);
N_NIMCALL(TY101002*, Newoptionentry_101056)(void);
static N_INLINE(void, asgnRefNoCycle)(void** Dest_11618, void* Src_11619);
N_NIMCALL(TY101012*, Newcontext_101046)(TY49547* Module_101048, NimStringDesc* Nimfile_101049);
N_NIMCALL(void, objectInit)(void* Dest_18062, TNimType* Typ_18063);
N_NIMCALL(void, Initsymtab_53111)(TY53107* Tab_53114);
N_NIMCALL(void, Intsetinit_49924)(TY49900* S_49927);
N_NIMCALL(void, Initlinkedlist_37031)(TY37019* List_37034);
N_NIMCALL(void, Append_37035)(TY37019* List_37038, TY37013* Entry_37039);
N_NIMCALL(TY49525*, Newnode_49710)(NU8 Kind_49712);
N_NIMCALL(NimStringDesc*, copyString)(NimStringDesc* Src_17108);
N_NIMCALL(void, Initstrtable_49746)(TY49529* X_49749);
N_NIMCALL(void, Addconverter_101058)(TY101012* C_101060, TY49547* Conv_101061);
static N_INLINE(NI, addInt)(NI A_5603, NI B_5604);
N_NIMCALL(TY49543*, Newlib_101062)(NU8 Kind_101064);
N_NIMCALL(void, Addtolib_101065)(TY49543* Lib_101067, TY49547* Sym_101068);
N_NIMCALL(void, Limessage_41562)(TY41532 Info_41564, NU8 Msg_41565, NimStringDesc* Arg_41566);
N_NIMCALL(TY49551*, Makeptrtype_101069)(TY101012* C_101071, TY49551* Basetype_101072);
N_NIMCALL(void, Addson_49827)(TY49551* Father_49829, TY49551* Son_49830);
N_NIMCALL(TY49551*, Makevartype_101073)(TY101012* C_101075, TY49551* Basetype_101076);
N_NIMCALL(TY49551*, Newtypes_101077)(NU8 Kind_101079, TY101012* C_101080);
N_NIMCALL(TY49551*, Newtype_49706)(NU8 Kind_49708, TY49547* Owner_49709);
N_NIMCALL(void, Filltypes_101081)(TY49551* Dest_101083, NU8 Kind_101084, TY101012* C_101085);
N_NIMCALL(TY49551*, Makerangetype_101086)(TY101012* C_101088, NI64 First_101089, NI64 Last_101090, TY41532 Info_101091);
N_NIMCALL(TY49525*, Newnodei_49737)(NU8 Kind_49739, TY41532 Info_49740);
N_NIMCALL(void, Addson_49823)(TY49525* Father_49825, TY49525* Son_49826);
N_NIMCALL(TY49525*, Newintnode_49713)(NU8 Kind_49715, NI64 Intval_49716);
N_NIMCALL(TY49551*, Getsystype_96008)(NU8 Kind_96010);
N_NIMCALL(void, Illformedast_101092)(TY49525* N_101094);
N_NIMCALL(NimStringDesc*, Rendertree_79042)(TY49525* N_79044, NU8 Renderflags_79047);
N_NIMCALL(TY49525*, Getson_101095)(TY49525* N_101097, NI Indx_101098);
N_NIMCALL(NI, Sonslen_49803)(TY49525* N_49805);
N_NOINLINE(void, raiseFieldError)(NimStringDesc* F_5275);
N_NIMCALL(void, Checksonslen_101099)(TY49525* N_101101, NI Length_101102);
N_NIMCALL(void, Checkminsonslen_101103)(TY49525* N_101105, NI Length_101106);
N_NIMCALL(void, Initidtable_49754)(TY49563* X_49757);
STRING_LITERAL(TMP101183, "popOwner", 8);
STRING_LITERAL(TMP101222, "owner is nil", 12);
STRING_LITERAL(TMP101380, "", 0);
STRING_LITERAL(TMP101397, "makePtrType", 11);
STRING_LITERAL(TMP101414, "makeVarType", 11);
static NIM_CONST TY49999 TMP101467 = {
0xEC, 0xFF, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}
;STRING_LITERAL(TMP101468, "sons", 4);
TY49563 Ginsttypes_101045;
TY49527* Gowners_101131;
extern TNimType* NTI49527; /* TSymSeq */
extern TY7816 Dl_7815;
extern TY10790 Gch_10810;
extern TY7820 Dl_7819;
extern TNimType* NTI101002; /* TOptionEntry */
extern TNimType* NTI101008; /* PProcCon */
extern TNimType* NTI101004; /* POptionEntry */
extern NU32 Goptions_40075;
extern NU32 Gnotes_41539;
extern TNimType* NTI101010; /* PContext */
extern TNimType* NTI101012; /* TContext */
extern TNimType* NTI49545; /* PLib */
extern TNimType* NTI49543; /* TLib */
static N_INLINE(NI, Atomicinc_2801)(NI* Memloc_2804, NI X_2805) {
NI Result_7208;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "atomicInc";
F.prev = framePtr;
F.filename = "/home/andreas/projects/nimrod/lib/system/systhread.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
Result_7208 = 0;
F.line = 29;F.filename = "systhread.nim";
Result_7208 = __sync_add_and_fetch(Memloc_2804, X_2805);
framePtr = framePtr->prev;
return Result_7208;
}
static N_INLINE(NIM_BOOL, Canbecycleroot_10840)(TY10402* C_10842) {
NIM_BOOL Result_10843;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "canbeCycleRoot";
F.prev = framePtr;
F.filename = "/home/andreas/projects/nimrod/lib/system/gc.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
Result_10843 = 0;
F.line = 103;F.filename = "gc.nim";
Result_10843 = !((((*(*C_10842).Typ).flags &(1<<((((NU8) 1))&7)))!=0));
framePtr = framePtr->prev;
return Result_10843;
}
static N_INLINE(void, Rtladdcycleroot_11452)(TY10402* C_11454) {
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "rtlAddCycleRoot";
F.prev = framePtr;
F.filename = "/home/andreas/projects/nimrod/lib/system/gc.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
F.line = 205;F.filename = "gc.nim";
if (!NIM_TRUE) goto LA2;
F.line = 205;F.filename = "gc.nim";
Dl_7815(&Gch_10810.Cyclerootslock);
LA2: ;
F.line = 206;F.filename = "gc.nim";
Incl_10674(&Gch_10810.Cycleroots, C_11454);
F.line = 207;F.filename = "gc.nim";
if (!NIM_TRUE) goto LA5;
F.line = 207;F.filename = "gc.nim";
Dl_7819(&Gch_10810.Cyclerootslock);
LA5: ;
framePtr = framePtr->prev;
}
static N_INLINE(void, Incref_11602)(TY10402* C_11604) {
NI LOC1;
NIM_BOOL LOC3;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "incRef";
F.prev = framePtr;
F.filename = "/home/andreas/projects/nimrod/lib/system/gc.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
F.line = 226;F.filename = "gc.nim";
LOC1 = Atomicinc_2801(&(*C_11604).Refcount, 8);
F.line = 227;F.filename = "gc.nim";
LOC3 = Canbecycleroot_10840(C_11604);
if (!LOC3) goto LA4;
F.line = 228;F.filename = "gc.nim";
Rtladdcycleroot_11452(C_11604);
LA4: ;
framePtr = framePtr->prev;
}
static N_INLINE(TY10402*, Usrtocell_10836)(void* Usr_10838) {
TY10402* Result_10839;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "usrToCell";
F.prev = framePtr;
F.filename = "/home/andreas/projects/nimrod/lib/system/gc.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
Result_10839 = 0;
F.line = 100;F.filename = "gc.nim";
Result_10839 = ((TY10402*) ((NI32)((NU32)(((NI) (Usr_10838))) - (NU32)(((NI) (((NI)sizeof(TY10402))))))));
framePtr = framePtr->prev;
return Result_10839;
}
static N_INLINE(NI, Atomicdec_2806)(NI* Memloc_2809, NI X_2810) {
NI Result_7406;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "atomicDec";
F.prev = framePtr;
F.filename = "/home/andreas/projects/nimrod/lib/system/systhread.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
Result_7406 = 0;
F.line = 37;F.filename = "systhread.nim";
Result_7406 = __sync_sub_and_fetch(Memloc_2809, X_2810);
framePtr = framePtr->prev;
return Result_7406;
}
static N_INLINE(void, Rtladdzct_11458)(TY10402* C_11460) {
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "rtlAddZCT";
F.prev = framePtr;
F.filename = "/home/andreas/projects/nimrod/lib/system/gc.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
F.line = 211;F.filename = "gc.nim";
if (!NIM_TRUE) goto LA2;
F.line = 211;F.filename = "gc.nim";
Dl_7815(&Gch_10810.Zctlock);
LA2: ;
F.line = 212;F.filename = "gc.nim";
Addzct_10825(&Gch_10810.Zct, C_11460);
F.line = 213;F.filename = "gc.nim";
if (!NIM_TRUE) goto LA5;
F.line = 213;F.filename = "gc.nim";
Dl_7819(&Gch_10810.Zctlock);
LA5: ;
framePtr = framePtr->prev;
}
static N_INLINE(void, Decref_11464)(TY10402* C_11466) {
NI LOC2;
NIM_BOOL LOC5;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "decRef";
F.prev = framePtr;
F.filename = "/home/andreas/projects/nimrod/lib/system/gc.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
F.line = 219;F.filename = "gc.nim";
F.line = 220;F.filename = "gc.nim";
LOC2 = Atomicdec_2806(&(*C_11466).Refcount, 8);
if (!((NU32)(LOC2) < (NU32)(8))) goto LA3;
F.line = 221;F.filename = "gc.nim";
Rtladdzct_11458(C_11466);
goto LA1;
LA3: ;
LOC5 = Canbecycleroot_10840(C_11466);
if (!LOC5) goto LA6;
F.line = 223;F.filename = "gc.nim";
Rtladdcycleroot_11452(C_11466);
goto LA1;
LA6: ;
LA1: ;
framePtr = framePtr->prev;
}
static N_INLINE(void, asgnRef)(void** Dest_11614, void* Src_11615) {
TY10402* LOC4;
TY10402* LOC8;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "asgnRef";
F.prev = framePtr;
F.filename = "/home/andreas/projects/nimrod/lib/system/gc.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
F.line = 235;F.filename = "gc.nim";
F.line = 237;F.filename = "gc.nim";
if (!!((Src_11615 == NIM_NIL))) goto LA2;
F.line = 237;F.filename = "gc.nim";
LOC4 = Usrtocell_10836(Src_11615);
Incref_11602(LOC4);
LA2: ;
F.line = 238;F.filename = "gc.nim";
if (!!(((*Dest_11614) == NIM_NIL))) goto LA6;
F.line = 238;F.filename = "gc.nim";
LOC8 = Usrtocell_10836((*Dest_11614));
Decref_11464(LOC8);
LA6: ;
F.line = 239;F.filename = "gc.nim";
(*Dest_11614) = Src_11615;
framePtr = framePtr->prev;
}
N_NIMCALL(TY49547*, Getcurrowner_101107)(void) {
TY49547* Result_101134;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "getCurrOwner";
F.prev = framePtr;
F.filename = "rod/semdata.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
Result_101134 = 0;
F.line = 91;F.filename = "semdata.nim";
if ((NU)((Gowners_101131->Sup.len-1)) >= (NU)(Gowners_101131->Sup.len)) raiseIndexError();
Result_101134 = Gowners_101131->data[(Gowners_101131->Sup.len-1)];
framePtr = framePtr->prev;
return Result_101134;
}
N_NIMCALL(void, Pushowner_101109)(TY49547* Owner_101111) {
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "PushOwner";
F.prev = framePtr;
F.filename = "rod/semdata.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
F.line = 94;F.filename = "semdata.nim";
Gowners_101131 = (TY49527*) incrSeq(&(Gowners_101131)->Sup, sizeof(TY49547*));
asgnRef((void**) &Gowners_101131->data[Gowners_101131->Sup.len-1], Owner_101111);
framePtr = framePtr->prev;
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
N_NIMCALL(void, Popowner_101112)(void) {
NI Length_101168;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "PopOwner";
F.prev = framePtr;
F.filename = "rod/semdata.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
Length_101168 = 0;
F.line = 97;F.filename = "semdata.nim";
Length_101168 = Gowners_101131->Sup.len;
F.line = 98;F.filename = "semdata.nim";
if (!(Length_101168 <= 0)) goto LA2;
F.line = 98;F.filename = "semdata.nim";
Internalerror_41571(((NimStringDesc*) &TMP101183));
LA2: ;
F.line = 99;F.filename = "semdata.nim";
Gowners_101131 = (TY49527*) setLengthSeq(&(Gowners_101131)->Sup, sizeof(TY49547*), subInt(Length_101168, 1));
framePtr = framePtr->prev;
}
N_NIMCALL(TY101002*, Lastoptionentry_101053)(TY101012* C_101055) {
TY101002* Result_101187;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "lastOptionEntry";
F.prev = framePtr;
F.filename = "rod/semdata.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
Result_101187 = 0;
F.line = 102;F.filename = "semdata.nim";
if ((*C_101055).Optionstack.Tail) chckObj((*(*C_101055).Optionstack.Tail).Sup.m_type, NTI101002);
Result_101187 = ((TY101002*) ((*C_101055).Optionstack.Tail));
framePtr = framePtr->prev;
return Result_101187;
}
N_NIMCALL(TY101006*, Newproccon_101050)(TY49547* Owner_101052) {
TY101006* Result_101195;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "newProcCon";
F.prev = framePtr;
F.filename = "rod/semdata.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
Result_101195 = 0;
F.line = 105;F.filename = "semdata.nim";
if (!(Owner_101052 == NIM_NIL)) goto LA2;
F.line = 105;F.filename = "semdata.nim";
Internalerror_41571(((NimStringDesc*) &TMP101222));
LA2: ;
F.line = 106;F.filename = "semdata.nim";
Result_101195 = (TY101006*) newObj(NTI101008, sizeof(TY101006));
F.line = 107;F.filename = "semdata.nim";
asgnRef((void**) &(*Result_101195).Owner, Owner_101052);
framePtr = framePtr->prev;
return Result_101195;
}
static N_INLINE(void, asgnRefNoCycle)(void** Dest_11618, void* Src_11619) {
TY10402* C_11620;
NI LOC4;
TY10402* C_11622;
NI LOC9;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "asgnRefNoCycle";
F.prev = framePtr;
F.filename = "/home/andreas/projects/nimrod/lib/system/gc.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
F.line = 244;F.filename = "gc.nim";
if (!!((Src_11619 == NIM_NIL))) goto LA2;
C_11620 = 0;
F.line = 245;F.filename = "gc.nim";
C_11620 = Usrtocell_10836(Src_11619);
F.line = 246;F.filename = "gc.nim";
LOC4 = Atomicinc_2801(&(*C_11620).Refcount, 8);
LA2: ;
F.line = 247;F.filename = "gc.nim";
if (!!(((*Dest_11618) == NIM_NIL))) goto LA6;
C_11622 = 0;
F.line = 248;F.filename = "gc.nim";
C_11622 = Usrtocell_10836((*Dest_11618));
F.line = 249;F.filename = "gc.nim";
LOC9 = Atomicdec_2806(&(*C_11622).Refcount, 8);
if (!((NU32)(LOC9) < (NU32)(8))) goto LA10;
F.line = 250;F.filename = "gc.nim";
Rtladdzct_11458(C_11622);
LA10: ;
LA6: ;
F.line = 251;F.filename = "gc.nim";
(*Dest_11618) = Src_11619;
framePtr = framePtr->prev;
}
N_NIMCALL(TY101002*, Newoptionentry_101056)(void) {
TY101002* Result_101226;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "newOptionEntry";
F.prev = framePtr;
F.filename = "rod/semdata.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
Result_101226 = 0;
F.line = 110;F.filename = "semdata.nim";
Result_101226 = (TY101002*) newObj(NTI101004, sizeof(TY101002));
(*Result_101226).Sup.Sup.m_type = NTI101002;
F.line = 111;F.filename = "semdata.nim";
(*Result_101226).Options = Goptions_40075;
F.line = 112;F.filename = "semdata.nim";
(*Result_101226).Defaultcc = ((NU8) 0);
F.line = 113;F.filename = "semdata.nim";
asgnRefNoCycle((void**) &(*Result_101226).Dynlib, NIM_NIL);
F.line = 114;F.filename = "semdata.nim";
(*Result_101226).Notes = Gnotes_41539;
framePtr = framePtr->prev;
return Result_101226;
}
N_NIMCALL(TY101012*, Newcontext_101046)(TY49547* Module_101048, NimStringDesc* Nimfile_101049) {
TY101012* Result_101246;
TY101002* LOC1;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "newContext";
F.prev = framePtr;
F.filename = "rod/semdata.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
Result_101246 = 0;
F.line = 117;F.filename = "semdata.nim";
Result_101246 = (TY101012*) newObj(NTI101010, sizeof(TY101012));
objectInit(Result_101246, NTI101012);
F.line = 118;F.filename = "semdata.nim";
Initsymtab_53111(&(*Result_101246).Tab);
F.line = 119;F.filename = "semdata.nim";
Intsetinit_49924(&(*Result_101246).Ambiguoussymbols);
F.line = 120;F.filename = "semdata.nim";
Initlinkedlist_37031(&(*Result_101246).Optionstack);
F.line = 121;F.filename = "semdata.nim";
Initlinkedlist_37031(&(*Result_101246).Libs);
F.line = 122;F.filename = "semdata.nim";
LOC1 = 0;
LOC1 = Newoptionentry_101056();
Append_37035(&(*Result_101246).Optionstack, &LOC1->Sup);
F.line = 123;F.filename = "semdata.nim";
asgnRef((void**) &(*Result_101246).Module, Module_101048);
F.line = 124;F.filename = "semdata.nim";
asgnRefNoCycle((void**) &(*Result_101246).Generics, Newnode_49710(((NU8) 101)));
F.line = 125;F.filename = "semdata.nim";
asgnRef((void**) &(*Result_101246).Converters, (TY49527*) newSeq(NTI49527, 0));
F.line = 126;F.filename = "semdata.nim";
asgnRefNoCycle((void**) &(*Result_101246).Filename, copyString(Nimfile_101049));
F.line = 127;F.filename = "semdata.nim";
Intsetinit_49924(&(*Result_101246).Includedfiles);
F.line = 128;F.filename = "semdata.nim";
Initstrtable_49746(&(*Result_101246).Userpragmas);
framePtr = framePtr->prev;
return Result_101246;
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
N_NIMCALL(void, Addconverter_101058)(TY101012* C_101060, TY49547* Conv_101061) {
NI L_101302;
NI I_101325;
NI HEX3Atmp_101341;
NI Res_101343;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "addConverter";
F.prev = framePtr;
F.filename = "rod/semdata.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
L_101302 = 0;
F.line = 131;F.filename = "semdata.nim";
L_101302 = (*C_101060).Converters->Sup.len;
I_101325 = 0;
HEX3Atmp_101341 = 0;
F.line = 132;F.filename = "semdata.nim";
HEX3Atmp_101341 = subInt(L_101302, 1);
Res_101343 = 0;
F.line = 1019;F.filename = "system.nim";
Res_101343 = 0;
F.line = 1020;F.filename = "system.nim";
while (1) {
if (!(Res_101343 <= HEX3Atmp_101341)) goto LA1;
F.line = 1019;F.filename = "system.nim";
I_101325 = Res_101343;
F.line = 133;F.filename = "semdata.nim";
if ((NU)(I_101325) >= (NU)((*C_101060).Converters->Sup.len)) raiseIndexError();
if (!((*(*C_101060).Converters->data[I_101325]).Sup.Id == (*Conv_101061).Sup.Id)) goto LA3;
F.line = 133;F.filename = "semdata.nim";
goto BeforeRet;
LA3: ;
F.line = 1022;F.filename = "system.nim";
Res_101343 = addInt(Res_101343, 1);
} LA1: ;
F.line = 134;F.filename = "semdata.nim";
(*C_101060).Converters = (TY49527*) setLengthSeq(&((*C_101060).Converters)->Sup, sizeof(TY49547*), addInt(L_101302, 1));
F.line = 135;F.filename = "semdata.nim";
if ((NU)(L_101302) >= (NU)((*C_101060).Converters->Sup.len)) raiseIndexError();
asgnRef((void**) &(*C_101060).Converters->data[L_101302], Conv_101061);
BeforeRet: ;
framePtr = framePtr->prev;
}
N_NIMCALL(TY49543*, Newlib_101062)(NU8 Kind_101064) {
TY49543* Result_101349;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "newLib";
F.prev = framePtr;
F.filename = "rod/semdata.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
Result_101349 = 0;
F.line = 138;F.filename = "semdata.nim";
Result_101349 = (TY49543*) newObj(NTI49545, sizeof(TY49543));
(*Result_101349).Sup.Sup.m_type = NTI49543;
F.line = 139;F.filename = "semdata.nim";
(*Result_101349).Kind = Kind_101064;
framePtr = framePtr->prev;
return Result_101349;
}
N_NIMCALL(void, Addtolib_101065)(TY49543* Lib_101067, TY49547* Sym_101068) {
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "addToLib";
F.prev = framePtr;
F.filename = "rod/semdata.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
F.line = 143;F.filename = "semdata.nim";
if (!!(((*Sym_101068).Annex == NIM_NIL))) goto LA2;
F.line = 143;F.filename = "semdata.nim";
Limessage_41562((*Sym_101068).Info, ((NU8) 26), ((NimStringDesc*) &TMP101380));
LA2: ;
F.line = 144;F.filename = "semdata.nim";
asgnRefNoCycle((void**) &(*Sym_101068).Annex, Lib_101067);
framePtr = framePtr->prev;
}
N_NIMCALL(TY49551*, Makeptrtype_101069)(TY101012* C_101071, TY49551* Basetype_101072) {
TY49551* Result_101385;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "makePtrType";
F.prev = framePtr;
F.filename = "rod/semdata.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
Result_101385 = 0;
F.line = 147;F.filename = "semdata.nim";
if (!(Basetype_101072 == NIM_NIL)) goto LA2;
F.line = 147;F.filename = "semdata.nim";
Internalerror_41571(((NimStringDesc*) &TMP101397));
LA2: ;
F.line = 148;F.filename = "semdata.nim";
Result_101385 = Newtypes_101077(((NU8) 21), C_101071);
F.line = 149;F.filename = "semdata.nim";
Addson_49827(Result_101385, Basetype_101072);
framePtr = framePtr->prev;
return Result_101385;
}
N_NIMCALL(TY49551*, Makevartype_101073)(TY101012* C_101075, TY49551* Basetype_101076) {
TY49551* Result_101402;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "makeVarType";
F.prev = framePtr;
F.filename = "rod/semdata.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
Result_101402 = 0;
F.line = 152;F.filename = "semdata.nim";
if (!(Basetype_101076 == NIM_NIL)) goto LA2;
F.line = 152;F.filename = "semdata.nim";
Internalerror_41571(((NimStringDesc*) &TMP101414));
LA2: ;
F.line = 153;F.filename = "semdata.nim";
Result_101402 = Newtypes_101077(((NU8) 23), C_101075);
F.line = 154;F.filename = "semdata.nim";
Addson_49827(Result_101402, Basetype_101076);
framePtr = framePtr->prev;
return Result_101402;
}
N_NIMCALL(TY49551*, Newtypes_101077)(NU8 Kind_101079, TY101012* C_101080) {
TY49551* Result_101419;
TY49547* LOC1;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "newTypeS";
F.prev = framePtr;
F.filename = "rod/semdata.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
Result_101419 = 0;
F.line = 157;F.filename = "semdata.nim";
LOC1 = 0;
LOC1 = Getcurrowner_101107();
Result_101419 = Newtype_49706(Kind_101079, LOC1);
framePtr = framePtr->prev;
return Result_101419;
}
N_NIMCALL(void, Filltypes_101081)(TY49551* Dest_101083, NU8 Kind_101084, TY101012* C_101085) {
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "fillTypeS";
F.prev = framePtr;
F.filename = "rod/semdata.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
F.line = 160;F.filename = "semdata.nim";
(*Dest_101083).Kind = Kind_101084;
F.line = 161;F.filename = "semdata.nim";
asgnRef((void**) &(*Dest_101083).Owner, Getcurrowner_101107());
F.line = 162;F.filename = "semdata.nim";
(*Dest_101083).Size = -1;
framePtr = framePtr->prev;
}
N_NIMCALL(TY49551*, Makerangetype_101086)(TY101012* C_101088, NI64 First_101089, NI64 Last_101090, TY41532 Info_101091) {
TY49551* Result_101431;
TY49525* N_101432;
TY49525* LOC1;
TY49525* LOC2;
TY49551* LOC3;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "makeRangeType";
F.prev = framePtr;
F.filename = "rod/semdata.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
Result_101431 = 0;
N_101432 = 0;
F.line = 166;F.filename = "semdata.nim";
N_101432 = Newnodei_49737(((NU8) 35), Info_101091);
F.line = 167;F.filename = "semdata.nim";
LOC1 = 0;
LOC1 = Newintnode_49713(((NU8) 6), First_101089);
Addson_49823(N_101432, LOC1);
F.line = 168;F.filename = "semdata.nim";
LOC2 = 0;
LOC2 = Newintnode_49713(((NU8) 6), Last_101090);
Addson_49823(N_101432, LOC2);
F.line = 169;F.filename = "semdata.nim";
Result_101431 = Newtypes_101077(((NU8) 20), C_101088);
F.line = 170;F.filename = "semdata.nim";
asgnRefNoCycle((void**) &(*Result_101431).N, N_101432);
F.line = 171;F.filename = "semdata.nim";
LOC3 = 0;
LOC3 = Getsystype_96008(((NU8) 31));
Addson_49827(Result_101431, LOC3);
framePtr = framePtr->prev;
return Result_101431;
}
N_NIMCALL(void, Illformedast_101092)(TY49525* N_101094) {
NimStringDesc* LOC1;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "illFormedAst";
F.prev = framePtr;
F.filename = "rod/semdata.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
F.line = 174;F.filename = "semdata.nim";
LOC1 = 0;
LOC1 = Rendertree_79042(N_101094, 4);
Limessage_41562((*N_101094).Info, ((NU8) 1), LOC1);
framePtr = framePtr->prev;
}
N_NIMCALL(TY49525*, Getson_101095)(TY49525* N_101097, NI Indx_101098) {
TY49525* Result_101441;
NIM_BOOL LOC2;
NI LOC4;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "getSon";
F.prev = framePtr;
F.filename = "rod/semdata.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
Result_101441 = 0;
F.line = 177;F.filename = "semdata.nim";
LOC2 = !((N_101097 == NIM_NIL));
if (!(LOC2)) goto LA3;
LOC4 = Sonslen_49803(N_101097);
LOC2 = (Indx_101098 < LOC4);
LA3: ;
if (!LOC2) goto LA5;
F.line = 178;F.filename = "semdata.nim";
if (((TMP101467[(*N_101097).Kind/8] &(1<<((*N_101097).Kind%8)))!=0)) raiseFieldError(((NimStringDesc*) &TMP101468));
if ((NU)(Indx_101098) >= (NU)((*N_101097).KindU.S6.Sons->Sup.len)) raiseIndexError();
Result_101441 = (*N_101097).KindU.S6.Sons->data[Indx_101098];
goto LA1;
LA5: ;
F.line = 180;F.filename = "semdata.nim";
Illformedast_101092(N_101097);
F.line = 181;F.filename = "semdata.nim";
Result_101441 = NIM_NIL;
LA1: ;
framePtr = framePtr->prev;
return Result_101441;
}
N_NIMCALL(void, Checksonslen_101099)(TY49525* N_101101, NI Length_101102) {
NIM_BOOL LOC2;
NI LOC4;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "checkSonsLen";
F.prev = framePtr;
F.filename = "rod/semdata.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
F.line = 184;F.filename = "semdata.nim";
LOC2 = (N_101101 == NIM_NIL);
if (LOC2) goto LA3;
LOC4 = Sonslen_49803(N_101101);
LOC2 = !((LOC4 == Length_101102));
LA3: ;
if (!LOC2) goto LA5;
F.line = 184;F.filename = "semdata.nim";
Illformedast_101092(N_101101);
LA5: ;
framePtr = framePtr->prev;
}
N_NIMCALL(void, Checkminsonslen_101103)(TY49525* N_101105, NI Length_101106) {
NIM_BOOL LOC2;
NI LOC4;
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "checkMinSonsLen";
F.prev = framePtr;
F.filename = "rod/semdata.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
F.line = 187;F.filename = "semdata.nim";
LOC2 = (N_101105 == NIM_NIL);
if (LOC2) goto LA3;
LOC4 = Sonslen_49803(N_101105);
LOC2 = (LOC4 < Length_101106);
LA3: ;
if (!LOC2) goto LA5;
F.line = 187;F.filename = "semdata.nim";
Illformedast_101092(N_101105);
LA5: ;
framePtr = framePtr->prev;
}
N_NOINLINE(void, semdataInit)(void) {
volatile struct {TFrame* prev;NCSTRING procname;NI line;NCSTRING filename;NI len;
} F;
F.procname = "semdata";
F.prev = framePtr;
F.filename = "rod/semdata.nim";
F.line = 0;
framePtr = (TFrame*)&F;
F.len = 0;
F.line = 83;F.filename = "semdata.nim";
asgnRef((void**) &Gowners_101131, (TY49527*) newSeq(NTI49527, 0));
F.line = 189;F.filename = "semdata.nim";
Initidtable_49754(&Ginsttypes_101045);
framePtr = framePtr->prev;
}
