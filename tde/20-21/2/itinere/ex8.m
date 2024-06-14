% Si consideri il seguente problema ai limiti:
% −u''(x) + η u'(x) = f(x) x ∈ (a, b),
% u(a) = u(b) = 0,
% dove η > 0. Si supponga di approssimare tale problema utilizzando il metodo delle
% differenze finite centrate con tecnica Upwind e passo di discretizzazione h > 0,
% ottenendo cos`ı la soluzione numerica {uj}N+1, j=0 nei corrispondenti nodi
% {xj}N+1, j=0 .
% Assumendo che la soluzione esatta u ∈ C4([a, b]) sia nota e che l’errore per h =
% h1 = 0.1 sia Eh1 = maxj=0,...,N +1 |u(xj ) − uj | = 2 · 10−2, si riporti il valore stimato
% dell’errore Eh2 corrispondente alla scelta h = h2 = 0.05

h1 = 0.1;
Eh1 = 2 * 10^-2;

h2 = 0.05;

% Il metodo upwind ha ordine di accuratezza 1

Eh2 = Eh1 * (h2 / h1);

disp(Eh2)