Sheets  = readxls("./muestras/1/workbook.xls")
A = Sheets(1).value

// Se sumariza cada componente de las tripletas (RS)
RS1 = sum(A(:,[1:3:25]),2) // Componente a
RS2 = sum(A(:,[2:3:26]),2) // Componente b
RS3 = sum(A(:,[3:3:27]),2) // Componente c

// Se concatena los componentes RS en R
R = cat(2,RS1,RS2,RS3)

// Se transforma R en vector RS
RS = matrix(R',1,27)

// Se sumariza cada columna de A (CS)
CS = sum(A,1)

// M
A1 = A(:,1) / CS(1) + A(:,2) / CS(2) + A(:,2) / CS(2) + A(:,3) / CS(3) + A(:,4) / CS(4) + A(:,5) / CS(5) + A(:,6) / CS(6) + A(:,7) / CS(7) + A(:,8) / CS(8) + A(:,9) / CS(9)

Matplot(A)
