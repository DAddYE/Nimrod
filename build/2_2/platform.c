/* Generated by Nimrod Compiler v0.8.11 */
/*   (c) 2011 Andreas Rumpf */

typedef long long int NI;
typedef unsigned long long int NU;
#include "nimbase.h"

typedef struct TY52036 TY52036;
typedef struct NimStringDesc NimStringDesc;
typedef struct TGenericSeq TGenericSeq;
typedef struct TY52449 TY52449;
typedef struct TY10802 TY10802;
typedef struct TNimType TNimType;
typedef struct TY10818 TY10818;
typedef struct TY11196 TY11196;
typedef struct TY10814 TY10814;
typedef struct TY10810 TY10810;
typedef struct TY11194 TY11194;
typedef struct TNimNode TNimNode;
struct TGenericSeq {
NI len;
NI space;
};
typedef NIM_CHAR TY245[100000001];
struct NimStringDesc {
  TGenericSeq Sup;
TY245 data;
};
struct TY52036 {
NimStringDesc* Name;
NimStringDesc* Pardir;
NimStringDesc* Dllfrmt;
NimStringDesc* Altdirsep;
NimStringDesc* Objext;
NimStringDesc* Newline;
NimStringDesc* Pathsep;
NimStringDesc* Dirsep;
NimStringDesc* Scriptext;
NimStringDesc* Curdir;
NimStringDesc* Exeext;
NimStringDesc* Extsep;
NU8 Props;
};
typedef TY52036 TY52054[21];
typedef NimStringDesc* TY52458[2];
struct TY52449 {
NimStringDesc* Name;
NI Intsize;
NU8 Endian;
NI Floatsize;
NI Bit;
};
typedef TY52449 TY52462[13];
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
struct TNimType {
NI size;
NU8 kind;
NU8 flags;
TNimType* base;
TNimNode* node;
void* finalizer;
};
typedef NI TY8814[8];
struct TY10810 {
TY10810* Next;
NI Key;
TY8814 Bits;
};
struct TNimNode {
NU8 kind;
NI offset;
TNimType* typ;
NCSTRING name;
NI len;
TNimNode** sons;
};
N_NIMCALL(NU8, Nametocpu_52575)(NimStringDesc* Name_52577);
N_NIMCALL(NI, nsuCmpIgnoreStyle)(NimStringDesc* A_24632, NimStringDesc* B_24633);
N_NIMCALL(NU8, Nametoos_52572)(NimStringDesc* Name_52574);
N_NIMCALL(void, Settarget_52582)(NU8 O_52584, NU8 C_52585);
static N_INLINE(void, asgnRefNoCycle)(void** Dest_13218, void* Src_13219);
static N_INLINE(TY10802*, Usrtocell_11612)(void* Usr_11614);
static N_INLINE(NI, Atomicinc_3221)(NI* Memloc_3224, NI X_3225);
static N_INLINE(NI, Atomicdec_3226)(NI* Memloc_3229, NI X_3230);
static N_INLINE(void, Rtladdzct_12601)(TY10802* C_12603);
N_NOINLINE(void, Addzct_11601)(TY10818* S_11604, TY10802* C_11605);
N_NIMCALL(NimStringDesc*, copyString)(NimStringDesc* Src_18712);
STRING_LITERAL(TMP52384, "DOS", 3);
STRING_LITERAL(TMP52385, "..", 2);
STRING_LITERAL(TMP52386, "$1.dll", 6);
STRING_LITERAL(TMP52387, "/", 1);
STRING_LITERAL(TMP52388, ".obj", 4);
STRING_LITERAL(TMP52389, "\015\012", 2);
STRING_LITERAL(TMP52390, ";", 1);
STRING_LITERAL(TMP52391, "\\", 1);
STRING_LITERAL(TMP52392, ".bat", 4);
STRING_LITERAL(TMP52393, ".", 1);
STRING_LITERAL(TMP52394, ".exe", 4);
STRING_LITERAL(TMP52395, "Windows", 7);
STRING_LITERAL(TMP52396, "OS2", 3);
STRING_LITERAL(TMP52397, "Linux", 5);
STRING_LITERAL(TMP52398, "lib$1.so", 8);
STRING_LITERAL(TMP52399, ".o", 2);
STRING_LITERAL(TMP52400, "\012", 1);
STRING_LITERAL(TMP52401, ":", 1);
STRING_LITERAL(TMP52402, ".sh", 3);
STRING_LITERAL(TMP52403, "", 0);
STRING_LITERAL(TMP52404, "MorphOS", 7);
STRING_LITERAL(TMP52405, "SkyOS", 5);
STRING_LITERAL(TMP52406, "Solaris", 7);
STRING_LITERAL(TMP52407, "Irix", 4);
STRING_LITERAL(TMP52408, "NetBSD", 6);
STRING_LITERAL(TMP52409, "FreeBSD", 7);
STRING_LITERAL(TMP52410, "OpenBSD", 7);
STRING_LITERAL(TMP52411, "AIX", 3);
STRING_LITERAL(TMP52412, "PalmOS", 6);
STRING_LITERAL(TMP52413, "QNX", 3);
STRING_LITERAL(TMP52414, "Amiga", 5);
STRING_LITERAL(TMP52415, "$1.library", 10);
STRING_LITERAL(TMP52416, "Atari", 5);
STRING_LITERAL(TMP52417, ".tpp", 4);
STRING_LITERAL(TMP52418, "Netware", 7);
STRING_LITERAL(TMP52419, "$1.nlm", 6);
STRING_LITERAL(TMP52420, ".nlm", 4);
STRING_LITERAL(TMP52421, "MacOS", 5);
STRING_LITERAL(TMP52422, "::", 2);
STRING_LITERAL(TMP52423, "$1Lib", 5);
STRING_LITERAL(TMP52424, "\015", 1);
STRING_LITERAL(TMP52425, ",", 1);
STRING_LITERAL(TMP52426, "MacOSX", 6);
STRING_LITERAL(TMP52427, "lib$1.dylib", 11);
STRING_LITERAL(TMP52428, "EcmaScript", 10);
STRING_LITERAL(TMP52429, "NimrodVM", 8);
NIM_CONST TY52054 Os_52053 = {{((NimStringDesc*) &TMP52384),
((NimStringDesc*) &TMP52385),
((NimStringDesc*) &TMP52386),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52388),
((NimStringDesc*) &TMP52389),
((NimStringDesc*) &TMP52390),
((NimStringDesc*) &TMP52391),
((NimStringDesc*) &TMP52392),
((NimStringDesc*) &TMP52393),
((NimStringDesc*) &TMP52394),
((NimStringDesc*) &TMP52393),
2}
,
{((NimStringDesc*) &TMP52395),
((NimStringDesc*) &TMP52385),
((NimStringDesc*) &TMP52386),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52388),
((NimStringDesc*) &TMP52389),
((NimStringDesc*) &TMP52390),
((NimStringDesc*) &TMP52391),
((NimStringDesc*) &TMP52392),
((NimStringDesc*) &TMP52393),
((NimStringDesc*) &TMP52394),
((NimStringDesc*) &TMP52393),
2}
,
{((NimStringDesc*) &TMP52396),
((NimStringDesc*) &TMP52385),
((NimStringDesc*) &TMP52386),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52388),
((NimStringDesc*) &TMP52389),
((NimStringDesc*) &TMP52390),
((NimStringDesc*) &TMP52391),
((NimStringDesc*) &TMP52392),
((NimStringDesc*) &TMP52393),
((NimStringDesc*) &TMP52394),
((NimStringDesc*) &TMP52393),
2}
,
{((NimStringDesc*) &TMP52397),
((NimStringDesc*) &TMP52385),
((NimStringDesc*) &TMP52398),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52399),
((NimStringDesc*) &TMP52400),
((NimStringDesc*) &TMP52401),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52402),
((NimStringDesc*) &TMP52393),
((NimStringDesc*) &TMP52403),
((NimStringDesc*) &TMP52393),
5}
,
{((NimStringDesc*) &TMP52404),
((NimStringDesc*) &TMP52385),
((NimStringDesc*) &TMP52398),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52399),
((NimStringDesc*) &TMP52400),
((NimStringDesc*) &TMP52401),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52402),
((NimStringDesc*) &TMP52393),
((NimStringDesc*) &TMP52403),
((NimStringDesc*) &TMP52393),
5}
,
{((NimStringDesc*) &TMP52405),
((NimStringDesc*) &TMP52385),
((NimStringDesc*) &TMP52398),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52399),
((NimStringDesc*) &TMP52400),
((NimStringDesc*) &TMP52401),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52402),
((NimStringDesc*) &TMP52393),
((NimStringDesc*) &TMP52403),
((NimStringDesc*) &TMP52393),
5}
,
{((NimStringDesc*) &TMP52406),
((NimStringDesc*) &TMP52385),
((NimStringDesc*) &TMP52398),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52399),
((NimStringDesc*) &TMP52400),
((NimStringDesc*) &TMP52401),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52402),
((NimStringDesc*) &TMP52393),
((NimStringDesc*) &TMP52403),
((NimStringDesc*) &TMP52393),
5}
,
{((NimStringDesc*) &TMP52407),
((NimStringDesc*) &TMP52385),
((NimStringDesc*) &TMP52398),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52399),
((NimStringDesc*) &TMP52400),
((NimStringDesc*) &TMP52401),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52402),
((NimStringDesc*) &TMP52393),
((NimStringDesc*) &TMP52403),
((NimStringDesc*) &TMP52393),
5}
,
{((NimStringDesc*) &TMP52408),
((NimStringDesc*) &TMP52385),
((NimStringDesc*) &TMP52398),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52399),
((NimStringDesc*) &TMP52400),
((NimStringDesc*) &TMP52401),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52402),
((NimStringDesc*) &TMP52393),
((NimStringDesc*) &TMP52403),
((NimStringDesc*) &TMP52393),
5}
,
{((NimStringDesc*) &TMP52409),
((NimStringDesc*) &TMP52385),
((NimStringDesc*) &TMP52398),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52399),
((NimStringDesc*) &TMP52400),
((NimStringDesc*) &TMP52401),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52402),
((NimStringDesc*) &TMP52393),
((NimStringDesc*) &TMP52403),
((NimStringDesc*) &TMP52393),
5}
,
{((NimStringDesc*) &TMP52410),
((NimStringDesc*) &TMP52385),
((NimStringDesc*) &TMP52398),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52399),
((NimStringDesc*) &TMP52400),
((NimStringDesc*) &TMP52401),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52402),
((NimStringDesc*) &TMP52393),
((NimStringDesc*) &TMP52403),
((NimStringDesc*) &TMP52393),
5}
,
{((NimStringDesc*) &TMP52411),
((NimStringDesc*) &TMP52385),
((NimStringDesc*) &TMP52398),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52399),
((NimStringDesc*) &TMP52400),
((NimStringDesc*) &TMP52401),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52402),
((NimStringDesc*) &TMP52393),
((NimStringDesc*) &TMP52403),
((NimStringDesc*) &TMP52393),
5}
,
{((NimStringDesc*) &TMP52412),
((NimStringDesc*) &TMP52385),
((NimStringDesc*) &TMP52398),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52399),
((NimStringDesc*) &TMP52400),
((NimStringDesc*) &TMP52401),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52402),
((NimStringDesc*) &TMP52393),
((NimStringDesc*) &TMP52403),
((NimStringDesc*) &TMP52393),
1}
,
{((NimStringDesc*) &TMP52413),
((NimStringDesc*) &TMP52385),
((NimStringDesc*) &TMP52398),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52399),
((NimStringDesc*) &TMP52400),
((NimStringDesc*) &TMP52401),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52402),
((NimStringDesc*) &TMP52393),
((NimStringDesc*) &TMP52403),
((NimStringDesc*) &TMP52393),
5}
,
{((NimStringDesc*) &TMP52414),
((NimStringDesc*) &TMP52385),
((NimStringDesc*) &TMP52415),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52399),
((NimStringDesc*) &TMP52400),
((NimStringDesc*) &TMP52401),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52402),
((NimStringDesc*) &TMP52393),
((NimStringDesc*) &TMP52403),
((NimStringDesc*) &TMP52393),
1}
,
{((NimStringDesc*) &TMP52416),
((NimStringDesc*) &TMP52385),
((NimStringDesc*) &TMP52386),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52399),
((NimStringDesc*) &TMP52400),
((NimStringDesc*) &TMP52401),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52403),
((NimStringDesc*) &TMP52393),
((NimStringDesc*) &TMP52417),
((NimStringDesc*) &TMP52393),
1}
,
{((NimStringDesc*) &TMP52418),
((NimStringDesc*) &TMP52385),
((NimStringDesc*) &TMP52419),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52403),
((NimStringDesc*) &TMP52389),
((NimStringDesc*) &TMP52401),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52402),
((NimStringDesc*) &TMP52393),
((NimStringDesc*) &TMP52420),
((NimStringDesc*) &TMP52393),
2}
,
{((NimStringDesc*) &TMP52421),
((NimStringDesc*) &TMP52422),
((NimStringDesc*) &TMP52423),
((NimStringDesc*) &TMP52401),
((NimStringDesc*) &TMP52399),
((NimStringDesc*) &TMP52424),
((NimStringDesc*) &TMP52425),
((NimStringDesc*) &TMP52401),
((NimStringDesc*) &TMP52403),
((NimStringDesc*) &TMP52401),
((NimStringDesc*) &TMP52403),
((NimStringDesc*) &TMP52393),
2}
,
{((NimStringDesc*) &TMP52426),
((NimStringDesc*) &TMP52385),
((NimStringDesc*) &TMP52427),
((NimStringDesc*) &TMP52401),
((NimStringDesc*) &TMP52399),
((NimStringDesc*) &TMP52400),
((NimStringDesc*) &TMP52401),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52402),
((NimStringDesc*) &TMP52393),
((NimStringDesc*) &TMP52403),
((NimStringDesc*) &TMP52393),
5}
,
{((NimStringDesc*) &TMP52428),
((NimStringDesc*) &TMP52385),
((NimStringDesc*) &TMP52398),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52399),
((NimStringDesc*) &TMP52400),
((NimStringDesc*) &TMP52401),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52402),
((NimStringDesc*) &TMP52393),
((NimStringDesc*) &TMP52403),
((NimStringDesc*) &TMP52393),
0}
,
{((NimStringDesc*) &TMP52429),
((NimStringDesc*) &TMP52385),
((NimStringDesc*) &TMP52398),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52399),
((NimStringDesc*) &TMP52400),
((NimStringDesc*) &TMP52401),
((NimStringDesc*) &TMP52387),
((NimStringDesc*) &TMP52402),
((NimStringDesc*) &TMP52393),
((NimStringDesc*) &TMP52403),
((NimStringDesc*) &TMP52393),
0}
}
;
STRING_LITERAL(TMP52553, "littleEndian", 12);
STRING_LITERAL(TMP52554, "bigEndian", 9);
NIM_CONST TY52458 Endiantostr_52457 = {((NimStringDesc*) &TMP52553),
((NimStringDesc*) &TMP52554)}
;
STRING_LITERAL(TMP52555, "i386", 4);
STRING_LITERAL(TMP52556, "m68k", 4);
STRING_LITERAL(TMP52557, "alpha", 5);
STRING_LITERAL(TMP52558, "powerpc", 7);
STRING_LITERAL(TMP52559, "powerpc64", 9);
STRING_LITERAL(TMP52560, "sparc", 5);
STRING_LITERAL(TMP52561, "vm", 2);
STRING_LITERAL(TMP52562, "ia64", 4);
STRING_LITERAL(TMP52563, "amd64", 5);
STRING_LITERAL(TMP52564, "mips", 4);
STRING_LITERAL(TMP52565, "arm", 3);
STRING_LITERAL(TMP52566, "ecmascript", 10);
STRING_LITERAL(TMP52567, "nimrodvm", 8);
NIM_CONST TY52462 Cpu_52461 = {{((NimStringDesc*) &TMP52555),
32,
((NU8) 0),
64,
32}
,
{((NimStringDesc*) &TMP52556),
32,
((NU8) 1),
64,
32}
,
{((NimStringDesc*) &TMP52557),
64,
((NU8) 0),
64,
64}
,
{((NimStringDesc*) &TMP52558),
32,
((NU8) 1),
64,
32}
,
{((NimStringDesc*) &TMP52559),
64,
((NU8) 1),
64,
64}
,
{((NimStringDesc*) &TMP52560),
32,
((NU8) 1),
64,
32}
,
{((NimStringDesc*) &TMP52561),
32,
((NU8) 0),
64,
32}
,
{((NimStringDesc*) &TMP52562),
64,
((NU8) 0),
64,
64}
,
{((NimStringDesc*) &TMP52563),
64,
((NU8) 0),
64,
64}
,
{((NimStringDesc*) &TMP52564),
32,
((NU8) 1),
64,
32}
,
{((NimStringDesc*) &TMP52565),
32,
((NU8) 0),
64,
32}
,
{((NimStringDesc*) &TMP52566),
32,
((NU8) 1),
64,
32}
,
{((NimStringDesc*) &TMP52567),
32,
((NU8) 1),
64,
32}
}
;
STRING_LITERAL(TMP52700, "linux", 5);
NU8 Targetcpu_52568;
NU8 Hostcpu_52569;
NU8 Targetos_52570;
NU8 Hostos_52571;
NI Intsize_52578;
NI Floatsize_52579;
NI Ptrsize_52580;
NimStringDesc* Tnl_52581;
extern TY11196 Gch_11214;
N_NIMCALL(NU8, Nametocpu_52575)(NimStringDesc* Name_52577) {
NU8 Result_52655;
NU8 I_52695;
NU8 Res_52699;
NI LOC3;
Result_52655 = 0;
I_52695 = 0;
Res_52699 = 0;
Res_52699 = ((NU8) 1);
while (1) {
if (!(Res_52699 <= ((NU8) 13))) goto LA1;
I_52695 = Res_52699;
LOC3 = nsuCmpIgnoreStyle(Name_52577, Cpu_52461[(I_52695)-1].Name);
if (!(LOC3 == 0)) goto LA4;
Result_52655 = I_52695;
goto BeforeRet;
LA4: ;
Res_52699 += 1;
} LA1: ;
Result_52655 = ((NU8) 0);
BeforeRet: ;
return Result_52655;
}
N_NIMCALL(NU8, Nametoos_52572)(NimStringDesc* Name_52574) {
NU8 Result_52607;
NU8 I_52647;
NU8 Res_52651;
NI LOC3;
Result_52607 = 0;
I_52647 = 0;
Res_52651 = 0;
Res_52651 = ((NU8) 1);
while (1) {
if (!(Res_52651 <= ((NU8) 21))) goto LA1;
I_52647 = Res_52651;
LOC3 = nsuCmpIgnoreStyle(Name_52574, Os_52053[(I_52647)-1].Name);
if (!(LOC3 == 0)) goto LA4;
Result_52607 = I_52647;
goto BeforeRet;
LA4: ;
Res_52651 += 1;
} LA1: ;
Result_52607 = ((NU8) 0);
BeforeRet: ;
return Result_52607;
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
N_NIMCALL(void, Settarget_52582)(NU8 O_52584, NU8 C_52585) {
Targetcpu_52568 = C_52585;
Targetos_52570 = O_52584;
Intsize_52578 = (NI64)(Cpu_52461[(C_52585)-1].Intsize / 8);
Floatsize_52579 = (NI64)(Cpu_52461[(C_52585)-1].Floatsize / 8);
Ptrsize_52580 = (NI64)(Cpu_52461[(C_52585)-1].Bit / 8);
asgnRefNoCycle((void**) &Tnl_52581, copyString(Os_52053[(O_52584)-1].Newline));
}
N_NOINLINE(void, platformInit)(void) {
Hostcpu_52569 = Nametocpu_52575(((NimStringDesc*) &TMP52563));
Hostos_52571 = Nametoos_52572(((NimStringDesc*) &TMP52700));
Settarget_52582(Hostos_52571, Hostcpu_52569);
}

