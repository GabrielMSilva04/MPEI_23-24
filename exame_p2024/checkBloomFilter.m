function nAval = checkBloomFilter(bloomFilter, key, k)
    contagens = zeros(1, k);
    % aplicar a função de dispersão (hash) ao elemento
    n = length(bloomFilter);

    out = kHashValues(key,k);
    out = mod(out, n) + 1;
    
    % contagem para cada função de hash
    for i = 1:k
        contagens(i) = bloomFilter(out(i));
    end
    % a estimativa é o mínimo das contagens coletadas
    nAval = min(contagens);
end