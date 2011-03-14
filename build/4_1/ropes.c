/* Generated by Nimrod Compiler v0.8.11 */
/*   (c) 2011 Andreas Rumpf */

typedef long int NI;
typedef unsigned long int NU;
#include "nimbase.h"

typedef struct TY53008 TY53008;
typedef struct TNimType TNimType;
typedef struct TNimNode TNimNode;
typedef struct TNimObject TNimObject;
typedef struct NimStringDesc NimStringDesc;
typedef struct TGenericSeq TGenericSeq;
typedef struct TY10802 TY10802;
typedef struct TY10818 TY10818;
typedef struct TY11196 TY11196;
typedef struct TY10814 TY10814;
typedef struct TY10810 TY10810;
typedef struct TY11194 TY11194;
typedef struct TY53406 TY53406;
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
struct TGenericSeq {
NI len;
NI space;
};
typedef NIM_CHAR TY245[100000001];
struct NimStringDesc {
  TGenericSeq Sup;
TY245 data;
};
struct TY53008 {
  TNimObject Sup;
TY53008* Left;
TY53008* Right;
NI Length;
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
typedef TY53008* TY53407[1];
typedef NI TY51040[256];
typedef NI TY8814[16];
struct TY10810 {
TY10810* Next;
NI Key;
TY8814 Bits;
};
struct TY53406 {
  TGenericSeq Sup;
  TY53008* data[SEQ_DECL_SIZE];
};
N_NIMCALL(void*, newObj)(TNimType* Typ_13910, NI Size_13911);
static N_INLINE(void, asgnRefNoCycle)(void** Dest_13218, void* Src_13219);
static N_INLINE(TY10802*, Usrtocell_11612)(void* Usr_11614);
static N_INLINE(NI, Atomicinc_3221)(NI* Memloc_3224, NI X_3225);
static N_INLINE(NI, Atomicdec_3226)(NI* Memloc_3229, NI X_3230);
static N_INLINE(void, Rtladdzct_12601)(TY10802* C_12603);
N_NOINLINE(void, Addzct_11601)(TY10818* S_11604, TY10802* C_11605);
N_NIMCALL(NimStringDesc*, copyString)(NimStringDesc* Src_18712);
N_NIMCALL(NimStringDesc*, mnewString)(NI Len_1353);
N_NIMCALL(void, Newrecropetostr_53388)(NimStringDesc** Result_53391, NI* Resultlen_53393, TY53008* R_53394);
N_NIMCALL(void*, newSeq)(TNimType* Typ_14404, NI Len_14405);
N_NIMCALL(TGenericSeq*, incrSeq)(TGenericSeq* Seq_18842, NI Elemsize_18843);
N_NIMCALL(TY53008*, Insertincache_53201)(NimStringDesc* S_53203, TY53008* Tree_53204);
N_NIMCALL(TY53008*, Newrope_53102)(NimStringDesc* Data_53104);
N_NIMCALL(TY53008*, Splay_53136)(NimStringDesc* S_53138, TY53008* Tree_53139, NI* Cmpres_53141);
N_NIMCALL(NI, Cmp_1325)(NimStringDesc* X_1327, NimStringDesc* Y_1328);
static N_INLINE(NI, cmpStrings)(NimStringDesc* A_18613, NimStringDesc* B_18614);
N_NIMCALL(void, App_53036)(TY53008** A_53039, NimStringDesc* B_53040);
N_NIMCALL(TY53008*, Con_53019)(TY53008* A_53021, NimStringDesc* B_53022);
N_NIMCALL(TY53008*, Con_53015)(TY53008* A_53017, TY53008* B_53018);
N_NIMCALL(TY53008*, Torope_53046)(NimStringDesc* S_53048);
N_NIMCALL(void, unsureAsgnRef)(void** Dest_13226, void* Src_13227);
N_NIMCALL(void, App_53031)(TY53008** A_53034, TY53008* B_53035);
N_NIMCALL(void, Internalerror_49212)(NimStringDesc* Errmsg_49214);
static N_INLINE(void, appendString)(NimStringDesc* Dest_18799, NimStringDesc* Src_18800);
N_NIMCALL(NimStringDesc*, nimIntToStr)(NI X_19403);
N_NIMCALL(NimStringDesc*, rawNewString)(NI Space_18689);
static N_INLINE(void, appendChar)(NimStringDesc* Dest_18816, NIM_CHAR C_18817);
N_NIMCALL(NimStringDesc*, copyStrLast)(NimStringDesc* S_2328, NI First_2329, NI Last_2330);
N_NIMCALL(NimStringDesc*, nimInt64ToStr)(NI64 X_19470);
N_NIMCALL(TY53008*, Ropef_53066)(NimStringDesc* Frmt_53068, TY53008** Args_53070, NI Args_53070Len0);
N_NIMCALL(int, Crcfromfile_51029)(NimStringDesc* Filename_51031);
N_NIMCALL(int, Crcfromrope_53981)(TY53008* R_53983);
N_NIMCALL(int, Newcrcfromropeaux_53896)(TY53008* R_53898, int Startval_53899);
static N_INLINE(int, Updatecrc32_51018)(NIM_CHAR Val_51020, int Crc_51021);
static N_INLINE(int, Updatecrc32_51014)(NI8 Val_51016, int Crc_51017);
N_NIMCALL(void, Writerope_53055)(TY53008* Head_53057, NimStringDesc* Filename_53058);
N_NIMCALL(NIM_BOOL, Open_3817)(FILE** F_3820, NimStringDesc* Filename_3821, NU8 Mode_3822, NI Bufsize_3823);
N_NIMCALL(void, Writerope_53605)(FILE** F_53608, TY53008* C_53609);
N_NIMCALL(void, Write_3866)(FILE* F_3868, NimStringDesc* S_3869);
N_NIMCALL(void, Rawmessage_49094)(NU8 Msg_49096, NimStringDesc* Arg_49097);
static N_INLINE(TY53008*, Pop_53429)(TY53406** S_53434);
N_NIMCALL(TGenericSeq*, setLengthSeq)(TGenericSeq* Seq_19003, NI Elemsize_19004, NI Newlen_19005);
STRING_LITERAL(TMP197908, "", 0);
STRING_LITERAL(TMP198281, "$", 1);
STRING_LITERAL(TMP198282, "ropes: invalid format string $", 30);
extern NIM_CONST TY51040 Crc32table_51039;
TY53008* Cache_53123;
NI Misses_53124;
NI Hits_53125;
TY53008* N_53126;
extern TNimType* NTI53006; /* PRope */
extern TY11196 Gch_11214;
extern TNimType* NTI53008; /* TRope */
extern TNimType* NTI53406; /* seq[PRope] */
extern NimStringDesc* Tnl_52581;
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
N_NIMCALL(void, Newrecropetostr_53388)(NimStringDesc** Result_53391, NI* Resultlen_53393, TY53008* R_53394) {
TY53406* Stack_53409;
TY53407 LOC1;
TY53008* It_53460;
Stack_53409 = 0;
It_53460 = 0;
Stack_53409 = NIM_NIL;
Stack_53409 = (TY53406*) newSeq(NTI53406, 1);
memset((void*)&LOC1, 0, sizeof(LOC1));
LOC1[0] = R_53394;
asgnRefNoCycle((void**) &Stack_53409->data[0], LOC1[0]);
while (1) {
if (!(0 < Stack_53409->Sup.len)) goto LA2;
It_53460 = NIM_NIL;
It_53460 = Pop_53429(&Stack_53409);
while (1) {
if (!((*It_53460).Data == NIM_NIL)) goto LA3;
Stack_53409 = (TY53406*) incrSeq(&(Stack_53409)->Sup, sizeof(TY53008*));
asgnRefNoCycle((void**) &Stack_53409->data[Stack_53409->Sup.len-1], (*It_53460).Right);
It_53460 = (*It_53460).Left;
} LA3: ;
memcpy(((void*) (&(*Result_53391)->data[(*Resultlen_53393)])), ((void*) (&(*It_53460).Data->data[0])), (*It_53460).Length);
(*Resultlen_53393) += (*It_53460).Length;
} LA2: ;
}
N_NIMCALL(NimStringDesc*, Ropetostr_53063)(TY53008* P_53065) {
NimStringDesc* Result_53500;
NI Resultlen_53512;
Result_53500 = 0;
Result_53500 = NIM_NIL;
if (!(P_53065 == NIM_NIL)) goto LA2;
Result_53500 = copyString(((NimStringDesc*) &TMP197908));
goto LA1;
LA2: ;
Result_53500 = mnewString((*P_53065).Length);
Resultlen_53512 = 0;
Resultlen_53512 = 0;
Newrecropetostr_53388(&Result_53500, &Resultlen_53512, P_53065);
LA1: ;
return Result_53500;
}
N_NIMCALL(TY53008*, Newrope_53102)(NimStringDesc* Data_53104) {
TY53008* Result_53105;
Result_53105 = 0;
Result_53105 = NIM_NIL;
Result_53105 = (TY53008*) newObj(NTI53006, sizeof(TY53008));
(*Result_53105).Sup.m_type = NTI53008;
if (!!((Data_53104 == NIM_NIL))) goto LA2;
(*Result_53105).Length = Data_53104->Sup.len;
asgnRefNoCycle((void**) &(*Result_53105).Data, copyString(Data_53104));
LA2: ;
return Result_53105;
}
static N_INLINE(NI, cmpStrings)(NimStringDesc* A_18613, NimStringDesc* B_18614) {
NI Result_18615;
int LOC10;
Result_18615 = 0;
if (!(A_18613 == B_18614)) goto LA2;
Result_18615 = 0;
goto BeforeRet;
LA2: ;
if (!(A_18613 == NIM_NIL)) goto LA5;
Result_18615 = -1;
goto BeforeRet;
LA5: ;
if (!(B_18614 == NIM_NIL)) goto LA8;
Result_18615 = 1;
goto BeforeRet;
LA8: ;
LOC10 = strcmp(((NCSTRING) ((*A_18613).data)), ((NCSTRING) ((*B_18614).data)));
Result_18615 = ((NI) (LOC10));
goto BeforeRet;
BeforeRet: ;
return Result_18615;
}
N_NIMCALL(TY53008*, Splay_53136)(NimStringDesc* S_53138, TY53008* Tree_53139, NI* Cmpres_53141) {
TY53008* Result_53142;
NI C_53143;
TY53008* T_53144;
TY53008* Le_53145;
TY53008* R_53146;
NIM_BOOL LOC6;
TY53008* Y_53162;
NIM_BOOL LOC16;
TY53008* Y_53189;
Result_53142 = 0;
T_53144 = 0;
Le_53145 = 0;
R_53146 = 0;
Y_53162 = 0;
Y_53189 = 0;
Result_53142 = NIM_NIL;
C_53143 = 0;
T_53144 = NIM_NIL;
T_53144 = Tree_53139;
asgnRefNoCycle((void**) &(*N_53126).Left, NIM_NIL);
asgnRefNoCycle((void**) &(*N_53126).Right, NIM_NIL);
Le_53145 = NIM_NIL;
Le_53145 = N_53126;
R_53146 = NIM_NIL;
R_53146 = N_53126;
while (1) {
C_53143 = Cmp_1325(S_53138, (*T_53144).Data);
if (!(C_53143 < 0)) goto LA3;
LOC6 = !(((*T_53144).Left == NIM_NIL));
if (!(LOC6)) goto LA7;
LOC6 = (cmpStrings(S_53138, (*(*T_53144).Left).Data) < 0);
LA7: ;
if (!LOC6) goto LA8;
Y_53162 = NIM_NIL;
Y_53162 = (*T_53144).Left;
asgnRefNoCycle((void**) &(*T_53144).Left, (*Y_53162).Right);
asgnRefNoCycle((void**) &(*Y_53162).Right, T_53144);
T_53144 = Y_53162;
LA8: ;
if (!((*T_53144).Left == NIM_NIL)) goto LA11;
goto LA1;
LA11: ;
asgnRefNoCycle((void**) &(*R_53146).Left, T_53144);
R_53146 = T_53144;
T_53144 = (*T_53144).Left;
goto LA2;
LA3: ;
if (!(0 < C_53143)) goto LA13;
LOC16 = !(((*T_53144).Right == NIM_NIL));
if (!(LOC16)) goto LA17;
LOC16 = (cmpStrings((*(*T_53144).Right).Data, S_53138) < 0);
LA17: ;
if (!LOC16) goto LA18;
Y_53189 = NIM_NIL;
Y_53189 = (*T_53144).Right;
asgnRefNoCycle((void**) &(*T_53144).Right, (*Y_53189).Left);
asgnRefNoCycle((void**) &(*Y_53189).Left, T_53144);
T_53144 = Y_53189;
LA18: ;
if (!((*T_53144).Right == NIM_NIL)) goto LA21;
goto LA1;
LA21: ;
asgnRefNoCycle((void**) &(*Le_53145).Right, T_53144);
Le_53145 = T_53144;
T_53144 = (*T_53144).Right;
goto LA2;
LA13: ;
goto LA1;
LA2: ;
} LA1: ;
(*Cmpres_53141) = C_53143;
asgnRefNoCycle((void**) &(*Le_53145).Right, (*T_53144).Left);
asgnRefNoCycle((void**) &(*R_53146).Left, (*T_53144).Right);
asgnRefNoCycle((void**) &(*T_53144).Left, (*N_53126).Right);
asgnRefNoCycle((void**) &(*T_53144).Right, (*N_53126).Left);
Result_53142 = T_53144;
return Result_53142;
}
N_NIMCALL(TY53008*, Insertincache_53201)(NimStringDesc* S_53203, TY53008* Tree_53204) {
TY53008* Result_53205;
TY53008* T_53206;
NI Cmp_53230;
Result_53205 = 0;
T_53206 = 0;
Result_53205 = NIM_NIL;
T_53206 = NIM_NIL;
T_53206 = Tree_53204;
if (!(T_53206 == NIM_NIL)) goto LA2;
Result_53205 = Newrope_53102(S_53203);
if (!NIM_FALSE) goto LA5;
Misses_53124 += 1;
LA5: ;
goto BeforeRet;
LA2: ;
Cmp_53230 = 0;
T_53206 = Splay_53136(S_53203, T_53206, &Cmp_53230);
if (!(Cmp_53230 == 0)) goto LA8;
Result_53205 = T_53206;
if (!NIM_FALSE) goto LA11;
Hits_53125 += 1;
LA11: ;
goto LA7;
LA8: ;
if (!NIM_FALSE) goto LA14;
Misses_53124 += 1;
LA14: ;
Result_53205 = Newrope_53102(S_53203);
if (!(Cmp_53230 < 0)) goto LA17;
asgnRefNoCycle((void**) &(*Result_53205).Left, (*T_53206).Left);
asgnRefNoCycle((void**) &(*Result_53205).Right, T_53206);
asgnRefNoCycle((void**) &(*T_53206).Left, NIM_NIL);
goto LA16;
LA17: ;
asgnRefNoCycle((void**) &(*Result_53205).Right, (*T_53206).Right);
asgnRefNoCycle((void**) &(*Result_53205).Left, T_53206);
asgnRefNoCycle((void**) &(*T_53206).Right, NIM_NIL);
LA16: ;
LA7: ;
BeforeRet: ;
return Result_53205;
}
N_NIMCALL(TY53008*, Torope_53046)(NimStringDesc* S_53048) {
TY53008* Result_53280;
Result_53280 = 0;
Result_53280 = NIM_NIL;
if (!((S_53048) && (S_53048)->Sup.len == 0)) goto LA2;
Result_53280 = NIM_NIL;
goto LA1;
LA2: ;
if (!NIM_TRUE) goto LA4;
Result_53280 = Insertincache_53201(S_53048, Cache_53123);
asgnRefNoCycle((void**) &Cache_53123, Result_53280);
goto LA1;
LA4: ;
Result_53280 = Newrope_53102(S_53048);
LA1: ;
return Result_53280;
}
N_NIMCALL(TY53008*, Con_53015)(TY53008* A_53017, TY53008* B_53018) {
TY53008* Result_53519;
Result_53519 = 0;
Result_53519 = NIM_NIL;
if (!(A_53017 == NIM_NIL)) goto LA2;
Result_53519 = B_53018;
goto LA1;
LA2: ;
if (!(B_53018 == NIM_NIL)) goto LA4;
Result_53519 = A_53017;
goto LA1;
LA4: ;
Result_53519 = Newrope_53102(NIM_NIL);
(*Result_53519).Length = (NI32)((*A_53017).Length + (*B_53018).Length);
asgnRefNoCycle((void**) &(*Result_53519).Left, A_53017);
asgnRefNoCycle((void**) &(*Result_53519).Right, B_53018);
LA1: ;
return Result_53519;
}
N_NIMCALL(TY53008*, Con_53019)(TY53008* A_53021, NimStringDesc* B_53022) {
TY53008* Result_53546;
TY53008* LOC1;
Result_53546 = 0;
Result_53546 = NIM_NIL;
LOC1 = 0;
LOC1 = Torope_53046(B_53022);
Result_53546 = Con_53015(A_53021, LOC1);
return Result_53546;
}
N_NIMCALL(void, App_53036)(TY53008** A_53039, NimStringDesc* B_53040) {
unsureAsgnRef((void**) &(*A_53039), Con_53019((*A_53039), B_53040));
}
N_NIMCALL(void, App_53031)(TY53008** A_53034, TY53008* B_53035) {
unsureAsgnRef((void**) &(*A_53034), Con_53015((*A_53034), B_53035));
}
static N_INLINE(void, appendString)(NimStringDesc* Dest_18799, NimStringDesc* Src_18800) {
memcpy(((NCSTRING) (&(*Dest_18799).data[((*Dest_18799).Sup.len)-0])), ((NCSTRING) ((*Src_18800).data)), ((int) ((NI32)((NI32)((*Src_18800).Sup.len + 1) * 1))));
(*Dest_18799).Sup.len += (*Src_18800).Sup.len;
}
static N_INLINE(void, appendChar)(NimStringDesc* Dest_18816, NIM_CHAR C_18817) {
(*Dest_18816).data[((*Dest_18816).Sup.len)-0] = C_18817;
(*Dest_18816).data[((NI32)((*Dest_18816).Sup.len + 1))-0] = 0;
(*Dest_18816).Sup.len += 1;
}
N_NIMCALL(TY53008*, Ropef_53066)(NimStringDesc* Frmt_53068, TY53008** Args_53070, NI Args_53070Len0) {
TY53008* Result_53704;
NI I_53705;
NI Length_53708;
NI Num_53709;
NI J_53764;
NIM_BOOL LOC7;
NimStringDesc* LOC14;
NimStringDesc* LOC15;
NimStringDesc* LOC16;
NI Start_53823;
NimStringDesc* LOC24;
Result_53704 = 0;
Result_53704 = NIM_NIL;
I_53705 = 0;
I_53705 = 0;
Length_53708 = 0;
Length_53708 = Frmt_53068->Sup.len;
Result_53704 = NIM_NIL;
Num_53709 = 0;
Num_53709 = 0;
while (1) {
if (!(I_53705 <= (NI32)(Length_53708 - 1))) goto LA1;
if (!((NU8)(Frmt_53068->data[I_53705]) == (NU8)(36))) goto LA3;
I_53705 += 1;
switch (((NU8)(Frmt_53068->data[I_53705]))) {
case 36:
App_53036(&Result_53704, ((NimStringDesc*) &TMP198281));
I_53705 += 1;
break;
case 35:
I_53705 += 1;
App_53031(&Result_53704, Args_53070[Num_53709]);
Num_53709 += 1;
break;
case 48 ... 57:
J_53764 = 0;
J_53764 = 0;
while (1) {
J_53764 = (NI32)((NI32)((NI32)(J_53764 * 10) + ((NU8)(Frmt_53068->data[I_53705]))) - 48);
I_53705 += 1;
LOC7 = ((NI32)((NI32)(Length_53708 + 0) - 1) < I_53705);
if (LOC7) goto LA8;
LOC7 = !((((NU8)(Frmt_53068->data[I_53705])) >= ((NU8)(48)) && ((NU8)(Frmt_53068->data[I_53705])) <= ((NU8)(57))));
LA8: ;
if (!LOC7) goto LA9;
goto LA5;
LA9: ;
} LA5: ;
Num_53709 = J_53764;
if (!((NI32)((Args_53070Len0-1) + 1) < J_53764)) goto LA12;
LOC14 = 0;
LOC15 = 0;
LOC15 = nimIntToStr(J_53764);
LOC14 = rawNewString(LOC15->Sup.len + 30);
appendString(LOC14, ((NimStringDesc*) &TMP198282));
appendString(LOC14, LOC15);
Internalerror_49212(LOC14);
LA12: ;
App_53031(&Result_53704, Args_53070[(NI32)(J_53764 - 1)]);
break;
case 78:
case 110:
App_53036(&Result_53704, Tnl_52581);
I_53705 += 1;
break;
default:
LOC16 = 0;
LOC16 = rawNewString(31);
appendString(LOC16, ((NimStringDesc*) &TMP198282));
appendChar(LOC16, Frmt_53068->data[I_53705]);
Internalerror_49212(LOC16);
break;
}
LA3: ;
Start_53823 = 0;
Start_53823 = I_53705;
while (1) {
if (!(I_53705 <= (NI32)(Length_53708 - 1))) goto LA17;
if (!!(((NU8)(Frmt_53068->data[I_53705]) == (NU8)(36)))) goto LA19;
I_53705 += 1;
goto LA18;
LA19: ;
goto LA17;
LA18: ;
} LA17: ;
if (!(Start_53823 <= (NI32)(I_53705 - 1))) goto LA22;
LOC24 = 0;
LOC24 = copyStrLast(Frmt_53068, Start_53823, (NI32)(I_53705 - 1));
App_53036(&Result_53704, LOC24);
LA22: ;
} LA1: ;
return Result_53704;
}
N_NIMCALL(TY53008*, Torope_53049)(NI64 I_53051) {
TY53008* Result_53587;
NimStringDesc* LOC1;
Result_53587 = 0;
Result_53587 = NIM_NIL;
LOC1 = 0;
LOC1 = nimInt64ToStr(I_53051);
Result_53587 = Torope_53046(LOC1);
return Result_53587;
}
N_NIMCALL(void, Appf_53071)(TY53008** C_53074, NimStringDesc* Frmt_53075, TY53008** Args_53077, NI Args_53077Len0) {
TY53008* LOC1;
LOC1 = 0;
LOC1 = Ropef_53066(Frmt_53075, Args_53077, Args_53077Len0);
App_53031(C_53074, LOC1);
}
N_NIMCALL(TY53008*, Con_53023)(NimStringDesc* A_53025, TY53008* B_53026) {
TY53008* Result_53551;
TY53008* LOC1;
Result_53551 = 0;
Result_53551 = NIM_NIL;
LOC1 = 0;
LOC1 = Torope_53046(A_53025);
Result_53551 = Con_53015(LOC1, B_53026);
return Result_53551;
}
N_NIMCALL(void, Prepend_53041)(TY53008** A_53044, TY53008* B_53045) {
unsureAsgnRef((void**) &(*A_53044), Con_53015(B_53045, (*A_53044)));
}
static N_INLINE(int, Updatecrc32_51014)(NI8 Val_51016, int Crc_51017) {
int Result_51048;
Result_51048 = 0;
Result_51048 = (NI32)(((int) (Crc32table_51039[((NI32)((NI32)(((NI) (Crc_51017)) ^ (NI32)(((NI) (Val_51016)) & 255)) & 255))-0])) ^ (NI32)((NU32)(Crc_51017) >> (NU32)(((NI32) 8))));
return Result_51048;
}
static N_INLINE(int, Updatecrc32_51018)(NIM_CHAR Val_51020, int Crc_51021) {
int Result_51053;
Result_51053 = 0;
Result_51053 = Updatecrc32_51014(((NI8) (((NU8)(Val_51020)))), Crc_51021);
return Result_51053;
}
N_NIMCALL(int, Newcrcfromropeaux_53896)(TY53008* R_53898, int Startval_53899) {
int Result_53900;
TY53406* Stack_53915;
TY53407 LOC1;
TY53008* It_53942;
NI I_53961;
NI L_53964;
Stack_53915 = 0;
It_53942 = 0;
Result_53900 = 0;
Stack_53915 = NIM_NIL;
Stack_53915 = (TY53406*) newSeq(NTI53406, 1);
memset((void*)&LOC1, 0, sizeof(LOC1));
LOC1[0] = R_53898;
asgnRefNoCycle((void**) &Stack_53915->data[0], LOC1[0]);
Result_53900 = Startval_53899;
while (1) {
if (!(0 < Stack_53915->Sup.len)) goto LA2;
It_53942 = NIM_NIL;
It_53942 = Pop_53429(&Stack_53915);
while (1) {
if (!((*It_53942).Data == NIM_NIL)) goto LA3;
Stack_53915 = (TY53406*) incrSeq(&(Stack_53915)->Sup, sizeof(TY53008*));
asgnRefNoCycle((void**) &Stack_53915->data[Stack_53915->Sup.len-1], (*It_53942).Right);
It_53942 = (*It_53942).Left;
} LA3: ;
I_53961 = 0;
I_53961 = 0;
L_53964 = 0;
L_53964 = (*It_53942).Data->Sup.len;
while (1) {
if (!(I_53961 < L_53964)) goto LA4;
Result_53900 = Updatecrc32_51018((*It_53942).Data->data[I_53961], Result_53900);
I_53961 += 1;
} LA4: ;
} LA2: ;
return Result_53900;
}
N_NIMCALL(int, Crcfromrope_53981)(TY53008* R_53983) {
int Result_53984;
Result_53984 = 0;
Result_53984 = Newcrcfromropeaux_53896(R_53983, ((NI32) -1));
return Result_53984;
}
N_NIMCALL(void, Writerope_53605)(FILE** F_53608, TY53008* C_53609) {
TY53406* Stack_53624;
TY53407 LOC1;
TY53008* It_53651;
Stack_53624 = 0;
It_53651 = 0;
Stack_53624 = NIM_NIL;
Stack_53624 = (TY53406*) newSeq(NTI53406, 1);
memset((void*)&LOC1, 0, sizeof(LOC1));
LOC1[0] = C_53609;
asgnRefNoCycle((void**) &Stack_53624->data[0], LOC1[0]);
while (1) {
if (!(0 < Stack_53624->Sup.len)) goto LA2;
It_53651 = NIM_NIL;
It_53651 = Pop_53429(&Stack_53624);
while (1) {
if (!((*It_53651).Data == NIM_NIL)) goto LA3;
Stack_53624 = (TY53406*) incrSeq(&(Stack_53624)->Sup, sizeof(TY53008*));
asgnRefNoCycle((void**) &Stack_53624->data[Stack_53624->Sup.len-1], (*It_53651).Right);
It_53651 = (*It_53651).Left;
} LA3: ;
Write_3866((*F_53608), (*It_53651).Data);
} LA2: ;
}
N_NIMCALL(void, Writerope_53055)(TY53008* Head_53057, NimStringDesc* Filename_53058) {
FILE* F_53685;
NIM_BOOL LOC2;
F_53685 = 0;
LOC2 = Open_3817(&F_53685, Filename_53058, ((NU8) 1), -1);
if (!LOC2) goto LA3;
if (!!((Head_53057 == NIM_NIL))) goto LA6;
Writerope_53605(&F_53685, Head_53057);
LA6: ;
fclose(F_53685);
goto LA1;
LA3: ;
Rawmessage_49094(((NU8) 2), Filename_53058);
LA1: ;
}
N_NIMCALL(NIM_BOOL, Writeropeifnotequal_53059)(TY53008* R_53061, NimStringDesc* Filename_53062) {
NIM_BOOL Result_53989;
int C_53990;
int LOC2;
Result_53989 = 0;
C_53990 = 0;
C_53990 = Crcfromfile_51029(Filename_53062);
LOC2 = Crcfromrope_53981(R_53061);
if (!!((C_53990 == LOC2))) goto LA3;
Writerope_53055(R_53061, Filename_53062);
Result_53989 = NIM_TRUE;
goto LA1;
LA3: ;
Result_53989 = NIM_FALSE;
LA1: ;
return Result_53989;
}
N_NIMCALL(NI, Ropelen_53052)(TY53008* A_53054) {
NI Result_53090;
Result_53090 = 0;
if (!(A_53054 == NIM_NIL)) goto LA2;
Result_53090 = 0;
goto LA1;
LA2: ;
Result_53090 = (*A_53054).Length;
LA1: ;
return Result_53090;
}
static N_INLINE(TY53008*, Pop_53429)(TY53406** S_53434) {
TY53008* Result_53435;
NI L_53446;
Result_53435 = 0;
Result_53435 = NIM_NIL;
L_53446 = 0;
L_53446 = (NI32)((*S_53434)->Sup.len - 1);
Result_53435 = (*S_53434)->data[L_53446];
(*S_53434) = (TY53406*) setLengthSeq(&((*S_53434))->Sup, sizeof(TY53008*), L_53446);
return Result_53435;
}
N_NOINLINE(void, ropesInit)(void) {
asgnRefNoCycle((void**) &N_53126, (TY53008*) newObj(NTI53006, sizeof(TY53008)));
(*N_53126).Sup.m_type = NTI53008;
}

