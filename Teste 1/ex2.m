load("L.mat");

%% a)
N = length(L);
sumL = sum(L);
dead_ends = sumL == 0;
disp("Dead-ends:")
for i=1:N
    if dead_ends(i) == 1
        disp(i)
    end
end

%% b)
H=zeros(N);
n=0;
for i=1:N
    n=sumL(i);
    if n ~= 0
        H(:,i)=L(:,i)/n;
    end
end

%% c)
b = 0.8;
A = (b*H+(1-b)*(ones(N)/N))./N;

%% d)
exato=H/N;

%% e)
disp("pageranks maiores que 0.015")
for j=1:N
    Prank_exato = sum(exato(j,:));
    Prank_Google = sum(A(j,:));
    if Prank_Google >= 0.015
        disp(j)
    end
end