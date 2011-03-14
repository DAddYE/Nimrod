/* Generated by Nimrod Compiler v0.8.11 */
/*   (c) 2011 Andreas Rumpf */

typedef long int NI;
typedef unsigned long int NU;
#include "nimbase.h"

typedef struct TY81132 TY81132;
typedef struct TGenericSeq TGenericSeq;
typedef struct TNimType TNimType;
typedef struct TNimNode TNimNode;
typedef struct TY10802 TY10802;
typedef struct TY10818 TY10818;
typedef struct TY11196 TY11196;
typedef struct TY10814 TY10814;
typedef struct TY10810 TY10810;
typedef struct TY11194 TY11194;
typedef struct NimStringDesc NimStringDesc;
typedef struct TY78267 TY78267;
typedef struct TY77015 TY77015;
typedef struct TNimObject TNimObject;
typedef struct TY76204 TY76204;
typedef struct TY78281 TY78281;
typedef struct TY78263 TY78263;
typedef struct TY55011 TY55011;
typedef struct TY55005 TY55005;
typedef struct TY48538 TY48538;
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
typedef NIM_CHAR TY245[100000001];
struct NimStringDesc {
  TGenericSeq Sup;
TY245 data;
};
struct TNimObject {
TNimType* m_type;
};
struct TY77015 {
  TNimObject Sup;
NI Bufpos;
NCSTRING Buf;
NI Buflen;
TY76204* Stream;
NI Linenumber;
NI Sentinel;
NI Linestart;
};
struct TY78267 {
  TY77015 Sup;
NimStringDesc* Filename;
TY78281* Indentstack;
NI Dedent;
NI Indentahead;
};
struct TY78263 {
TNimType* m_type;
NU8 Toktype;
NI Indent;
TY55011* Ident;
NI64 Inumber;
NF64 Fnumber;
NU8 Base;
NimStringDesc* Literal;
TY78263* Next;
};
struct TY55005 {
  TNimObject Sup;
NI Id;
};
struct TY55011 {
  TY55005 Sup;
NimStringDesc* S;
TY55011* Next;
NI H;
};
struct TY48538 {
NI16 Line;
NI16 Col;
int Fileindex;
};
typedef NimStringDesc* TY74026[3];
typedef NI TY8814[16];
struct TY10810 {
TY10810* Next;
NI Key;
TY8814 Bits;
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
struct TY81132 {
  TGenericSeq Sup;
  NIM_BOOL data[SEQ_DECL_SIZE];
};
struct TY78281 {
  TGenericSeq Sup;
  NI data[SEQ_DECL_SIZE];
};
N_NIMCALL(void*, newSeq)(TNimType* Typ_14404, NI Len_14405);
static N_INLINE(void, asgnRefNoCycle)(void** Dest_13218, void* Src_13219);
static N_INLINE(TY10802*, Usrtocell_11612)(void* Usr_11614);
static N_INLINE(NI, Atomicinc_3221)(NI* Memloc_3224, NI X_3225);
static N_INLINE(NI, Atomicdec_3226)(NI* Memloc_3229, NI X_3230);
static N_INLINE(void, Rtladdzct_12601)(TY10802* C_12603);
N_NOINLINE(void, Addzct_11601)(TY10818* S_11604, TY10802* C_11605);
N_NIMCALL(NimStringDesc*, Getprefixdir_47114)(void);
static N_INLINE(NIM_BOOL, eqStrings)(NimStringDesc* A_18649, NimStringDesc* B_18650);
N_NIMCALL(NimStringDesc*, copyString)(NimStringDesc* Src_18712);
N_NIMCALL(NimStringDesc*, nosJoinPath)(NimStringDesc* Head_38403, NimStringDesc* Tail_38404);
N_NIMCALL(void, Loadspecialconfig_81007)(NimStringDesc* Configfilename_81009);
N_NIMCALL(void, Readconfigfile_81434)(NimStringDesc* Filename_81436);
N_NIMCALL(void, genericReset)(void* Dest_19728, TNimType* Mt_19729);
N_NIMCALL(void*, newObj)(TNimType* Typ_13910, NI Size_13911);
N_NIMCALL(TY76204*, Llstreamopen_76224)(NimStringDesc* Filename_76226, NU8 Mode_76227);
N_NIMCALL(void, Openlexer_78298)(TY78267* Lex_78301, NimStringDesc* Filename_78302, TY76204* Inputstream_78303);
N_NIMCALL(void, Conftok_81317)(TY78267* L_81320, TY78263* Tok_81321);
N_NIMCALL(void, Ppgettok_81010)(TY78267* L_81013, TY78263* Tok_81014);
N_NIMCALL(void, Rawgettok_78304)(TY78267* L_78307, TY78263* Tok_78309);
N_NIMCALL(void, Parsedirective_81288)(TY78267* L_81291, TY78263* Tok_81292);
N_NIMCALL(NU8, Whichkeyword_73492)(TY55011* Id_73494);
N_NIMCALL(TGenericSeq*, setLengthSeq)(TGenericSeq* Seq_19003, NI Elemsize_19004, NI Newlen_19005);
N_NIMCALL(NIM_BOOL, Evalppif_81117)(TY78267* L_81120, TY78263* Tok_81121);
N_NIMCALL(NIM_BOOL, Parseexpr_81053)(TY78267* L_81056, TY78263* Tok_81057);
N_NIMCALL(NIM_BOOL, Parseandexpr_81089)(TY78267* L_81092, TY78263* Tok_81093);
N_NIMCALL(NIM_BOOL, Parseatom_81058)(TY78267* L_81061, TY78263* Tok_81062);
N_NIMCALL(void, Lexmessage_78326)(TY78267* L_78328, NU8 Msg_78329, NimStringDesc* Arg_78330);
N_NIMCALL(NIM_BOOL, Isdefined_65059)(TY55011* Symbol_65061);
N_NIMCALL(void, Jumptodirective_81175)(TY78267* L_81178, TY78263* Tok_81179, NU8 Dest_81180);
N_NIMCALL(void, Doelse_81181)(TY78267* L_81184, TY78263* Tok_81185);
N_NIMCALL(void, Doelif_81199)(TY78267* L_81202, TY78263* Tok_81203);
N_NIMCALL(void, Doend_81150)(TY78267* L_81153, TY78263* Tok_81154);
N_NIMCALL(void, Msgwriteln_48794)(NimStringDesc* S_48796);
N_NIMCALL(NimStringDesc*, Toktostr_78323)(TY78263* Tok_78325);
N_NIMCALL(void, Putenv_39832)(NimStringDesc* Key_39834, NimStringDesc* Val_39835);
static N_INLINE(void, appendString)(NimStringDesc* Dest_18799, NimStringDesc* Src_18800);
N_NIMCALL(NimStringDesc*, Getenv_39818)(NimStringDesc* Key_39820);
N_NIMCALL(NimStringDesc*, rawNewString)(NI Space_18689);
N_NIMCALL(void, Parseassignment_81358)(TY78267* L_81361, TY78263* Tok_81362);
N_NIMCALL(TY55011*, Getident_55016)(NimStringDesc* Identifier_55018);
N_NIMCALL(TY48538, Getlineinfo_78313)(TY78267* L_78315);
N_NIMCALL(void, Checksymbol_81333)(TY78267* L_81335, TY78263* Tok_81336);
N_NIMCALL(NimStringDesc*, addChar)(NimStringDesc* S_1803, NIM_CHAR C_1804);
N_NIMCALL(NimStringDesc*, resizeString)(NimStringDesc* Dest_18789, NI Addlen_18790);
N_NIMCALL(void, Processswitch_74012)(NimStringDesc* Switch_74014, NimStringDesc* Arg_74015, NU8 Pass_74016, TY48538 Info_74017);
N_NIMCALL(void, Closelexer_78316)(TY78267* Lex_78319);
N_NIMCALL(void, Rawmessage_49094)(NU8 Msg_49096, NimStringDesc* Arg_49097);
N_NIMCALL(NimStringDesc*, Getconfigpath_81495)(NimStringDesc* Filename_81497);
N_NIMCALL(NimStringDesc*, nosgetConfigDir)(void);
N_NIMCALL(NIM_BOOL, nosexistsFile)(NimStringDesc* Filename_37003);
N_NIMCALL(NimStringDesc*, nosJoinPathOpenArray)(NimStringDesc** Parts_38451, NI Parts_38451Len0);
N_NIMCALL(NimStringDesc*, nosChangeFileExt)(NimStringDesc* Filename_38820, NimStringDesc* Ext_38821);
STRING_LITERAL(TMP197675, "/usr", 4);
STRING_LITERAL(TMP197676, "/usr/lib/nimrod", 15);
STRING_LITERAL(TMP197677, "/usr/local", 10);
STRING_LITERAL(TMP197678, "/usr/local/lib/nimrod", 21);
STRING_LITERAL(TMP197679, "lib", 3);
STRING_LITERAL(TMP197707, "@", 1);
STRING_LITERAL(TMP197708, "\')\'", 3);
STRING_LITERAL(TMP197709, "\':\'", 3);
STRING_LITERAL(TMP197710, "@if", 3);
STRING_LITERAL(TMP197711, "@end", 4);
STRING_LITERAL(TMP197713, "-", 1);
STRING_LITERAL(TMP197714, "--", 2);
STRING_LITERAL(TMP197715, "", 0);
STRING_LITERAL(TMP197716, "\']\'", 3);
STRING_LITERAL(TMP197717, "&", 1);
STRING_LITERAL(TMP197719, "config", 6);
STRING_LITERAL(TMP197720, "/etc/", 5);
STRING_LITERAL(TMP197721, "nimrod.cfg", 10);
STRING_LITERAL(TMP197722, "cfg", 3);
TY81132* Condstack_81133;
extern TNimType* NTI81132; /* seq[bool] */
extern TY11196 Gch_11214;
extern NimStringDesc* Libpath_47117;
extern NU32 Gglobaloptions_47084;
extern TNimType* NTI78267; /* TLexer */
extern TNimType* NTI78261; /* PToken */
extern TNimType* NTI78263; /* TToken */
extern NI Gverbosity_47090;
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
LOC11 = memcmp(((NCSTRING) ((*A_18649).data)), ((NCSTRING) ((*B_18650).data)), ((int) ((NI32)((*A_18649).Sup.len * 1))));
LOC9 = (LOC11 == ((NI32) 0));
LA10: ;
Result_18651 = LOC9;
goto BeforeRet;
BeforeRet: ;
return Result_18651;
}
N_NIMCALL(void, Ppgettok_81010)(TY78267* L_81013, TY78263* Tok_81014) {
NIM_BOOL LOC2;
NIM_BOOL LOC3;
NIM_BOOL LOC4;
Rawgettok_78304(L_81013, Tok_81014);
while (1) {
LOC4 = ((*Tok_81014).Toktype == ((NU8) 102));
if (LOC4) goto LA5;
LOC4 = ((*Tok_81014).Toktype == ((NU8) 103));
LA5: ;
LOC3 = LOC4;
if (LOC3) goto LA6;
LOC3 = ((*Tok_81014).Toktype == ((NU8) 104));
LA6: ;
LOC2 = LOC3;
if (LOC2) goto LA7;
LOC2 = ((*Tok_81014).Toktype == ((NU8) 100));
LA7: ;
if (!LOC2) goto LA1;
Rawgettok_78304(L_81013, Tok_81014);
} LA1: ;
}
N_NIMCALL(NIM_BOOL, Parseatom_81058)(TY78267* L_81061, TY78263* Tok_81062) {
NIM_BOOL Result_81063;
NIM_BOOL LOC9;
Result_81063 = 0;
if (!((*Tok_81062).Toktype == ((NU8) 80))) goto LA2;
Ppgettok_81010(L_81061, Tok_81062);
Result_81063 = Parseexpr_81053(L_81061, Tok_81062);
if (!((*Tok_81062).Toktype == ((NU8) 81))) goto LA5;
Ppgettok_81010(L_81061, Tok_81062);
goto LA4;
LA5: ;
Lexmessage_78326(&(*L_81061), ((NU8) 21), ((NimStringDesc*) &TMP197708));
LA4: ;
goto LA1;
LA2: ;
if (!((*(*Tok_81062).Ident).Sup.Id == 40)) goto LA7;
Ppgettok_81010(L_81061, Tok_81062);
LOC9 = Parseatom_81058(L_81061, Tok_81062);
Result_81063 = !(LOC9);
goto LA1;
LA7: ;
Result_81063 = Isdefined_65059((*Tok_81062).Ident);
Ppgettok_81010(L_81061, Tok_81062);
LA1: ;
return Result_81063;
}
N_NIMCALL(NIM_BOOL, Parseandexpr_81089)(TY78267* L_81092, TY78263* Tok_81093) {
NIM_BOOL Result_81094;
NIM_BOOL B_81095;
NIM_BOOL LOC2;
Result_81094 = 0;
B_81095 = 0;
Result_81094 = Parseatom_81058(L_81092, Tok_81093);
while (1) {
if (!((*(*Tok_81093).Ident).Sup.Id == 2)) goto LA1;
Ppgettok_81010(L_81092, Tok_81093);
B_81095 = Parseatom_81058(L_81092, Tok_81093);
LOC2 = Result_81094;
if (!(LOC2)) goto LA3;
LOC2 = B_81095;
LA3: ;
Result_81094 = LOC2;
} LA1: ;
return Result_81094;
}
N_NIMCALL(NIM_BOOL, Parseexpr_81053)(TY78267* L_81056, TY78263* Tok_81057) {
NIM_BOOL Result_81108;
NIM_BOOL B_81109;
NIM_BOOL LOC2;
Result_81108 = 0;
B_81109 = 0;
Result_81108 = Parseandexpr_81089(L_81056, Tok_81057);
while (1) {
if (!((*(*Tok_81057).Ident).Sup.Id == 44)) goto LA1;
Ppgettok_81010(L_81056, Tok_81057);
B_81109 = Parseandexpr_81089(L_81056, Tok_81057);
LOC2 = Result_81108;
if (LOC2) goto LA3;
LOC2 = B_81109;
LA3: ;
Result_81108 = LOC2;
} LA1: ;
return Result_81108;
}
N_NIMCALL(NIM_BOOL, Evalppif_81117)(TY78267* L_81120, TY78263* Tok_81121) {
NIM_BOOL Result_81122;
Result_81122 = 0;
Ppgettok_81010(L_81120, Tok_81121);
Result_81122 = Parseexpr_81053(L_81120, Tok_81121);
if (!((*Tok_81121).Toktype == ((NU8) 94))) goto LA2;
Ppgettok_81010(L_81120, Tok_81121);
goto LA1;
LA2: ;
Lexmessage_78326(&(*L_81120), ((NU8) 21), ((NimStringDesc*) &TMP197709));
LA1: ;
return Result_81122;
}
N_NIMCALL(void, Doelse_81181)(TY78267* L_81184, TY78263* Tok_81185) {
if (!((Condstack_81133->Sup.len-1) < 0)) goto LA2;
Lexmessage_78326(&(*L_81184), ((NU8) 21), ((NimStringDesc*) &TMP197710));
LA2: ;
Ppgettok_81010(L_81184, Tok_81185);
if (!((*Tok_81185).Toktype == ((NU8) 94))) goto LA5;
Ppgettok_81010(L_81184, Tok_81185);
LA5: ;
if (!Condstack_81133->data[(Condstack_81133->Sup.len-1)]) goto LA8;
Jumptodirective_81175(L_81184, Tok_81185, ((NU8) 0));
LA8: ;
}
N_NIMCALL(void, Doelif_81199)(TY78267* L_81202, TY78263* Tok_81203) {
NIM_BOOL Res_81204;
NIM_BOOL LOC5;
Res_81204 = 0;
if (!((Condstack_81133->Sup.len-1) < 0)) goto LA2;
Lexmessage_78326(&(*L_81202), ((NU8) 21), ((NimStringDesc*) &TMP197710));
LA2: ;
Res_81204 = Evalppif_81117(L_81202, Tok_81203);
LOC5 = Condstack_81133->data[(Condstack_81133->Sup.len-1)];
if (LOC5) goto LA6;
LOC5 = !(Res_81204);
LA6: ;
if (!LOC5) goto LA7;
Jumptodirective_81175(L_81202, Tok_81203, ((NU8) 1));
goto LA4;
LA7: ;
Condstack_81133->data[(Condstack_81133->Sup.len-1)] = NIM_TRUE;
LA4: ;
}
N_NIMCALL(void, Doend_81150)(TY78267* L_81153, TY78263* Tok_81154) {
if (!((Condstack_81133->Sup.len-1) < 0)) goto LA2;
Lexmessage_78326(&(*L_81153), ((NU8) 21), ((NimStringDesc*) &TMP197710));
LA2: ;
Ppgettok_81010(L_81153, Tok_81154);
Condstack_81133 = (TY81132*) setLengthSeq(&(Condstack_81133)->Sup, sizeof(NIM_BOOL), (Condstack_81133->Sup.len-1));
}
N_NIMCALL(void, Jumptodirective_81175)(TY78267* L_81178, TY78263* Tok_81179, NU8 Dest_81180) {
NI Nestedifs_81215;
NIM_BOOL LOC3;
NU8 LOC7;
NIM_BOOL LOC9;
NIM_BOOL LOC14;
Nestedifs_81215 = 0;
Nestedifs_81215 = 0;
while (1) {
LOC3 = !(((*Tok_81179).Ident == NIM_NIL));
if (!(LOC3)) goto LA4;
LOC3 = eqStrings((*(*Tok_81179).Ident).S, ((NimStringDesc*) &TMP197707));
LA4: ;
if (!LOC3) goto LA5;
Ppgettok_81010(L_81178, Tok_81179);
LOC7 = Whichkeyword_73492((*Tok_81179).Ident);
switch (LOC7) {
case ((NU8) 26):
Nestedifs_81215 += 1;
break;
case ((NU8) 18):
LOC9 = (Dest_81180 == ((NU8) 1));
if (!(LOC9)) goto LA10;
LOC9 = (Nestedifs_81215 == 0);
LA10: ;
if (!LOC9) goto LA11;
Doelse_81181(L_81178, Tok_81179);
goto LA1;
LA11: ;
break;
case ((NU8) 17):
LOC14 = (Dest_81180 == ((NU8) 1));
if (!(LOC14)) goto LA15;
LOC14 = (Nestedifs_81215 == 0);
LA15: ;
if (!LOC14) goto LA16;
Doelif_81199(L_81178, Tok_81179);
goto LA1;
LA16: ;
break;
case ((NU8) 19):
if (!(Nestedifs_81215 == 0)) goto LA19;
Doend_81150(L_81178, Tok_81179);
goto LA1;
LA19: ;
if (!(0 < Nestedifs_81215)) goto LA22;
Nestedifs_81215 -= 1;
LA22: ;
break;
default:
break;
}
Ppgettok_81010(L_81178, Tok_81179);
goto LA2;
LA5: ;
if (!((*Tok_81179).Toktype == ((NU8) 1))) goto LA24;
Lexmessage_78326(&(*L_81178), ((NU8) 21), ((NimStringDesc*) &TMP197711));
goto LA2;
LA24: ;
Ppgettok_81010(L_81178, Tok_81179);
LA2: ;
} LA1: ;
}
static N_INLINE(void, appendString)(NimStringDesc* Dest_18799, NimStringDesc* Src_18800) {
memcpy(((NCSTRING) (&(*Dest_18799).data[((*Dest_18799).Sup.len)-0])), ((NCSTRING) ((*Src_18800).data)), ((int) ((NI32)((NI32)((*Src_18800).Sup.len + 1) * 1))));
(*Dest_18799).Sup.len += (*Src_18800).Sup.len;
}
N_NIMCALL(void, Parsedirective_81288)(TY78267* L_81291, TY78263* Tok_81292) {
NIM_BOOL Res_81293;
NimStringDesc* Key_81294;
NU8 LOC1;
NimStringDesc* LOC5;
NimStringDesc* LOC6;
NimStringDesc* LOC7;
NimStringDesc* LOC8;
NimStringDesc* LOC9;
NimStringDesc* LOC10;
NimStringDesc* LOC11;
NimStringDesc* LOC12;
NimStringDesc* LOC13;
Key_81294 = 0;
Res_81293 = 0;
Key_81294 = NIM_NIL;
Ppgettok_81010(L_81291, Tok_81292);
LOC1 = Whichkeyword_73492((*Tok_81292).Ident);
switch (LOC1) {
case ((NU8) 26):
Condstack_81133 = (TY81132*) setLengthSeq(&(Condstack_81133)->Sup, sizeof(NIM_BOOL), (NI32)(Condstack_81133->Sup.len + 1));
Res_81293 = Evalppif_81117(L_81291, Tok_81292);
Condstack_81133->data[(Condstack_81133->Sup.len-1)] = Res_81293;
if (!!(Res_81293)) goto LA3;
Jumptodirective_81175(L_81291, Tok_81292, ((NU8) 1));
LA3: ;
break;
case ((NU8) 17):
Doelif_81199(L_81291, Tok_81292);
break;
case ((NU8) 18):
Doelse_81181(L_81291, Tok_81292);
break;
case ((NU8) 19):
Doend_81150(L_81291, Tok_81292);
break;
case ((NU8) 202):
Ppgettok_81010(L_81291, Tok_81292);
LOC5 = 0;
LOC5 = Toktostr_78323(Tok_81292);
Msgwriteln_48794(LOC5);
Ppgettok_81010(L_81291, Tok_81292);
break;
case ((NU8) 203):
Ppgettok_81010(L_81291, Tok_81292);
Key_81294 = Toktostr_78323(Tok_81292);
Ppgettok_81010(L_81291, Tok_81292);
LOC6 = 0;
LOC6 = Toktostr_78323(Tok_81292);
Putenv_39832(Key_81294, LOC6);
Ppgettok_81010(L_81291, Tok_81292);
break;
case ((NU8) 204):
Ppgettok_81010(L_81291, Tok_81292);
Key_81294 = Toktostr_78323(Tok_81292);
Ppgettok_81010(L_81291, Tok_81292);
LOC7 = 0;
LOC8 = 0;
LOC8 = Toktostr_78323(Tok_81292);
LOC9 = 0;
LOC9 = Getenv_39818(Key_81294);
LOC7 = rawNewString(LOC8->Sup.len + LOC9->Sup.len + 0);
appendString(LOC7, LOC8);
appendString(LOC7, LOC9);
Putenv_39832(Key_81294, LOC7);
Ppgettok_81010(L_81291, Tok_81292);
break;
case ((NU8) 205):
Ppgettok_81010(L_81291, Tok_81292);
Key_81294 = Toktostr_78323(Tok_81292);
Ppgettok_81010(L_81291, Tok_81292);
LOC10 = 0;
LOC11 = 0;
LOC11 = Getenv_39818(Key_81294);
LOC12 = 0;
LOC12 = Toktostr_78323(Tok_81292);
LOC10 = rawNewString(LOC11->Sup.len + LOC12->Sup.len + 0);
appendString(LOC10, LOC11);
appendString(LOC10, LOC12);
Putenv_39832(Key_81294, LOC10);
Ppgettok_81010(L_81291, Tok_81292);
break;
default:
LOC13 = 0;
LOC13 = Toktostr_78323(Tok_81292);
Lexmessage_78326(&(*L_81291), ((NU8) 28), LOC13);
break;
}
}
N_NIMCALL(void, Conftok_81317)(TY78267* L_81320, TY78263* Tok_81321) {
NIM_BOOL LOC2;
Ppgettok_81010(L_81320, Tok_81321);
while (1) {
LOC2 = !(((*Tok_81321).Ident == NIM_NIL));
if (!(LOC2)) goto LA3;
LOC2 = eqStrings((*(*Tok_81321).Ident).S, ((NimStringDesc*) &TMP197707));
LA3: ;
if (!LOC2) goto LA1;
Parsedirective_81288(L_81320, Tok_81321);
} LA1: ;
}
N_NIMCALL(void, Checksymbol_81333)(TY78267* L_81335, TY78263* Tok_81336) {
NimStringDesc* LOC4;
if (!!(((*Tok_81336).Toktype >= ((NU8) 2) && (*Tok_81336).Toktype <= ((NU8) 65) || (*Tok_81336).Toktype >= ((NU8) 74) && (*Tok_81336).Toktype <= ((NU8) 76)))) goto LA2;
LOC4 = 0;
LOC4 = Toktostr_78323(Tok_81336);
Lexmessage_78326(L_81335, ((NU8) 19), LOC4);
LA2: ;
}
N_NIMCALL(void, Parseassignment_81358)(TY78267* L_81361, TY78263* Tok_81362) {
NimStringDesc* S_81363;
NimStringDesc* Val_81364;
TY48538 Info_81365;
NIM_BOOL LOC2;
TY55011* LOC3;
TY55011* LOC5;
NimStringDesc* LOC9;
NimStringDesc* LOC13;
NIM_BOOL LOC18;
NimStringDesc* LOC25;
NIM_BOOL LOC27;
TY55011* LOC29;
NimStringDesc* LOC30;
S_81363 = 0;
Val_81364 = 0;
S_81363 = NIM_NIL;
Val_81364 = NIM_NIL;
memset((void*)&Info_81365, 0, sizeof(Info_81365));
LOC3 = 0;
LOC3 = Getident_55016(((NimStringDesc*) &TMP197713));
LOC2 = ((*(*Tok_81362).Ident).Sup.Id == (*LOC3).Sup.Id);
if (LOC2) goto LA4;
LOC5 = 0;
LOC5 = Getident_55016(((NimStringDesc*) &TMP197714));
LOC2 = ((*(*Tok_81362).Ident).Sup.Id == (*LOC5).Sup.Id);
LA4: ;
if (!LOC2) goto LA6;
Conftok_81317(L_81361, Tok_81362);
LA6: ;
Info_81365 = Getlineinfo_78313(&(*L_81361));
Checksymbol_81333(&(*L_81361), Tok_81362);
S_81363 = Toktostr_78323(Tok_81362);
Conftok_81317(L_81361, Tok_81362);
Val_81364 = copyString(((NimStringDesc*) &TMP197715));
while (1) {
if (!((*Tok_81362).Toktype == ((NU8) 96))) goto LA8;
S_81363 = addChar(S_81363, 46);
Conftok_81317(L_81361, Tok_81362);
Checksymbol_81333(&(*L_81361), Tok_81362);
LOC9 = 0;
LOC9 = Toktostr_78323(Tok_81362);
S_81363 = resizeString(S_81363, LOC9->Sup.len + 0);
appendString(S_81363, LOC9);
Conftok_81317(L_81361, Tok_81362);
} LA8: ;
if (!((*Tok_81362).Toktype == ((NU8) 82))) goto LA11;
Conftok_81317(L_81361, Tok_81362);
Checksymbol_81333(&(*L_81361), Tok_81362);
LOC13 = 0;
LOC13 = Toktostr_78323(Tok_81362);
Val_81364 = resizeString(Val_81364, LOC13->Sup.len + 0);
appendString(Val_81364, LOC13);
Conftok_81317(L_81361, Tok_81362);
if (!((*Tok_81362).Toktype == ((NU8) 83))) goto LA15;
Conftok_81317(L_81361, Tok_81362);
goto LA14;
LA15: ;
Lexmessage_78326(&(*L_81361), ((NU8) 21), ((NimStringDesc*) &TMP197716));
LA14: ;
Val_81364 = addChar(Val_81364, 93);
LA11: ;
LOC18 = ((*Tok_81362).Toktype == ((NU8) 94));
if (LOC18) goto LA19;
LOC18 = ((*Tok_81362).Toktype == ((NU8) 95));
LA19: ;
if (!LOC18) goto LA20;
if (!(0 < Val_81364->Sup.len)) goto LA23;
Val_81364 = addChar(Val_81364, 58);
LA23: ;
Conftok_81317(L_81361, Tok_81362);
Checksymbol_81333(&(*L_81361), Tok_81362);
LOC25 = 0;
LOC25 = Toktostr_78323(Tok_81362);
Val_81364 = resizeString(Val_81364, LOC25->Sup.len + 0);
appendString(Val_81364, LOC25);
Conftok_81317(L_81361, Tok_81362);
while (1) {
LOC27 = !(((*Tok_81362).Ident == NIM_NIL));
if (!(LOC27)) goto LA28;
LOC29 = 0;
LOC29 = Getident_55016(((NimStringDesc*) &TMP197717));
LOC27 = ((*(*Tok_81362).Ident).Sup.Id == (*LOC29).Sup.Id);
LA28: ;
if (!LOC27) goto LA26;
Conftok_81317(L_81361, Tok_81362);
Checksymbol_81333(&(*L_81361), Tok_81362);
LOC30 = 0;
LOC30 = Toktostr_78323(Tok_81362);
Val_81364 = resizeString(Val_81364, LOC30->Sup.len + 0);
appendString(Val_81364, LOC30);
Conftok_81317(L_81361, Tok_81362);
} LA26: ;
LA20: ;
Processswitch_74012(S_81363, Val_81364, ((NU8) 2), Info_81365);
}
N_NIMCALL(void, Readconfigfile_81434)(NimStringDesc* Filename_81436) {
TY78267 L_81437;
TY78263* Tok_81438;
TY76204* Stream_81439;
memset((void*)&L_81437, 0, sizeof(L_81437));
L_81437.Sup.Sup.m_type = NTI78267;
Tok_81438 = 0;
Stream_81439 = 0;
genericReset((void*)&L_81437, NTI78267);
Tok_81438 = NIM_NIL;
Stream_81439 = NIM_NIL;
Tok_81438 = (TY78263*) newObj(NTI78261, sizeof(TY78263));
(*Tok_81438).m_type = NTI78263;
Stream_81439 = Llstreamopen_76224(Filename_81436, ((NU8) 0));
if (!!((Stream_81439 == NIM_NIL))) goto LA2;
Openlexer_78298(&L_81437, Filename_81436, Stream_81439);
(*Tok_81438).Toktype = ((NU8) 1);
Conftok_81317(&L_81437, Tok_81438);
while (1) {
if (!!(((*Tok_81438).Toktype == ((NU8) 1)))) goto LA4;
Parseassignment_81358(&L_81437, Tok_81438);
} LA4: ;
if (!(0 < Condstack_81133->Sup.len)) goto LA6;
Lexmessage_78326(&L_81437, ((NU8) 21), ((NimStringDesc*) &TMP197711));
LA6: ;
Closelexer_78316(&L_81437);
if (!(1 <= Gverbosity_47090)) goto LA9;
Rawmessage_49094(((NU8) 234), Filename_81436);
LA9: ;
LA2: ;
}
N_NIMCALL(NimStringDesc*, Getconfigpath_81495)(NimStringDesc* Filename_81497) {
NimStringDesc* Result_81498;
NimStringDesc* LOC1;
NIM_BOOL LOC3;
TY74026 LOC6;
NIM_BOOL LOC8;
NimStringDesc* LOC11;
Result_81498 = 0;
Result_81498 = NIM_NIL;
LOC1 = 0;
LOC1 = nosgetConfigDir();
Result_81498 = nosJoinPath(LOC1, Filename_81497);
LOC3 = nosexistsFile(Result_81498);
if (!!(LOC3)) goto LA4;
memset((void*)&LOC6, 0, sizeof(LOC6));
LOC6[0] = Getprefixdir_47114();
LOC6[1] = copyString(((NimStringDesc*) &TMP197719));
LOC6[2] = copyString(Filename_81497);
Result_81498 = nosJoinPathOpenArray(LOC6, 3);
LOC8 = nosexistsFile(Result_81498);
if (!!(LOC8)) goto LA9;
LOC11 = 0;
LOC11 = rawNewString(Filename_81497->Sup.len + 5);
appendString(LOC11, ((NimStringDesc*) &TMP197720));
appendString(LOC11, Filename_81497);
Result_81498 = LOC11;
LA9: ;
LA4: ;
return Result_81498;
}
N_NIMCALL(void, Loadspecialconfig_81007)(NimStringDesc* Configfilename_81009) {
NimStringDesc* LOC4;
if (!!(((Gglobaloptions_47084 &(1<<((((NU8) 16))&31)))!=0))) goto LA2;
LOC4 = 0;
LOC4 = Getconfigpath_81495(Configfilename_81009);
Readconfigfile_81434(LOC4);
LA2: ;
}
N_NIMCALL(void, Loadconfig_81004)(NimStringDesc* Project_81006) {
NimStringDesc* Conffile_81520;
NimStringDesc* Prefix_81521;
NIM_BOOL LOC10;
NIM_BOOL LOC15;
Conffile_81520 = 0;
Prefix_81521 = 0;
Conffile_81520 = NIM_NIL;
Prefix_81521 = NIM_NIL;
if (!((Libpath_47117) && (Libpath_47117)->Sup.len == 0)) goto LA2;
Prefix_81521 = Getprefixdir_47114();
if (!eqStrings(Prefix_81521, ((NimStringDesc*) &TMP197675))) goto LA5;
asgnRefNoCycle((void**) &Libpath_47117, copyString(((NimStringDesc*) &TMP197676)));
goto LA4;
LA5: ;
if (!eqStrings(Prefix_81521, ((NimStringDesc*) &TMP197677))) goto LA7;
asgnRefNoCycle((void**) &Libpath_47117, copyString(((NimStringDesc*) &TMP197678)));
goto LA4;
LA7: ;
asgnRefNoCycle((void**) &Libpath_47117, nosJoinPath(Prefix_81521, ((NimStringDesc*) &TMP197679)));
LA4: ;
LA2: ;
Loadspecialconfig_81007(((NimStringDesc*) &TMP197721));
LOC10 = !(((Gglobaloptions_47084 &(1<<((((NU8) 17))&31)))!=0));
if (!(LOC10)) goto LA11;
LOC10 = !(((Project_81006) && (Project_81006)->Sup.len == 0));
LA11: ;
if (!LOC10) goto LA12;
Conffile_81520 = nosChangeFileExt(Project_81006, ((NimStringDesc*) &TMP197722));
LOC15 = nosexistsFile(Conffile_81520);
if (!LOC15) goto LA16;
Readconfigfile_81434(Conffile_81520);
LA16: ;
LA12: ;
}
N_NOINLINE(void, nimconfInit)(void) {
asgnRefNoCycle((void**) &Condstack_81133, (TY81132*) newSeq(NTI81132, 0));
}

