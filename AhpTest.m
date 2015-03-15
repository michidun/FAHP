clc
clf
clear

%%
CompMat = [ 1     1     5     5     9     1/5    5
            0     1     9     5     7     1/3    3
            0     0     1     1/5   3     1/9    1
            0     0     0     1     5     1/3    3
            0     0     0     0     1     1/9    1
            0     0     0     0     0      1     9
            0     0     0     0     0      0     1];


if ConsistencyAHP(CompMat)< 0.10
    [result] = FuzzyAHP(CompMat);
    disp(result);
    bar(result);
end

