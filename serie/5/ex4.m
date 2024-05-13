clear; clc; close all;

stress = [0.1800 0.3000 0.5000 0.6000 0.7200 0.7500 0.8000 0.9000 1.0000];
def = [0.0005 0.0010 0.0013 0.0015 0.0020 0.0045 0.0060 0.0070 0.0085];

stress_values = linspace(min(stress), max(stress), 1000);

grid on;

%% interpolazione polinomiale di Lagrange
p = polyfit(stress, def, length(stress)-1);
def_values_lag = polyval(p, stress_values);

figure;
plot(stress, def, 'o', 'DisplayName', 'Dati sperimentali');
hold on;
plot(stress_values, def_values_lag, 'DisplayName', 'Interpolazione polinomiale di Lagrange', 'LineWidth', 3);
legend;

%% interpolazione polinomiale composita lineare (interpolazione lineare a tratti)
def_values_lin = interp1(stress, def, stress_values);

figure;
plot(stress, def, 'o', 'DisplayName', 'Dati sperimentali');
hold on;
plot(stress_values, def_values_lin, 'DisplayName', 'Interpolazione lineare a tratti', 'LineWidth', 3);
legend;

%% spline cubica naturale interpolante
def_values_spln = cubicspline(stress, def, stress_values);

figure;
plot(stress, def, 'o', 'DisplayName', 'Dati sperimentali');
hold on;
plot(stress_values, def_values_spln, 'DisplayName', 'Spline cubica naturale interpolante', 'LineWidth', 3);
legend;

%% spline cubica interpolante con condizioni di chiusura “not-a-knot”
def_values_nak = spline(stress, def, stress_values);

figure;
plot(stress, def, 'o', 'DisplayName', 'Dati sperimentali');
hold on;
plot(stress_values, def_values_nak, 'DisplayName', 'Spline cubica interpolante con condizioni di chiusura “not-a-knot”', 'LineWidth', 3);
legend;

%% approssimazioni nel senso dei minimi quadrati di grado 1, 2 e 4

% approx1 = regression(stress', def', 1);
% approx2 = regression(stress', def', 2);
% approx4 = regression(stress', def', 4);

% def_values1 = polyval(approx1, stress_values);
% def_values2 = polyval(approx2, stress_values);
% def_values4 = polyval(approx4, stress_values);

def_values_app1 = polyval(polyfit(stress, def, 1), stress_values);
def_values_app2 = polyval(polyfit(stress, def, 2), stress_values);
def_values_app4 = polyval(polyfit(stress, def, 4), stress_values);

figure;
plot(stress, def, 'o', 'DisplayName', 'Dati sperimentali');
hold on;
plot(stress_values, def_values_app1, 'DisplayName', 'Approssimazione nel senso dei minimi quadrati di grado 1', 'LineWidth', 3);
plot(stress_values, def_values_app2, 'DisplayName', 'Approssimazione nel senso dei minimi quadrati di grado 2', 'LineWidth', 3);
plot(stress_values, def_values_app4, 'DisplayName', 'Approssimazione nel senso dei minimi quadrati di grado 4', 'LineWidth', 3);
legend;

%% Rappresentare graficamente le singole funzioni interpolanti ed approssimanti a confronto
% con i dati sperimentali;

figure;
plot(stress, def, 'o', 'DisplayName', 'Dati sperimentali');
hold on;
plot(stress_values, def_values_lag, 'DisplayName', 'Interpolazione polinomiale di Lagrange', 'LineWidth', 3);
plot(stress_values, def_values_lin, 'DisplayName', 'Interpolazione lineare a tratti', 'LineWidth', 3);
plot(stress_values, def_values_spln, 'DisplayName', 'Spline cubica naturale interpolante', 'LineWidth', 3);
plot(stress_values, def_values_nak, 'DisplayName', 'Spline cubica interpolante con condizioni di chiusura “not-a-knot”', 'LineWidth', 3);
% plot(stress_values, def_values_app1, 'DisplayName', 'Approssimazione nel senso dei minimi quadrati di grado 1', 'LineWidth', 3);
% plot(stress_values, def_values_app2, 'DisplayName', 'Approssimazione nel senso dei minimi quadrati di grado 2', 'LineWidth', 3);
plot(stress_values, def_values_app4, 'DisplayName', 'Approssimazione nel senso dei minimi quadrati di grado 4', 'LineWidth', 3);
legend;
ylim([0, 0.02]);

%% Valutare, per ogni interpolante ed approssimante, la deformazione ε in corrispondenza
% di σ = 400 kgF/cm2 e σ = 650 kgF/cm2; si commentino i risultati ottenuti.

def_values_lag_400 = polyval(p, 0.4);
def_values_lag_650 = polyval(p, 0.65);

def_values_lin_400 = interp1(stress, def, 0.4);
def_values_lin_650 = interp1(stress, def, 0.65);

def_values_spln_400 = cubicspline(stress, def, 0.4);
def_values_spln_650 = cubicspline(stress, def, 0.65);

def_values_nak_400 = spline(stress, def, 0.4);
def_values_nak_650 = spline(stress, def, 0.65);

def_values_app1_400 = polyval(polyfit(stress, def, 1), 0.4);
def_values_app1_650 = polyval(polyfit(stress, def, 1), 0.65);

def_values_app2_400 = polyval(polyfit(stress, def, 2), 0.4);
def_values_app2_650 = polyval(polyfit(stress, def, 2), 0.65);

def_values_app4_400 = polyval(polyfit(stress, def, 4), 0.4);
def_values_app4_650 = polyval(polyfit(stress, def, 4), 0.65);

disp('Interpolazione polinomiale di Lagrange');
disp(['ε(400) = ', num2str(def_values_lag_400)]);
disp(['ε(650) = ', num2str(def_values_lag_650)]);
disp('Interpolazione lineare a tratti');
disp(['ε(400) = ', num2str(def_values_lin_400)]);
disp(['ε(650) = ', num2str(def_values_lin_650)]);
disp('Spline cubica naturale interpolante');
disp(['ε(400) = ', num2str(def_values_spln_400)]);
disp(['ε(650) = ', num2str(def_values_spln_650)]);
disp('Spline cubica interpolante con condizioni di chiusura “not-a-knot”');
disp(['ε(400) = ', num2str(def_values_nak_400)]);
disp(['ε(650) = ', num2str(def_values_nak_650)]);
disp('Approssimazione nel senso dei minimi quadrati di grado 1');
disp(['ε(400) = ', num2str(def_values_app1_400)]);
disp(['ε(650) = ', num2str(def_values_app1_650)]);
disp('Approssimazione nel senso dei minimi quadrati di grado 2');
disp(['ε(400) = ', num2str(def_values_app2_400)]);
disp(['ε(650) = ', num2str(def_values_app2_650)]);
disp('Approssimazione nel senso dei minimi quadrati di grado 4');
disp(['ε(400) = ', num2str(def_values_app4_400)]);
disp(['ε(650) = ', num2str(def_values_app4_650)]);
