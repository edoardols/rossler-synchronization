function I = maxLattice(eqc)
    % vector of max for each rows
    M = max(eqc,[],2);

    [M, I] = max(M);
end