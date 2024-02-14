function SimilarUsers = findSimilar(dJ,threshold,users)
    % Array para guardar pares similares (user1, user2, distância)
    Nu = length(users);
    SimilarUsers = zeros(1,3);
    k = 1;
    for n1=1:Nu
        for n2=(n1+1):Nu
            if dJ(n1,n2) < threshold
                SimilarUsers(k,:) = [users(n1) users(n2) dJ(n1,n2)];
                k = k+1;
            end
        end
    end
end