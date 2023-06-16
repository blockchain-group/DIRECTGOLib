function y = Watson(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Watson.m
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
%   f = 2.69404045947512837955
%   x = [-0.75659769162374457263;  2.67019170664994609510;  
%         0.21852772754808771905; -0.60617837481749525796;  
%         4.99999999987878407381; -2.82795697489832553728];
%
% Default variable bounds:
%   -5 <= x(i) <= 5, i = 1...n
%
% Problem Properties:
%   n  = 6;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Non-differentiable, Separable, Scalable, Multi-modal,
%   Non-convex, Non-plateau, Non-Zero-Solution, Asymmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 6;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 1, 1, 1, 0, 0, 0, 0];
    y.libraries = [0, 0, 0, 1, 1, 0, 0, 0, 0, 0];
    return
end   
if size(x, 2) > size(x, 1), x = x'; end

y = 0;
a = (0:29)'./29;
sum1 = @(ii) sum((-1:3)'.*(a(ii).^((0:4)')).*x(1:5));
sum2 = @(ii) sum((a(ii).^((0:5)')).*x(1:6))^2;
for i = 1:30
    y = y + (sum1(i) - sum2(i) - 1)^2;
end
y = y + x(1)^2;
end 

function xl = get_xl(nx)
    xl = -5*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 5*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 2.69404045947512837955;
end

function xmin = get_xmin(~)
    xmin = [-0.75659769162374457263;  2.67019170664994609510; ...
             0.21852772754808771905; -0.60617837481749525796; ...
             4.99999999987878407381; -2.82795697489832553728];
end