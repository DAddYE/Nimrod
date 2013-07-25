/* Generated by Nimrod Compiler v0.9.3 */
/*   (c) 2012 Andreas Rumpf */
/* The generated code is subject to the original license. */
/* Compiled for: MacOSX, amd64, gcc */
/* Command for C compiler:
   gcc -c  -w -O3 -fno-strict-aliasing  -I/usr/src/extras/Nimrod/lib -o compiler/nimcache/parseopt.o compiler/nimcache/parseopt.c */
#define NIM_INTBITS 64
#include "nimbase.h"

#include <string.h>
typedef struct NimStringDesc NimStringDesc;
typedef struct TGenericSeq TGenericSeq;
typedef struct toptparser422606 toptparser422606;
typedef struct TNimObject TNimObject;
typedef struct TNimType TNimType;
typedef struct TNimNode TNimNode;
struct TGenericSeq {
NI len;
NI reserved;
};
typedef NIM_CHAR TY611[100000001];
struct NimStringDesc {
  TGenericSeq Sup;
TY611 data;
};
typedef N_NIMCALL_PTR(void, TY891) (void* p, NI op);
struct TNimType {
NI size;
NU8 kind;
NU8 flags;
TNimType* base;
TNimNode* node;
void* finalizer;
TY891 marker;
};
struct TNimObject {
TNimType* m_type;
};
struct toptparser422606 {
  TNimObject Sup;
NimStringDesc* Cmd;
NI Pos;
NIM_BOOL Inshortstate;
NU8 Kind;
NimStringDesc* Key;
NimStringDesc* Val;
};
struct TNimNode {
NU8 kind;
NI offset;
TNimType* typ;
NCSTRING name;
NI len;
TNimNode** sons;
};
typedef NU8 TY78658[32];
N_NIMCALL(void, unsureAsgnRef)(void** dest, void* src);
N_NIMCALL(NimStringDesc*, copyString)(NimStringDesc* src);
N_NIMCALL(NI, paramcount_98433)(void);
static N_INLINE(void, appendString)(NimStringDesc* dest, NimStringDesc* src);
N_NIMCALL(NimStringDesc*, quoteifcontainswhite_78720)(NimStringDesc* s);
N_NIMCALL(NimStringDesc*, paramstr_98405)(NI i);
static N_INLINE(void, appendChar)(NimStringDesc* dest, NIM_CHAR c);
N_NIMCALL(NimStringDesc*, rawNewString)(NI space);
N_NIMCALL(NimStringDesc*, setLengthStr)(NimStringDesc* s, NI newlen);
N_NIMCALL(void, handleshortoption_422882)(toptparser422606* p);
N_NIMCALL(NimStringDesc*, addChar)(NimStringDesc* s, NIM_CHAR c);
N_NIMCALL(NI, parseword_422802)(NimStringDesc* s, NI i, NimStringDesc** w, TY78658 delim);
N_NIMCALL(NimStringDesc*, nsuStrip)(NimStringDesc* s, NIM_BOOL leading, NIM_BOOL trailing);
N_NIMCALL(NimStringDesc*, copyStrLast)(NimStringDesc* s, NI start_63424, NI last);
N_NIMCALL(NimStringDesc*, copyStrLast)(NimStringDesc* s, NI first, NI last);
STRING_LITERAL(TMP968, "", 0);
STRING_LITERAL(TMP972, "", 0);
static NIM_CONST TY78658 TMP977 = {
0x01, 0x02, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}
;
static NIM_CONST TY78658 TMP978 = {
0x01, 0x02, 0x00, 0x00, 0x01, 0x00, 0x00, 0x24,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}
;
extern TNimType NTI1009; /* TObject */
TNimType NTI422606; /* TOptParser */
extern TNimType NTI143; /* string */
extern TNimType NTI105; /* int */
extern TNimType NTI132; /* bool */
TNimType NTI422604; /* TCmdLineKind */

static N_INLINE(void, appendString)(NimStringDesc* dest, NimStringDesc* src) {
	memcpy(((NCSTRING) (&(*dest).data[((*dest).Sup.len)- 0])), ((NCSTRING) ((*src).data)), (NI64)((*src).Sup.len + 1));
	(*dest).Sup.len += (*src).Sup.len;
}

static N_INLINE(void, appendChar)(NimStringDesc* dest, NIM_CHAR c) {
	(*dest).data[((*dest).Sup.len)- 0] = c;
	(*dest).data[((NI64)((*dest).Sup.len + 1))- 0] = 0;
	(*dest).Sup.len += 1;
}

