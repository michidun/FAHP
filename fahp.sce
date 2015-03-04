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

// Se sumariza cada columna de ARS (CS)
CS = sum(A,1)

