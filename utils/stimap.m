function [p,c]=stimap(xvect)
%
% [p,c]=stimap(xvect)
%
% Stima ordine e fattore di abbattimento di un metodo 
% iterativo per il calcolo degli zeri di una funzione 
% utilizzando le seguenti formule :
%          
%        | x_(k+1) - x_k |
%     ln ------------------
%        | x_k - x_(k-1) |            | x_(k+1) - x_k |
% p = --------------------------  c = ---------------------
%        | x_k - x_(k-1) |           | x_(k) - x_(k-1) |^p  
%     ln ----------------------
%        | x_(k-1) - x_(k-2) |
%
% Parametri di ingresso:
%
% xvect         Vettore contenente tutte le iterate
%
% Parametri di uscita:
%
% p          Vettore contenente tutte le stime dell'ordine calcolate
% c          Vettore contenente tutte le stime del 
%            fattore di abbattimento dell'errore

it = max(size(xvect));

for i=3:it-1
  diff1=abs(xvect(i+1)-xvect(i));
  diff2=abs(xvect(i)-xvect(i-1));
  if (diff1 == 0 || diff2 == 0) 
    disp(' Attenzione: due valori di xvect coincidenti');
    break;
  else
    num  = log(abs(xvect(i+1)-xvect(i))/abs(xvect(i)-xvect(i-1)));
    den  = log(abs(xvect(i)-xvect(i-1))/abs(xvect(i-1)-xvect(i-2)));
    p(i) = num/den;
    c(i) = abs(xvect(i+1)-xvect(i))/(abs(xvect(i)-xvect(i-1)))^p(i);
  end
end

dim = max(size(p));
if (it > 3)
  fprintf(' Ordine stimato       : %12.8f \n',p(dim) );
  fprintf(' Fattore di riduzione : %12.8f \n',c(dim) );  
else
  disp(' Numero di iterazioni insufficiente !!!')
end
return

% Spiegazione. 
%-------------
% Si ponga e_k = |x_k - alfa|. Se per un metodo numerico iterativo vale asintoticamente
% e_k+1 = c * (e_k)^p , si dice che il metodo ha ordine di convergenza p e fattore di convergenza c.

% Illustrazione della stima.
%---------------------------
% Si ha:  e_k+1/(e_k)^p = e_k /(e_k-1)^p, quindi e_k+1/e_k = (e_k / e_k-1)^p, quindi
% p= log_{e_k/e_k-1}(e_k+1/e_k) = ln(e_k+1/e_k)/ln(e_k/e_k-1).
% Quindi approssimo e_k con x_k+1 - x_k.
