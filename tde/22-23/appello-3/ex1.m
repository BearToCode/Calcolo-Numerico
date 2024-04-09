% Si determini la distanza fra il numero 8 (in base decimale) e il suo successivo
% rappresentato nell’insieme F(2, 5, −4, 4). Si riporti il risultato in base decimale.
sign = 0;
base = 2;

curr = floatingpoint(sign, [1 0 0 0, 0], base, 4);
next = floatingpoint(sign, [1 0 0 0, 1], base, 4);

diff = next - curr;

disp(diff);