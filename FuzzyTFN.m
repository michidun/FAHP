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
## @deftypefn {Function File} {@var{retval} =} FuzzyTFN (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Criptotec <criptotec@criptotec-ThinkPad-Edge-E430>
## Created: 2015-03-31
## % fuzzy tfn and inverse fuzzy tfn constants


function [fuzzyCompMatCell] = FuzzyTFN (CompMat)
% Escala de Tolga
fuzzyTFN = {[1     1     1  ] 	[1      1    1  ]
            [1/2   3/4   1  ] 	[1      4/3  2  ]
            [2/3   1     3/2] 	[2/3    1    3/2]
            [1     3/2   2  ] 	[1/2    2/3  1  ]
            [3/2   2     5/2] 	[2/5    1/2  2/3]
            [2     5/2   3  ] 	[1/3    2/5  1/2]
            [5/2   3     7/2] 	[2/7    1/3  2/5]
            [3     7/2   4  ] 	[1/4    2/7  1/3]
            [7/2   4     9/2] 	[2/9    1/4  2/7]};

fuzzyTFN = {[1     1     1  ]   [1      1    1  ]
            [1/2   1     3/2]   [2/3    1    2  ]
            [1     3/2   2  ]   [1/2    2/3  1  ]
            [3/2   2     5/2]   [2/5    1/2  2/3]
            [2     5/2   3  ]   [1/3    2/5  1/2]
            [5/2   3     7/2]   [2/7    1/3  2/5]};

fuzzyTFN = {[1     1     1  ]   [1      1    1  ]
            [1     2     3  ]   [1/3    1/2  1  ]
            [2     3     4  ]   [1/4    1/3  1/2]
            [3     4     5  ]   [1/5    1/4  1/3]
            [4     5     6  ]   [1/6    1/5  1/4]
            [5     6     7  ]   [1/7    1/6  1/5]
            [6     7     8  ]   [1/8    1/7  1/6]
            [7     8     9  ]   [1/9    1/8  1/7]
            [8     9     10 ]   [1/10   1/9  1/8]};  
clear fuzzyTFN;

fuzzyTFN = {[1     1     3  ]   [1/3    1    1  ]
            [1     2     4  ]   [1/4    1/2  1  ]
            [1     3     5  ]   [1/5    1/3  1  ]
            [2     4     6  ]   [1/6    1/4  1/2]
            [3     5     7  ]   [1/7    1/5  1/3]
            [4     6     8  ]   [1/8    1/6  1/4]
            [5     7     9  ]   [1/9    1/7  1/5]
            [6     8     9  ]   [1/9    1/8  1/6]
            [7     9     9  ]   [1/9    1/9  1/7]};

fuzzyTFN = {[1     1     1  ]   [1      1    1  ]
            [1     2     3  ]   [1/3    1/2  1  ]
            [2     3     4  ]   [1/4    1/3  1/2]
            [3     4     5  ]   [1/5    1/4  1/3]
            [4     5     6  ]   [1/6    1/5  1/4]
            [5     6     7  ]   [1/7    1/6  1/5]
            [6     7     8  ]   [1/8    1/7  1/6]
            [7     8     9  ]   [1/9    1/8  1/7]
            [8     9     10 ]   [1/10   1/9  1/8]};  


fuzzyCompMatCell={};

%%
% convert ordinal numbers to
% triangular fuzzy number using fuzzyTFN matrix
[m n] = size(CompMat);

for i=1:m
    for j=i+1:m
       CompMat(j,i) = 1 / CompMat(i,j); 
    end
end

for i=1:m
    for j=1:n
        criteria = CompMat(i,j);
        if criteria >= 1
           fuzzyCompMatCell{i,j} = fuzzyTFN{ criteria ,1 };
        else
           fuzzyCompMatCell{i,j} = fuzzyTFN{ round(criteria^-1) ,2 };
        end
    end
end

endfunction
