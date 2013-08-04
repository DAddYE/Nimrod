#==============================================================================#
# Project: Ararat Synapse                                        | 003.004.001 #
#==============================================================================#
# Content: SSL support by OpenSSL                                              #
#==============================================================================#
# Copyright (c)1999-2005, Lukas Gebauer                                        #
# All rights reserved.                                                         #
#                                                                              #
# Redistribution and use in source and binary forms, with or without           #
# modification, are permitted provided that the following conditions are met:  #
#                                                                              #
# Redistributions of source code must retain the above copyright notice, this  #
# list of conditions and the following disclaimer.                             #
#                                                                              #
# Redistributions in binary form must reproduce the above copyright notice,    #
# this list of conditions and the following disclaimer in the documentation    #
# and/or other materials provided with the distribution.                       #
#                                                                              #
# Neither the name of Lukas Gebauer nor the names of its contributors may      #
# be used to endorse or promote products derived from this software without    #
# specific prior written permission.                                           #
#                                                                              #
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"  #
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE    #
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE   #
# ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR  #
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL       #
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR   #
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER   #
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT           #
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY    #
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH  #
# DAMAGE.                                                                      #
#==============================================================================#
# The Initial Developer of the Original Code is Lukas Gebauer (Czech Republic).#
# Portions created by Lukas Gebauer are Copyright (c)2002-2005.                #
# All Rights Reserved.                                                         #
#==============================================================================#

## OpenSSL support

{.deadCodeElim: on.}

when defined(WINDOWS): 
  const 
    DLLSSLName = "(ssleay32|libssl32).dll"
    DLLUtilName = "libeay32.dll"
else:
  const
    versions = "(|.1.0.0|.0.9.9|.0.9.8|.0.9.7|.0.9.6|.0.9.5|.0.9.4)"
  when defined(macosx):
    const
      DLLSSLName = "libssl" & versions & ".dylib"
      DLLUtilName = "libcrypto" & versions & ".dylib"
  else:
    const 
      DLLSSLName = "libssl.so" & versions
      DLLUtilName = "libcrypto.so" & versions

type 
  SslStruct {.final, pure.} = object
  SslPtr* = ptr SslStruct
  PSslPtr* = ptr SslPtr
  PsslCtx* = SslPtr
  Pssl* = SslPtr
  PsslMethod* = SslPtr
  Px509* = SslPtr
  Px509Name* = SslPtr
  PevpMd* = SslPtr
  PbioMethod* = SslPtr
  Pbio* = SslPtr
  EvpPkey* = SslPtr
  Prsa* = SslPtr
  Pasn1Utctime* = SslPtr
  PASN1CInt* = SslPtr
  PPasswdCb* = SslPtr
  PFunction* = proc () {.cdecl.}
  DESCblock* = Array[0..7, Int8]
  PDESCblock* = ptr DESCblock
  DesKsStruct*{.final.} = object 
    ks*: DESCblock
    weak_key*: Cint

  DesKeySchedule* = Array[1..16, DesKsStruct]

