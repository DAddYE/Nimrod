/* Generated by Nimrod Compiler v0.8.11 */
/*   (c) 2011 Andreas Rumpf */

typedef long long int NI;
typedef unsigned long long int NU;
#include "nimbase.h"

typedef struct NimStringDesc NimStringDesc;
typedef struct TGenericSeq TGenericSeq;
typedef NI TY51040[256];
struct TGenericSeq {
NI len;
NI space;
};
typedef NIM_CHAR TY245[100000001];
struct NimStringDesc {
  TGenericSeq Sup;
TY245 data;
};
static N_INLINE(int, Updatecrc32_51018)(NIM_CHAR Val_51020, int Crc_51021);
static N_INLINE(int, Updatecrc32_51014)(NI8 Val_51016, int Crc_51017);
N_NIMCALL(NIM_BOOL, Open_3817)(FILE** F_3820, NimStringDesc* Filename_3821, NU8 Mode_3822, NI Bufsize_3823);
N_NOCONV(void*, Alloc_2350)(NI Size_2352);
N_NIMCALL(NI, Readbuffer_3922)(FILE* F_3924, void* Buffer_3925, NI Len_3926);
N_NOCONV(void, Dealloc_2360)(void* P_2362);
NIM_CONST TY51040 Crc32table_51039 = {0,
1996959894,
-301047508,
-1727442502,
124634137,
1886057615,
-379345611,
-1637575261,
249268274,
2044508324,
-522852066,
-1747789432,
162941995,
2125561021,
-407360249,
-1866523247,
498536548,
1789927666,
-205950648,
-2067906082,
450548861,
1843258603,
-187386543,
-2083289657,
325883990,
1684777152,
-43845254,
-1973040660,
335633487,
1661365465,
-99664541,
-1928851979,
997073096,
1281953886,
-715111964,
-1570279054,
1006888145,
1258607687,
-770865667,
-1526024853,
901097722,
1119000684,
-608450090,
-1396901568,
853044451,
1172266101,
-589951537,
-1412350631,
651767980,
1373503546,
-925412992,
-1076862698,
565507253,
1454621731,
-809855591,
-1195530993,
671266974,
1594198024,
-972236366,
-1324619484,
795835527,
1483230225,
-1050600021,
-1234817731,
1994146192,
31158534,
-1731059524,
-271249366,
1907459465,
112637215,
-1614814043,
-390540237,
2013776290,
251722036,
-1777751922,
-519137256,
2137656763,
141376813,
-1855689577,
-429695999,
1802195444,
476864866,
-2056965928,
-228458418,
1812370925,
453092731,
-2113342271,
-183516073,
1706088902,
314042704,
-1950435094,
-54949764,
1658658271,
366619977,
-1932296973,
-69972891,
1303535960,
984961486,
-1547960204,
-725929758,
1256170817,
1037604311,
-1529756563,
-740887301,
1131014506,
879679996,
-1385723834,
-631195440,
1141124467,
855842277,
-1442165665,
-586318647,
1342533948,
654459306,
-1106571248,
-921952122,
1466479909,
544179635,
-1184443383,
-832445281,
1591671054,
702138776,
-1328506846,
-942167884,
1504918807,
783551873,
-1212326853,
-1061524307,
-306674912,
-1698712650,
62317068,
1957810842,
-355121351,
-1647151185,
81470997,
1943803523,
-480048366,
-1805370492,
225274430,
2053790376,
-468791541,
-1828061283,
167816743,
2097651377,
-267414716,
-2029476910,
503444072,
1762050814,
-144550051,
-2140837941,
426522225,
1852507879,
-19653770,
-1982649376,
282753626,
1742555852,
-105259153,
-1900089351,
397917763,
1622183637,
-690576408,
-1580100738,
953729732,
1340076626,
-776247311,
-1497606297,
1068828381,
1219638859,
-670225446,
-1358292148,
906185462,
1090812512,
-547295293,
-1469587627,
829329135,
1181335161,
-882789492,
-1134132454,
628085408,
1382605366,
-871598187,
-1156888829,
570562233,
1426400815,
-977650754,
-1296233688,
733239954,
1555261956,
-1026031705,
-1244606671,
752459403,
1541320221,
-1687895376,
-328994266,
1969922972,
40735498,
-1677130071,
-351390145,
1913087877,
83908371,
-1782625662,
-491226604,
2075208622,
213261112,
-1831694693,
-438977011,
2094854071,
198958881,
-2032938284,
-237706686,
1759359992,
534414190,
-2118248755,
-155638181,
1873836001,
414664567,
-2012718362,
-15766928,
1711684554,
285281116,
-1889165569,
-127750551,
1634467795,
376229701,
-1609899400,
-686959890,
1308918612,
956543938,
-1486412191,
-799009033,
1231636301,
1047427035,
-1362007478,
-640263460,
1088359270,
936918000,
-1447252397,
-558129467,
1202900863,
817233897,
-1111625188,
-893730166,
1404277552,
615818150,
-1160759803,
-841546093,
1423857449,
601450431,
-1285129682,
-1000256840,
1567103746,
711928724,
-1274298825,
-1022587231,
1510334235,
755167117}
;
static N_INLINE(int, Updatecrc32_51014)(NI8 Val_51016, int Crc_51017) {
int Result_51048;
Result_51048 = 0;
Result_51048 = (NI32)(((int) (Crc32table_51039[((NI64)((NI64)(((NI) (Crc_51017)) ^ (NI64)(((NI) (Val_51016)) & 255)) & 255))-0])) ^ (NI32)((NU32)(Crc_51017) >> (NU32)(((NI32) 8))));
return Result_51048;
}
static N_INLINE(int, Updatecrc32_51018)(NIM_CHAR Val_51020, int Crc_51021) {
int Result_51053;
Result_51053 = 0;
Result_51053 = Updatecrc32_51014(((NI8) (((NU8)(Val_51020)))), Crc_51021);
return Result_51053;
}
N_NIMCALL(int, HEX3EHEX3C_51092)(int C_51094, NimStringDesc* S_51095) {
int Result_51096;
NI I_51107;
NI HEX3Atmp_51108;
NI Res_51110;
Result_51096 = 0;
Result_51096 = C_51094;
I_51107 = 0;
HEX3Atmp_51108 = 0;
HEX3Atmp_51108 = (NI64)(S_51095->Sup.len - 1);
Res_51110 = 0;
Res_51110 = 0;
while (1) {
if (!(Res_51110 <= HEX3Atmp_51108)) goto LA1;
I_51107 = Res_51110;
Result_51096 = Updatecrc32_51018(S_51095->data[I_51107], Result_51096);
Res_51110 += 1;
} LA1: ;
return Result_51096;
}
N_NIMCALL(int, Crcfromfile_51029)(NimStringDesc* Filename_51031) {
int Result_51137;
FILE* Bin_51139;
void* Buf_51140;
NI Readbytes_51141;
NI8* P_51142;
NIM_BOOL LOC2;
NI I_51152;
NI HEX3Atmp_51155;
NI Res_51157;
P_51142 = 0;
Result_51137 = 0;
Bin_51139 = 0;
Buf_51140 = 0;
Readbytes_51141 = 0;
P_51142 = NIM_NIL;
Result_51137 = ((NI32) -1);
LOC2 = Open_3817(&Bin_51139, Filename_51031, ((NU8) 0), -1);
if (!!(LOC2)) goto LA3;
goto BeforeRet;
LA3: ;
Buf_51140 = Alloc_2350(8192);
P_51142 = ((NI8*) (Buf_51140));
while (1) {
Readbytes_51141 = Readbuffer_3922(Bin_51139, Buf_51140, 8192);
I_51152 = 0;
HEX3Atmp_51155 = 0;
HEX3Atmp_51155 = (NI64)(Readbytes_51141 - 1);
Res_51157 = 0;
Res_51157 = 0;
while (1) {
if (!(Res_51157 <= HEX3Atmp_51155)) goto LA6;
I_51152 = Res_51157;
Result_51137 = Updatecrc32_51014(P_51142[(I_51152)-0], Result_51137);
Res_51157 += 1;
} LA6: ;
if (!!((Readbytes_51141 == 8192))) goto LA8;
goto LA5;
LA8: ;
} LA5: ;
Dealloc_2360(Buf_51140);
fclose(Bin_51139);
BeforeRet: ;
return Result_51137;
}
N_NOINLINE(void, crcInit)(void) {
}

