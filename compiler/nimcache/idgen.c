/* Generated by Nimrod Compiler v0.9.3 */
/*   (c) 2012 Andreas Rumpf */
/* The generated code is subject to the original license. */
/* Compiled for: MacOSX, amd64, gcc */
/* Command for C compiler:
   gcc -c  -w -O3 -fno-strict-aliasing  -I/usr/src/extras/Nimrod/lib -o compiler/nimcache/idgen.o compiler/nimcache/idgen.c */
#define NIM_INTBITS 64
#include "nimbase.h"

#include <stdio.h>
typedef struct NimStringDesc NimStringDesc;
typedef struct TGenericSeq TGenericSeq;
typedef struct tidobj131012 tidobj131012;
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
typedef NimStringDesc* TY129263[1];
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
struct tidobj131012 {
  TNimObject Sup;
NI Id;
};
struct TNimNode {
NU8 kind;
NI offset;
TNimType* typ;
NCSTRING name;
NI len;
TNimNode** sons;
};
N_NIMCALL(NIM_BOOL, open_8817)(FILE** f, NimStringDesc* filename, NU8 mode, NI bufsize);
N_NIMCALL(NimStringDesc*, togid_134450)(NimStringDesc* f);
N_NIMCALL(NimStringDesc*, completegeneratedfilepath_105438)(NimStringDesc* f, NIM_BOOL createsubdir);
N_NIMCALL(NimStringDesc*, rawNewString)(NI space);
N_NIMCALL(NimStringDesc*, rawNewString)(NI cap);
N_NIMCALL(NIM_BOOL, readline_9086)(FILE* f, NimStringDesc** line);
N_NIMCALL(NI, nsuParseInt)(NimStringDesc* s);
N_NIMCALL(FILE*, open_8832)(NimStringDesc* filename, NU8 mode, NI bufsize);
N_NIMCALL(NimStringDesc*, nimIntToStr)(NI x);
static N_INLINE(void, writeln_105451)(FILE* f, NimStringDesc** x, NI xlen0);
N_NIMCALL(void, write_9062)(FILE* f, NimStringDesc* s);
STRING_LITERAL(TMP1642, "nimrod.gid", 10);
STRING_LITERAL(TMP4207, "\012", 1);
NI gfrontendid_134005;
NI gbackendid_134006;

N_NIMCALL(NimStringDesc*, togid_134450)(NimStringDesc* f) {
	NimStringDesc* result;
	result = 0;
	result = completegeneratedfilepath_105438(((NimStringDesc*) &TMP1642), NIM_TRUE);
	return result;
}

N_NIMCALL(void, loadmaxids_134488)(NimStringDesc* project) {
	FILE* f;
	f = 0;
	{
		NimStringDesc* LOC3;
		NIM_BOOL LOC4;
		NimStringDesc* line;
		LOC3 = 0;
		LOC3 = togid_134450(project);
		LOC4 = open_8817(&f, LOC3, ((NU8) 0), -1);
		if (!LOC4) goto LA5;
		line = rawNewString(20);
		{
			NIM_BOOL LOC9;
			NI frontendid;
			LOC9 = readline_9086(f, &line);
			if (!LOC9) goto LA10;
			frontendid = nsuParseInt(line);
			{
				NIM_BOOL LOC14;
				NI backendid;
				LOC14 = readline_9086(f, &line);
				if (!LOC14) goto LA15;
				backendid = nsuParseInt(line);
				gfrontendid_134005 = ((gfrontendid_134005 >= frontendid) ? gfrontendid_134005 : frontendid);
				gbackendid_134006 = ((gbackendid_134006 >= backendid) ? gbackendid_134006 : backendid);
			}
			LA15: ;
		}
		LA10: ;
		fclose(f);
	}
	LA5: ;
}

N_NIMCALL(void, registerid_134201)(tidobj131012* id) {
}

N_NIMCALL(void, idsynchronizationpoint_134445)(NI idrange) {
	gfrontendid_134005 = (NI64)((NI64)((NI64)((NI64)(gfrontendid_134005 / idrange) + 1) * idrange) + 1);
}

N_NIMCALL(void, savemaxids_134456)(NimStringDesc* project) {
	FILE* f;
	NimStringDesc* LOC1;
	TY129263 LOC2;
	TY129263 LOC3;
	LOC1 = 0;
	LOC1 = togid_134450(project);
	f = open_8832(LOC1, ((NU8) 1), -1);
	memset((void*)LOC2, 0, sizeof(LOC2));
	LOC2[0] = nimIntToStr(gfrontendid_134005);
	writeln_105451(f, LOC2, 1);
	memset((void*)LOC3, 0, sizeof(LOC3));
	LOC3[0] = nimIntToStr(gbackendid_134006);
	writeln_105451(f, LOC3, 1);
	fclose(f);
}

static N_INLINE(void, writeln_105451)(FILE* f, NimStringDesc** x, NI xlen0) {
	NimStringDesc* i_105465;
	NI i_105471;
	i_105465 = 0;
	i_105471 = 0;
	while (1) {
		if (!(i_105471 < xlen0)) goto LA1;
		i_105465 = x[i_105471];
		write_9062(f, i_105465);
		i_105471 += 1;
	} LA1: ;
	write_9062(f, ((NimStringDesc*) &TMP4207));
}
N_NOINLINE(void, idgenInit)(void) {
}

N_NOINLINE(void, idgenDatInit)(void) {
}

