/* Generated by Nimrod Compiler v0.9.3 */
/*   (c) 2012 Andreas Rumpf */
/* The generated code is subject to the original license. */
/* Compiled for: MacOSX, amd64, gcc */
/* Command for C compiler:
   gcc -c  -w -O3 -fno-strict-aliasing  -I/usr/src/extras/Nimrod/lib -o compiler/nimcache/depends.o compiler/nimcache/depends.c */
#define NIM_INTBITS 64
#include "nimbase.h"
typedef struct trope126007 trope126007;
typedef struct tpasscontext224003 tpasscontext224003;
typedef struct tsym135677 tsym135677;
typedef struct tgen420010 tgen420010;
typedef struct TNimObject TNimObject;
typedef struct TNimType TNimType;
typedef struct TNimNode TNimNode;
typedef struct tcell38449 tcell38449;
typedef struct tcellseq38465 tcellseq38465;
typedef struct tgcheap40416 tgcheap40416;
typedef struct tcellset38461 tcellset38461;
typedef struct tpagedesc38457 tpagedesc38457;
typedef struct tmemregion22010 tmemregion22010;
typedef struct tsmallchunk21243 tsmallchunk21243;
typedef struct tllchunk22004 tllchunk22004;
typedef struct tbigchunk21245 tbigchunk21245;
typedef struct tintset21218 tintset21218;
typedef struct ttrunk21214 ttrunk21214;
typedef struct tavlnode22008 tavlnode22008;
typedef struct tgcstat40414 tgcstat40414;
typedef struct tnode135647 tnode135647;
typedef struct ttype135681 ttype135681;
typedef struct tlineinfo128308 tlineinfo128308;
typedef struct NimStringDesc NimStringDesc;
typedef struct TGenericSeq TGenericSeq;
typedef struct tident131018 tident131018;
typedef struct tnodeseq135641 tnodeseq135641;
typedef struct tidobj131012 tidobj131012;
typedef struct ttypeseq135679 ttypeseq135679;
typedef struct TY135771 TY135771;
typedef struct tinstantiation135667 tinstantiation135667;
typedef struct tscope135671 tscope135671;
typedef struct tstrtable135651 tstrtable135651;
typedef struct tsymseq135649 tsymseq135649;
typedef struct tloc135661 tloc135661;
typedef struct tlib135665 tlib135665;
typedef struct tbasechunk21241 tbasechunk21241;
typedef struct tfreecell21233 tfreecell21233;
typedef struct TY135763 TY135763;
typedef struct tlistentry100011 tlistentry100011;
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
struct tpasscontext224003 {
  TNimObject Sup;
NIM_BOOL Fromcache;
};
struct tgen420010 {
  tpasscontext224003 Sup;
tsym135677* Module;
};
struct TNimNode {
NU8 kind;
NI offset;
TNimType* typ;
NCSTRING name;
NI len;
TNimNode** sons;
};
struct tcell38449 {
NI Refcount;
TNimType* Typ;
};
struct tcellseq38465 {
NI Len;
NI Cap;
tcell38449** D;
};
struct tcellset38461 {
NI Counter;
NI Max;
tpagedesc38457* Head;
tpagedesc38457** Data;
};
typedef tsmallchunk21243* TY22022[512];
typedef ttrunk21214* ttrunkbuckets21216[256];
struct tintset21218 {
ttrunkbuckets21216 Data;
};
struct tmemregion22010 {
NI Minlargeobj;
NI Maxlargeobj;
TY22022 Freesmallchunks;
tllchunk22004* Llmem;
NI Currmem;
NI Maxmem;
NI Freemem;
NI Lastsize;
tbigchunk21245* Freechunkslist;
tintset21218 Chunkstarts;
tavlnode22008* Root;
tavlnode22008* Deleted;
tavlnode22008* Last;
tavlnode22008* Freeavlnodes;
};
struct tgcstat40414 {
NI Stackscans;
NI Cyclecollections;
NI Maxthreshold;
NI Maxstacksize;
NI Maxstackcells;
NI Cycletablesize;
NI64 Maxpause;
};
struct tgcheap40416 {
void* Stackbottom;
NI Cyclethreshold;
tcellseq38465 Zct;
tcellseq38465 Decstack;
tcellset38461 Cycleroots;
tcellseq38465 Tempstack;
NI Recgclock;
tmemregion22010 Region;
tgcstat40414 Stat;
};
struct tlineinfo128308 {
NI16 Line;
NI16 Col;
NI32 Fileindex;
};
struct TGenericSeq {
NI len;
NI reserved;
};
typedef NIM_CHAR TY611[100000001];
struct NimStringDesc {
  TGenericSeq Sup;
TY611 data;
};
struct tnode135647 {
ttype135681* Typ;
tlineinfo128308 Info;
NU8 Flags;
NU8 Kind;
union {
struct {NI64 Intval;
} S1;
struct {NF64 Floatval;
} S2;
struct {NimStringDesc* Strval;
} S3;
struct {tsym135677* Sym;
} S4;
struct {tident131018* Ident;
} S5;
struct {tnodeseq135641* Sons;
} S6;
} kindU;
NimStringDesc* Comment;
};
typedef trope126007* TY376406[2];
struct tidobj131012 {
  TNimObject Sup;
NI Id;
};
struct tstrtable135651 {
NI Counter;
tsymseq135649* Data;
};
struct tloc135661 {
NU8 K;
NU8 S;
NU8 Flags;
ttype135681* T;
trope126007* R;
trope126007* Heaproot;
NI A;
};
struct tsym135677 {
  tidobj131012 Sup;
NU8 Kind;
union {
struct {ttypeseq135679* Typeinstcache;
} S1;
struct {TY135771* Procinstcache;
tscope135671* Scope;
} S2;
struct {TY135771* Usedgenerics;
tstrtable135651 Tab;
} S3;
} kindU;
NU16 Magic;
ttype135681* Typ;
tident131018* Name;
tlineinfo128308 Info;
tsym135677* Owner;
NU32 Flags;
tnode135647* Ast;
NU32 Options;
NI Position;
NI Offset;
tloc135661 Loc;
tlib135665* Annex;
tnode135647* Constraint;
};
struct tident131018 {
  tidobj131012 Sup;
NimStringDesc* S;
tident131018* Next;
NI H;
};
struct trope126007 {
  TNimObject Sup;
trope126007* Left;
trope126007* Right;
NI Length;
NimStringDesc* Data;
};
typedef NI TY21221[8];
struct tpagedesc38457 {
tpagedesc38457* Next;
NI Key;
TY21221 Bits;
};
struct tbasechunk21241 {
NI Prevsize;
NI Size;
NIM_BOOL Used;
};
struct tsmallchunk21243 {
  tbasechunk21241 Sup;
tsmallchunk21243* Next;
tsmallchunk21243* Prev;
tfreecell21233* Freelist;
NI Free;
NI Acc;
NF64 Data;
};
struct tllchunk22004 {
NI Size;
NI Acc;
tllchunk22004* Next;
};
struct tbigchunk21245 {
  tbasechunk21241 Sup;
tbigchunk21245* Next;
tbigchunk21245* Prev;
NI Align;
NF64 Data;
};
struct ttrunk21214 {
ttrunk21214* Next;
NI Key;
TY21221 Bits;
};
typedef tavlnode22008* TY22014[2];
struct tavlnode22008 {
TY22014 Link;
NI Key;
NI Upperbound;
NI Level;
};
struct ttype135681 {
  tidobj131012 Sup;
NU8 Kind;
NU8 Callconv;
NU32 Flags;
ttypeseq135679* Sons;
tnode135647* N;
tsym135677* Destructor;
tsym135677* Owner;
tsym135677* Sym;
NI64 Size;
NI Align;
tloc135661 Loc;
};
struct tinstantiation135667 {
tsym135677* Sym;
ttypeseq135679* Concretetypes;
TY135763* Usedby;
};
struct tscope135671 {
NI Depthlevel;
tstrtable135651 Symbols;
tscope135671* Parent;
};
struct tlistentry100011 {
  TNimObject Sup;
tlistentry100011* Prev;
tlistentry100011* Next;
};
struct tlib135665 {
  tlistentry100011 Sup;
NU8 Kind;
NIM_BOOL Generated;
NIM_BOOL Isoverriden;
trope126007* Name;
tnode135647* Path;
};
struct tfreecell21233 {
tfreecell21233* Next;
NI Zerofield;
};
struct tnodeseq135641 {
  TGenericSeq Sup;
  tnode135647* data[SEQ_DECL_SIZE];
};
struct ttypeseq135679 {
  TGenericSeq Sup;
  ttype135681* data[SEQ_DECL_SIZE];
};
struct TY135771 {
  TGenericSeq Sup;
  tinstantiation135667* data[SEQ_DECL_SIZE];
};
struct tsymseq135649 {
  TGenericSeq Sup;
  tsym135677* data[SEQ_DECL_SIZE];
};
struct TY135763 {
  TGenericSeq Sup;
  NI32 data[SEQ_DECL_SIZE];
};
N_NIMCALL(void, nimGCvisit)(void* d, NI op);
N_NIMCALL(void, TMP4112)(void* p, NI op);
N_NIMCALL(void*, newObj)(TNimType* typ, NI size);
static N_INLINE(void, asgnRefNoCycle)(void** dest, void* src);
static N_INLINE(tcell38449*, usrtocell_41843)(void* usr);
static N_INLINE(void, rtladdzct_43002)(tcell38449* c);
N_NOINLINE(void, addzct_41815)(tcellseq38465* s, tcell38449* c);
static N_INLINE(NI, sonslen_136002)(tnode135647* n);
N_NIMCALL(NimStringDesc*, getmodulename_264012)(tnode135647* n);
N_NIMCALL(void, adddependencyaux_420018)(NimStringDesc* importing, NimStringDesc* imported);
N_NIMCALL(void, appf_126085)(trope126007** c, NimStringDesc* frmt, trope126007** args, NI argslen0);
N_NIMCALL(trope126007*, torope_126058)(NimStringDesc* s);
N_NIMCALL(tnode135647*, adddotdependency_420030)(tpasscontext224003* c, tnode135647* n);
N_NIMCALL(void, writerope_127407)(trope126007* head, NimStringDesc* filename, NIM_BOOL usewarning);
N_NIMCALL(trope126007*, ropef_126079)(NimStringDesc* frmt, trope126007** args, NI argslen0);
N_NIMCALL(NimStringDesc*, noschangeFileExt)(NimStringDesc* filename, NimStringDesc* ext);
N_NIMCALL(NimStringDesc*, nosextractFilename)(NimStringDesc* path);
STRING_LITERAL(TMP4113, "$1 -> $2;$n", 11);
STRING_LITERAL(TMP4115, "digraph $1 {$n$2}$n", 19);
STRING_LITERAL(TMP4116, "", 0);
STRING_LITERAL(TMP4117, "dot", 3);
trope126007* gdotgraph_420015;
extern TNimType NTI224003; /* TPassContext */
TNimType NTI420010; /* TGen */
extern TNimType NTI135645; /* PSym */
TNimType NTI420012; /* PGen */
extern tgcheap40416 gch_40442;
N_NIMCALL(void, TMP4112)(void* p, NI op) {
	tgen420010* a;
	a = (tgen420010*)p;
	nimGCvisit((void*)(*a).Module, op);
}

