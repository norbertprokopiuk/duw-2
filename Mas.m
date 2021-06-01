function [ M ] = Mas( Bezwladnosci, NB )

M = zeros(3*NB);

for i=1:NB
    M(3*i-2, 3*i-2) = Bezwladnosci(i).m;
    M(3*i-1, 3*i-1) = Bezwladnosci(i).m;
    M(3*i, 3*i) = Bezwladnosci(i).Iz;
end

end

