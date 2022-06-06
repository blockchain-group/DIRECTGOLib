function y = Layeb15(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Layeb15.m
%
% Original source:
%  - abdesslem layeb (2022). New hard benchmark functions for global 
%    optimization (https://www.mathworks.com/matlabcentral/fileexchange/
%    106450-new-hard-benchmark-functions-for-global-optimization), 
%    MATLAB Central File Exchange. Retrieved February 16, 2022.
%
% Globally optimal solution:
%   f = 0
%   x = is alternation of 1 and -1
%
% Default variable bounds:
%   -100 <= x(i) <= 100, i = 1...n
%   
% Problem Properties:
%   n  = any dimension;
%   #g = 0;
%   #h = 0;
% -------------------------------------------------------------------------
 if nargin == 0
    y.nx = 0;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(i) -100;
    y.xu = @(i) 100;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
 end
 if size(x, 2) > size(x, 1)
    x = x'; 
end
y = 0;
dim = length(x);
for i = 1:dim - 1
    y = y + 10*abs(tanh((2*abs(x(i)) - x(i + 1)^2 - 1)))^0.5 +...
        abs(exp(x(i + 1)*x(i) + 1) - 1);
end
end 

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(nx)
    xmin = ones(nx, 1);
    for i = 1:nx
        if mod(i, 2) == 0
            xmin(i) = -1;
        end
    end
end 