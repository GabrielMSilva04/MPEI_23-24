function M=calcularMatrizAssinaturas(Set,v,k,primo)
% Calcular Matriz de Assinaturas (M) através da aplicação de k funções
% de dispersão aos Conjuntos de restaurantes avaliados por cada utiizador

Nu=length(Set);  % número de conjuntos
M=zeros(k,Nu);        % Matriz MinHash
h= waitbar(0,'Calculando as Assinaturas (MinHash) ...');
   
for u= 1:Nu
    waitbar(u/Nu,h);
    if ~isempty(Set{u})

        C= Set{u};   % Obter Conjunto correspondente a nu
        
        % para cada uma das funções de dispersão
        for nh= 1:k
            % calc. MinHash para restaurantes do  conjunto:
            
            % calcular para o primeiro restaurante do conjunto
            M(nh,u)= mod(v(nh)*C(1), primo);
            
            % calcular para os restantes restaurante do conjunto    
            for nf= 2:length(C)
                htmp= mod(v(nh)*(C(nf)), primo);
                % para determinar min
                if  htmp < M(nh,u)
                    M(nh,u)= htmp;
                end
            end
        end
    end
end
delete (h)