clear; clc;

% Si consideri l’approssimazione dell’integrale I(f) = ∫[-1,1] f(x)dx con f (x) = √(3 + 2|x|),
% tramite la formula del punto medio composita per sottointervalli equispaziati di
% ampiezza H = 0.5. Si riporti il valore approssimato dalla formula Ic_pm(f) così ottenuto.

f = @(x) sqrt(3 + 2*abs(x));
H = 0.5;
a = -1;
b = 1;

N = (b - a) / H;

I = pmedcomp(a, b, N, f);

disp(I); %3.9921