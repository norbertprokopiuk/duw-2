% %% 
% % Utworzenie pustej struktury do przechowywania wi�z�w w postaci og�nej
% Wiezy = struct('typ',{},... % dopisanych czy kinematyczny
%     'klasa',{},... % para postepowa czy obrotowa (innych na razie nie ma)
%     'bodyi',{},... % numer pierwszego ciala
%     'bodyj',{},... % numer drugiego ciala
%     'sA',{},... % wektor sA w i-tym ukladzie
%     'sB',{},... % wektor sB w j-tym ukladzie
%     'phi0',{},... % kat phi0 (jezeli para obrotowa - nie uzywamy)
%     'perp',{},... % wersor prostopadly osi ruch (jezeli para obrotowa - nie uzywamy)
%     'fodt',{},... % funkcja od czasu dla wiezow dopisanych
%     'dotfodt',{},... % pochodna funkcji od czasu dla wiezow dopisanych
%     'ddotfodt',{}); % druga pochodna funkcji od czasu dla wiezow dopisanych
% 
% Bezwladnosci = struct('m',{},... % masa cz�onu (m)
%     'Iz',{}); % moment bezw�adno�ci cz�onu wzgl�dem osi z (I_z)
% 
% Sprezyny = struct('k',{},... % sztywnosc sprezyny
%     'c',{},... % tlumienie w sprezynie
%     'bodyi',{},... % numer pierwszego ciala przylozenia sprezyny
%     'bodyj',{},... % numer drugiego ciala przylozenia sprezyny
%     'sA',{},... % punkt przylozenia sprezyny do ciala i w i-tym ukladzie lokalnym
%     'sB',{},... % punkt przylozenia sprezyny do ciala j w j-tym ukladzie lokalnym
%     'd0',{}); % dlugosc swobodna sprezyny
% 
% Sily = struct('F',{},... % wektor przylozonej sily
%     'bodyi',{},... % numer ciala, do ktorego przylozono sile
%     'sA',{}); % punkt przylozenia sily do ciala i w i-tym ukladzie lokalnym

% Wczytanie wi�z�w opisuj�cych mechanizm
%input_wiezy;
%input_wymiary;
pobierz_dane;
% Inicjalizacja zmiennej do wyznaczania liczby r�wna� wi�z�w 
rows = 0;

%% PAUSE


for l=1:length(Wiezy)
    if(lower(Wiezy(l).typ(1)) == 'd')
        if(lower(Wiezy(l).klasa(1)) == 'o')
            rows = rows + 1;
        elseif(lower(Wiezy(l).klasa(1)) == 'p')
            rows = rows + 1;
        
        else
            error(['Blednie podana klasa dla wiezu nr ', num2str(l)]);
        end
    elseif(lower(Wiezy(l).typ(1)) == 'k')
        if(lower(Wiezy(l).klasa(1)) == 'o')
            rows = rows + 2;
        elseif(lower(Wiezy(l).klasa(1)) == 'p')
            rows = rows + 2;
        else
            error(['Blednie podana klasa dla wiezu nr ', num2str(l)]);
        end
    else
        error(['Blednie podany typ dla wiezu nr ', num2str(l)]);
    end
end

%% PAUSE

%% Ca�kowanie przy pomocy metody Rungego-Kutty rz�du 4-5

tstart = 0;
tstop = 5;
timestep = 0.001; % Paramtery czasu ca�kowania
timespan = tstart:timestep:tstop;

M = MacierzMasowa(Bezwladnosci, ilosc_cial);

q0=zeros(3*length(srodki_ciezkosci),1);
for i=0:length(srodki_ciezkosci)-1
   q0(1+i*3)= srodki_ciezkosci(i+1,1);
   q0(2+i*3)= srodki_ciezkosci(i+1,2);
   q0(3+i*3)= 0;
end
qdot0 = zeros(size(q0)); % Pocz�tkowe pr�dko�ci

Y0 = [q0; qdot0]; % Wektor, kt�ry b�dzie ca�kowany

%% PAUSE

OPTIONS = odeset('RelTol', 1e-6, 'AbsTol', 1e-9);
[T,Y]=ode45(@(t,Y) RHS(t,Y,Wiezy,rows,M, ilosc_cial, Bezwladnosci, ilosc_sprezyn, Sprezyny, ilosc_sil, Sily),timespan,Y0,OPTIONS);
    % Poniewa� macierz bezw�adno�ci nie zmienia si� w czasie, wi�c aby nie
    % oblicza� jej za ka�dym razem od nowa, jest po prostu przekazywana
    % jako argument funkcji ca�kowanej

Y = Y';    
    
timepoints = 1:( length(T) );
Ydot = zeros(size(Y));
for iter=timepoints
	Ydot(:,iter) = RHS( T(iter), Y(:,iter), Wiezy,rows,M, ilosc_cial, Bezwladnosci, ilosc_sprezyn, Sprezyny, ilosc_sil, Sily );
end

calc_done = 1;  %przekazuje informacje o tym, ze obliczenia zostaly wykonane
                %tak, by m�c odpali� LVADowolnyPunkt
                
%% PAUSE
%Porz�dkowanie danych wyj�ciowych
%Wektor po�o�e�:
Q = [ Y( 1:3*ilosc_cial , : )];
%Wektor predkosci
DQ = [ Y( 3*ilosc_cial+1:6*ilosc_cial , : )];
%Wektor przyspieszen
D2Q = [ Ydot( 3*ilosc_cial+1:6*ilosc_cial , : )];

postprocessor;

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


 