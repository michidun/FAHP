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
## @deftypefn {Function File} {@var{retval} =} PrintTFN (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Criptotec <criptotec@criptotec-ThinkPad-Edge-E430>
## Created: 2015-03-31

function PrintTFN (TFN)
  [m n] = size(TFN);
  printf("\n");
  for i=1:m
    for j=1:n
      printf("(%1.3f, %1.3f, %1.3f) ", TFN{i,j}(1), TFN{i,j}(2), TFN{i,j}(3));
    end
    printf("\n");
  end
endfunction
