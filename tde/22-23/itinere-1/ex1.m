% Per l’insieme dei numeri floating point F(2, 5, L, U ) dipendente da due parametri
% L, U ∈ Z tali che L < −2 e U > 6, dati la mantissa m = (10101)2, il segno s = 0 e
% l’esponente e = 3, si riporti il numero reale x cos`ı rappresentato in base 10.

n = floating_point(0, [1, 0, 1, 0, 1], 2, 3);
disp(n);

function x = floating_point(s, cifre, b, e)
% Calcola il valore di un numero in floating point
% s - segno, 0 per positivo, 1 per negativo
% cifre - vettore colonna delle cifre
% b - base
% e - esponente (per esempio, per 123,45 e = 3)
    mantissa = 0;
    for i = 1:length(cifre)
        mantissa = mantissa + cifre(i) * b^(-i);   
    end
    x = (-1)^s * mantissa * b^(e);
end