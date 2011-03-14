/* Generated by Nimrod Compiler v0.8.11 */
/*   (c) 2011 Andreas Rumpf */

typedef long long int NI;
typedef unsigned long long int NU;
#include "nimbase.h"

typedef struct TY44019 TY44019;
typedef struct TNimType TNimType;
typedef struct TNimNode TNimNode;
typedef struct TY44013 TY44013;
typedef struct NimStringDesc NimStringDesc;
typedef struct TGenericSeq TGenericSeq;
typedef struct TY44015 TY44015;
typedef struct TNimObject TNimObject;
typedef struct TY10802 TY10802;
typedef struct TY10814 TY10814;
typedef struct TY11196 TY11196;
typedef struct TY10818 TY10818;
typedef struct TY10810 TY10810;
typedef struct TY11194 TY11194;
struct TNimType {
NI size;
NU8 kind;
NU8 flags;
TNimType* base;
TNimNode* node;
void* finalizer;
};
struct TY44019 {
TNimType* m_type;
TY44013* Head;
TY44013* Tail;
NI Counter;
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
struct TNimObject {
TNimType* m_type;
};
struct TY44013 {
  TNimObject Sup;
TY44013* Prev;
TY44013* Next;
};
struct TY44015 {
  TY44013 Sup;
NimStringDesc* Data;
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
struct TNimNode {
NU8 kind;
NI offset;
TNimType* typ;
NCSTRING name;
NI len;
TNimNode** sons;
};
typedef NI TY8814[8];
struct TY10810 {
TY10810* Next;
NI Key;
TY8814 Bits;
};
static N_INLINE(NIM_BOOL, eqStrings)(NimStringDesc* A_18649, NimStringDesc* B_18650);
N_NIMCALL(void, Prepend_44040)(TY44019* List_44043, TY44013* Entry_44044);
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
N_NIMCALL(void, unsureAsgnRef)(void** Dest_13226, void* Src_13227);
N_NIMCALL(TY44015*, Newstrentry_44130)(NimStringDesc* Data_44132);
N_NIMCALL(void*, newObj)(TNimType* Typ_13910, NI Size_13911);
static N_INLINE(void, asgnRefNoCycle)(void** Dest_13218, void* Src_13219);
N_NIMCALL(NimStringDesc*, copyString)(NimStringDesc* Src_18712);
N_NIMCALL(void, Append_44035)(TY44019* List_44038, TY44013* Entry_44039);
N_NIMCALL(NIM_BOOL, Contains_44159)(TY44019* List_44161, NimStringDesc* Data_44162);
N_NIMCALL(void, Appendstr_44061)(TY44019* List_44064, NimStringDesc* Data_44065);
extern TY11196 Gch_11214;
extern TNimType* NTI44017; /* PStrEntry */
extern TNimType* NTI44015; /* TStrEntry */
static N_INLINE(NIM_BOOL, eqStrings)(NimStringDesc* A_18649, NimStringDesc* B_18650) {
NIM_BOOL Result_18651;
NIM_BOOL LOC5;
NIM_BOOL LOC9;
int LOC11;
Result_18651 = 0;
if (!(A_18649 == B_18650)) goto LA2;
Result_18651 = NIM_TRUE;
goto BeforeRet;
LA2: ;
LOC5 = (A_18649 == NIM_NIL);
if (LOC5) goto LA6;
LOC5 = (B_18650 == NIM_NIL);
LA6: ;
if (!LOC5) goto LA7;
Result_18651 = NIM_FALSE;
goto BeforeRet;
LA7: ;
LOC9 = ((*A_18649).Sup.len == (*B_18650).Sup.len);
if (!(LOC9)) goto LA10;
LOC11 = memcmp(((NCSTRING) ((*A_18649).data)), ((NCSTRING) ((*B_18650).data)), ((int) ((NI64)((*A_18649).Sup.len * 1))));
LOC9 = (LOC11 == ((NI32) 0));
LA10: ;
Result_18651 = LOC9;
goto BeforeRet;
BeforeRet: ;
return Result_18651;
}
N_NIMCALL(NIM_BOOL, Contains_44159)(TY44019* List_44161, NimStringDesc* Data_44162) {
NIM_BOOL Result_44163;
TY44013* It_44164;
It_44164 = 0;
Result_44163 = 0;
It_44164 = NIM_NIL;
It_44164 = (*List_44161).Head;
while (1) {
if (!!((It_44164 == NIM_NIL))) goto LA1;
if (!eqStrings((*((TY44015*) (It_44164))).Data, Data_44162)) goto LA3;
Result_44163 = NIM_TRUE;
goto BeforeRet;
LA3: ;
It_44164 = (*It_44164).Next;
} LA1: ;
BeforeRet: ;
return Result_44163;
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
N_NIMCALL(void, Prepend_44040)(TY44019* List_44043, TY44013* Entry_44044) {
(*List_44043).Counter += 1;
asgnRef((void**) &(*Entry_44044).Prev, NIM_NIL);
asgnRef((void**) &(*Entry_44044).Next, (*List_44043).Head);
if (!!(((*List_44043).Head == NIM_NIL))) goto LA2;
asgnRef((void**) &(*(*List_44043).Head).Prev, Entry_44044);
LA2: ;
unsureAsgnRef((void**) &(*List_44043).Head, Entry_44044);
if (!((*List_44043).Tail == NIM_NIL)) goto LA5;
unsureAsgnRef((void**) &(*List_44043).Tail, Entry_44044);
LA5: ;
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
N_NIMCALL(TY44015*, Newstrentry_44130)(NimStringDesc* Data_44132) {
TY44015* Result_44133;
Result_44133 = 0;
Result_44133 = NIM_NIL;
Result_44133 = (TY44015*) newObj(NTI44017, sizeof(TY44015));
(*Result_44133).Sup.Sup.m_type = NTI44015;
asgnRefNoCycle((void**) &(*Result_44133).Data, copyString(Data_44132));
return Result_44133;
}
N_NIMCALL(void, Prependstr_44071)(TY44019* List_44074, NimStringDesc* Data_44075) {
TY44015* LOC1;
LOC1 = 0;
LOC1 = Newstrentry_44130(Data_44075);
Prepend_44040(List_44074, &LOC1->Sup);
}
N_NIMCALL(void, Append_44035)(TY44019* List_44038, TY44013* Entry_44039) {
(*List_44038).Counter += 1;
asgnRef((void**) &(*Entry_44039).Next, NIM_NIL);
asgnRef((void**) &(*Entry_44039).Prev, (*List_44038).Tail);
if (!!(((*List_44038).Tail == NIM_NIL))) goto LA2;
asgnRef((void**) &(*(*List_44038).Tail).Next, Entry_44039);
LA2: ;
unsureAsgnRef((void**) &(*List_44038).Tail, Entry_44039);
if (!((*List_44038).Head == NIM_NIL)) goto LA5;
unsureAsgnRef((void**) &(*List_44038).Head, Entry_44039);
LA5: ;
}
N_NIMCALL(void, Appendstr_44061)(TY44019* List_44064, NimStringDesc* Data_44065) {
TY44015* LOC1;
LOC1 = 0;
LOC1 = Newstrentry_44130(Data_44065);
Append_44035(List_44064, &LOC1->Sup);
}
N_NIMCALL(void, Initlinkedlist_44031)(TY44019* List_44034) {
(*List_44034).Counter = 0;
unsureAsgnRef((void**) &(*List_44034).Head, NIM_NIL);
unsureAsgnRef((void**) &(*List_44034).Tail, NIM_NIL);
}
N_NIMCALL(void, Remove_44045)(TY44019* List_44048, TY44013* Entry_44049) {
(*List_44048).Counter -= 1;
if (!(Entry_44049 == (*List_44048).Tail)) goto LA2;
unsureAsgnRef((void**) &(*List_44048).Tail, (*Entry_44049).Prev);
LA2: ;
if (!(Entry_44049 == (*List_44048).Head)) goto LA5;
unsureAsgnRef((void**) &(*List_44048).Head, (*Entry_44049).Next);
LA5: ;
if (!!(((*Entry_44049).Next == NIM_NIL))) goto LA8;
asgnRef((void**) &(*(*Entry_44049).Next).Prev, (*Entry_44049).Prev);
LA8: ;
if (!!(((*Entry_44049).Prev == NIM_NIL))) goto LA11;
asgnRef((void**) &(*(*Entry_44049).Prev).Next, (*Entry_44049).Next);
LA11: ;
}
N_NIMCALL(NIM_BOOL, Includestr_44066)(TY44019* List_44069, NimStringDesc* Data_44070) {
NIM_BOOL Result_44181;
NIM_BOOL LOC2;
Result_44181 = 0;
LOC2 = Contains_44159(&(*List_44069), Data_44070);
if (!LOC2) goto LA3;
Result_44181 = NIM_TRUE;
goto BeforeRet;
LA3: ;
Appendstr_44061(List_44069, Data_44070);
BeforeRet: ;
return Result_44181;
}
N_NOINLINE(void, listsInit)(void) {
}

