/* Generated by Nimrod Compiler v0.8.11 */
/*   (c) 2011 Andreas Rumpf */

typedef long long int NI;
typedef unsigned long long int NU;
#include "nimbase.h"

typedef struct TY76204 TY76204;
typedef struct NimStringDesc NimStringDesc;
typedef struct TGenericSeq TGenericSeq;
typedef struct TNimType TNimType;
typedef struct TNimNode TNimNode;
typedef struct TNimObject TNimObject;
typedef struct TY10802 TY10802;
typedef struct TY10818 TY10818;
typedef struct TY11196 TY11196;
typedef struct TY10814 TY10814;
typedef struct TY10810 TY10810;
typedef struct TY11194 TY11194;
typedef NU8 TY22602[32];
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
struct TY76204 {
  TNimObject Sup;
NU8 Kind;
FILE* F;
NimStringDesc* S;
NI Rd;
NI Wr;
NI Lineoffset;
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
N_NIMCALL(void*, newObj)(TNimType* Typ_13910, NI Size_13911);
N_NIMCALL(NIM_BOOL, Open_3817)(FILE** F_3820, NimStringDesc* Filename_3821, NU8 Mode_3822, NI Bufsize_3823);
N_NIMCALL(NI, Readbuffer_3922)(FILE* F_3924, void* Buffer_3925, NI Len_3926);
N_NIMCALL(NI, Llreadfromstdin_76464)(TY76204* S_76466, void* Buf_76467, NI Buflen_76468);
static N_INLINE(void, asgnRefNoCycle)(void** Dest_13218, void* Src_13219);
static N_INLINE(TY10802*, Usrtocell_11612)(void* Usr_11614);
static N_INLINE(NI, Atomicinc_3221)(NI* Memloc_3224, NI X_3225);
static N_INLINE(NI, Atomicdec_3226)(NI* Memloc_3229, NI X_3230);
static N_INLINE(void, Rtladdzct_12601)(TY10802* C_12603);
N_NOINLINE(void, Addzct_11601)(TY10818* S_11604, TY10802* C_11605);
N_NIMCALL(NimStringDesc*, copyString)(NimStringDesc* Src_18712);
N_NIMCALL(NimStringDesc*, Readlinefromstdin_76365)(NimStringDesc* Prompt_76367);
N_NIMCALL(void, Write_3866)(FILE* F_3868, NimStringDesc* S_3869);
N_NIMCALL(NimStringDesc*, Readline_3887)(FILE* F_3889);
static N_INLINE(void, appendString)(NimStringDesc* Dest_18799, NimStringDesc* Src_18800);
N_NIMCALL(NimStringDesc*, resizeString)(NimStringDesc* Dest_18789, NI Addlen_18790);
N_NIMCALL(NIM_BOOL, Contains_26284)(NimStringDesc* S_26286, NimStringDesc* Sub_26287);
static N_INLINE(NIM_BOOL, Continueline_76447)(NimStringDesc* Line_76449, NIM_BOOL Intriplestring_76450);
N_NIMCALL(NIM_BOOL, Endswith_76401)(NimStringDesc* X_76403, TY22602 S_76405);
N_NIMCALL(NimStringDesc*, addChar)(NimStringDesc* S_1803, NIM_CHAR C_1804);
N_NIMCALL(NIM_BOOL, Endoffile_3838)(FILE* F_3840);
N_NIMCALL(NI, Writebuffer_3941)(FILE* F_3943, void* Buffer_3944, NI Len_3945);
N_NIMCALL(void, Llstreamwrite_76246)(TY76204* S_76248, NimStringDesc* Data_76249);
NIM_CONST TY22602 Linecontinuationoprs_76439 = {
0x00, 0x00, 0x00, 0x00, 0x72, 0xBC, 0x00, 0xD0,
0x01, 0x00, 0x00, 0x50, 0x00, 0x00, 0x00, 0x50,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}
;
NIM_CONST TY22602 Additionallinecontinuationoprs_76441 = {
0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x24,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}
;
STRING_LITERAL(TMP197693, "", 0);
STRING_LITERAL(TMP197694, ">>> ", 4);
STRING_LITERAL(TMP197695, "... ", 4);
STRING_LITERAL(TMP197696, "\012", 1);
STRING_LITERAL(TMP197697, "\"\"\"", 3);
static NIM_CONST TY22602 TMP197850 = {
0x00, 0x00, 0x00, 0x00, 0x72, 0xBC, 0x00, 0xD0,
0x01, 0x00, 0x00, 0x50, 0x00, 0x00, 0x00, 0x50,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}
;extern TNimType* NTI76206; /* PLLStream */
extern TNimType* NTI76204; /* TLLStream */
extern TY11196 Gch_11214;
N_NIMCALL(TY76204*, Llstreamopen_76224)(NimStringDesc* Filename_76226, NU8 Mode_76227) {
TY76204* Result_76309;
NIM_BOOL LOC2;
Result_76309 = 0;
Result_76309 = NIM_NIL;
Result_76309 = (TY76204*) newObj(NTI76206, sizeof(TY76204));
(*Result_76309).Sup.m_type = NTI76204;
(*Result_76309).Kind = ((NU8) 2);
LOC2 = Open_3817(&(*Result_76309).F, Filename_76226, Mode_76227, -1);
if (!!(LOC2)) goto LA3;
Result_76309 = NIM_NIL;
LA3: ;
return Result_76309;
}
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
N_NIMCALL(NimStringDesc*, Readlinefromstdin_76365)(NimStringDesc* Prompt_76367) {
NimStringDesc* Result_76368;
Result_76368 = 0;
Result_76368 = NIM_NIL;
Write_3866(stdout, Prompt_76367);
Result_76368 = Readline_3887(stdin);
return Result_76368;
}
static N_INLINE(void, appendString)(NimStringDesc* Dest_18799, NimStringDesc* Src_18800) {
memcpy(((NCSTRING) (&(*Dest_18799).data[((*Dest_18799).Sup.len)-0])), ((NCSTRING) ((*Src_18800).data)), ((int) ((NI64)((NI64)((*Src_18800).Sup.len + 1) * 1))));
(*Dest_18799).Sup.len += (*Src_18800).Sup.len;
}
N_NIMCALL(NIM_BOOL, Endswith_76401)(NimStringDesc* X_76403, TY22602 S_76405) {
NIM_BOOL Result_76406;
NI I_76409;
NIM_BOOL LOC2;
NIM_BOOL LOC5;
Result_76406 = 0;
I_76409 = 0;
I_76409 = (NI64)(X_76403->Sup.len - 1);
while (1) {
LOC2 = (0 <= I_76409);
if (!(LOC2)) goto LA3;
LOC2 = ((NU8)(X_76403->data[I_76409]) == (NU8)(32));
LA3: ;
if (!LOC2) goto LA1;
I_76409 -= 1;
} LA1: ;
LOC5 = (0 <= I_76409);
if (!(LOC5)) goto LA6;
LOC5 = ((S_76405[((NU8)(X_76403->data[I_76409]))/8] &(1<<(((NU8)(X_76403->data[I_76409]))%8)))!=0);
LA6: ;
if (!LOC5) goto LA7;
Result_76406 = NIM_TRUE;
LA7: ;
return Result_76406;
}
static N_INLINE(NIM_BOOL, Continueline_76447)(NimStringDesc* Line_76449, NIM_BOOL Intriplestring_76450) {
NIM_BOOL Result_76451;
NIM_BOOL LOC1;
NIM_BOOL LOC2;
TY22602 LOC5;
NI LOC6;
NI LOC7;
NI LOC8;
Result_76451 = 0;
LOC2 = Intriplestring_76450;
if (LOC2) goto LA3;
LOC2 = ((NU8)(Line_76449->data[0]) == (NU8)(32));
LA3: ;
LOC1 = LOC2;
if (LOC1) goto LA4;
memset(LOC5, 0, sizeof(LOC5));
LOC5[((NU8)(33))/8] |=(1<<(((NU8)(33))%8));
for (LOC6 = ((NU8)(35)); LOC6 <= ((NU8)(38)); LOC6++) 
LOC5[LOC6/8] |=(1<<(LOC6%8));
for (LOC7 = ((NU8)(42)); LOC7 <= ((NU8)(45)); LOC7++) 
LOC5[LOC7/8] |=(1<<(LOC7%8));
LOC5[((NU8)(47))/8] |=(1<<(((NU8)(47))%8));
LOC5[((NU8)(58))/8] |=(1<<(((NU8)(58))%8));
for (LOC8 = ((NU8)(60)); LOC8 <= ((NU8)(64)); LOC8++) 
LOC5[LOC8/8] |=(1<<(LOC8%8));
LOC5[((NU8)(92))/8] |=(1<<(((NU8)(92))%8));
LOC5[((NU8)(94))/8] |=(1<<(((NU8)(94))%8));
LOC5[((NU8)(124))/8] |=(1<<(((NU8)(124))%8));
LOC5[((NU8)(126))/8] |=(1<<(((NU8)(126))%8));
LOC1 = Endswith_76401(Line_76449, LOC5);
LA4: ;
Result_76451 = LOC1;
return Result_76451;
}
N_NIMCALL(NI, Llreadfromstdin_76464)(TY76204* S_76466, void* Buf_76467, NI Buflen_76468) {
NI Result_76469;
NimStringDesc* Line_76470;
NI L_76471;
NIM_BOOL Intriplestring_76472;
NimStringDesc* LOC2;
NIM_BOOL LOC6;
NIM_BOOL LOC10;
Line_76470 = 0;
Result_76469 = 0;
Line_76470 = NIM_NIL;
L_76471 = 0;
Intriplestring_76472 = 0;
Intriplestring_76472 = NIM_FALSE;
asgnRefNoCycle((void**) &(*S_76466).S, copyString(((NimStringDesc*) &TMP197693)));
(*S_76466).Rd = 0;
while (1) {
LOC2 = 0;
if (!((*S_76466).S->Sup.len == 0)) goto LA4;
LOC2 = copyString(((NimStringDesc*) &TMP197694));
goto LA3;
LA4: ;
LOC2 = copyString(((NimStringDesc*) &TMP197695));
LA3: ;
Line_76470 = Readlinefromstdin_76365(LOC2);
L_76471 = Line_76470->Sup.len;
(*S_76466).S = resizeString((*S_76466).S, Line_76470->Sup.len + 0);
appendString((*S_76466).S, Line_76470);
(*S_76466).S = resizeString((*S_76466).S, 1);
appendString((*S_76466).S, ((NimStringDesc*) &TMP197696));
LOC6 = Contains_26284(Line_76470, ((NimStringDesc*) &TMP197697));
if (!LOC6) goto LA7;
Intriplestring_76472 = !(Intriplestring_76472);
LA7: ;
LOC10 = Continueline_76447(Line_76470, Intriplestring_76472);
if (!!(LOC10)) goto LA11;
goto LA1;
LA11: ;
} LA1: ;
(*S_76466).Lineoffset += 1;
Result_76469 = ((Buflen_76468 <= (NI64)((*S_76466).S->Sup.len - (*S_76466).Rd)) ? Buflen_76468 : (NI64)((*S_76466).S->Sup.len - (*S_76466).Rd));
if (!(0 < Result_76469)) goto LA14;
memcpy(Buf_76467, ((void*) (&(*S_76466).S->data[(*S_76466).Rd])), Result_76469);
(*S_76466).Rd += Result_76469;
LA14: ;
return Result_76469;
}
N_NIMCALL(NI, Llstreamread_76235)(TY76204* S_76237, void* Buf_76238, NI Buflen_76239) {
NI Result_76519;
Result_76519 = 0;
switch ((*S_76237).Kind) {
case ((NU8) 0):
Result_76519 = 0;
break;
case ((NU8) 1):
Result_76519 = ((Buflen_76239 <= (NI64)((*S_76237).S->Sup.len - (*S_76237).Rd)) ? Buflen_76239 : (NI64)((*S_76237).S->Sup.len - (*S_76237).Rd));
if (!(0 < Result_76519)) goto LA2;
memcpy(Buf_76238, ((void*) (&(*S_76237).S->data[(NI64)(0 + (*S_76237).Rd)])), Result_76519);
(*S_76237).Rd += Result_76519;
LA2: ;
break;
case ((NU8) 2):
Result_76519 = Readbuffer_3922((*S_76237).F, Buf_76238, Buflen_76239);
break;
case ((NU8) 3):
Result_76519 = Llreadfromstdin_76464(S_76237, Buf_76238, Buflen_76239);
break;
}
return Result_76519;
}
N_NIMCALL(void, Llstreamclose_76232)(TY76204* S_76234) {
switch ((*S_76234).Kind) {
case ((NU8) 0):
case ((NU8) 1):
case ((NU8) 3):
break;
case ((NU8) 2):
fclose((*S_76234).F);
break;
}
}
N_NIMCALL(NimStringDesc*, Llstreamreadline_76240)(TY76204* S_76242) {
NimStringDesc* Result_76544;
Result_76544 = 0;
Result_76544 = NIM_NIL;
switch ((*S_76242).Kind) {
case ((NU8) 0):
Result_76544 = copyString(((NimStringDesc*) &TMP197693));
break;
case ((NU8) 1):
Result_76544 = copyString(((NimStringDesc*) &TMP197693));
while (1) {
if (!((*S_76242).Rd < (*S_76242).S->Sup.len)) goto LA1;
switch (((NU8)((*S_76242).S->data[(NI64)((*S_76242).Rd + 0)]))) {
case 13:
(*S_76242).Rd += 1;
if (!((NU8)((*S_76242).S->data[(NI64)((*S_76242).Rd + 0)]) == (NU8)(10))) goto LA3;
(*S_76242).Rd += 1;
LA3: ;
goto LA1;
break;
case 10:
(*S_76242).Rd += 1;
goto LA1;
break;
default:
Result_76544 = addChar(Result_76544, (*S_76242).S->data[(NI64)((*S_76242).Rd + 0)]);
(*S_76242).Rd += 1;
break;
}
} LA1: ;
break;
case ((NU8) 2):
Result_76544 = Readline_3887((*S_76242).F);
break;
case ((NU8) 3):
Result_76544 = Readline_3887(stdin);
break;
}
return Result_76544;
}
N_NIMCALL(TY76204*, Llstreamopen_76217)(NimStringDesc* Data_76219) {
TY76204* Result_76269;
Result_76269 = 0;
Result_76269 = NIM_NIL;
Result_76269 = (TY76204*) newObj(NTI76206, sizeof(TY76204));
(*Result_76269).Sup.m_type = NTI76204;
asgnRefNoCycle((void**) &(*Result_76269).S, copyString(Data_76219));
(*Result_76269).Kind = ((NU8) 1);
return Result_76269;
}
N_NIMCALL(NIM_BOOL, Llstreamatend_76263)(TY76204* S_76265) {
NIM_BOOL Result_76604;
Result_76604 = 0;
switch ((*S_76265).Kind) {
case ((NU8) 0):
Result_76604 = NIM_TRUE;
break;
case ((NU8) 1):
Result_76604 = ((*S_76265).S->Sup.len <= (*S_76265).Rd);
break;
case ((NU8) 2):
Result_76604 = Endoffile_3838((*S_76265).F);
break;
case ((NU8) 3):
Result_76604 = NIM_FALSE;
break;
}
return Result_76604;
}
N_NIMCALL(void, Llstreamwrite_76246)(TY76204* S_76248, NimStringDesc* Data_76249) {
switch ((*S_76248).Kind) {
case ((NU8) 0):
case ((NU8) 3):
break;
case ((NU8) 1):
(*S_76248).S = resizeString((*S_76248).S, Data_76249->Sup.len + 0);
appendString((*S_76248).S, Data_76249);
(*S_76248).Wr += Data_76249->Sup.len;
break;
case ((NU8) 2):
Write_3866((*S_76248).F, Data_76249);
break;
}
}
N_NIMCALL(NIM_BOOL, Endswithopr_76443)(NimStringDesc* X_76445) {
NIM_BOOL Result_76446;
Result_76446 = 0;
Result_76446 = Endswith_76401(X_76445, TMP197850);
return Result_76446;
}
N_NIMCALL(void, Llstreamwrite_76250)(TY76204* S_76252, NIM_CHAR Data_76253) {
NIM_CHAR C_76635;
NI LOC1;
C_76635 = 0;
switch ((*S_76252).Kind) {
case ((NU8) 0):
case ((NU8) 3):
break;
case ((NU8) 1):
(*S_76252).S = addChar((*S_76252).S, Data_76253);
(*S_76252).Wr += 1;
break;
case ((NU8) 2):
C_76635 = Data_76253;
LOC1 = Writebuffer_3941((*S_76252).F, ((void*) (&C_76635)), 1);
break;
}
}
N_NIMCALL(void, Llstreamwriteln_76259)(TY76204* S_76261, NimStringDesc* Data_76262) {
Llstreamwrite_76246(S_76261, Data_76262);
Llstreamwrite_76246(S_76261, ((NimStringDesc*) &TMP197696));
}
N_NIMCALL(TY76204*, Llstreamopen_76220)(FILE** F_76223) {
TY76204* Result_76289;
Result_76289 = 0;
Result_76289 = NIM_NIL;
Result_76289 = (TY76204*) newObj(NTI76206, sizeof(TY76204));
(*Result_76289).Sup.m_type = NTI76204;
(*Result_76289).F = (*F_76223);
(*Result_76289).Kind = ((NU8) 2);
return Result_76289;
}
N_NIMCALL(TY76204*, Llstreamopenstdin_76230)(void) {
TY76204* Result_76346;
Result_76346 = 0;
Result_76346 = NIM_NIL;
Result_76346 = (TY76204*) newObj(NTI76206, sizeof(TY76204));
(*Result_76346).Sup.m_type = NTI76204;
(*Result_76346).Kind = ((NU8) 3);
asgnRefNoCycle((void**) &(*Result_76346).S, copyString(((NimStringDesc*) &TMP197693)));
(*Result_76346).Lineoffset = -1;
return Result_76346;
}
N_NOINLINE(void, llstreamInit)(void) {
}

