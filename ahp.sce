Sheets  = readxls("./muestras/2/workbook.xls")
A = Sheets(1).value

// Cantidad de criterios a evaluar
C = 4

// Se sumariza cada componente de las tripletas (RS)
RS = sum(A,2)

// Se sumariza cada columna de A (CS)
CS = sum(A,1)

A2 = cat(2, A(:,1) / CS(1), A(:,2) / CS(2), A(:,3) / CS(3), A(:,4) / CS(4))

// Se calcula el autovector aproximadoß
EV = sum(A2,2)/4

LAMBDAMAX = CS * EV

CI = (LAMBDAMAX - C) / (C -1)

CR = (CI / 0.9) * 100

if CR >= 10 then
    messagebox("Matriz inconsistente.")
end

// Priotity vector
PV = gsort(EV)

bar(PV)