const 
  EvpMaxMdSize* = 16 + 20
  SslErrorNone* = 0
  SslErrorSsl* = 1
  SslErrorWantRead* = 2
  SslErrorWantWrite* = 3
  SslErrorWantX509Lookup* = 4
  SslErrorSyscall* = 5      #look at error stack/return value/errno
  SslErrorZeroReturn* = 6
  SslErrorWantConnect* = 7
  SslErrorWantAccept* = 8
  SslCtrlNeedTmpRsa* = 1
  SslCtrlSetTmpRsa* = 2
  SslCtrlSetTmpDh* = 3
  SslCtrlSetTmpEcdh* = 4
  SslCtrlSetTmpRsaCb* = 5
  SslCtrlSetTmpDhCb* = 6
  SslCtrlSetTmpEcdhCb* = 7
  SslCtrlGetSessionReused* = 8
  SslCtrlGetClientCertRequest* = 9
  SslCtrlGetNumRenegotiations* = 10
  SslCtrlClearNumRenegotiations* = 11
  SslCtrlGetTotalRenegotiations* = 12
  SslCtrlGetFlags* = 13
  SslCtrlExtraChainCert* = 14
  SslCtrlSetMsgCallback* = 15
  SslCtrlSetMsgCallbackArg* = 16 # only applies to datagram connections  
  SslCtrlSetMtu* = 17      # Stats  
  SslCtrlSessNumber* = 20
  SslCtrlSessConnect* = 21
  SslCtrlSessConnectGood* = 22
  SslCtrlSessConnectRenegotiate* = 23
  SslCtrlSessAccept* = 24
  SslCtrlSessAcceptGood* = 25
  SslCtrlSessAcceptRenegotiate* = 26
  SslCtrlSessHit* = 27
  SslCtrlSessCbHit* = 28
  SslCtrlSessMisses* = 29
  SslCtrlSessTimeouts* = 30
  SslCtrlSessCacheFull* = 31
  SslCtrlOptions* = 32
  SslCtrlMode* = 33
  SslCtrlGetReadAhead* = 40
  SslCtrlSetReadAhead* = 41
  SslCtrlSetSessCacheSize* = 42
  SslCtrlGetSessCacheSize* = 43
  SslCtrlSetSessCacheMode* = 44
  SslCtrlGetSessCacheMode* = 45
  SslCtrlGetMaxCertList* = 50
  SslCtrlSetMaxCertList* = 51 #* Allow SSL_write(..., n) to return r with 0 < r < n (i.e. report success
                                   # * when just a single record has been written): *
  SslModeEnablePartialWrite* = 1 #* Make it possible to retry SSL_write() with changed buffer location
                                     # * (buffer contents must stay the same!); this is not the default to avoid
                                     # * the misconception that non-blocking SSL_write() behaves like
                                     # * non-blocking write(): *
  SslModeAcceptMovingWriteBuffer* = 2 #* Never bother the application with retries if the transport
                                           # * is blocking: *
  SslModeAutoRetry* = 4    #* Don't attempt to automatically build certificate chain *
  SslModeNoAutoChain* = 8
  SSLOPNOSSLv2* = 0x01000000
  SSLOPNOSSLv3* = 0x02000000
  SSLOPNOTLSv1* = 0x04000000
  SslOpAll* = 0x000FFFFF
  SslVerifyNone* = 0x00000000
  SslVerifyPeer* = 0x00000001
  OpensslDesDecrypt* = 0
  OpensslDesEncrypt* = 1
  X509VOk* = 0
  X509VIllegal* = 1
  X509VErrUnableToGetIssuerCert* = 2
  X509VErrUnableToGetCrl* = 3
  X509VErrUnableToDecryptCertSignature* = 4
  X509VErrUnableToDecryptCrlSignature* = 5
  X509VErrUnableToDecodeIssuerPublicKey* = 6
  X509VErrCertSignatureFailure* = 7
  X509VErrCrlSignatureFailure* = 8
  X509VErrCertNotYetValid* = 9
  X509VErrCertHasExpired* = 10
  X509VErrCrlNotYetValid* = 11
  X509VErrCrlHasExpired* = 12
  X509VErrErrorInCertNotBeforeField* = 13
  X509VErrErrorInCertNotAfterField* = 14
  X509VErrErrorInCrlLastUpdateField* = 15
  X509VErrErrorInCrlNextUpdateField* = 16
  X509VErrOutOfMem* = 17
  X509VErrDepthZeroSelfSignedCert* = 18
  X509VErrSelfSignedCertInChain* = 19
  X509VErrUnableToGetIssuerCertLocally* = 20
  X509VErrUnableToVerifyLeafSignature* = 21
  X509VErrCertChainTooLong* = 22
  X509VErrCertRevoked* = 23
  X509VErrInvalidCa* = 24
  X509VErrPathLengthExceeded* = 25
  X509VErrInvalidPurpose* = 26
  X509VErrCertUntrusted* = 27
  X509VErrCertRejected* = 28 #These are 'informational' when looking for issuer cert
  X509VErrSubjectIssuerMismatch* = 29
  X509VErrAkidSkidMismatch* = 30
  X509VErrAkidIssuerSerialMismatch* = 31
  X509VErrKeyusageNoCertsign* = 32
  X509VErrUnableToGetCrlIssuer* = 33
  X509VErrUnhandledCriticalExtension* = 34 #The application is not happy
  X509VErrApplicationVerification* = 50
  SslFiletypeAsn1* = 2
  SslFiletypePem* = 1
  EvpPkeyRsa* = 6           # libssl.dll
  
  BioCSetConnect = 100
  BioCDoStateMachine = 101
  BioCGetSsl = 110