static N_INLINE(tcell38449*, usrtocell_41843)(void* usr) {
	tcell38449* result;
	result = 0;
	result = ((tcell38449*) ((NI)((NU64)(((NI) (usr))) - (NU64)(((NI)sizeof(tcell38449))))));
	return result;
}

static N_INLINE(void, rtladdzct_43002)(tcell38449* c) {
	addzct_41815(&gch_40442.Zct, c);
}

static N_INLINE(void, asgnRefNoCycle)(void** dest, void* src) {
	{
		tcell38449* c;
		if (!!((src == NIM_NIL))) goto LA3;
		c = usrtocell_41843(src);
		(*c).Refcount += 8;
	}
	LA3: ;
	{
		tcell38449* c;
		if (!!(((*dest) == NIM_NIL))) goto LA7;
		c = usrtocell_41843((*dest));
		{
			(*c).Refcount -= 8;
			if (!((NU64)((*c).Refcount) < (NU64)(8))) goto LA11;
			rtladdzct_43002(c);
		}
		LA11: ;
	}
	LA7: ;
	(*dest) = src;
}

N_NIMCALL(tpasscontext224003*, myopen_420108)(tsym135677* module) {
	tpasscontext224003* result;
	tgen420010* g;
	result = 0;
	g = 0;
	g = (tgen420010*) newObj((&NTI420012), sizeof(tgen420010));
	(*g).Sup.Sup.m_type = (&NTI420010);
	asgnRefNoCycle((void**) &(*g).Module, module);
	result = &g->Sup;
	return result;
}

