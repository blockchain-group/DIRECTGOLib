function y = Layeb06(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Layeb06.m
%
% Original source:
%  - abdesslem layeb (2022). New hard benchmark functions for global 
%    optimization (https://www.mathworks.com/matlabcentral/fileexchange/
%    106450-new-hard-benchmark-functions-for-global-optimization), 
%    MATLAB Central File Exchange. Retrieved February 16, 2022.
%
% Globally optimal solution:
%   f = 0
%   x = pi*ones(n, 1)
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
cos_rad = @(theta) cosd(theta/pi*180);
sin_rad = @(theta) sind(theta/pi*180);
y = 0;
dim = length(x);
for i=1:dim-1   
    y = y + abs(cos_rad((sqrt(x(i).^2 + x(i + 1).^2)))*...
        sin_rad(x(i + 1)) + cos_rad(x(i)) + 1).^0.1;
end
end 

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(nx)
    xmin = pi*ones(nx, 1);
end