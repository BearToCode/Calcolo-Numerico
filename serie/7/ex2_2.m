clear; clc;

y_exact = @(t, t0, y0, lambda) y0 * exp(lambda * (t - t0));

% 2. Risolvere il problema di Cauchy con la funzione f(t, y)  con il metodo di Eulero in avanti, scegliendo λ = 2.4, t0 = 0,
% tmax = 3, y0 = 0.1 per i valori del passo temporale h1 = 0.05 e h2 = 0.01. Rappresentare
% sullo stesso grafico le soluzioni numeriche ottenute e confrontarle con la soluzione esatta.

lambda = 2.4;
t0     = 0;
t_max  = 3;
y0     = 0.1;

f      = @(t, y) lambda * y;

h1 = 0.05;
h2 = 0.01;

[t_h1, u_h1] = eulerfwd(f, t_max, y0, h1);
[t_h2, u_h2] = eulerfwd(f, t_max, y0, h2);

t_h = 0:0.001:t_max;
y_exact_values = y_exact(t_h, t0, y0, lambda);

figure;
hold on;
plot(t_h1, u_h1);
plot(t_h2, u_h2);
plot(t_h, y_exact_values, '--');
legend('h = 0.05', 'h = 0.01', 'y(t)');
xlabel('t');
ylabel('y(t)');
title('Eulero in avanti');

% 4. Risolvere il problema (2) con il metodo
% di Eulero all’indietro, scegliendo λ = 2.4, t0 = 0, tmax = 3, y0 = 0.1 per i valori del
% passo h1 = 0.05 e h2 = 0.01. Rappresentare sullo stesso grafico le soluzioni numeriche
% ottenute e confrontarle con la soluzione esatta.

[t_h1, u_h1, iter_pf1] = eulerbkw(f, t_max, y0, h1);
[t_h2, u_h2, iter_pf2] = eulerbkw(f, t_max, y0, h2);

figure;
hold on;
plot(t_h1, u_h1);
plot(t_h2, u_h2);
plot(t_h, y_exact_values, '--');
legend('h = 0.05', 'h = 0.01', 'y(t)');
xlabel('t');
ylabel('y(t)');
title("Eulero all'indetro");

% 5. Riportare su un grafico l’andamento del numero di iterazioni impiegate dal metodo delle
% iterazioni di punto fisso per risolvere l’equazione non lineare con il metodo di Eulero
% all’indietro in funzione degli istanti temporali.

figure;
hold on;
plot(t_h1, iter_pf1);
plot(t_h2, iter_pf2);
legend('h = 0.05', 'h = 0.01');
xlabel('t');
ylabel('iterazioni');
title('Iterazioni metodo punto fisso');
hold off;

% 6. Definito eh = maxn=0,1,...,Nh |y(tn) − un|, il massimo modulo dell’errore compiuto ap-
% prossimando la soluzione esatta y(tn) con la soluzione numerica un, riportare, su un
% grafico in scala logaritmica, l’andamento di eh al variare di h, utilizzando i passi tem-
% porali h = 0.04, 0.02, 0.01, 0.005, 0.0025 per entrambi i metodi di Eulero in avanti e
% all’indietro. Si commenti il risultato ottenuto alla luce della teoria.

h_values = 0.04./2.^(0:4);
eh_eulero_fwd = zeros(1, length(h_values));
eh_eulero_bkw = zeros(1, length(h_values));

for i = 1:length(h_values)
    [t_h, u_h] = eulerfwd(f, t_max, y0, h_values(i));
    y_exact_values = y_exact(t_h, t0, y0, lambda);
    eh_eulero_fwd(i) = max(abs(y_exact_values - u_h));
    
    [t_h, u_h, ~] = eulerbkw_fixedpt(f, t_max, y0, h_values(i));
    y_exact_values = y_exact(t_h, t0, y0, lambda);
    eh_eulero_bkw(i) = max(abs(y_exact_values - u_h));
end

figure;
loglog(h_values, h_values, '--', h_values, h_values.^2, '--', h_values, eh_eulero_fwd, '-o', h_values, eh_eulero_bkw, '-o');
title('Errore massimo al variare di h');