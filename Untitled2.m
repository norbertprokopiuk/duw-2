%% Zadanie po�o�enia punktu, kt�rego po�o�enie b�dzie obliczane
body = 4; % Numer cz�onu, z kt�rym zwi�zany b�dzie punkt
rKloc = [0.35; -0.15]; % Po�o�enie punktu w lokalnym uk�adzie

% Przed obliczeniem po�o�enia punktu w og�le nale�y wykona� obliczenia
% dynamiki mechanizmu (SuperSkrypt) - ten skrypcik nie sprawdza, czy
% Q,DQ,D2Q w og�le istniej�

%% Obliczenia
for time=1:length(T)
    
IIrK(1:2,time) = [Q(3*body-2,time);Q(3*body-1,time)]+RotMat(Q(3*body,time))*rKloc;

IIrdotK(1:2,time) = [DQ(3*body-2,time);DQ(3*body-1,time)] + Omega()*RotMat(Q(3*body,time))*rKloc*DQ(12,time);

IIrddotK(1:2,time) = [D2Q(3*body-2,time);D2Q(3*body-1,time)] - RotMat(Q(3*body,time))*rKloc*DQ(3*body,time)*DQ(3*body,time)...
    + Omega()*RotMat(Q(3*body,time))*rKloc*D2Q(3*body,time);
end

%% Tu mo�na by wstawi� rysowanie wykres�w