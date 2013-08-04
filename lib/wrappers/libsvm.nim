#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## This module is a low level wrapper for `libsvm`:idx:.

{.deadCodeElim: on.}
const 
  LibsvmVersion* = 312
  
when defined(windows):
  const svmdll* = "libsvm.dll"
elif defined(macosx):
  const svmdll* = "libsvm.dylib"
else:
  const svmdll* = "libsvm.so"

type 
  Tnode*{.pure, final.} = object 
    index*: Cint
    value*: Cdouble

  Tproblem*{.pure, final.} = object 
    L*: Cint
    y*: ptr Cdouble
    x*: ptr ptr Tnode

  Ttype*{.size: sizeof(cint).} = enum 
    C_SVC, NU_SVC, ONE_CLASS, EPSILON_SVR, NU_SVR
  
  TKernelType*{.size: sizeof(cint).} = enum 
    LINEAR, POLY, RBF, SIGMOID, PRECOMPUTED
  
  Tparameter*{.pure, final.} = object 
    typ*: Ttype
    kernelType*: TKernelType
    degree*: Cint             # for poly 
    gamma*: Cdouble           # for poly/rbf/sigmoid 
    coef0*: Cdouble           # for poly/sigmoid 
                              # these are for training only 
    cache_size*: Cdouble      # in MB 
    eps*: Cdouble             # stopping criteria 
    C*: Cdouble               # for C_SVC, EPSILON_SVR and NU_SVR 
    nr_weight*: Cint          # for C_SVC 
    weight_label*: ptr Cint   # for C_SVC 
    weight*: ptr Cdouble      # for C_SVC 
    nu*: Cdouble              # for NU_SVC, ONE_CLASS, and NU_SVR 
    p*: Cdouble               # for EPSILON_SVR 
    shrinking*: Cint          # use the shrinking heuristics 
    probability*: Cint        # do probability estimates 
  

#
# svm_model
# 

type 
  TModel*{.pure, final.} = object 
    param*: Tparameter        # parameter 
    nr_class*: Cint           # number of classes, = 2 in regression/one class svm 
    L*: Cint                  # total #SV 
    SV*: ptr ptr Tnode        # SVs (SV[l]) 
    sv_coef*: ptr ptr Cdouble # coefficients for SVs in decision functions (sv_coef[k-1][l]) 
    rho*: ptr Cdouble         # constants in decision functions (rho[k*(k-1)/2]) 
    probA*: ptr Cdouble       # pariwise probability information 
    probB*: ptr Cdouble       # for classification only 
    label*: ptr Cint          # label of each class (label[k]) 
    nSV*: ptr Cint            # number of SVs for each class (nSV[k]) 
                              # nSV[0] + nSV[1] + ... + nSV[k-1] = l 
                              # XXX 
    free_sv*: Cint            # 1 if svm_model is created by svm_load_model
                              # 0 if svm_model is created by svm_train 
  

proc train*(prob: ptr Tproblem, param: ptr Tparameter): ptr Tmodel{.cdecl, 
    importc: "svm_train", dynlib: svmdll.}
proc crossValidation*(prob: ptr Tproblem, param: ptr Tparameter, nr_fold: Cint, 
                       target: ptr Cdouble){.cdecl, 
    importc: "svm_cross_validation", dynlib: svmdll.}
proc saveModel*(model_file_name: Cstring, model: ptr Tmodel): Cint{.cdecl, 
    importc: "svm_save_model", dynlib: svmdll.}
proc loadModel*(model_file_name: Cstring): ptr Tmodel{.cdecl, 
    importc: "svm_load_model", dynlib: svmdll.}
proc getSvmType*(model: ptr Tmodel): Cint{.cdecl, importc: "svm_get_svm_type", 
    dynlib: svmdll.}
proc getNrClass*(model: ptr Tmodel): Cint{.cdecl, importc: "svm_get_nr_class", 
    dynlib: svmdll.}
proc getLabels*(model: ptr Tmodel, label: ptr Cint){.cdecl, 
    importc: "svm_get_labels", dynlib: svmdll.}
proc getSvrProbability*(model: ptr Tmodel): Cdouble{.cdecl, 
    importc: "svm_get_svr_probability", dynlib: svmdll.}
proc predictValues*(model: ptr Tmodel, x: ptr Tnode, dec_values: ptr Cdouble): Cdouble{.
    cdecl, importc: "svm_predict_values", dynlib: svmdll.}
proc predict*(model: ptr Tmodel, x: ptr Tnode): Cdouble{.cdecl, 
    importc: "svm_predict", dynlib: svmdll.}
proc predictProbability*(model: ptr Tmodel, x: ptr Tnode, 
                          prob_estimates: ptr Cdouble): Cdouble{.cdecl, 
    importc: "svm_predict_probability", dynlib: svmdll.}
proc freeModelContent*(model_ptr: ptr Tmodel){.cdecl, 
    importc: "svm_free_model_content", dynlib: svmdll.}
proc freeAndDestroyModel*(model_ptr_ptr: ptr ptr Tmodel){.cdecl, 
    importc: "svm_free_and_destroy_model", dynlib: svmdll.}
proc destroyParam*(param: ptr Tparameter){.cdecl, importc: "svm_destroy_param", 
    dynlib: svmdll.}
proc checkParameter*(prob: ptr Tproblem, param: ptr Tparameter): Cstring{.
    cdecl, importc: "svm_check_parameter", dynlib: svmdll.}
proc checkProbabilityModel*(model: ptr Tmodel): Cint{.cdecl, 
    importc: "svm_check_probability_model", dynlib: svmdll.}

proc setPrintStringFunction*(print_func: proc (arg: Cstring) {.cdecl.}){.
    cdecl, importc: "svm_set_print_string_function", dynlib: svmdll.}
