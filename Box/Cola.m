function y = Cola(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   ChungR.m
%
% Original source:
%  - Jamil, Momin, and Xin-She Yang. "A literature survey of benchmark 
%    functions for global optimization problems." International Journal of 
%    Mathematical Modelling and Numerical Optimization 4.2 (2013): 150-194.
%
% Globally optimal solution:
%   f = 12.0150208539963
%   x = [1.88233901088738e-19, 0.561483065264138, -1.52448154217515,...
%        2.43203646013122, 1.94210709426414, 3.99999995113990,...
%        -0.306889438480682, 2.38359497486440, -1.27124875319439,...
%        3.57147091120464, 0.218532259878877, 3.18582992724449,...
%        -1.77607000084176, 1.55385758277365, 1.13503441154639,...
%        1.88233901088740e-19, 1.88233901088740e-19]
%
% Default variable bounds:
%   -100 <= x(i) <= 350, i = 1...n
%   
% Problem Properties:
%   n  = any;
%   #g = 0;
%   #h = 0;
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 17;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(i) -4;
    y.xu = @(i) 4;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
d = [1.27, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00;
     1.69, 1.43, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00;
     2.04, 2.35, 2.43, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00;
     3.09, 3.18, 3.26, 2.85, 0.00, 0.00, 0.00, 0.00, 0.00;
     3.20, 3.22, 3.27, 2.88, 1.55, 0.00, 0.00, 0.00, 0.00;
     2.86, 2.56, 2.58, 2.59, 3.12, 3.06, 0.00, 0.00, 0.00;
     3.17, 3.18, 3.18, 3.12, 1.31, 1.64, 3.00, 0.00, 0.00;
     3.21, 3.18, 3.18, 3.17, 1.70, 1.36, 2.95, 1.32, 0.00;
     2.38, 2.31, 2.42, 1.94, 2.85, 2.81, 2.56, 2.91, 2.97;];
y = 0;
[df, z] = deal(zeros(9, 1));
df(2) = x(2);
for i = 3:9
    df(i) = x(2*(i - 2));
    z(i) = x(2*(i - 2) + 1);
end

for i = 1:9
    for j = 1:9
        if i > j
            r = ((df(i) - df(j))^2 + (z(i) - z(j))^2)^0.5;
            y = y + (r - d(i, j))^2;
        end
    end
end
end  

function fmin = get_fmin(~)
    fmin = 12.0150208539963;
end

function xmin = get_xmin(~)
    xmin = [1.88233901088738e-19; 0.561483065264138; -1.52448154217515;...
            2.43203646013122; 1.94210709426414; 3.99999995113990;...
            -0.306889438480682; 2.38359497486440; -1.27124875319439;...
            3.57147091120464; 0.218532259878877; 3.18582992724449;...
            -1.77607000084176; 1.55385758277365; 1.13503441154639;...
            1.88233901088740e-19; 1.88233901088740e-19];
end