function [t_h,u_h] = rk4(f,t_max,y_0,h)

%[t_h,u_h]=rk4(f,t_max,y_0,h)
%
% Risolve il problema di Cauchy
%
% y'=f(t,y)
% y(0)=y_0
%
% utilizzando il metodo di Runge-Kutta di ordine 4.
%
% Input:
% -> f: function che descrive il problema di Cauchy (dichiarata ad esempio tramite
%       inline o @) deve ricevere in ingresso due argomenti: f=f(t,y)
% -> t_max: l'istante finale dell' intervallo temporale di soluzione
%           (l'istante iniziale e' t_0=0)
% -> y_0: il dato iniziale del problema di cauchy: y(t=0)=dato_iniziale
% -> h: l'ampiezza del passo di discretizzazione temporale.
%
% Output:
% -> t_h: vettore contenente gli istanti in cui si calcola la soluzione discreta
% -> u_h: la soluzione discreta calcolata nei nodi temporali t_h



% vettore degli istanti in cui risolvo la edo
t0=0;
t_h=t0:h:t_max;

% inizializzo il vettore che conterra' la soluzione discreta
N_istanti=length(t_h);
u_h=zeros(1,N_istanti);

u_h(1)=y_0;

% ciclo iterativo per calcolare la soluzione
for i=2:N_istanti
    k_1 = f (t_h (i-1), u_h (i-1));
    k_2 = f (t_h (i-1) + 0.5 * h, u_h (i-1) + 0.5 * h * k_1);
    k_3 = f (t_h (i-1) + 0.5 * h, u_h (i-1) + 0.5 * h * k_2);
    k_4 = f (t_h (i-1) + h, u_h (i-1) + k_3 * h);
    
    u_h (i) = u_h (i-1) + 1/6 * (k_1 + 2 * k_2 + 2 * k_3 + k_4) * h;
end
