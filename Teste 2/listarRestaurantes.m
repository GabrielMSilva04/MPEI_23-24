function listarRestaurantes(listaIDsRestaurantes,rest)
    % função que faz print de todos os restaurantes a partir de um array
    % com os seus ids com o formato (id nome concelho)
    for r = 1:length(listaIDsRestaurantes)
        restaurante = rest(listaIDsRestaurantes(r),:);
        fprintf("%-4d %-40s %-20s\n", restaurante{1}, restaurante{2}, restaurante{4});
    end
end