proc SSL_library_init*(): Cint{.cdecl, dynlib: DLLSSLName, importc, discardable.}
proc SSL_load_error_strings*(){.cdecl, dynlib: DLLSSLName, importc.}
proc ERR_load_BIO_strings*(){.cdecl, dynlib: DLLUtilName, importc.}

proc SSLv23_client_method*(): PsslMethod{.cdecl, dynlib: DLLSSLName, importc.}
proc SSLv23_method*(): PsslMethod{.cdecl, dynlib: DLLSSLName, importc.}
proc SSLv2_method*(): PsslMethod{.cdecl, dynlib: DLLSSLName, importc.}
proc SSLv3_method*(): PsslMethod{.cdecl, dynlib: DLLSSLName, importc.}
proc TLSv1_method*(): PsslMethod{.cdecl, dynlib: DLLSSLName, importc.}

proc SSL_new*(context: PsslCtx): Pssl{.cdecl, dynlib: DLLSSLName, importc.}
proc SSL_free*(ssl: Pssl){.cdecl, dynlib: DLLSSLName, importc.}
proc SSL_CTX_new*(meth: PsslMethod): PsslCtx{.cdecl,
    dynlib: DLLSSLName, importc.}
proc SSL_CTX_load_verify_locations*(ctx: PsslCtx, CAfile: Cstring,
    CApath: Cstring): Cint{.cdecl, dynlib: DLLSSLName, importc.}
proc SSL_CTX_free*(arg0: PsslCtx){.cdecl, dynlib: DLLSSLName, importc.}
proc SSL_CTX_set_verify*(s: PsslCtx, mode: Int, cb: proc (a: Int, b: Pointer): Int {.cdecl.}){.cdecl, dynlib: DLLSSLName, importc.}
proc SSL_get_verify_result*(ssl: Pssl): Int{.cdecl,
    dynlib: DLLSSLName, importc.}

proc SSL_CTX_set_cipher_list*(s: PsslCtx, ciphers: Cstring): Cint{.cdecl, dynlib: DLLSSLName, importc.}
proc SSL_CTX_use_certificate_file*(ctx: PsslCtx, filename: Cstring, typ: Cint): Cint{.
    stdcall, dynlib: DLLSSLName, importc.}
proc SSL_CTX_use_certificate_chain_file*(ctx: PsslCtx, filename: Cstring): Cint{.
    stdcall, dynlib: DLLSSLName, importc.}
proc SSL_CTX_use_PrivateKey_file*(ctx: PsslCtx,
    filename: Cstring, typ: Cint): Cint{.cdecl, dynlib: DLLSSLName, importc.}
proc SSL_CTX_check_private_key*(ctx: PsslCtx): Cint{.cdecl, dynlib: DLLSSLName, 
    importc.}

proc SSL_set_fd*(ssl: Pssl, fd: Cint): Cint{.cdecl, dynlib: DLLSSLName, importc.}

