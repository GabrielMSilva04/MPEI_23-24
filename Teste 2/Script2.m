% load de ficheiros
load("turistas1.data")
rest = readcell('restaurantes.txt','Delimiter','\t');
load("RestaurantsByUser.mat")
load("assinaturasUsers.mat")
load("distanciasUsers.mat")
load("BloomFilter.mat")



Nu = length(unique(turistas1(:,1)));

prompt = sprintf("Insert User ID (1 to %d): ", Nu);

user_ID = input(prompt);
while user_ID < 1 || user_ID > Nu
    disp("Invalid ID")
    user_ID = input(prompt);
end

menu = ["\n1 - Restaurants evaluated by you\n" ...
        "2 - Set of restaurants evaluated by the most similar user\n" ...
        "3 - Search Restaurant\n" ...
        "4 - Find most similar restaurants\n" ...
        "5 - Estimate the number of evaluations for each restaurant\n" ...
        "6 - Exit\n" ...
        "Select choice: "];

menu = sprintf('%s',menu{:});

option = 0;
while option ~= 6
    option = input(menu);

    switch option
        case 1
            restaurantes = Set{user_ID};
            listarRestaurantes(restaurantes,rest)
    
        case 2
            distancias = dists(user_ID,:);
            minDist = 1;
            for u=1:Nu
                if distancias(u) < minDist && u ~= user_ID
                    minDist = distancias(u);
                    ind = u;
                end
            end
            restaurantes = Set{ind};
            listarRestaurantes(restaurantes,rest)
    
        case 3
            string = input("Write a string: ","s");
            
            sortedDists = StringsSimilares(rest(:,2),string,0.99);
            if length(sortedDists) > 5
                sortedDists = sortedDists(1:5,:);
            end
    
            if isempty(sortedDists)
                disp("Restaurant not found");
            end
    
            %print
            for r = 1:length(sortedDists(:,1))
                nome = rest{sortedDists(r,1),2};
                dist = sortedDists(r,2);
                fprintf("%-35s %.3f\n",nome,dist);
            end
    
        case 4
            listarRestaurantes(Set{user_ID},rest)
    
            id = input("Choose a restaurant ID: ");
            while ~ismember(id, Set{user_ID})
                disp("Restaurant not found for this user")
                id = input("Choose a restaurant ID: ");
            end
    
            % primeira fase
            % calculo da distancia de cada campo
            DistLoc = StringsSimilares(rest(:,3),rest(id,3));
    
            DistConc = StringsSimilares(rest(:,4),rest(id,4));
    
            DistCoz = StringsSimilares(rest(:,5),rest(id,5));
    
            DistPratos = StringsSimilares(rest(:,6),rest(id,6));
    
            DistEncerr = StringsSimilares(rest(:,7),rest(id,7));
    
    
            % calculo distancia media de cada campo
            DistMedia = zeros(length(rest(:,1)),2);
            DistMedia(:,1) = 1:length(rest(:,1));
            for r=1:length(DistLoc(:,1))
                DistMedia(DistLoc(r,1),2) = DistMedia(DistLoc(r,1),2) + DistLoc(r,2); 
            end
            for r=1:length(DistConc(:,1))
                DistMedia(DistConc(r,1),2) = DistMedia(DistConc(r,1),2) + DistConc(r,2); 
            end
            for r=1:length(DistCoz(:,1))
                DistMedia(DistCoz(r,1),2) = DistMedia(DistCoz(r,1),2) + DistCoz(r,2); 
            end
            for r=1:length(DistPratos(:,1))
                DistMedia(DistPratos(r,1),2) = DistMedia(DistPratos(r,1),2) + DistPratos(r,2); 
            end
            for r=1:length(DistEncerr(:,1))
                DistMedia(DistEncerr(r,1),2) = DistMedia(DistEncerr(r,1),2) + DistEncerr(r,2); 
            end
            DistMedia(:,2) = DistMedia(:,2) / 5;
    
            
            % organizar
            DistMedia = sortrows(DistMedia,2);         
            
            d1 = DistMedia(2,2);
            d2 = DistMedia(3,2);
            d3 = DistMedia(4,2);
            DistFinal = [];
            

            % comparar valores
            if d1 ~= d2
                DistFinal(1,1) = DistMedia(2,1);
                DistFinal(1,2) = d1;
                if d2 ~= d3
                    DistFinal(2,1) = DistMedia(3,1);
                    DistFinal(2,2) = d2;
                    if d3 ~= DistMedia(5,2)
                        DistFinal(3,1) = DistMedia(4,1);
                        DistFinal(3,2) = d3;
                    end
                end
            end
           
            % procurar valores para usar na segunda fase
            DistsIguais = [];
            if ~isempty(DistFinal)
                if length(DistFinal(:,1)) == 3
                elseif length(DistFinal(:,1)) == 2
                    d = d3;
                    i = 4;
                    while d == d3
                        i = i + 1;
                        d = DistMedia(i-1,2);
                        if d ~= d3
                            break
                        end
                        DistsIguais(i-4,1) = DistMedia(i-1,1);
                        DistsIguais(i-4,2) = d;
                    end

                    mediasAval = calcularAvaliacaoMedia(turistas1,DistsIguais);
                    DistFinal(3,:) = mediasAval(1,:);
    
                elseif length(DistFinal(:,1)) == 1
                    d = d2;
                    i = 3;
                    while d == d2
                        i = i + 1;
                        d = DistMedia(i-1,2);
                        if d ~= d2
                            break
                        end
                        DistsIguais(i-3,1) = DistMedia(i-1,1);
                        DistsIguais(i-3,2) = d;
                    end
    
                    mediasAval = calcularAvaliacaoMedia(turistas1,DistsIguais);
                    DistFinal(2:3,:) = mediasAval(1:2,:);
                end
            else
                if d1 == d2 && d2 ~= d3
                    d = d1;
                    i = 2;
                    while d == d1
                        i = i + 1;
                        d = DistMedia(i-1,2);
                        if d ~= d1
                            break
                        end
                        DistsIguais(i-2,1) = DistMedia(i-1,1);
                        DistsIguais(i-2,2) = d;
                    end
    
                    mediasAval = calcularAvaliacaoMedia(turistas1,DistsIguais);
                    DistFinal(1:2,:) = mediasAval;
    
                    if d3 ~= DistMedia(5,2)
                        DistFinal(3,1) = DistMedia(4,1);
                        DistFinal(3,2) = d3;
                    else
                        d = d3;
                        i = 4;
                        DistsIguais = [];
                        while d == d3
                            i = i + 1;
                            d = DistMedia(i-1,2);
                            if d ~= d3
                                break
                            end
                            DistsIguais(i-4,1) = DistMedia(i-1,1);
                            DistsIguais(i-4,2) = d;
                        end
    
                        mediasAval = calcularAvaliacaoMedia(turistas1,DistsIguais);
                        DistFinal(3,:) = mediasAval(1,:);
                    end
                else
                    d = d1;
                    i = 2;
                    while d == d1
                        i = i + 1;
                        d = DistMedia(i-1,2);
                        if d ~= d1
                            break
                        end
                        DistsIguais(i-2,1) = DistMedia(i-1,1);
                        DistsIguais(i-2,2) = d;
                    end

                    mediasAval = calcularAvaliacaoMedia(turistas1,DistsIguais);
                    DistFinal(1:3,:) = mediasAval;
                end
            end

            listarRestaurantes(DistFinal(:,1),rest)
    
        case 5
            id = input("Choose a restaurant ID: ");
            while id < 1 || id > length(rest(:,1))
                disp("Restaurant not found")
                id = input("Choose a restaurant ID: ");
            end
            
            m = length(rest(:,1));
            p = 0.01;
            n = round(- (m * log(p)) / (log(2)^2));
            k = round((n * log(2)) / m);
            

            % estimar o número de avaliaçoes
            estimativa = checkBloomFilter(BloomFilter, id, k);

            fprintf("A estimativa do número de avaliações do restaurante escolhido é %d\n",estimativa);
            
        
        case 6
            disp("A terminar programa...")

        otherwise
            disp("Opção inválida")
            continue
    end
end