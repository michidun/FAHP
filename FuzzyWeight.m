function [SC, APV, GFPV, WPV] = FuzzyWeight (PV, n)
	SC{1} = FuzzyProduct(PV{2},PV{1}{1});
	SC{2} = FuzzyProduct(PV{3},PV{1}{2});
	SC{3} = FuzzyProduct(PV{4},PV{1}{3});
	SC{4} = FuzzyProduct(PV{5},PV{1}{4});
	APV{1} = FuzzyProduct(PV{6}, SC{1}{1});
	APV{2} = FuzzyProduct(PV{7}, SC{1}{2});
	APV{3} = FuzzyProduct(PV{8}, SC{1}{3});
	APV{4} = FuzzyProduct(PV{9}, SC{2}{1});
	APV{5} = FuzzyProduct(PV{10}, SC{2}{2});
	APV{6} = FuzzyProduct(PV{11}, SC{2}{3});
	APV{7} = FuzzyProduct(PV{12}, SC{2}{4});
	APV{8} = FuzzyProduct(PV{13}, SC{3}{1});
	APV{9} = FuzzyProduct(PV{14}, SC{3}{2});

	APV{10} = FuzzyProduct(PV{15}, SC{3}{3});

	APV{11} = FuzzyProduct(PV{16}, SC{3}{4});

	APV{12} = FuzzyProduct(PV{17}, SC{4}{1});

	APV{13} = FuzzyProduct(PV{18}, SC{4}{2});

	APV{14} = FuzzyProduct(PV{19}, SC{4}{3});


	% Creando vector global unificado 
	m = length(APV);
	n = length(APV{n});

	for i=1:m
	  for j=1:n
	    lv(i,j) = APV{i}{j}(1);
	    mv(i,j) = APV{i}{j}(2);
	    uv(i,j) = APV{i}{j}(3);
	  endfor
	endfor

	for i=1:n
	  GFPV{i} = [sum(lv(:,i)), sum(mv(:,i)), sum(uv(:,i))]; 
	end

	%Desfuzificación mediante centroide
	for i=1:n
	  AVERAGEPV(i) = mean(GFPV{i}); 
	end

	AVERAGEPV;

	WPV = AVERAGEPV/sum(AVERAGEPV);

	WPV;
endfunction