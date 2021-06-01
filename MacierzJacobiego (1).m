function [ Jacob ] = MacierzJacobiego( q, ~, Wiezy, rows )


m = 1; 

Jacob = zeros(rows, size(q,1));

for l=1:length(Wiezy) 
        if(lower(Wiezy(l).klasa(1)) == 'o')
            if(Wiezy(l).bodyi>0)
                Jacob(m:(m+1), (3*Wiezy(l).bodyi - 2):(3*Wiezy(l).bodyi - 1)) = eye(2);
                Jacob(m:m+1, 3*Wiezy(l).bodyi) = Omega()*...
                    RotMat(q_phi(q, Wiezy(l).bodyi))*Wiezy(l).sA;
            end
            if(Wiezy(l).bodyj>0)
                Jacob(m:m+1, (3*Wiezy(l).bodyj - 2):(3*Wiezy(l).bodyj - 1)) = -eye(2);
                Jacob(m:m+1, 3*Wiezy(l).bodyj) = - Omega()*...
                    RotMat(q_phi(q, Wiezy(l).bodyj))*Wiezy(l).sB;
            end
            m = m+2;
        elseif(lower(Wiezy(l).klasa(1)) == 'p')
            if(Wiezy(l).bodyi>0)
                Jacob(m, 3*Wiezy(l).bodyi) = 1;
            end
            if(Wiezy(l).bodyj>0)
                Jacob(m, 3*Wiezy(l).bodyj) = - 1;
            end
            m = m+1;
            
            tmp = (RotMat(q_phi(q, Wiezy(l).bodyj)) * Wiezy(l).perp )';
            if(Wiezy(l).bodyi>0)
                Jacob(m, (3*Wiezy(l).bodyi - 2):(3*Wiezy(l).bodyi - 1)) = - tmp;
                Jacob(m, 3*Wiezy(l).bodyi) = -tmp * Omega() * ...
                    RotMat(q_phi(q, Wiezy(l).bodyi))*Wiezy(l).sA;
            end
            if(Wiezy(l).bodyj>0)
                Jacob(m, (3*Wiezy(l).bodyj - 2):(3*Wiezy(l).bodyj - 1)) = tmp;
                Jacob(m, 3*Wiezy(l).bodyj) = -tmp * Omega() * ...
                    (q_r(q, Wiezy(l).bodyj) - q_r(q, Wiezy(l).bodyi) - ...
                    RotMat(q_phi(q, Wiezy(l).bodyi))*Wiezy(l).sA);
            end
            m = m+1;
        else
            error(['Blednie podana klasa dla wiezu nr ', num2str(l)]);
        end

end

wspolczynnik_uwarunkowania = cond(Jacob);
if (wspolczynnik_uwarunkowania > (1/1e-6))
    error('Macierz Jacobiego osobliwa');
end


end

