%% Rossler system equation
function df = rossler(vals, a, b, c)

    % vals is a 3x1 vector that contains the [u,v,z] at T-1
   	[u,v,z] = deal(vals(1),vals(2),vals(3));

    du = -v -z;
    dv = u + a*v;
    dz = b + z*(u - c);

    df = [du; dv; dz];
end