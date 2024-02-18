function sortedDists = StringsSimilares(nomes,string,threshold)
    k = 200; % n de funcoes hash
    tamanhoShingle = 2;
    shingles = {};
    count = 1;
    nomes = [nomes; string];
    for s=1:length(nomes)
        nome = nomes{s};
        while length(nome) >= tamanhoShingle
            Shingle = nome(1:tamanhoShingle);
            nome = nome(2:length(nome));
            shingles{count} = Shingle;
            count = count + 1;
        end
    end
    shingles = unique(shingles);


    for n = 1:length(nomes)
        if ismissing(nomes{n})
            nomes{n} = '';
        end
    end


    matrizEntrada = zeros(length(shingles),length(nomes));
    for n = 1:length(nomes)
        for s = 1:length(shingles)
            if contains(nomes(n),shingles(s))
                matrizEntrada(s,n) = 1;
            end
        end
    end

    Set = cell(length(nomes),1);
    for n = 1:length(nomes)
        Set{n} = find(matrizEntrada(:,n));
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

    minHash = calcularMatrizAssinaturas(Set,v,k,p);
    


    % calcular distancia e preencher SimilarNames
    count = 1;
    if nargin == 2
        threshold = 1;
    end
    SimilarNames = zeros(1,2);
    w = waitbar(0,'Filtering');
    for n=1:length(nomes)
        waitbar(n/length(nomes),w);
        s = 0;
        for h = 1:k
            if minHash(h,n) == minHash(h,end)
                s = s + 1;
            end
        end
        s = s/k;

        if (1-s) <= threshold
            SimilarNames(count,:) = [n 1-s];
            count = count + 1;
        end
    end
    delete (w)

    SimilarNames = SimilarNames(1:end-1,:);
    sortedDists = [];
    if ~isempty(SimilarNames)
        sortedDists = sortrows(SimilarNames,2);
    end
end