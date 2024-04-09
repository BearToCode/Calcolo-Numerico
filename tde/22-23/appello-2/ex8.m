% Si vuole approssimare lo zero della funzione f (x) = e^sin(x) − 2 nell’intervallo 
% I =[ 1/2 , 2 ] con il metodo di bisezione. Si stimi, senza applicare il metodo, qual è
% il numero minimo di iterazioni che garantisce un errore inferiore a 10−5 a partire
% dall’intervallo I.

a = 1/2;
b = 2;
tol = 10^-5;

nmax = ceil(log2((b-a) / tol) - 1);
disp(nmax);