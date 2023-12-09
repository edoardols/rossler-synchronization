function df = rosslerEquation(vals, a, b, c)
    %% Rossler system equation

    % vals is a 3x1 vector that contains the [u,v,z] at T-1
   	[u,v,z] = deal(vals(1),vals(2),vals(3));
    % u = vals(1);
    % v = vals(2);
    % z = vals(3);
    
    % Rossler
    du = -v - z;
    dv = u + a*v;
    dz = b + z*(u - c);

    % Paper
    %du = a*u + v;
    %dv = -u -v;
    %dz = b + z*(v - c);
    
    df = [du; dv; dz];
end