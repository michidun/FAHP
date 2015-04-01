clear

[exist, names] = xlsfinfo ('muestras/1/workbook.xlsx');

wmax = 19;

for w=1:wmax
  printf("Nombre hoja:%s\n", names{w});
  
  # Leyendo matrices de los excel de cada muestras
  printf("\nLeyendo matrices de los excel de cada muestras...\n");
  A = xlsread('muestras/1/workbook.xlsx',w);
  B = xlsread('muestras/2/workbook.xlsx',w);
  C = xlsread('muestras/3/workbook.xlsx',w);

  # Sustituyendo nulos y campos no numéricos por 0
  printf("Sustituyendo nulos y campos no numéricos por 0...\n");
  A(~isfinite(A))=0;
  A
  B(~isfinite(B))=0;
  B
  C(~isfinite(C))=0;
  C
  
  # Verificando consistencia según fórmula
  printf "Verificando consistencia de muestra A:\n";
  ConsistencyAHP(A); 
  printf "Verificando consistencia de muestra B:\n";
  ConsistencyAHP(B); 
  printf "Verificando consistencia de muestra C:\n";
  ConsistencyAHP(C); 
  
  # Convirtiendo matrices crisp por su equivalente fuzzy
  printf("\nConvirtiendo matrices crisp por su equivalente fuzzy...\n");
  printf("A:\n");
  TFN_A = FuzzyTFN(A);
  PrintTFN(TFN_A);
  printf("B:\n");
  TFN_B = FuzzyTFN(B);
  PrintTFN(TFN_B);
  printf("C:\n");
  TFN_C = FuzzyTFN(C);
  PrintTFN(TFN_C);
  
  # Creando matriz unificada utilizando media geométrica
  printf("\nCreando matriz unificada utilizando media geométrica...\n");
  [m n] = size(TFN_A);
  CompMat = {};
  
  for i=1:m
    for j=1:n
      lm = geomean([TFN_A{i,j}(1), TFN_B{i,j}(1), TFN_C{i,j}(1)]);
      mm = geomean([TFN_A{i,j}(2), TFN_B{i,j}(2), TFN_C{i,j}(2)]);
      um = geomean([TFN_A{i,j}(3), TFN_B{i,j}(3), TFN_C{i,j}(3)]);
      CompMat{i,j} = [lm, mm, um];
    endfor
  endfor
  
  PrintTFN(CompMat);
  
  printf("\nAplicando FuzzyAHP sobre la matriz unificada...\n");
  result = FuzzyAHP(CompMat);
  PrintTFN(result);
  PV{w} = result;

endfor

printf ("Resultados:\n");
for w=1:wmax
  printf("\nResultado de la matriz: %s\n", names{w});
  PrintTFN(PV{w});
end

printf("Creando vector de alternativas unificado...\n");
printf("\nSubcriterios x Criterio 1:\n");
SC{1} = FuzzyProduct(PV{2},PV{1}{1});
PrintTFN(SC{1});
printf("\nSubcriterios x Criterio 2:\n");
SC{2} = FuzzyProduct(PV{3},PV{1}{2});
PrintTFN(SC{2});
printf("\nSubcriterios x Criterio 3:\n");
SC{3} = FuzzyProduct(PV{4},PV{1}{3});
PrintTFN(SC{3});
printf("\nSubcriterios x Criterio 4:\n");
SC{4} = FuzzyProduct(PV{5},PV{1}{4});
PrintTFN(SC{4});

printf("\nProyectos x ML:\n");
APV{1} = FuzzyProduct(PV{6}, SC{1}{1});
PrintTFN(APV{1});

printf("\nProyectos x FE:\n");
APV{2} = FuzzyProduct(PV{7}, SC{1}{2});
PrintTFN(APV{2});

printf("\nProyectos x FT:\n");
APV{3} = FuzzyProduct(PV{8}, SC{1}{3});
PrintTFN(APV{3});

printf("\nProyectos x NP:\n");
APV{4} = FuzzyProduct(PV{9}, SC{2}{1});
PrintTFN(APV{4});

printf("\nProyectos x TH:\n");
APV{5} = FuzzyProduct(PV{10}, SC{2}{2});
PrintTFN(APV{5});

printf("\nProyectos x DR:\n");
APV{6} = FuzzyProduct(PV{11}, SC{2}{3});
PrintTFN(APV{6});

printf("\nProyectos x NC:\n");
APV{7} = FuzzyProduct(PV{12}, SC{2}{4});
PrintTFN(APV{7});

printf("\nProyectos x FG:\n");
APV{8} = FuzzyProduct(PV{13}, SC{3}{1});
PrintTFN(APV{8});

printf("\nProyectos x OP:\n");
APV{9} = FuzzyProduct(PV{14}, SC{3}{2});
PrintTFN(APV{9});

printf("\nProyectos x MR:\n");
APV{10} = FuzzyProduct(PV{15}, SC{3}{3});
PrintTFN(APV{10});

printf("\nProyectos x OC:\n");
APV{11} = FuzzyProduct(PV{16}, SC{3}{4});
PrintTFN(APV{11});

printf("\nProyectos x II:\n");
APV{12} = FuzzyProduct(PV{17}, SC{4}{1});
PrintTFN(APV{12});

printf("\nProyectos x IE:\n");
APV{13} = FuzzyProduct(PV{18}, SC{4}{2});
PrintTFN(APV{13});

printf("\nProyectos x GI:\n");
APV{14} = FuzzyProduct(PV{19}, SC{4}{3});
PrintTFN(APV{14});

 # Creando vector global unificado 
printf("\nCreando vector global unificado...\n");
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

PrintTFN(GFPV);

#Desfuzificación mediante centroide
printf("\nDesfuzificación mediante centroide\n");
for i=1:n
  GPV(i) = mean(GFPV{i}); 
end

GPV

clf ();
bar(GPV);
print -dpdf "plots/plot.pdf";
#filename = strcat("plots/plot.pdf");
#saveas(1, filename);
