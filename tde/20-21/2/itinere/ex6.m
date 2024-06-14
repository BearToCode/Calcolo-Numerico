% Si consideri l’approssimazione dell’integrale doppio I(f) = ∫[a,b] ∫[c,d] f(x,y) dydx
% tramite la formula dei trapezi, ovvero
% It(f) = (b − a)(d − c)/4  * [f(a,c) + f(a,d) + f(b,c) + f(b,d)] .
% Posti a = c = 0, b = d = 1 e f (x, y) = 2(x+3y), si riporti il valore di It(f ).

a = 0;
b = 1;
c = 0;
d = 1;

f = @(x, y) 2^(x + 3 * y);

It = (b - a) * (d - c) / 4 * (f(a, c) + f(a, d) + f(b, c) + f(b, d));

disp(It);