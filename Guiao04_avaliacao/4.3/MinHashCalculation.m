function SimilarUsers = MinHashCalculation(Set, k, threshold)
    Nu = length(Set); % Número de usuários
    max_movie_id = max(cellfun(@max, Set)); % O maior ID de filme
    
    % Inicializar as assinaturas MinHash para cada usuário
    user_movie_array = zeros(Nu, max_movie_id);
    
    for n = 1:Nu
        for m = 1:length(Set{n})
            user_movie_array(n,Set{n}(m)) = 1;
        end
    end
    

    % definir primo p
    ff = 1000; 
    % valor minimo do primo em max
    p = ff * max(5000 + 1,76);
    p = p + ~mod(p,2); % par
    while (isprime(p) == false)
        p = p + 2;
    end

    v = randi([1,(p - 1)],1,k);
    % preencer minhash
    minHash = calcularMatrizAssinaturas(Set,v,k,p);
    

    % calcular distancia e preencher SimilarUsers
    count = 1;
    SimilarUsers = zeros(1,3);
    w = waitbar(0,'Filtering');
    for n1=1:Nu
        waitbar(n1/Nu,w);
        for n2=(n1+1):Nu
            s = 0;
            for h = 1:k
                if minHash(h,n1) == minHash(h,n2)
                    s = s + 1;
                end
            end
            s = s/k;

            if (1-s) < threshold
                SimilarUsers(count,:) = [n1 n2 1-s];
                count = count + 1;
            end
        end
    end
    delete (w)
end