pkg install pkg/io.tar.gz
pkg install pkg/statistics.tar.gz
pkg load io statistics
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

  printf "Verificando consistencia de la matriz unificada\n";
  ConsistencyAHP(CompMat); 
  
  printf("\nAplicando FuzzyAHP sobre la matriz unificada...\n");
  result = FuzzyAHP(CompMat);
  PrintTFN(result);
  PV{w} = result;

  PVA{w} = FuzzyAHP(TFN_A);
  PVB{w} = FuzzyAHP(TFN_B);
  PVC{w} = FuzzyAHP(TFN_C);

endfor

[SC, APV, GFPV, WPV] = FuzzyWeight (PV, n);

printf ("Resultados:\n");
for w=1:wmax
  printf("\nResultado de la matriz: %s\n", names{w});
  PrintTFN(PV{w});
end

printf("Creando vector de alternativas unificado...\n");
printf("\nSubcriterios x Criterio 1:\n");
PrintTFN(SC{1});
printf("\nSubcriterios x Criterio 2:\n");
PrintTFN(SC{2});
printf("\nSubcriterios x Criterio 3:\n");
PrintTFN(SC{3});
printf("\nSubcriterios x Criterio 4:\n");
PrintTFN(SC{4});
printf("\nProyectos x ML:\n");
PrintTFN(APV{1});
printf("\nProyectos x FE:\n");
PrintTFN(APV{2});
printf("\nProyectos x FT:\n");
PrintTFN(APV{3});
printf("\nProyectos x NP:\n");
PrintTFN(APV{4});
printf("\nProyectos x TH:\n");
PrintTFN(APV{5});
printf("\nProyectos x DR:\n");
PrintTFN(APV{6});
printf("\nProyectos x NC:\n");
PrintTFN(APV{7});
printf("\nProyectos x FG:\n");
PrintTFN(APV{8});
printf("\nProyectos x OP:\n");
PrintTFN(APV{9});
printf("\nProyectos x MR:\n");
PrintTFN(APV{10});
printf("\nProyectos x OC:\n");
PrintTFN(APV{11});
printf("\nProyectos x II:\n");
PrintTFN(APV{12});
printf("\nProyectos x IE:\n");
PrintTFN(APV{13});
printf("\nProyectos x GI:\n");
PrintTFN(APV{14});
printf("\nCreando vector global unificado...\n");
PrintTFN(GFPV);
printf("\nDesfuzificación mediante centroide\n");

WPV

clf ();
bar(WPV);
print -dpdf "plots/plot.pdf";
#filename = strcat("plots/plot.pdf");
#saveas(1, filename);

printf("\nSuma de Comprobación\n");
sum(WPV)

printf("Vector de prioridad por muestra A:");
[SC, APV, GFPV, WPV] = FuzzyWeight (PVA, n);
WPV

printf("Vector de prioridad por muestra B:");
[SC, APV, GFPV, WPV] = FuzzyWeight (PVB, n);
WPV

printf("Vector de prioridad por muestra C:");
[SC, APV, GFPV, WPV] = FuzzyWeight (PVC, n);
WPV


