function [ result ] = FuzzyAHP( CompMat )
%FUZZYAHP Fuzzy AHP
%   Fuzzy AHP selection algorithm
%
% AUTHOR:
%           F. Ozgur CATAK
% CREATED:
%           October, 2011

% fuzzy tfn and inverse fuzzy tfn constants
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

% Row sum
for i=1:m
  RS(i,1) = 0;
  RS(i,2) = 0;
  RS(i,3) = 0;
  for j=1:n
    RS(i,1) = RS(i,1) + fuzzyCompMatCell{i,j}(1);
    RS(i,2) = RS(i,2) + fuzzyCompMatCell{i,j}(2);
    RS(i,3) = RS(i,3) + fuzzyCompMatCell{i,j}(3);
  end
end

%Column sum
for i=1:n
  CS(i,1) = 0;
  CS(i,2) = 0;
  CS(i,3) = 0;
  for j=1:m
    CS(i,1) = CS(i,1) + fuzzyCompMatCell{j,i}(1);
    CS(i,2) = CS(i,2) + fuzzyCompMatCell{j,i}(2);
    CS(i,3) = CS(i,3) + fuzzyCompMatCell{j,i}(3);
  end
end

NM_MAT = RS / 9;
NM_SUM =  sum(NM_MAT);

N = [NM_MAT(:,1)/NM_SUM(3), NM_MAT(:,2)/NM_SUM(2), NM_MAT(:,3)/NM_SUM(1)];
N = reshape(N',1,m*3);

IN = fliplr(CS);
IN = reshape(IN',1,m*3);
IN = IN.^-1;

AVP = (IN+N)/2;

%Dezfucificación con centroide
crisp = sum(reshape(AVP, 3, m)',2)/3;

result = crisp;
end