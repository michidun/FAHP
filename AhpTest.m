clc
clf
clear

%%

CompMat = [ 1     1/3   5     1/5   1     1/3   1/3   5     3
		    0     1     9     1     5     3     3     7     5
		    0     0     1     1/9   1/5   1/7   1/7   1/3   1/5
		    0     0     0     1     5     3     3     9     7
		    0     0     0     0     1     1/3   1/3   5     3
		    0     0     0     0     0     1     1     7     3
		    0     0     0     0     0     0     1     7     3
		    0     0     0     0     0     0     0     1     1/3
		    0     0     0     0     0     0     0     0     1 ];	


printf("Matriz CompMat:\n");
if ConsistencyAHP(CompMat)< 0.10
	printf("Índice de consistencia: %f\n",ConsistencyAHP(CompMat))
    [result] = FuzzyAHP(CompMat);
    result
    bar(result);
end

