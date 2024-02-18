function distancias = calcularDistancias(Nu,minHash,NumberHashFunctions)
    % calcular distancia e preencher array com distancias
    distancias = zeros(Nu);
    w = waitbar(0,'Filtering');
    for n1=1:Nu
        waitbar(n1/Nu,w);
        for n2=(n1+1):Nu
            s = 0;
            for h = 1:NumberHashFunctions
                if minHash(h,n1) == minHash(h,n2)
                    s = s + 1;
                end
            end
            d = 1-(s/NumberHashFunctions);
            distancias(n1,n2) = d;
        end
    end
    delete (w)
    distancias = distancias + distancias';
end