N_NIMCALL(void, initoptparser_422618)(NimStringDesc* cmdline, toptparser422606* Result) {
	(*Result).Pos = 0;
	(*Result).Inshortstate = NIM_FALSE;
	{
		if (!!(((cmdline) && (cmdline)->Sup.len == 0))) goto LA3;
		unsureAsgnRef((void**) &(*Result).Cmd, copyString(cmdline));
	}
	goto LA1;
	LA3: ;
	{
		NI i_422630;
		NI HEX3Atmp_422632;
		NI res_422634;
		unsureAsgnRef((void**) &(*Result).Cmd, copyString(((NimStringDesc*) &TMP968)));
		i_422630 = 0;
		HEX3Atmp_422632 = 0;
		HEX3Atmp_422632 = paramcount_98433();
		res_422634 = 1;
		while (1) {
			NimStringDesc* LOC7;
			NimStringDesc* LOC8;
			NimStringDesc* LOC9;
			if (!(res_422634 <= HEX3Atmp_422632)) goto LA6;
			i_422630 = res_422634;
			LOC7 = 0;
			LOC8 = 0;
			LOC8 = paramstr_98405(i_422630);
			LOC9 = 0;
			LOC9 = quoteifcontainswhite_78720(LOC8);
			LOC7 = rawNewString((*Result).Cmd->Sup.len + LOC9->Sup.len + 1);
appendString(LOC7, (*Result).Cmd);
appendString(LOC7, LOC9);
appendChar(LOC7, 32);
			unsureAsgnRef((void**) &(*Result).Cmd, LOC7);
			res_422634 += 1;
		} LA6: ;
	}
	LA1: ;
	(*Result).Kind = ((NU8) 0);
	unsureAsgnRef((void**) &(*Result).Key, copyString(((NimStringDesc*) &TMP972)));
	unsureAsgnRef((void**) &(*Result).Val, copyString(((NimStringDesc*) &TMP972)));
}

N_NIMCALL(NI, parseword_422802)(NimStringDesc* s, NI i, NimStringDesc** w, TY78658 delim) {
	NI result;
	result = 0;
	result = i;
	{
		if (!((NU8)(s->data[result]) == (NU8)(34))) goto LA3;
		result += 1;
		while (1) {
			if (!!((((NU8)(s->data[result])) == ((NU8)(0)) || ((NU8)(s->data[result])) == ((NU8)(34))))) goto LA5;
			(*w) = addChar((*w), s->data[result]);
			result += 1;
		} LA5: ;
		{
			if (!((NU8)(s->data[result]) == (NU8)(34))) goto LA8;
			result += 1;
		}
		LA8: ;
	}
	goto LA1;
	LA3: ;
	{
		while (1) {
			if (!!(((delim[((NU8)(s->data[result]))/8] &(1<<(((NU8)(s->data[result]))%8)))!=0))) goto LA11;
			(*w) = addChar((*w), s->data[result]);
			result += 1;
		} LA11: ;
	}
	LA1: ;
	return result;
}

N_NIMCALL(void, handleshortoption_422882)(toptparser422606* p) {
	NI i;
	i = (*p).Pos;
	(*p).Kind = ((NU8) 3);
	(*p).Key = addChar((*p).Key, (*p).Cmd->data[i]);
	i += 1;
	(*p).Inshortstate = NIM_TRUE;
	while (1) {
		if (!(((NU8)((*p).Cmd->data[i])) == ((NU8)(9)) || ((NU8)((*p).Cmd->data[i])) == ((NU8)(32)))) goto LA1;
		i += 1;
		(*p).Inshortstate = NIM_FALSE;
	} LA1: ;
	{
		if (!(((NU8)((*p).Cmd->data[i])) == ((NU8)(58)) || ((NU8)((*p).Cmd->data[i])) == ((NU8)(61)))) goto LA4;
		i += 1;
		(*p).Inshortstate = NIM_FALSE;
		while (1) {
			if (!(((NU8)((*p).Cmd->data[i])) == ((NU8)(9)) || ((NU8)((*p).Cmd->data[i])) == ((NU8)(32)))) goto LA6;
			i += 1;
		} LA6: ;
		i = parseword_422802((*p).Cmd, i, &(*p).Val, TMP977);
	}
	LA4: ;
	{
		if (!((NU8)((*p).Cmd->data[i]) == (NU8)(0))) goto LA9;
		(*p).Inshortstate = NIM_FALSE;
	}
	LA9: ;
	(*p).Pos = i;
}

