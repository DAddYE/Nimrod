discard """
  disabled: false
"""

##
## can_alias_specialised_generic Nimrod Module
##
## Created by Eric Doughty-Papassideris on 2011-02-16.
## Copyright (c) 2011 FWA. All rights reserved.

type
  TGen[T] = object
  TSpef = TGen[String]
  
var
  s: TSpef

