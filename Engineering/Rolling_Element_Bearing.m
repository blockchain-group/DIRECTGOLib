function y = Rolling_Element_Bearing(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Rolling_Element_Bearing .m
%
% Original source: 
% - Kumar, A., Wu, G., Ali, M. Z., Mallipeddi, R., Suganthan, P. N., & 
%   Das, S. (2020). A test-suite of non-convex constrained optimization 
%   problems from the real-world and some baseline results. Swarm and 
%   Evolutionary Computation, 56, 100693.
%
% Known optimal solution:
%   f* = 14614.13571502644
%   x* = [131.2; 18; 4; 0.6; 0.6; 0.455861881094858; 0.699353027198474; 0.3; 0.036421895277574; 0.6];
%    
% Problem Properties:
%   n  = 10;
%   #g = 9;
%   #h = 0;  
% ------------------------------------------------------------------------- 
if nargin == 0
    y.nx = 10;
    y.ng = 9;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) ConFun(i);
    return
end
if size(x, 2) > size(x, 1)
    x = x';
end
% Variable assignments
Dm = x(1);
Db = x(2);
Z = x(3);
fi = x(4);
fo = x(5);
gamma = Db / Dm;

% Calculate the flow coefficient fc
fc = 37.91 * (1 + (1.04 * ((1 - gamma) / (1 + gamma))^1.72 * (fi * (2 * fo - 1) / (fo * (2 * fi - 1)))^0.41)^(10/3))^(-0.3) ...
    * (gamma^0.3 * (1 - gamma)^1.39 / (1 + gamma)^(1/3)) * (2 * fi / (2 * fi - 1))^0.41;

% Calculate the final result y
ind = find(Db > 25.4);
y = fc * Z^(2/3) * Db^(1.8);
y(ind) = 3.647 * fc(ind) * Z(ind)^(2/3) * Db(ind)^1.4;
end

function [g, ceq] = ConFun(x)
    % Variable assignments
    Dm = x(1);
    Db = x(2);
    Z = x(3);
    fi = x(4);
    fo = x(5);
    KDmin = x(6);
    KDmax = x(7);
    eps = x(8);
    e = x(9);
    chi = x(10);

    % Constants
    D = 160;
    d = 90;
    Bw = 30;
    T = D - d - 2 * Db;

    % Intermediate variable calculations
    phi_o = 2 * pi - 2 * acos((((D - d) * 0.5 - 0.75 * T)^2 + (0.5 * D - 0.25 * T - Db)^2 - (0.5 * d + 0.25 * T)^2) / (2 * (0.5 * (D - d) - 0.75 * T) * (0.5 * D - 0.25 * T - Db)));

    % Constraints
    g(1) = Z - 1 - phi_o / (2 * asin(Db / Dm)); 
    g(2) = KDmin * (D - d) - 2 * Db; 
    g(3) = 2 * Db - KDmax * (D - d); 
    g(4) = chi * Bw - Db; 
    g(5) = 0.5 * (D + d) - Dm; 
    g(6) = Dm - (0.5 + e) * (D + d);
    g(7) = eps * Db - 0.5 * (D - Dm - Db);
    g(8) = 0.515 - fi;
    g(9) = 0.515 - fo; 

    % No equality constraints
    ceq = [];
end

function xl = get_xl(~)
    xl = [125; 10.5; 4; 0.515; 0.515; 0.4; 0.6; 0.3; 0.02; 0.6];
end

function xu = get_xu(~)
    xu = [150; 31.5; 50; 0.6; 0.6; 0.5; 0.7; 0.4; 0.1; 0.85];
end

function fmin = get_fmin(~)
    fmin = 14614.13571502644;
end

function xmin = get_xmin(~)
    xmin = [131.2; 18; 4; 0.6; 0.6; 0.455861881094858; 0.699353027198474; 0.3; 0.036421895277574; 0.6];
end