proc SSL_shutdown*(ssl: Pssl): Cint{.cdecl, dynlib: DLLSSLName, importc.}
proc SSL_connect*(ssl: Pssl): Cint{.cdecl, dynlib: DLLSSLName, importc.}
proc SSL_read*(ssl: Pssl, buf: Pointer, num: Int): Cint{.cdecl, dynlib: DLLSSLName, importc.}
proc SSL_write*(ssl: Pssl, buf: Cstring, num: Int): Cint{.cdecl, dynlib: DLLSSLName, importc.}
proc SSL_get_error*(s: Pssl, ret_code: Cint): Cint{.cdecl, dynlib: DLLSSLName, importc.}
proc SSL_accept*(ssl: Pssl): Cint{.cdecl, dynlib: DLLSSLName, importc.}
proc SSL_pending*(ssl: Pssl): Cint{.cdecl, dynlib: DLLSSLName, importc.}

proc BIO_new_ssl_connect*(ctx: PsslCtx): Pbio{.cdecl,
    dynlib: DLLSSLName, importc.}
proc BIO_ctrl*(bio: Pbio, cmd: Cint, larg: Int, arg: Cstring): Int{.cdecl,
    dynlib: DLLSSLName, importc.}
proc bIOGetSsl*(bio: Pbio, ssl: ptr Pssl): Int = 
  return BIO_ctrl(bio, BIO_C_GET_SSL, 0, cast[Cstring](ssl))
proc bIOSetConnHostname*(bio: Pbio, name: Cstring): Int =
  return BIO_ctrl(bio, BIO_C_SET_CONNECT, 0, name)
proc bIODoHandshake*(bio: Pbio): Int =
  return BIO_ctrl(bio, BIO_C_DO_STATE_MACHINE, 0, NIL)
proc bIODoConnect*(bio: Pbio): Int =
  return bIODoHandshake(bio)

proc BIO_read*(b: Pbio, data: Cstring, length: Cint): Cint{.cdecl, 
    dynlib: DLLUtilName, importc.}
proc BIO_write*(b: Pbio, data: Cstring, length: Cint): Cint{.cdecl, 
    dynlib: DLLUtilName, importc.}

proc BIO_free*(b: Pbio): Cint{.cdecl, dynlib: DLLUtilName, importc.}

proc ERR_print_errors_fp*(fp: TFile){.cdecl, dynlib: DLLSSLName, importc.}

proc ERR_error_string*(e: Cint, buf: Cstring): Cstring{.cdecl, 
    dynlib: DLLUtilName, importc.}
proc ERR_get_error*(): Cint{.cdecl, dynlib: DLLUtilName, importc.}
proc ERR_peek_last_error*(): Cint{.cdecl, dynlib: DLLUtilName, importc.}

proc openSSLAddAllAlgorithms*(){.cdecl, dynlib: DLLUtilName, importc: "OPENSSL_add_all_algorithms_conf".}

proc OPENSSL_config*(configName: Cstring){.cdecl, dynlib: DLLSSLName, importc.}

proc CRYPTO_set_mem_functions(a,b,c: Pointer){.cdecl, dynlib: DLLSSLName, importc.}

proc cRYPTOMallocInit*() =
  when not defined(windows):
    CRYPTO_set_mem_functions(alloc, realloc, dealloc)

when True:
  nil
