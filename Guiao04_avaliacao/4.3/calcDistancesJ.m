function dJ = calcDistancesJ(Set, users)
    Nu = length(users);
    dJ=zeros(Nu,Nu); % array para guardar distancias
    h = waitbar(0,'Calculating distances');
    for n1=1:Nu
        waitbar(n1/Nu,h);
        for n2=(n1+1):Nu
            % Encontrar os filmes comuns entre os dois usuários
            filmes_comuns = intersect(Set{n1}, Set{n2});

            % Unir os filmes assistidos por ambos os usuários
            filmes_unidos = union(Set{n1}, Set{n2});
            
            % Calcular a distância de Jaccard
            sim = length(filmes_comuns) / length(filmes_unidos);
            dJ(n1, n2) = 1 - sim;
        end
    end
    delete (h)
end