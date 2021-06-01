Wiezy = struct('typ',{},... % dopisanych czy kinematyczny
    'klasa',{},... % para postepowa czy obrotowa (innych na razie nie ma)
    'bodyi',{},... % numer pierwszego ciala
    'bodyj',{},... % numer drugiego ciala
    'sA',{},... % wektor sA w i-tym ukladzie
    'sB',{},... % wektor sB w j-tym ukladzie
    'phi0',{},... % kat phi0 (jezeli para obrotowa - nie uzywamy)
    'perp',{},... % wersor prostopadly osi ruchu w ukladzie jtym! (jezeli para obrotowa - nie uzywamy)
    'fodt',{},... % funkcja od czasu dla wiezow dopisanych
    'dotfodt',{},... % pochodna funkcji od czasu dla wiezow dopisanych
    'ddotfodt',{}) % druga pochodna funkcji od czasu dla wiezow dopisanych


  
 Czlony = [-1.2; 0.6; 0; % x, y fi dla 1 cz³onu
    -0.7; 0.85; 0;
    0.4; 0.65; 0;
    -0.35; 0.4; 0;
    0.1; 0.9; 0;
    -0.4; 0.65; 0;
    0.15; 0.4; 0;
    0.25; 0; 0;
    0.05; 0.15; 0;
    0.35; 0.05; 0]
  

Obrotowe= [1   4   -1.2   0.30;
1   2   -1.1   0.90;
2   5   -0.4   0.90;
4   6   -0.4   0.50;
2   6   -0.4   0.80;
5   3   0.60   0.90;
3   7   0.10   0.60;
0   8   0.30   -0.2;
4   9   -0.1   0.20;
0   10   0.5   0;
3   4   0.50   0.50;
0   3   0.40   0.50;];

Postepowe=[9 10    -0.1   0.2  0.5   0 ;
  7  8   0.1   0.6 0.3   -0.2;];

    
  %Wczytanie par postêpowych - rozdzia³ 2.3
  
n=1;
for  i = 1:length(Obrotowe)
    
        tmp = Obrotowe(i,:)
        Czlon1 = tmp(1); Czlon2 = tmp(2);
        Polozenie = [tmp(3); tmp(4)];

        if(Czlon1==0)
            q1 = [0;0];
        else
            q1 = [Czlony(3*Czlon1-2);Czlony(3*Czlon1-1)];
          
        end
        
        if(Czlon2==0)
            q2 = [0;0]; 
        else
            q2 =[Czlony(3*Czlon2-2);Czlony(3*Czlon2-1)];
        end
        
       ssA= Polozenie-q1
       ssB= Polozenie-q2

    
Wiezy(n) = cell2struct(...
    {'kinematyczny', 'obrotowy',Czlon1, Czlon2,ssA,ssB , [], [], [], [], []}', ...
    fieldnames(Wiezy)); 
n=n+1;
end
 

 for i=1:2
     
      tmp =  Postepowe(i,:);
        Czlon1 = tmp(1); Czlon2 = tmp(2);
        Polozenie1 = [tmp(3); tmp(4)]
        Polozenie2 = [tmp(5); tmp(6)]

       if(Czlon1==0)
            q1 = [0;0]; f1 = 0;
        else
            q1 = [Czlony(3*Czlon1-2);Czlony(3*Czlon1-1)];
          
        end
        
        if(Czlon2==0)
            q2 = [0;0]; f2 = 0;
        else
            q2 =[Czlony(3*Czlon2-2);Czlony(3*Czlon2-1)];
        end
   
    

    Uv = q1-q2;
    Uv = Uv/norm(Uv)
    Uv=[Uv(2);-Uv(1)]
    ssA=(Polozenie1-q1)
    ssB=(Polozenie2-q2)
    
    
    
   Wiezy(n) = cell2struct(...
    {'kinematyczny', 'postepowy', Czlon1, Czlon2, ssA,ssB, 0, Uv, [], [], []}', ...
    fieldnames(Wiezy)); % Punkt HG  
     
 n=n+1;    
 end

% Wiezy(1) = cell2struct(...
%     {'kinematyczny', 'obrotowy', 1, 4,  [0;-0.3], [-0.85;-0.1], [], [], [], [], []}', ...
%     fieldnames(Wiezy)); % Punkt A
% Wiezy(2) = cell2struct(...
%     {'kinematyczny', 'obrotowy', 1, 2,  [0.1; 0.3], [-0.4; 0.05], [], [], [], [], []}', ...
%     fieldnames(Wiezy)); % Punkt B
% Wiezy(3) = cell2struct(...
%     {'kinematyczny', 'obrotowy', 2, 5,  [0.3; 0.05], [-0.5; 0], [], [], [], [], []}', ...
%     fieldnames(Wiezy)); % Punkt J
% Wiezy(4) = cell2struct(...
%     {'kinematyczny', 'obrotowy', 4, 6,  [-0.05; 0.1], [0; -0.15], [], [], [], [], []}', ...
%     fieldnames(Wiezy)); % Punkt D
% Wiezy(5) = cell2struct(...
%     {'kinematyczny', 'obrotowy', 2, 6,  [0.3; -0.05], [0; 0.15], [], [], [], [], []}', ...
%     fieldnames(Wiezy)); % Punkt E
% Wiezy(6) = cell2struct(...
%     {'kinematyczny', 'obrotowy', 5, 3,  [0.5; 0], [0.2; 0.25], [], [], [], [], []}', ...
%     fieldnames(Wiezy)); % Punkt F
% Wiezy(7) = cell2struct(...
%     {'kinematyczny', 'obrotowy', 3, 7,  [-0.3; -0.05], [-0.05; 0.2], [], [], [], [], []}', ...
%     fieldnames(Wiezy)); % Punkt G
% Wiezy(8) = cell2struct(...
%     {'kinematyczny', 'obrotowy', 0, 8,  [0.3; -0.2], [0.05; -0.2], [], [], [], [], []}', ...
%     fieldnames(Wiezy)); % Punkt H
% Wiezy(9) = cell2struct(...
%     {'kinematyczny', 'obrotowy', 4, 9,  [0.25; -0.2], [-0.15; 0.05], [], [], [], [], []}', ...
%     fieldnames(Wiezy)); % Punkt M
% Wiezy(10) = cell2struct(...
%     {'kinematyczny', 'obrotowy', 0, 10,  [0.5; 0], [0.15; -0.05], [], [], [], [], []}', ...
%     fieldnames(Wiezy)); % Punkt N
% Wiezy(11) = cell2struct(...
%     {'kinematyczny', 'obrotowy', 3, 4,  [0.1; -0.15], [0.85; 0.1], [], [], [], [], []}', ...
%     fieldnames(Wiezy)); % Punkt O
% Wiezy(12) = cell2struct(...
%     {'kinematyczny', 'obrotowy', 0, 3,  [0.4; 0.5], [0; -0.15], [], [], [], [], []}', ...
%     fieldnames(Wiezy)); % Punkt R
% Wiezy(13) = cell2struct(...
%     {'kinematyczny', 'postepowy', 9, 10,  [-0.15; 0.05], [0.15; -0.05], 0, [1;3]/sqrt(10), [], [], []}', ...
%     fieldnames(Wiezy)); % Punkt MN
% Wiezy(14) = cell2struct(...
%     {'kinematyczny', 'postepowy', 7, 8,  [-0.05; 0.2], [0.05; -0.2], 0, [4;1]/sqrt(17), [], [], []}', ...
%     fieldnames(Wiezy)); % Punkt HG