static N_INLINE(NI, sonslen_136002)(tnode135647* n) {
	NI result;
	result = 0;
	{
		if (!(*n).kindU.S6.Sons == 0) goto LA3;
		result = 0;
	}
	goto LA1;
	LA3: ;
	{
		result = (*n).kindU.S6.Sons->Sup.len;
	}
	LA1: ;
	return result;
}

N_NIMCALL(void, adddependencyaux_420018)(NimStringDesc* importing, NimStringDesc* imported) {
	TY376406 LOC1;
	memset((void*)LOC1, 0, sizeof(LOC1));
	LOC1[0] = torope_126058(importing);
	LOC1[1] = torope_126058(imported);
	appf_126085(&gdotgraph_420015, ((NimStringDesc*) &TMP4113), LOC1, 2);
}

N_NIMCALL(tnode135647*, adddotdependency_420030)(tpasscontext224003* c, tnode135647* n) {
	tnode135647* result;
	tgen420010* g;
	result = 0;
	result = n;
	g = ((tgen420010*) (c));
	switch ((*n).Kind) {
	case ((NU8) 115):
	{
		NI i_420044;
		NI HEX3Atmp_420086;
		NI LOC2;
		NI res_420088;
		i_420044 = 0;
		HEX3Atmp_420086 = 0;
		LOC2 = sonslen_136002(n);
		HEX3Atmp_420086 = (NI64)(LOC2 - 1);
		res_420088 = 0;
		while (1) {
			NimStringDesc* imported;
			if (!(res_420088 <= HEX3Atmp_420086)) goto LA3;
			i_420044 = res_420088;
			imported = getmodulename_264012((*n).kindU.S6.Sons->data[i_420044]);
			adddependencyaux_420018((*(*(*g).Module).Name).S, imported);
			res_420088 += 1;
		} LA3: ;
	}
	break;
	case ((NU8) 119):
	case ((NU8) 116):
	{
		NimStringDesc* imported;
		imported = getmodulename_264012((*n).kindU.S6.Sons->data[0]);
		adddependencyaux_420018((*(*(*g).Module).Name).S, imported);
	}
	break;
	case ((NU8) 114):
	case ((NU8) 111):
	case ((NU8) 124):
	case ((NU8) 125):
	{
		NI i_420075;
		NI HEX3Atmp_420090;
		NI LOC6;
		NI res_420092;
		i_420075 = 0;
		HEX3Atmp_420090 = 0;
		LOC6 = sonslen_136002(n);
		HEX3Atmp_420090 = (NI64)(LOC6 - 1);
		res_420092 = 0;
		while (1) {
			tnode135647* LOC8;
			if (!(res_420092 <= HEX3Atmp_420090)) goto LA7;
			i_420075 = res_420092;
			LOC8 = 0;
			LOC8 = adddotdependency_420030(c, (*n).kindU.S6.Sons->data[i_420075]);
			res_420092 += 1;
		} LA7: ;
	}
	break;
	default:
	{
	}
	break;
	}
	return result;
}

