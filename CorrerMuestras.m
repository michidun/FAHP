clear

for i=1:19
  printf "matriz No.:" + num2str(i);
  A = xlsread('muestras/1/workbook.xlsx',i);
  result = RunFuzzyAHP(A);
  result
  clf ();
  bar(result);
  %print -dpdf "plot" + i + ".pdf";
  filename = strcat("plots/plot", num2str(i),".pdf");
  saveas(1, filename);
endfor