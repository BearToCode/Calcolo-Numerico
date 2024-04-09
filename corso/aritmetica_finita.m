%% Spazio floating point

% F(b, t, L, U)
% b - base
% t - numero di cifre
% L - lower bound
% U - upper bound

% x = (-1)^s (a_1, a_2, ..., a_n) b^(e-t)
% e = [L, U]

% esempio: b = 10, t = 5, x = 123,45
fl = floating_point(0, [1 2 3 4 5]', 10, 3);
fprintf('Floating point: %f\n', fl);

%% Epsilon macchina

fprintf('Epsilon macchina: %E\n', eps);

% esempio: determinare la distanza tra 2 e il suo successore
% nello spazio F(2,4,-5,5)
% fl(2) = 2 (sistema binario)
% il successivo lo posso determinare come:

% s = 0, cifre = [1 0 0 1]', b = 2, e = 2
%                   👆 t cifre
next = floating_point(0, [1 0 0 1]', 2, 2);


%% Numero massimo/minimo(positivo) rappresentabile

x_max = @(b, t, U) b^U * (1 - b^(-t));
x_min = @(b, L) b^(L-1);
% esempio(MATLAB):
fprintf('Numero massimo rappresentabile: %E\n', x_max(2, 53, 1023));
fprintf('Numero minimo rappresentabile: %E\n', x_min(2, -1022));

%% Funzioni %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
