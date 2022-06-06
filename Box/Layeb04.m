function y = Layeb04(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Layeb04.m
%
% Original source:
%  - abdesslem layeb (2022). New hard benchmark functions for global 
%    optimization (https://www.mathworks.com/matlabcentral/fileexchange/
%    106450-new-hard-benchmark-functions-for-global-optimization), 
%    MATLAB Central File Exchange. Retrieved February 16, 2022.
%
% Globally optimal solution:
%   f = (log(0.001) - 1)*(n - 1)
%   x = is alternation of 0 and (2k-1)π, k is an integer
%
% Default variable bounds:
%   -10 <= x(i) <= 10, i = 1...n
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
    y.xl = @(i) -10;
    y.xu = @(i) 10;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
 end
 if size(x, 2) > size(x, 1)
    x = x'; 
end
cos_rad = @(theta) cosd(theta/pi*180) ;
dim = length(x);
y = 0;
for i = 1:dim - 1
    y = y + log(abs(x(i + 1).*x(i)) + 0.001) + cos_rad(x(i + 1) + x(i)); 
end
end 

function fmin = get_fmin(nx)
    fmin = (log(0.001) - 1)*(nx - 1);
end

function xmin = get_xmin(nx)
    xmin = zeros(nx, 1);
    for i = 1:nx
        if mod(i, 2) == 0
            xmin(i) = pi;
        end
    end
end 