N_NIMCALL(void, nponext)(toptparser422606* p) {
	NI i;
	i = (*p).Pos;
	while (1) {
		if (!(((NU8)((*p).Cmd->data[i])) == ((NU8)(9)) || ((NU8)((*p).Cmd->data[i])) == ((NU8)(32)))) goto LA1;
		i += 1;
	} LA1: ;
	(*p).Pos = i;
	(*p).Key = setLengthStr((*p).Key, 0);
	(*p).Val = setLengthStr((*p).Val, 0);
	{
		if (!(*p).Inshortstate) goto LA4;
		handleshortoption_422882(p);
		goto BeforeRet;
	}
	LA4: ;
	switch (((NU8)((*p).Cmd->data[i]))) {
	case 0:
	{
		(*p).Kind = ((NU8) 0);
	}
	break;
	case 45:
	{
		i += 1;
		{
			if (!((NU8)((*p).Cmd->data[i]) == (NU8)(45))) goto LA10;
			(*p).Kind = ((NU8) 2);
			i += 1;
			i = parseword_422802((*p).Cmd, i, &(*p).Key, TMP978);
			while (1) {
				if (!(((NU8)((*p).Cmd->data[i])) == ((NU8)(9)) || ((NU8)((*p).Cmd->data[i])) == ((NU8)(32)))) goto LA12;
				i += 1;
			} LA12: ;
			{
				if (!(((NU8)((*p).Cmd->data[i])) == ((NU8)(58)) || ((NU8)((*p).Cmd->data[i])) == ((NU8)(61)))) goto LA15;
				i += 1;
				while (1) {
					if (!(((NU8)((*p).Cmd->data[i])) == ((NU8)(9)) || ((NU8)((*p).Cmd->data[i])) == ((NU8)(32)))) goto LA17;
					i += 1;
				} LA17: ;
				(*p).Pos = parseword_422802((*p).Cmd, i, &(*p).Val, TMP977);
			}
			goto LA13;
			LA15: ;
			{
				(*p).Pos = i;
			}
			LA13: ;
		}
		goto LA8;
		LA10: ;
		{
			(*p).Pos = i;
			handleshortoption_422882(p);
		}
		LA8: ;
	}
	break;
	default:
	{
		(*p).Kind = ((NU8) 1);
		(*p).Pos = parseword_422802((*p).Cmd, i, &(*p).Key, TMP977);
	}
	break;
	}
	BeforeRet: ;
}

N_NIMCALL(NimStringDesc*, npocmdLineRest)(toptparser422606* p) {
	NimStringDesc* result;
	NimStringDesc* LOC1;
	result = 0;
	LOC1 = 0;
	LOC1 = copyStrLast((*p).Cmd, (*p).Pos, (NI64)((*p).Cmd->Sup.len - 1));
	result = nsuStrip(LOC1, NIM_TRUE, NIM_TRUE);
	return result;
}
N_NOINLINE(void, parseoptInit)(void) {
}

N_NOINLINE(void, parseoptDatInit)(void) {
static TNimNode* TMP973[6];
static TNimNode* TMP974[4];
NI TMP976;
static char* NIM_CONST TMP975[4] = {
"cmdEnd", 
"cmdArgument", 
"cmdLongoption", 
"cmdShortOption"};
static TNimNode TMP930[12];
NTI422606.size = sizeof(toptparser422606);
NTI422606.kind = 17;
NTI422606.base = (&NTI1009);
NTI422606.flags = 2;
TMP973[0] = &TMP930[1];
TMP930[1].kind = 1;
TMP930[1].offset = offsetof(toptparser422606, Cmd);
TMP930[1].typ = (&NTI143);
TMP930[1].name = "cmd";
TMP973[1] = &TMP930[2];
TMP930[2].kind = 1;
TMP930[2].offset = offsetof(toptparser422606, Pos);
TMP930[2].typ = (&NTI105);
TMP930[2].name = "pos";
TMP973[2] = &TMP930[3];
TMP930[3].kind = 1;
TMP930[3].offset = offsetof(toptparser422606, Inshortstate);
TMP930[3].typ = (&NTI132);
TMP930[3].name = "inShortState";
TMP973[3] = &TMP930[4];
NTI422604.size = sizeof(NU8);
NTI422604.kind = 14;
NTI422604.base = 0;
NTI422604.flags = 3;
for (TMP976 = 0; TMP976 < 4; TMP976++) {
TMP930[TMP976+5].kind = 1;
TMP930[TMP976+5].offset = TMP976;
TMP930[TMP976+5].name = TMP975[TMP976];
TMP974[TMP976] = &TMP930[TMP976+5];
}
TMP930[9].len = 4; TMP930[9].kind = 2; TMP930[9].sons = &TMP974[0];
NTI422604.node = &TMP930[9];
TMP930[4].kind = 1;
TMP930[4].offset = offsetof(toptparser422606, Kind);
TMP930[4].typ = (&NTI422604);
TMP930[4].name = "kind";
TMP973[4] = &TMP930[10];
TMP930[10].kind = 1;
TMP930[10].offset = offsetof(toptparser422606, Key);
TMP930[10].typ = (&NTI143);
TMP930[10].name = "key";
TMP973[5] = &TMP930[11];
TMP930[11].kind = 1;
TMP930[11].offset = offsetof(toptparser422606, Val);
TMP930[11].typ = (&NTI143);
TMP930[11].name = "val";
TMP930[0].len = 6; TMP930[0].kind = 2; TMP930[0].sons = &TMP973[0];
NTI422606.node = &TMP930[0];
}

