function x = floatingpoint(s, cifre, b, e)
% Calcola il valore di un numero in floating point
% s - segno, 0 per positivo, 1 per negativo
% cifre - vettore colonna delle cifre
% b - base
% e - esponente (per esempio, per 123,45 e = 3)
%
% F(b, t, L, U)
% b - base
% t - numero di cifre
% L - lower bound
% U - upper bound
    mantissa = 0;
    for i = 1:length(cifre)
      mantissa = mantissa + cifre(i) * b^(-i);   
    end
    x = (-1)^s * mantissa * b^(e);
  end
  