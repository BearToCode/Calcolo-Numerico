function [t_h,u_h,vett_it_newton] = eulerbkw_newton(f, df_du, t_max, valore_iniziale, delta_t)
% [t_h,u_h,vett_it_newton]=eulerbkw_newton (f, df_du, t_max, valore_iniziale, delta_t)
%
% Metodo di Eulero all'indietro per la soluzione di equazioni differenziali
% ordinarie con metodo di Newton per il calcolo della soluzione ad ogni
% step
%
% Parametri di ingresso:
%
% f                 funzione di t, u associata al problema di Cauchy
% df_du             derivata di f rispetto a u (è funzione di t e u)
% t_max             estremo di integrazione
% valore_iniziale   valore della soluzione al tempo iniziale t0 = 0
% delta_t           passo di integrazione
%
%
% Parametri di uscita:
%
% t_h               vettore dei tempi in cui la soluzione viene calcolata
% u_h               vettore delle soluzioni calcolate in t_h
% vett_it_newton    vettore delle iterazioni del metodo di Newton ad ogni
%                   passo

t0=0;

t_h=t0:delta_t:t_max;

% inizializzo il vettore che conterra' la soluzione discreta

N_istanti=length(t_h);

u_h=zeros(1,N_istanti);

u_h(1)=valore_iniziale;

% parametri per le iterazioni di punto fisso
N_max=100;
toll=1e-5;

vett_it_newton=zeros(1,N_istanti);


for it=2:N_istanti
    
    % preparo le variabili per le sottoiterazioni
    
    u_old=u_h(it-1);
    t_newton=t_h(it);
    
    F=@(u) u_old + delta_t * f( t_newton, u) - u;
    dF = @(u) delta_t * df_du (t_newton, u) - 1;
    
    % sottoiterazioni
    
    [u_newton, it_newton] = newton (u_old, N_max, toll, F, dF);
    
    u_h(it)=u_newton(end);
    
    % tengo traccia dei valori di it_newton per valutare la convergenza
    % delle iterazioni di punto fisso
    vett_it_newton(it)=it_newton;
    
end

