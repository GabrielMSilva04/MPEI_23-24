function dists = MinHashCalculation(Set, k)
    Nu = length(Set); % Número de turistas
    max_rest_id = max(cellfun(@max, Set)); % O maior ID de restaurante
    
    % Inicializar as assinaturas MinHash para cada turista
    user_rest_array = zeros(Nu, max_rest_id);
    
    for n = 1:Nu
        for m = 1:length(Set{n})
            user_rest_array(n,Set{n}(m)) = 1;
        end
    end
    

    % definir primo p
    ff = 1000; 
    % valor minimo do primo em max
    vmin = 5000;
    p = ff * max(vmin + 1,76);
    p = p + ~mod(p,2); % par
    while (isprime(p) == false)
        p = p + 2;
    end

    v = randi([1,(p - 1)],1,k);
    
    % preencer minhash
    minHash = calcularMatrizAssinaturas(Set,v,k,p);
    save("assinaturasUsers.mat","minHash");
    

    % calcular distancia e preencher array com distancias
    dists = calcularDistancias(Nu,minHash,k);
end
