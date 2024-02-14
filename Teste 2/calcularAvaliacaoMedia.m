function mediasAval = calcularAvaliacaoMedia(turistas,DistsIguais)
    mediasAval = zeros(length(DistsIguais(:,1)),2);
    for r = 1:length(DistsIguais)
        selecionados = find(turistas(:,2) == DistsIguais(r,1));
        media = sum(turistas(selecionados,4))/length(selecionados);
        mediasAval(r,1) = DistsIguais(r,1);
        mediasAval(r,2) = media;
    end

    if ~isempty(mediasAval)
        mediasAval = sortrows(mediasAval,2, "descend");
    end
end