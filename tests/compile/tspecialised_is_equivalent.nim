##
## specialised_is_equivalent Nimrod Module
##
## Created by Eric Doughty-Papassideris on 2011-02-16.
## Copyright (c) 2011 FWA. All rights reserved.

type
  TGen[T] = tuple[a: T]
  TSpef = tuple[a: String]

var
  a: TGen[String]
  b: TSpef
a = b

