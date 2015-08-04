function [ CR ] = ConsistencyAHP( CompMat )
	%%
	% Random Consistency Index
	RI = [0 0 0.58 0.9 1.12 1.24 1.32 1.41 1.45 1.49];
	%%

	[m n] = size(CompMat);

	for j=1:n
		lm = 0;
		mm = 0;
		um = 0;
	    for i=1:m
	    	lm = lm + CompMat{i,j}(1);
			mm = mm + CompMat{i,j}(2);
			um = um + CompMat{i,j}(3);
		endfor
		LS(j) = lm;
		MS(j) = mm;
		US(j) = um;
	endfor

	% Row sum
	for i=1:m
	  clear lv mv uv;
	  for j=1:n
	    lv(end+1) = CompMat{i,j}(1);
	    mv(end+1) = CompMat{i,j}(2);
	    uv(end+1) = CompMat{i,j}(3);
	  end
	  lm(i) = geomean(lv);
	  mm(i) = geomean(mv);
	  um(i) = geomean(uv);
	end

	GM_MAT = vertcat(lm, mm, um)';

	NM_MAT = horzcat(GM_MAT(:,1)/sum(GM_MAT)(3),GM_MAT(:,2)/sum(GM_MAT)(2),GM_MAT(:,3)/sum(GM_MAT)(1));

	LMAX = horzcat((NM_MAT(:,1)'.*LS)',(NM_MAT(:,2)'.*MS)',(NM_MAT(:,3)'.*US)');

	IC = (sum(LMAX)(2) - n) / (n - 1);

	CR = IC/RI(1,n);

	if CR > 0.10
	    str = 'CR is %% %1.2f. Subjective evaluation is NOT consistent!!!';
	    str = sprintf(str,CR);
	    disp(str);
	end
	  printf("Índice de consistencia: %1.2f\n",CR)
endfunction


