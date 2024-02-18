function h = hashFunction(chave, index, n)
    % Definindo um vetor com todas as sementes
    seeds = [2, 200, 1740, 5187, 5812, 1321, 3123, 623, 231, 652]; 
    % Obtendo a semente para o índice atual
    seed = seeds(index);

    h = DJB31MA(chave, seed);
    h = mod(h, n) + 1; % Garante que o hash esteja dentro do intervalo
end

