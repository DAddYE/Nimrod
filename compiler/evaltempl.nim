#
#
#           The Nimrod Compiler
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## Template evaluation engine. Now hygienic.

import
  strutils, options, ast, astalgo, msgs, os, idents, wordrecg, renderer, 
  rodread

type
  TemplCtx {.pure, final.} = object
    owner, genSymOwner: PSym
    mapping: TIdTable # every gensym'ed symbol needs to be mapped to some
                      # new symbol

proc evalTemplateAux(templ, actual: PNode, c: var TemplCtx, result: PNode) =
  case templ.kind
  of nkSym:
    var s = templ.sym
    if s.owner.id == c.owner.id:
      if s.kind == skParam:
        let x = actual.sons[s.position]
        if x.kind == nkArgList:
          for y in items(x): result.add(y)
        else:
          result.add copyTree(x)
      else:
        InternalAssert sfGenSym in s.flags
        var x = PSym(idTableGet(c.mapping, s))
        if x == nil:
          x = copySym(s, false)
          x.owner = c.genSymOwner
          idTablePut(c.mapping, s, x)
        result.add newSymNode(x, templ.info)
    else:
      result.add copyNode(templ)
  of nkNone..nkIdent, nkType..nkNilLit: # atom
    result.add copyNode(templ)
  else:
    var res = copyNode(templ)
    for i in countup(0, sonsLen(templ) - 1): 
      evalTemplateAux(templ.sons[i], actual, c, res)
    result.add res

when false:
  proc evalTemplateAux(templ, actual: PNode, c: var TemplCtx): PNode =
    case templ.kind
    of nkSym:
      var s = templ.sym
      if s.owner.id == c.owner.id:
        if s.kind == skParam:
          result = copyTree(actual.sons[s.position])
        else:
          InternalAssert sfGenSym in s.flags
          var x = PSym(IdTableGet(c.mapping, s))
          if x == nil:
            x = copySym(s, false)
            x.owner = c.genSymOwner
            IdTablePut(c.mapping, s, x)
          result = newSymNode(x, templ.info)
      else:
        result = copyNode(templ)
    of nkNone..nkIdent, nkType..nkNilLit: # atom
      result = copyNode(templ)
    else:
      result = copyNode(templ)
      newSons(result, sonsLen(templ))
      for i in countup(0, sonsLen(templ) - 1): 
        result.sons[i] = evalTemplateAux(templ.sons[i], actual, c)

proc evalTemplateArgs(n: PNode, s: PSym): PNode =
  # if the template has zero arguments, it can be called without ``()``
  # `n` is then a nkSym or something similar
  var a: Int
  case n.kind
  of nkCall, nkInfix, nkPrefix, nkPostfix, nkCommand, nkCallStrLit:
    a = sonsLen(n)
  else: a = 0
  var f = s.typ.sonsLen
  if a > f: globalError(n.info, errWrongNumberOfArguments)

  result = newNodeI(nkArgList, n.info)
  for i in countup(1, f - 1):
    var arg = if i < a: n.sons[i] else: copyTree(s.typ.n.sons[i].sym.ast)
    if arg == nil or arg.kind == nkEmpty:
      localError(n.info, errWrongNumberOfArguments)
    addSon(result, arg)

var evalTemplateCounter* = 0
  # to prevent endless recursion in templates instantiation

proc evalTemplate*(n: PNode, tmpl, genSymOwner: PSym): PNode =
  inc(evalTemplateCounter)
  if evalTemplateCounter > 100:
    globalError(n.info, errTemplateInstantiationTooNested)
    result = n

  # replace each param by the corresponding node:
  var args = evalTemplateArgs(n, tmpl)
  var ctx: TemplCtx
  ctx.owner = tmpl
  ctx.genSymOwner = genSymOwner
  initIdTable(ctx.mapping)
  
  let body = tmpl.getBody
  if isAtom(body): 
    result = newNodeI(nkPar, body.info)
    evalTemplateAux(body, args, ctx, result)
    if result.len == 1: result = result.sons[0]
    else:
      globalError(result.info, errIllFormedAstX,
                  renderTree(result, {renderNoComments}))
  else:
    result = copyNode(body)
    #evalTemplateAux(body, args, ctx, result)
    for i in countup(0, safeLen(body) - 1):
      evalTemplateAux(body.sons[i], args, ctx, result)
  
  dec(evalTemplateCounter)
