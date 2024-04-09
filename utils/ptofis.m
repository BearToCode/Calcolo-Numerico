function [succ,it] = ptofis(x0,phi,nmax,toll,a,b)
%
% [succ,it] = ptofis(x0,phi,nmax,toll,[a b]);
%
% --------Parametri di ingresso:
% x0      Punto di partenza
% phi     Funzione di punto fisso (definita inline o anonimous)
% nmax    Numero massimo di iterazioni
% toll    Tolleranza sul test d'arresto
% a b     Estremi dell'intervallo di esplorazione, SOLO PER OUTPUT GRAFICO
%
% --------Parametri di uscita:
% xvect   Vett. contenente tutte le iterate calcolate
%         (l'ultima componente e' la soluzione)
% it      Iterazioni effettuate
%

x = linspace(a,b,1000);
plot(x,x,'g',x,phi(x),'b',x,zeros(size(x)),'k')
hold on

succ = x0;
x = x0;
x = phi(x);
succ = [succ; x];
plot([x0 x0],[0 x],'r')
plot([x0 x],[x x],'r')
err =toll+1; 
it =1;
while (err >= toll && it < nmax)
    xold = x;
    x = phi(x);
    succ = [succ; x];
    plot([xold xold],[xold x], 'r')
    plot([xold x],[x x], 'r')
    err = abs(x-xold);
    it = it + 1;
end
hold off
axis([a,b,a,b]) 
if it < nmax %ovvero ho convergenza
    fprintf('\n Numero di Iterazioni : %d \n', it);
    fprintf(' Radice calcolata : %12.8f \n\n',succ(it+1));
else
    fprintf('\n Numero massimo di iterazioni raggiunto \n\n');
end

