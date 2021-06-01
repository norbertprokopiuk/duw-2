function [] = LVADowolnyPunkt( plot_type, plot_cord, body, rKloc, Q, DQ, D2Q, calc_done, T, timespan )%% Zadanie po�o�enia punktu, kt�rego po�o�enie b�dzie obliczane
    %body = 4; % Numer cz�onu, z kt�rym zwi�zany b�dzie punkt
    %rKloc = [0.35; -0.15]; % Po�o�enie punktu w lokalnym uk�adzie
    %plot_type = 3;
    %plot_cord = 1;
    % plot_type = 0 - brak wypluwania wykresu
    % plot_type = 1 - po�o�enia
    % plot_type = 2 - pr�dko�ci
    % plot_type = 3 - przy�pieszenia

    % plot_cord = 1 - wspl. x
    % plot_cord = 2 - wspl. y

    % Przed obliczeniem po�o�enia punktu w og�le nale�y wykona?obliczenia
    % dynamiki mechanizmu (SuperSkrypt) - ten skrypcik nie sprawdza, czy
    % Q,DQ,D2Q w og�le istniej?

    %% Obliczenia
    if( calc_done == 1 )
        for time=1:length(T)

        %IIrK(1:2,time) = [(3*body-2,time);Y(3*body-1,time)]+RotMat(Y(3*body,time))*rKloc;
        IIrK(1:2,time) = [Q(3*body-2,time);Q(3*body-1,time)]+RotMat(Q(3*body,time))*rKloc;

        IIrdotK(1:2,time) = [DQ(3*body-2,time);DQ(3*body-1,time)] + Omega()*RotMat(Q(3*body,time))*rKloc*DQ(12,time);

        IIrddotK(1:2,time) = [D2Q(3*body-2,time);D2Q(3*body-1,time)] - RotMat(Q(3*body,time))*rKloc*DQ(3*body,time)*DQ(3*body,time)...
            + Omega()*RotMat(Q(3*body,time))*rKloc*D2Q(3*body,time);
        end
    else
        error('Obliczenia nie zostaly jeszcze wykonane!');
    end

    %% Rysowanie wykres�w 
    if( plot_type == 3 )
        if ( plot_cord == 1 )        
            plot( timespan, IIrddotK( 1 , : )  );
        elseif( plot_cord == 2 )
            plot( timespan, IIrddotK( 2 , : )  );
        else
            error('Prosz? poda? poprawne zmienne wej?ciowe!');
        end
    elseif( plot_type == 2 )
        if ( plot_cord == 1 )        
            plot( timespan, IIrdotK( 1 , : )  );
        elseif( plot_cord == 2 )
            plot( timespan, IIrdotK( 2 , : )  );
        else
            error('Prosz? poda? poprawne zmienne wej?ciowe!');
        end
    elseif( plot_type == 1 )
        if ( plot_cord == 1 )        
            plot( timespan, IIrK( 1 , : )  );
        elseif( plot_cord == 2 )
            plot( timespan, IIrK( 2 , : )  );
        else
            error('Prosz? poda? poprawne zmienne wej?ciowe!');
        end
    else
        error('Prosz? poda? poprawne zmienne wej?ciowe!');
    end
end