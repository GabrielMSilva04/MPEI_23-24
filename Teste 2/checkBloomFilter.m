function nAval = checkBloomFilter(bloomFilter, key, k)
    contagens = zeros(1, k);
    for i = 1:k
        % aplicar a função de dispersão (hash) ao elemento
        h = hashFunction(key, i, length(bloomFilter));
        % contagem para cada função de hash
        contagens(i) = bloomFilter(h);
    end
    % a estimativa é o mínimo das contagens coletadas
    nAval = min(contagens);
end