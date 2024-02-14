T = [0.32 0.1750 0.2 0.2 0.2
     0.17 0.3    0.2 0.2 0.2
     0.17 0.1750 0.2 0.2 0.2
     0.17 0.1750 0.2 0.2 0.2
     0.17 0.1750 0.2 0.2 0.2]; %Cinema, Culinária, Desporto, História, Geografia

%% c)
x0 = [0.2;0.2;0.2;0.2;0.2];
T4 = T^(4-1) * x0;

disp("Probabilidade do quarto tema escolhido ser Desporto")
disp(T4(3))

%% d)
Tlim = T^100*x0;

disp("Probabilidade limite do tema escolhido ser História")
disp(Tlim(4))

%% e)
x0 = [0;0;0;1;0];
T2 = T*x0;

T3 = T^2*x0;

T6 = T^5*x0;

T7 = T^6*x0;

e = T2(3) * T3(3) * T6(1) * T7(2);

disp("Probabilidade da sessão")
disp(e)