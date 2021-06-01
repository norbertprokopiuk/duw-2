clc; clear all;

tstart = 0;
tstop = 5;
dt = 0.01;
time = tstart:dt:tstop;



% Wczytanie wi�z�w opisuj�cych mechanizm
WpiszPary;
WpiszDane;
rows=length(Wiezy)*2; %ilo�� wierszy w r�wnaniu wi�z�w - s� tylko kinematyczne


M = Mas(Bezwladnosci, NB);

q0 = Czlony; % Pocz�tkowe po�o�enia
qdot0 = zeros(size(q0)); % Pocz�tkowe pr�dko�ci
Y0 = [q0; qdot0]; % Wektor po�o�e� i pr�dko�ci



OPTIONS = odeset('RelTol', 1e-6, 'AbsTol', 1e-9);
[T,Y]=ode45(@(t,Y) WyzYdot(t,Y,Wiezy,rows,M, NB, Bezwladnosci, NS, Sprezyny, NF, Sily),time,Y0,OPTIONS);
Y = Y';       
Ydot = zeros(size(Y));

for i=i:length(T)
	Ydot(:,i) = WyzYdot( T(i), Y(:,i), Wiezy,rows,M, NB, Bezwladnosci, NS, Sprezyny, NF, Sily );
end



Q = [ Y( 1:3*NB , : )];
DQ = [ Y( 3*NB+1:6*NB , : )];
D2Q = [ Ydot( 3*NB+1:6*NB , : )];


% 
% plot(T,Q(13,:))
% hold
% plot(T,Q(14,:))
% grid on
% figure(2)
% plot(T,DQ(13,:))
% hold
% 
% plot(T,DQ(14,:))
% grid on
% figure(3)
% plot(T,DQ(15,:))
% figure(4)
% plot(T,D2Q(13,:))
% hold
% plot(T,D2Q(14,:))
% grid on
% figure(5)
% plot(T,D2Q(15,:))


 