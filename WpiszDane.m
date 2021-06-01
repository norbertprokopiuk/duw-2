

Bezwladnosci = struct('m',{},... % masa czlonu
    'Iz',{}); % moment bezwladnosci Izz

Sprezyny = struct('k',{},... % sztywnosc sprezyny
    'c',{},... % tlumienie w sprezynie
    'bodyi',{},... % numer pierwszego ciala przylozenia sprezyny
    'bodyj',{},... % numer drugiego ciala przylozenia sprezyny
    'sA',{},... % punkt przylozenia sprezyny do ciala i w i-tym ukladzie lokalnym
    'sB',{},... % punkt przylozenia sprezyny do ciala j w j-tym ukladzie lokalnym
    'd0',{}) % dlugosc swobodna sprezyny

Sily = struct('F',{},... % wektor przylozonej sily
    'bodyi',{},... % numer ciala, do ktorego przylozono sile
    'sA',{}) % punkt przylozenia sily do ciala i w i-tym ukladzie lokalnym



NB = 10; % 
Bezwladnosci(1) = cell2struct({60, 3.6}', fieldnames(Bezwladnosci));
Bezwladnosci(2) = cell2struct({50, 4}', fieldnames(Bezwladnosci)); 
Bezwladnosci(3) = cell2struct({90, 2}', fieldnames(Bezwladnosci));  
Bezwladnosci(4) = cell2struct({280, 40}', fieldnames(Bezwladnosci));
Bezwladnosci(5) = cell2struct({15, 0.5}', fieldnames(Bezwladnosci)); 
Bezwladnosci(6) = cell2struct({4, 0.2}', fieldnames(Bezwladnosci));
Bezwladnosci(7) = cell2struct({6, 0.2}', fieldnames(Bezwladnosci)); 
Bezwladnosci(8) = cell2struct({6, 0.2}', fieldnames(Bezwladnosci)); 
Bezwladnosci(9) = cell2struct({5, 0.2}', fieldnames(Bezwladnosci)); 
Bezwladnosci(10) = cell2struct({5, 0.2}', fieldnames(Bezwladnosci)); 




NS = 2; 

Sprezyny(1) = cell2struct({5e5, 1e3, 7, 8, [0.15; -0.6], [-0.15; 0.6], sqrt(0.68)}', fieldnames(Sprezyny)); 
Sprezyny(2) = cell2struct({2e5, 2e3, 9, 10, [0.45; -0.15], [-0.45; 0.15], sqrt(0.4)}', fieldnames(Sprezyny)); 


NF = 1; 

theta = 225;
P = 1000;

Sily(1) = cell2struct({[1000*cosd(theta); 1000*sind(theta)], 1, [-0.1; 0.1]}', fieldnames(Sily)); % jedyna sila, lokalny uklad wiec k - c1
