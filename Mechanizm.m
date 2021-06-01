function [T,Q,DQ,D2Q]=Mechanizm(Wiezy, rows)
% [T,Q,DQ,D2Q]=KorbWodz
% Rozwiązanie zadań kinematyki o położeniu, prędkości i przyspieszeniu 
%   dla mechanizmu korbowo-wodzikowego.
% Wyjście:
%   T   - tablica do zapisu kolejnych chwil.
%   Q   - tablica do zapisu rozwiązań zadania o położeniu w kolejnych chwilach.
%   DQ  - tablica do zapisu rozwiązań zadania o prędkości w kolejnych chwilach.
%   D2Q - tablica do zapisu rozwiązań zad. o przyspieszeniu w kolejnych chwilach.

input_wymiary;

% Przybliżenie startowe (gdy brak rozwiązania z poprzedniej chwili)

q = [-1.2; 0.6; 0;
    -0.7; 0.85; 0;
    0.4; 0.65; 0;
    -0.35; 0.4; 0;
    0.1; 0.9; 0;
    -0.4; 0.65; 0;
    0.15; 0.4; 0;
    0.25; 0; 0;
    0.05; 0.15; 0;
    0.35; 0.05; 0]; % kopia ze superskryptu_xd


qdot=zeros(size(q));
qddot=zeros(size(q));

lroz=0; % Licznik rozwiązań (służy do numerowania kolumn w tablicach z wynikami)
dt=0.01; % Odstęp pomiędzy kolejnymi chwilami

ZakresCzasu = 0:dt:5;                        % czas konca
Q = zeros(size(q,1), length(ZakresCzasu));
DQ = zeros(size(Q));
D2Q = zeros(size(Q));
T = zeros(1, size(Q,2));

% Rozwiązywanie zadań kinematyki w kolejnych chwilach t
for t=ZakresCzasu
    % Zadanie o położeniu. 
    % Przybliżeniem początkowym jest rozwiązanie z poprzedniej chwili, 
    % powiększone o składniki wynikające z obliczonej prędkości i przyspieszenia.
    q0=q+qdot*dt+0.5*qddot*dt*dt;
    q=NewtonRaphson(q0,t,Wiezy,rows); 

    % Zadanie o predkosciach
    qdot=MacierzJacobiego(q,t,Wiezy,rows)\WektorPrawychPredk(q,t,Wiezy,rows);  % Zadanie o prędkości

    % Zadanie o przyspieszeniach
    qddot=MacierzJacobiego(q,t,Wiezy,rows)\WektorGamma(q,qdot,t,Wiezy,rows);  % Zadanie o przyspieszeniu

    % Zapis do tablic gromadzących wyniki
    lroz %Wyswietlana tylko do debugowania
    lroz=lroz+1;
    T(1,lroz)=t; 
    Q(:,lroz)=q;
    DQ(:,lroz)=qdot;
    D2Q(:,lroz)=qddot;
end
