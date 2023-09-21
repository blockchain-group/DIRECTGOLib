function y = Lennard_Jones_Potential(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Lennard_Jones_Potential.m
%
% References:				
%  - Das, Swagatam, and Ponnuthurai N. Suganthan. "Problem definitions and 
%    evaluation criteria for CEC 2011 competition on testing evolutionary 
%    algorithms on real world optimization problems." Jadavpur University, 
%    Nanyang Technological University, Kolkata (2010): 341-359.																			
%
% Globally optimal solution for sixth dimension case:
%   f = -1
%   x = [-0.377645844660269;-5.590436078716519;-6.315523640090913;
%        0.613688247093040;-5.709204980922420;-6.371655007137434]
%
% Problem Properties:
%   n  = should be perfectly divisible by 3
%   #g = 0;
%   #h = 0;
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 0;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 1) > size(x, 2), x = x'; end

p = size(x);
n = p(2)/3;
x = reshape(x, 3, n)';
r = ones(3, n);
y = 0;
a = ones(n, n);
b = repmat(2,n,n);
for i = 1:(n - 1)
    for j = (i + 1):n
        r(i, j) = sqrt(sum((x(i, :) - x(j, :)).^2));
        y = y + (a(i, j)/r(i, j)^12 - b(i, j)/r(i, j)^6);
    end
end
if isnan(y), y = 10^100; end
end

function xl = get_xl(nx)
    xl = -ones(nx, 1).*6.4;
end

function xu = get_xu(nx)
    xu = ones(nx, 1).*6.35;
end

function fmin = get_fmin(~)
    fmin = -1;
end

function xmin = get_xmin(~)
    xmin = [-0.377645844660269;-5.590436078716519;-6.315523640090913;0.613688247093040;-5.709204980922420;-6.371655007137434];
end