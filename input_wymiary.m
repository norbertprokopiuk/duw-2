theta = 225;
FFF = 100;

%% Szablon struktury
% Bezwladnosci = struct('m',{},... % masa cz這nu (m)
%     'Iz',{}); % moment bezw豉dno�ci cz這nu wzgl璠em osi z (I_z)

% Sprezyny = struct('k',{},... % sztywnosc sprezyny
%     'c',{},... % tlumienie w sprezynie
%     'bodyi',{},... % numer pierwszego ciala przylozenia sprezyny
%     'bodyj',{},... % numer drugiego ciala przylozenia sprezyny
%     'sA',{},... % punkt przylozenia sprezyny do ciala i w i-tym ukladzie lokalnym
%     'sB',{},... % punkt przylozenia sprezyny do ciala j w j-tym ukladzie lokalnym
%     'd0',{}) % dlugosc swobodna sprezyny

% Sily = struct('F',{},... % wektor przylozonej sily
%     'bodyi',{},... % numer ciala, do ktorego przylozono sile
%     'sA',{}) % punkt przylozenia sily do ciala i w i-tym ukladzie lokalnym

%% Masy i momenty bezw豉dno�ci cz這n闚 mechanizmu

NoB = 10; % Liczba cz這n闚 mechanizmu (Number of Bodies)

Bezwladnosci(1) = cell2struct({60, 3.6}', fieldnames(Bezwladnosci)); % cz這n 1
Bezwladnosci(2) = cell2struct({50, 4}', fieldnames(Bezwladnosci)); % cz這n 2
Bezwladnosci(3) = cell2struct({90, 2}', fieldnames(Bezwladnosci)); % cz這n 3
Bezwladnosci(4) = cell2struct({280, 40}', fieldnames(Bezwladnosci)); % cz這n 4
Bezwladnosci(5) = cell2struct({15, 0.5}', fieldnames(Bezwladnosci)); % cz這n 5
Bezwladnosci(6) = cell2struct({4, 0.2}', fieldnames(Bezwladnosci)); % cz這n 6
Bezwladnosci(7) = cell2struct({6, 0.2}', fieldnames(Bezwladnosci)); % cz這n 7
Bezwladnosci(8) = cell2struct({6, 0.2}', fieldnames(Bezwladnosci)); % cz這n 8
Bezwladnosci(9) = cell2struct({5, 0.2}', fieldnames(Bezwladnosci)); % cz這n 9
Bezwladnosci(10) = cell2struct({5, 0.2}', fieldnames(Bezwladnosci)); % cz這n 10


%% Parametry fizyczne spr篹yn

NoS = 2; % Number of Springs

Sprezyny(1) = cell2struct({5e5, 1e3, 7, 8, [0.15; -0.6], [-0.15; 0.6], sqrt(0.68)}', fieldnames(Sprezyny)); % sprezyna 1  GH
Sprezyny(2) = cell2struct({2e5, 2e3, 9, 10, [0.45; -0.15], [-0.45; 0.15], sqrt(0.4)}', fieldnames(Sprezyny)); % sprezyna 2 MN


%% Si造 skupione przy這穎ne do mechanizmu

NoF = 1; % Number of Forces

Sily(1) = cell2struct({[1000*cosd(theta); 1000*sind(theta)], 1, [-1.3; 0.7]}', fieldnames(Sily)); % jedyna sila
