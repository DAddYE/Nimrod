/* Generated by Nimrod Compiler v0.8.11 */
/*   (c) 2011 Andreas Rumpf */

typedef long long int NI;
typedef unsigned long long int NU;
#include "nimbase.h"

typedef struct TY46008 TY46008;
typedef struct NimStringDesc NimStringDesc;
typedef struct TGenericSeq TGenericSeq;
typedef struct TNimType TNimType;
typedef struct TNimNode TNimNode;
typedef struct TNimObject TNimObject;
typedef struct TY46006 TY46006;
typedef struct TY46004 TY46004;
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
struct TY46004 {
NimStringDesc* Key;
NimStringDesc* Val;
};
struct TY46008 {
  TNimObject Sup;
NI Counter;
TY46006* Data;
NU8 Mode;
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
typedef NI TY8814[8];
struct TY10810 {
TY10810* Next;
NI Key;
TY8814 Bits;
};
struct TY46006 {
  TGenericSeq Sup;
  TY46004 data[SEQ_DECL_SIZE];
};
N_NIMCALL(void*, newObj)(TNimType* Typ_13910, NI Size_13911);
N_NIMCALL(void*, newSeq)(TNimType* Typ_14404, NI Len_14405);
static N_INLINE(void, asgnRefNoCycle)(void** Dest_13218, void* Src_13219);
static N_INLINE(TY10802*, Usrtocell_11612)(void* Usr_11614);
static N_INLINE(NI, Atomicinc_3221)(NI* Memloc_3224, NI X_3225);
static N_INLINE(NI, Atomicdec_3226)(NI* Memloc_3229, NI X_3230);
static N_INLINE(void, Rtladdzct_12601)(TY10802* C_12603);
N_NOINLINE(void, Addzct_11601)(TY10818* S_11604, TY10802* C_11605);
N_NIMCALL(void, Put_46024)(TY46008* T_46026, NimStringDesc* Key_46027, NimStringDesc* Val_46028);
N_NIMCALL(NI, Rawget_46149)(TY46008* T_46151, NimStringDesc* Key_46152);
N_NIMCALL(NI, Myhash_46106)(TY46008* T_46108, NimStringDesc* Key_46109);
N_NIMCALL(NI, Gethashstr_45031)(NimStringDesc* S_45033);
N_NIMCALL(NI, Gethashstrci_45034)(NimStringDesc* S_45036);
N_NIMCALL(NI, Getnormalizedhash_45037)(NimStringDesc* S_45039);
N_NIMCALL(NIM_BOOL, Mycmp_46111)(TY46008* T_46113, NimStringDesc* A_46114, NimStringDesc* B_46115);
N_NIMCALL(NI, Cmp_1325)(NimStringDesc* X_1327, NimStringDesc* Y_1328);
N_NIMCALL(NI, nsuCmpIgnoreCase)(NimStringDesc* A_24587, NimStringDesc* B_24588);
N_NIMCALL(NI, nsuCmpIgnoreStyle)(NimStringDesc* A_24632, NimStringDesc* B_24633);
N_NIMCALL(NI, Nexttry_46144)(NI H_46146, NI Maxhash_46147);
N_NIMCALL(NimStringDesc*, copyString)(NimStringDesc* Src_18712);
N_NIMCALL(NIM_BOOL, Mustrehash_46123)(NI Length_46125, NI Counter_46126);
N_NIMCALL(void, Enlarge_46178)(TY46008* T_46180);
N_NIMCALL(void, Rawinsert_46170)(TY46008* T_46172, TY46006** Data_46174, NimStringDesc* Key_46175, NimStringDesc* Val_46176);
STRING_LITERAL(TMP197671, "", 0);
extern TNimType* NTI46010; /* PStringTable */
extern TNimType* NTI46008; /* TStringTable */
extern TNimType* NTI46006; /* TKeyValuePairSeq */
extern TY11196 Gch_11214;
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
N_NIMCALL(NI, Myhash_46106)(TY46008* T_46108, NimStringDesc* Key_46109) {
NI Result_46110;
Result_46110 = 0;
switch ((*T_46108).Mode) {
case ((NU8) 0):
Result_46110 = Gethashstr_45031(Key_46109);
break;
case ((NU8) 1):
Result_46110 = Gethashstrci_45034(Key_46109);
break;
case ((NU8) 2):
Result_46110 = Getnormalizedhash_45037(Key_46109);
break;
}
return Result_46110;
}
N_NIMCALL(NIM_BOOL, Mycmp_46111)(TY46008* T_46113, NimStringDesc* A_46114, NimStringDesc* B_46115) {
NIM_BOOL Result_46116;
NI LOC1;
NI LOC2;
NI LOC3;
Result_46116 = 0;
switch ((*T_46113).Mode) {
case ((NU8) 0):
LOC1 = Cmp_1325(A_46114, B_46115);
Result_46116 = (LOC1 == 0);
break;
case ((NU8) 1):
LOC2 = nsuCmpIgnoreCase(A_46114, B_46115);
Result_46116 = (LOC2 == 0);
break;
case ((NU8) 2):
LOC3 = nsuCmpIgnoreStyle(A_46114, B_46115);
Result_46116 = (LOC3 == 0);
break;
}
return Result_46116;
}
N_NIMCALL(NI, Nexttry_46144)(NI H_46146, NI Maxhash_46147) {
NI Result_46148;
Result_46148 = 0;
Result_46148 = (NI64)((NI64)((NI64)(5 * H_46146) + 1) & Maxhash_46147);
return Result_46148;
}
N_NIMCALL(NI, Rawget_46149)(TY46008* T_46151, NimStringDesc* Key_46152) {
NI Result_46153;
NI H_46154;
NI LOC1;
NIM_BOOL LOC4;
Result_46153 = 0;
H_46154 = 0;
LOC1 = Myhash_46106(T_46151, Key_46152);
H_46154 = (NI64)(LOC1 & ((*T_46151).Data->Sup.len-1));
while (1) {
if (!!((*T_46151).Data->data[H_46154].Key == 0)) goto LA2;
LOC4 = Mycmp_46111(T_46151, (*T_46151).Data->data[H_46154].Key, Key_46152);
if (!LOC4) goto LA5;
Result_46153 = H_46154;
goto BeforeRet;
LA5: ;
H_46154 = Nexttry_46144(H_46154, ((*T_46151).Data->Sup.len-1));
} LA2: ;
Result_46153 = -1;
BeforeRet: ;
return Result_46153;
}
N_NIMCALL(NIM_BOOL, Mustrehash_46123)(NI Length_46125, NI Counter_46126) {
NIM_BOOL Result_46127;
NIM_BOOL LOC1;
Result_46127 = 0;
LOC1 = ((NI64)(Length_46125 * 2) < (NI64)(Counter_46126 * 3));
if (LOC1) goto LA2;
LOC1 = ((NI64)(Length_46125 - Counter_46126) < 4);
LA2: ;
Result_46127 = LOC1;
return Result_46127;
}
N_NIMCALL(void, Rawinsert_46170)(TY46008* T_46172, TY46006** Data_46174, NimStringDesc* Key_46175, NimStringDesc* Val_46176) {
NI H_46177;
NI LOC1;
H_46177 = 0;
LOC1 = Myhash_46106(T_46172, Key_46175);
H_46177 = (NI64)(LOC1 & ((*Data_46174)->Sup.len-1));
while (1) {
if (!!((*Data_46174)->data[H_46177].Key == 0)) goto LA2;
H_46177 = Nexttry_46144(H_46177, ((*Data_46174)->Sup.len-1));
} LA2: ;
asgnRefNoCycle((void**) &(*Data_46174)->data[H_46177].Key, copyString(Key_46175));
asgnRefNoCycle((void**) &(*Data_46174)->data[H_46177].Val, copyString(Val_46176));
}
N_NIMCALL(void, Enlarge_46178)(TY46008* T_46180) {
TY46006* N_46181;
NI I_46227;
NI HEX3Atmp_46238;
NI Res_46240;
TY46006* LOC5;
N_46181 = 0;
N_46181 = NIM_NIL;
N_46181 = (TY46006*) newSeq(NTI46006, (NI64)((*T_46180).Data->Sup.len * 2));
I_46227 = 0;
HEX3Atmp_46238 = 0;
HEX3Atmp_46238 = ((*T_46180).Data->Sup.len-1);
Res_46240 = 0;
Res_46240 = 0;
while (1) {
if (!(Res_46240 <= HEX3Atmp_46238)) goto LA1;
I_46227 = Res_46240;
if (!!((*T_46180).Data->data[I_46227].Key == 0)) goto LA3;
Rawinsert_46170(T_46180, &N_46181, (*T_46180).Data->data[I_46227].Key, (*T_46180).Data->data[I_46227].Val);
LA3: ;
Res_46240 += 1;
} LA1: ;
LOC5 = 0;
LOC5 = (*T_46180).Data;
asgnRefNoCycle((void**) &(*T_46180).Data, N_46181);
N_46181 = LOC5;
}
N_NIMCALL(void, Put_46024)(TY46008* T_46026, NimStringDesc* Key_46027, NimStringDesc* Val_46028) {
NI Index_46246;
NIM_BOOL LOC5;
Index_46246 = 0;
Index_46246 = Rawget_46149(T_46026, Key_46027);
if (!(0 <= Index_46246)) goto LA2;
asgnRefNoCycle((void**) &(*T_46026).Data->data[Index_46246].Val, copyString(Val_46028));
goto LA1;
LA2: ;
LOC5 = Mustrehash_46123((*T_46026).Data->Sup.len, (*T_46026).Counter);
if (!LOC5) goto LA6;
Enlarge_46178(T_46026);
LA6: ;
Rawinsert_46170(T_46026, &(*T_46026).Data, Key_46027, Val_46028);
(*T_46026).Counter += 1;
LA1: ;
}
N_NIMCALL(TY46008*, Newstringtable_46019)(NimStringDesc** Keyvaluepairs_46022, NI Keyvaluepairs_46022Len0, NU8 Mode_46023) {
TY46008* Result_46061;
NI I_46089;
Result_46061 = 0;
Result_46061 = NIM_NIL;
Result_46061 = (TY46008*) newObj(NTI46010, sizeof(TY46008));
(*Result_46061).Sup.m_type = NTI46008;
(*Result_46061).Mode = Mode_46023;
(*Result_46061).Counter = 0;
asgnRefNoCycle((void**) &(*Result_46061).Data, (TY46006*) newSeq(NTI46006, 64));
I_46089 = 0;
I_46089 = 0;
while (1) {
if (!(I_46089 < (Keyvaluepairs_46022Len0-1))) goto LA1;
Put_46024(Result_46061, Keyvaluepairs_46022[I_46089], Keyvaluepairs_46022[(NI64)(I_46089 + 1)]);
I_46089 += 2;
} LA1: ;
return Result_46061;
}
N_NIMCALL(NimStringDesc*, Get_46029)(TY46008* T_46031, NimStringDesc* Key_46032) {
NimStringDesc* Result_46159;
NI Index_46160;
Result_46159 = 0;
Result_46159 = NIM_NIL;
Index_46160 = 0;
Index_46160 = Rawget_46149(T_46031, Key_46032);
if (!(0 <= Index_46160)) goto LA2;
Result_46159 = copyString((*T_46031).Data->data[Index_46160].Val);
goto LA1;
LA2: ;
Result_46159 = copyString(((NimStringDesc*) &TMP197671));
LA1: ;
return Result_46159;
}
N_NIMCALL(NIM_BOOL, Haskey_46033)(TY46008* T_46035, NimStringDesc* Key_46036) {
NIM_BOOL Result_46167;
NI LOC1;
Result_46167 = 0;
LOC1 = Rawget_46149(T_46035, Key_46036);
Result_46167 = (0 <= LOC1);
return Result_46167;
}
N_NOINLINE(void, nstrtabsInit)(void) {
}

