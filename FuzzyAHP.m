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
  clear lv mv uv;
  for j=1:n
    lv(end+1) = fuzzyCompMatCell{i,j}(1);
    mv(end+1) = fuzzyCompMatCell{i,j}(2);
    uv(end+1) = fuzzyCompMatCell{i,j}(3);
  end
  lm(i) = geomean(lv);
  mm(i) = geomean(mv);
  um(i) = geomean(uv);
end

NM_MAT = vertcat(lm, mm, um)';
NM_MAT

NM_SUM =  sum(NM_MAT);

N = [NM_MAT(:,1)/NM_SUM(3), NM_MAT(:,2)/NM_SUM(2), NM_MAT(:,3)/NM_SUM(1)];
N

for i=1:m
  result{i} = [N(i,1), N(i,2), N(i,3)];
end

end
 