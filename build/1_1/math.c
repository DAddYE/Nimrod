/* Generated by Nimrod Compiler v0.8.11 */
/*   (c) 2011 Andreas Rumpf */

typedef long int NI;
typedef unsigned long int NU;
#include "nimbase.h"

N_NIMCALL(NIM_BOOL, Ispoweroftwo_98271)(NI X_98273) {
NIM_BOOL Result_98274;
Result_98274 = 0;
Result_98274 = ((NI32)(X_98273 & ((NI32)-(X_98273))) == X_98273);
goto BeforeRet;
BeforeRet: ;
return Result_98274;
}
N_NIMCALL(NI, Nextpoweroftwo_98277)(NI X_98279) {
NI Result_98280;
Result_98280 = 0;
Result_98280 = (NI32)(X_98279 - 1);
Result_98280 = (NI32)(Result_98280 | (NI32)((NU32)(Result_98280) >> (NU32)(16)));
Result_98280 = (NI32)(Result_98280 | (NI32)((NU32)(Result_98280) >> (NU32)(8)));
Result_98280 = (NI32)(Result_98280 | (NI32)((NU32)(Result_98280) >> (NU32)(4)));
Result_98280 = (NI32)(Result_98280 | (NI32)((NU32)(Result_98280) >> (NU32)(2)));
Result_98280 = (NI32)(Result_98280 | (NI32)((NU32)(Result_98280) >> (NU32)(1)));
Result_98280 += 1;
return Result_98280;
}
N_NOINLINE(void, mathInit)(void) {
}