N_NIMCALL(void, generatedot_420005)(NimStringDesc* project) {
	TY376406 LOC1;
	NimStringDesc* LOC2;
	NimStringDesc* LOC3;
	trope126007* LOC4;
	NimStringDesc* LOC5;
	memset((void*)LOC1, 0, sizeof(LOC1));
	LOC2 = 0;
	LOC2 = nosextractFilename(project);
	LOC3 = 0;
	LOC3 = noschangeFileExt(LOC2, ((NimStringDesc*) &TMP4116));
	LOC1[0] = torope_126058(LOC3);
	LOC1[1] = gdotgraph_420015;
	LOC4 = 0;
	LOC4 = ropef_126079(((NimStringDesc*) &TMP4115), LOC1, 2);
	LOC5 = 0;
	LOC5 = noschangeFileExt(project, ((NimStringDesc*) &TMP4117));
	writerope_127407(LOC4, LOC5, NIM_FALSE);
}
N_NOINLINE(void, dependsInit)(void) {
}

N_NOINLINE(void, dependsDatInit)(void) {
static TNimNode TMP924[1];
NTI420010.size = sizeof(tgen420010);
NTI420010.kind = 17;
NTI420010.base = (&NTI224003);
NTI420010.flags = 2;
TMP924[0].kind = 1;
TMP924[0].offset = offsetof(tgen420010, Module);
TMP924[0].typ = (&NTI135645);
TMP924[0].name = "module";
NTI420010.node = &TMP924[0];
NTI420012.size = sizeof(tgen420010*);
NTI420012.kind = 22;
NTI420012.base = (&NTI420010);
NTI420012.flags = 2;
NTI420012.marker = TMP4112;
}

