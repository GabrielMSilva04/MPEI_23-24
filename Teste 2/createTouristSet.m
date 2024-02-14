function [Set, turistas] = createTouristSet(turistas1)
    % Fica apenas com as duas primeiras colunas
    u = turistas1(1:end, 1:2);
    
    % Lista de utilizadores
    turistas = unique(u(:,1)); % Extrai os IDs dos turistas
    Nu = length(turistas); % Número de turistas
    
    % Constrói a lista de restaurantes para cada turista
    Set = cell(Nu,1); % Usa células
    for n = 1:Nu % Para cada turista
        % Obtem os restaurantes de cada um
        ind = find(u(:,1) == turistas(n));
        % E guarda num array. Usa células porque turista tem um número
        % diferente de restaurantes. Se fossem iguais podia ser um array
        Set{n} = unique([Set{n} u(ind,2)]);
    end
end