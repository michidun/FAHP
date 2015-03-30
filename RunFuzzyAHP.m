## Copyright (C) 2015 Criptotec
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} RunFuzzyAHP (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Criptotec <criptotec@criptotec-ThinkPad-Edge-E430>
## Created: 2015-03-30

function [retval] = RunFuzzyAHP (CompMat)
  CompMat(~isfinite(CompMat))=0;
  CI = ConsistencyAHP(CompMat);
  printf("Índice de consistencia: %f\n",CI)
  if CI< 0.10
    [retval] = FuzzyAHP(CompMat);
  else
    retval = 0;
  end
endfunction
