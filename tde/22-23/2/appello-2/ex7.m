clear; clc;

% Si consideri il metodo di Crank-Nicolson per l’approssimazione di un sistema di
% equazioni differenziali ordinarie lineari a coefficienti costanti, nella forma
% y′(t) = Ay(t) + g(t), t ∈ (0, +∞)
% y(0) = y0
% Quale o quali tra le seguenti affermazioni sono vere?
% 1. Il metodo è incondizionatamente assolutamente stabile per qualsiasi scelta
% di h > 0 e di y0 solo se A è simmetrica.
% 2. Se gli autovalori di A hanno tutti parte reale negativa, il metodo `e assolu-
% tamente stabile solo se h è “sufficientemente” piccolo.
% 3. Il metodo è consistente e zero stabile .
% 4. Se per h1 = 0.1 si ottiene un errore numerico pari a e1 = 10−2, quando
% h2 = 0.025 si ha che l’errore è pari a e2 = 6.25 · 10−4.

% 1: falsa, il metodo di Crank-Nicolson è incondizionatamente assolutamente stabile solo per lambda(A) con
%    parte reale negativa
% 2: falsa, se gli autovalori sono tutti negativi il metodo è incondizionatamente assolutamente stabile,
%    ovvero non dipende da h
% 3: vera, poiché il metodo è consistente e convergente => zero stabile
% 4: vera, poiché si ha ordine di convergenza 2