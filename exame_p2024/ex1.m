clear all

% a)
T = [0  0.8    0  0  0
     0    0  0.8  0  0
     1    0    0  0  0
     0  0.2    0  1  0
     0    0  0.2  0  1];

% b)
x0 = [0;0.8;0;0;0.2];
T6 = T^(6-1) * x0;
T6(3)


% c)
N = 1e6;

sum = 0;
cincoabsorvente = 0;
for i= 1:N
    state = crawl(T,3,[4 5]);
    sum = sum + length(state);
    if state(end) == 5
        cincoabsorvente = cincoabsorvente + 1;
    end
end

fprintf("Número médio de iterações antes de atingir estado absorvente: %f\n", sum/N)


% d)
fprintf("A probabilidade da absorção se dar no 5 é %f\n", cincoabsorvente/N)

