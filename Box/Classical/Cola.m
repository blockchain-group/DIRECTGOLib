function y = Cola(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   ChungR.m
%
% References:				
%  - Gavana, A.: Global optimization benchmarks and ampgo. 
%    URL: http://infinity77.net/global_optimization/index.html	
%  - Momin Jamil and Xin-She Yang, A literature survey of benchmark functions for
%    global optimization problems, Int. Journal of Mathematical Modelling and
%    Numerical Optimisation, Vol. 4, No. 2, pp. 150–194 (2013).
%    DOI: 10.1504/IJMMNO.2013.055204
%
% Globally optimal solution:
%   f = 12.01502083800263243063
%   x = [-0.00000000000000000053;  0.56148318393624918610; -1.52448151658903530148;
%         1.94210728841194524286;  3.99999999998045607796; -0.30688915161225388539;
%         2.38359515479439254548; -1.27124852757517281532;  3.57147102339169464358;
%         0.21853259400328020612;  3.18583011193942367001; -1.77606975239290876267;
%         1.55385750601535166382;  1.13503453649639163281; -0.00000000000000000053;
%        -0.00000000000000000053; -0.00000000000000000053];
%
% Default variable bounds:
%   -4 <= x(i) <= 4, i = 1,...,n
%   
% Problem Properties:
%   n  = 17;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-separable, Non-scalable, Multi-modal,
%   Non-convex, Non-plateau, Zero-Solution, Asymmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 17;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 0, 0, 1, 0, 0, 1, 0];
    y.libraries = [0, 0, 0, 1, 1, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

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

function xl = get_xl(nx)
    xl = -4*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 4*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 12.01502083800263243063;
end

function xmin = get_xmin(~)
    xmin = [-0.00000000000000000053;  0.56148318393624918610; -1.52448151658903530148;...
             2.43203630380497592967;  1.94210728841194524286;  3.99999999998045607796;...
            -0.30688915161225388539;  2.38359515479439254548; -1.27124852757517281532;...
             3.57147102339169464358;  0.21853259400328020612;  3.18583011193942367001;...
            -1.77606975239290876267;  1.55385750601535166382;  1.13503453649639163281;...
            -0.00000000000000000053; -0.00000000000000000053];
end