%% Rossler system equation
function df = rossler(vals, a, b, c)

    % vals is a 3x1 vector that contains the [u,v,z] at T-1
   	[u,v,z] = deal(vals(1),vals(2),vals(3));
    
    % Rossler
    %dx = -y -z;
    %dy = x + a*y;
    %dz = b + z*(x - c);

    % Paper
    du = a*u + v;
    dv = -u -v;
    dz = b + z*(v - c);

    % du = -v - z;
    % dv = u + a*v;
    % dz = b + z*(u - c);


    df = [du; dv; dz];
end