function y = Cola(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Cola.m
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
%   f = 11.746390275660298
%   x = [0.651922979899606; 1.301944326524565;  0.099231556304421; -0.883825470933591; 
%       -0.879598480047427; 0.204625887701572; -3.284148863664659;  0.851190554089573; 
%       -3.462424155712111; 2.532414885805949; -0.895252869041575;  1.409921084369296; 
%       -3.073706260405618; 1.962577398708555; -2.978741214481137; -0.807813614761909; 
%       -1.689781103111940];
%
% Default variable bounds:
%    0 <= x(1) <= 4, 
%   -4 <= x(i) <= 4, i = 2,...,n
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

d = [0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00;
     1.27, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00;
     1.69, 1.43, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00;
     2.04, 2.35, 2.43, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00;
     3.09, 3.18, 3.26, 2.85, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00;
     3.20, 3.22, 3.27, 2.88, 1.55, 0.00, 0.00, 0.00, 0.00, 0.00;
     2.86, 2.56, 2.58, 2.59, 3.12, 3.06, 0.00, 0.00, 0.00, 0.00;
     3.17, 3.18, 3.18, 3.12, 1.31, 1.64, 3.00, 0.00, 0.00, 0.00;
     3.21, 3.18, 3.18, 3.17, 1.70, 1.36, 2.95, 1.32, 0.00, 0.00;
     2.38, 2.31, 2.42, 1.94, 2.85, 2.81, 2.56, 2.91, 2.97, 0.00];

[xi, yi] = deal(zeros(10, 1));
 
xi(1) = 0;  yi(1) = 0;
xi(2) = x(1); yi(2) = 0;

for i = 3:10
    xi(i) = x(2*(i - 2));
    yi(i) = x(2*(i - 2) + 1);
end

y = 0;
for i = 2:10
    for j = 1:(i-1)
        rij = hypot(xi(i) - xi(j), yi(i) - yi(j));
        y = y + (rij - d(i,j))^2;
    end
end
end  

function xl = get_xl(nx)
    xl = [0; -4*ones(nx-1, 1)];
end

function xu = get_xu(nx)
    xu = 4*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 11.746390275660298;
end

function xmin = get_xmin(~)
    xmin = [0.651922979899606; 1.301944326524565;  0.099231556304421; -0.883825470933591; 
           -0.879598480047427; 0.204625887701572; -3.284148863664659;  0.851190554089573; 
           -3.462424155712111; 2.532414885805949; -0.895252869041575;  1.409921084369296; 
           -3.073706260405618; 1.962577398708555; -2.978741214481137; -0.807813614761909; 
           -1.689781103111940];
end