else:
  proc SslCtxSetCipherList*(arg0: PSSL_CTX, str: cstring): cInt{.cdecl, 
      dynlib: DLLSSLName, importc.}
  proc SslCtxNew*(meth: PSSL_METHOD): PSSL_CTX{.cdecl,
      dynlib: DLLSSLName, importc.}

  proc SslSetFd*(s: PSSL, fd: cInt): cInt{.cdecl, dynlib: DLLSSLName, importc.}
  proc SslCtrl*(ssl: PSSL, cmd: cInt, larg: int, parg: Pointer): int{.cdecl, 
      dynlib: DLLSSLName, importc.}
  proc SslCTXCtrl*(ctx: PSSL_CTX, cmd: cInt, larg: int, parg: Pointer): int{.
      cdecl, dynlib: DLLSSLName, importc.}

  proc SSLCTXSetMode*(ctx: PSSL_CTX, mode: int): int
  proc SSLSetMode*(s: PSSL, mode: int): int
  proc SSLCTXGetMode*(ctx: PSSL_CTX): int
  proc SSLGetMode*(s: PSSL): int
  proc SslMethodV2*(): PSSL_METHOD{.cdecl, dynlib: DLLSSLName, importc.}
  proc SslMethodV3*(): PSSL_METHOD{.cdecl, dynlib: DLLSSLName, importc.}
  proc SslMethodTLSV1*(): PSSL_METHOD{.cdecl, dynlib: DLLSSLName, importc.}
  proc SslMethodV23*(): PSSL_METHOD{.cdecl, dynlib: DLLSSLName, importc.}
  proc SslCtxUsePrivateKey*(ctx: PSSL_CTX, pkey: SslPtr): cInt{.cdecl, 
      dynlib: DLLSSLName, importc.}
  proc SslCtxUsePrivateKeyASN1*(pk: cInt, ctx: PSSL_CTX,
      d: cstring, length: int): cInt{.cdecl, dynlib: DLLSSLName, importc.}

  proc SslCtxUseCertificate*(ctx: PSSL_CTX, x: SslPtr): cInt{.cdecl, 
      dynlib: DLLSSLName, importc.}
  proc SslCtxUseCertificateASN1*(ctx: PSSL_CTX, length: int, d: cstring): cInt{.
      cdecl, dynlib: DLLSSLName, importc.}

    #  function SslCtxUseCertificateChainFile(ctx: PSSL_CTX; const filename: PChar):cInt;
  proc SslCtxUseCertificateChainFile*(ctx: PSSL_CTX, filename: cstring): cInt{.
      cdecl, dynlib: DLLSSLName, importc.}
  proc SslCtxSetDefaultPasswdCb*(ctx: PSSL_CTX, cb: PPasswdCb){.cdecl, 
      dynlib: DLLSSLName, importc.}
  proc SslCtxSetDefaultPasswdCbUserdata*(ctx: PSSL_CTX, u: SslPtr){.cdecl, 
      dynlib: DLLSSLName, importc.}
    #  function SslCtxLoadVerifyLocations(ctx: PSSL_CTX; const CAfile: PChar; const CApath: PChar):cInt;
  proc SslCtxLoadVerifyLocations*(ctx: PSSL_CTX, CAfile: cstring, CApath: cstring): cInt{.
      cdecl, dynlib: DLLSSLName, importc.}
  proc SslNew*(ctx: PSSL_CTX): PSSL{.cdecl, dynlib: DLLSSLName, importc.}


  proc SslConnect*(ssl: PSSL): cInt{.cdecl, dynlib: DLLSSLName, importc.}

  proc SslRead*(ssl: PSSL, buf: SslPtr, num: cInt): cInt{.cdecl, 
      dynlib: DLLSSLName, importc.}
  proc SslPeek*(ssl: PSSL, buf: SslPtr, num: cInt): cInt{.cdecl, 
      dynlib: DLLSSLName, importc.}
  proc SslWrite*(ssl: PSSL, buf: SslPtr, num: cInt): cInt{.cdecl, 
      dynlib: DLLSSLName, importc.}
  proc SslGetVersion*(ssl: PSSL): cstring{.cdecl, dynlib: DLLSSLName, importc.}
  proc SslGetPeerCertificate*(ssl: PSSL): PX509{.cdecl, dynlib: DLLSSLName, 
      importc.}
  proc SslCtxSetVerify*(ctx: PSSL_CTX, mode: cInt, arg2: PFunction){.cdecl, 
      dynlib: DLLSSLName, importc.}
  proc SSLGetCurrentCipher*(s: PSSL): SslPtr{.cdecl, dynlib: DLLSSLName, importc.}
  proc SSLCipherGetName*(c: SslPtr): cstring{.cdecl, dynlib: DLLSSLName, importc.}
  proc SSLCipherGetBits*(c: SslPtr, alg_bits: var cInt): cInt{.cdecl, 
      dynlib: DLLSSLName, importc.}
  proc SSLGetVerifyResult*(ssl: PSSL): int{.cdecl, dynlib: DLLSSLName, importc.}
    # libeay.dll
  proc X509New*(): PX509{.cdecl, dynlib: DLLUtilName, importc.}
  proc X509Free*(x: PX509){.cdecl, dynlib: DLLUtilName, importc.}
  proc X509NameOneline*(a: PX509_NAME, buf: cstring, size: cInt): cstring{.
      cdecl, dynlib: DLLUtilName, importc.}
  proc X509GetSubjectName*(a: PX509): PX509_NAME{.cdecl, dynlib: DLLUtilName, 
      importc.}
  proc X509GetIssuerName*(a: PX509): PX509_NAME{.cdecl, dynlib: DLLUtilName, 
      importc.}
  proc X509NameHash*(x: PX509_NAME): int{.cdecl, dynlib: DLLUtilName, importc.}
    #  function SslX509Digest(data: PX509; typ: PEVP_MD; md: PChar; len: PcInt):cInt;
  proc X509Digest*(data: PX509, typ: PEVP_MD, md: cstring, length: var cInt): cInt{.
      cdecl, dynlib: DLLUtilName, importc.}
  proc X509print*(b: PBIO, a: PX509): cInt{.cdecl, dynlib: DLLUtilName, importc.}
  proc X509SetVersion*(x: PX509, version: cInt): cInt{.cdecl, dynlib: DLLUtilName, 
      importc.}
  proc X509SetPubkey*(x: PX509, pkey: EVP_PKEY): cInt{.cdecl, dynlib: DLLUtilName, 
      importc.}
  proc X509SetIssuerName*(x: PX509, name: PX509_NAME): cInt{.cdecl, 
      dynlib: DLLUtilName, importc.}
  proc X509NameAddEntryByTxt*(name: PX509_NAME, field: cstring, typ: cInt, 
                              bytes: cstring, length, loc, theSet: cInt): cInt{.
      cdecl, dynlib: DLLUtilName, importc.}
  proc X509Sign*(x: PX509, pkey: EVP_PKEY, md: PEVP_MD): cInt{.cdecl, 
      dynlib: DLLUtilName, importc.}
  proc X509GmtimeAdj*(s: PASN1_UTCTIME, adj: cInt): PASN1_UTCTIME{.cdecl, 
      dynlib: DLLUtilName, importc.}
  proc X509SetNotBefore*(x: PX509, tm: PASN1_UTCTIME): cInt{.cdecl, 
      dynlib: DLLUtilName, importc.}
  proc X509SetNotAfter*(x: PX509, tm: PASN1_UTCTIME): cInt{.cdecl, 
      dynlib: DLLUtilName, importc.}
  proc X509GetSerialNumber*(x: PX509): PASN1_cInt{.cdecl, dynlib: DLLUtilName, 
      importc.}
  proc EvpPkeyNew*(): EVP_PKEY{.cdecl, dynlib: DLLUtilName, importc.}
  proc EvpPkeyFree*(pk: EVP_PKEY){.cdecl, dynlib: DLLUtilName, importc.}
  proc EvpPkeyAssign*(pkey: EVP_PKEY, typ: cInt, key: Prsa): cInt{.cdecl, 
      dynlib: DLLUtilName, importc.}
  proc EvpGetDigestByName*(Name: cstring): PEVP_MD{.cdecl, dynlib: DLLUtilName, 
      importc.}
  proc EVPcleanup*(){.cdecl, dynlib: DLLUtilName, importc.}
    #  function ErrErrorString(e: cInt; buf: PChar): PChar;
  proc SSLeayversion*(t: cInt): cstring{.cdecl, dynlib: DLLUtilName, importc.}

  proc ErrClearError*(){.cdecl, dynlib: DLLUtilName, importc.}
  proc ErrFreeStrings*(){.cdecl, dynlib: DLLUtilName, importc.}
  proc ErrRemoveState*(pid: cInt){.cdecl, dynlib: DLLUtilName, importc.}
  proc OPENSSLaddallalgorithms*(){.cdecl, dynlib: DLLUtilName, importc.}
  proc CRYPTOcleanupAllExData*(){.cdecl, dynlib: DLLUtilName, importc.}
  proc RandScreen*(){.cdecl, dynlib: DLLUtilName, importc.}
  proc BioNew*(b: PBIO_METHOD): PBIO{.cdecl, dynlib: DLLUtilName, importc.}
  proc BioFreeAll*(b: PBIO){.cdecl, dynlib: DLLUtilName, importc.}
  proc BioSMem*(): PBIO_METHOD{.cdecl, dynlib: DLLUtilName, importc.}
  proc BioCtrlPending*(b: PBIO): cInt{.cdecl, dynlib: DLLUtilName, importc.}
  proc BioRead*(b: PBIO, Buf: cstring, length: cInt): cInt{.cdecl, 
      dynlib: DLLUtilName, importc.}
  proc BioWrite*(b: PBIO, Buf: cstring, length: cInt): cInt{.cdecl, 
      dynlib: DLLUtilName, importc.}
  proc d2iPKCS12bio*(b: PBIO, Pkcs12: SslPtr): SslPtr{.cdecl, dynlib: DLLUtilName, 
      importc.}
  proc PKCS12parse*(p12: SslPtr, pass: cstring, pkey, cert, ca: var SslPtr): cint{.
      dynlib: DLLUtilName, importc, cdecl.}

  proc PKCS12free*(p12: SslPtr){.cdecl, dynlib: DLLUtilName, importc.}
  proc RsaGenerateKey*(bits, e: cInt, callback: PFunction, cb_arg: SslPtr): PRSA{.
      cdecl, dynlib: DLLUtilName, importc.}
  proc Asn1UtctimeNew*(): PASN1_UTCTIME{.cdecl, dynlib: DLLUtilName, importc.}
  proc Asn1UtctimeFree*(a: PASN1_UTCTIME){.cdecl, dynlib: DLLUtilName, importc.}
  proc Asn1cIntSet*(a: PASN1_cInt, v: cInt): cInt{.cdecl, dynlib: DLLUtilName, 
      importc.}
  proc i2dX509bio*(b: PBIO, x: PX509): cInt{.cdecl, dynlib: DLLUtilName, importc.}
  proc i2dPrivateKeyBio*(b: PBIO, pkey: EVP_PKEY): cInt{.cdecl, 
      dynlib: DLLUtilName, importc.}
    # 3DES functions
  proc DESsetoddparity*(Key: des_cblock){.cdecl, dynlib: DLLUtilName, importc.}
  proc DESsetkeychecked*(key: des_cblock, schedule: des_key_schedule): cInt{.
      cdecl, dynlib: DLLUtilName, importc.}
  proc DESecbencrypt*(Input: des_cblock, output: des_cblock, ks: des_key_schedule, 
                      enc: cInt){.cdecl, dynlib: DLLUtilName, importc.}
  # implementation

  proc SSLCTXSetMode(ctx: PSSL_CTX, mode: int): int = 
    Result = SslCTXCtrl(ctx, SSL_CTRL_MODE, mode, nil)

  proc SSLSetMode(s: PSSL, mode: int): int = 
    Result = SSLctrl(s, SSL_CTRL_MODE, mode, nil)

  proc SSLCTXGetMode(ctx: PSSL_CTX): int = 
    Result = SSLCTXctrl(ctx, SSL_CTRL_MODE, 0, nil)

  proc SSLGetMode(s: PSSL): int = 
    Result = SSLctrl(s, SSL_CTRL_MODE, 0, nil)

