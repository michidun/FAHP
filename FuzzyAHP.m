function [ result ] = FuzzyAHP( fuzzyCompMatCell )
%FUZZYAHP Fuzzy AHP
%   Fuzzy AHP selection algorithm
%
% AUTHOR:
%           F. Ozgur CATAK
% CREATED:
%           October, 2011

[m n] = size(fuzzyCompMatCell);

%fuzzyCompMatCell = FuzzyTFN(CompMat);

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

for i=0:m-1
  result{i+1} = [AVP(i*3+1), AVP(i*3+2), AVP(i*3+3)];
end

end
