function y = SineEnvelope(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   SineEnvelope.m
%
% References:				
%  - Gavana, A.: Global optimization benchmarks and ampgo. 
%    URL: http://infinity77.net/global_optimization/index.html	
%
% Globally optimal solution:
%   f = -2.65357683353993012432*(n-1);
%   x = is alternation of -0.569775980249943 and -4.66392318244169 
%
% Default variable bounds:
%   -100 <= x(i) <= 100, i = 1,...,n
%
% Problem Properties:
%   n  = "n >= 2";
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-separable, Scalable, Multi-modal,
%   Non-convex, Non-plateau, Non-Zero-Solution, Symmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 0;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 0, 1, 1, 0, 0, 0, 1];
    y.libraries = [0, 0, 0, 1, 0, 0, 0, 0, 0, 0];
    return
end   
if size(x, 2) > size(x, 1), x = x'; end

y = 0;
for i = 1:length(x) - 1
   y = y + (((sin((x(i)^2 + x(i + 1)^2)^0.5) - 0.5)^2)/((0.001*(x(i)^2 ...
       + x(i + 1)^2) + 1)^2)) + 0.5;
end
y = -y;
end 

function xl = get_xl(nx)
    xl = -100*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 100*ones(nx, 1);
end

function fmin = get_fmin(nx)
    fmin = -2.65357683353993012432*(nx - 1);
end

function xmin = get_xmin(nx)
    xmin = repmat([4.69553532723094235735; -0.16962283193502969425], fix(nx/2) + 1, 1);
    xmin = xmin(1:nx);
end