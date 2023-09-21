function y = Spread_Spectrum_Radar(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Spread_Spectrum_Radar.m
%
% References:				
%  - Das, Swagatam, and Ponnuthurai N. Suganthan. "Problem definitions and 
%    evaluation criteria for CEC 2011 competition on testing evolutionary 
%    algorithms on real world optimization problems." Jadavpur University, 
%    Nanyang Technological University, Kolkata (2010): 341-359.																			
%
% Known optimal solution for sixth dimension case:
%   f* = 0.5
%   x* = [5.93411945678072;3.14159265358979;3.14159265358979;2.44346095279206;1.04719755119660;1.04719755119660]
%
% Problem Properties:
%   n  = 1,...,20
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

% Determine the number of variables and initialize variables
[~, d] = size(x);
var = 2 * d - 1;
hsum = zeros(var, 1);

% Calculate the values of hsum vector
for kk = 1:2 * var
    if rem(kk, 2) ~= 0
        % Odd index
        i = (kk + 1) / 2;
        hsum(kk) = 0;
        for j = i:d
            summ = 0;
            for i1 = (abs(2 * i - j - 1) + 1):j
                summ = x(i1) + summ;
            end
            hsum(kk) = cos(summ) + hsum(kk);
        end
    else
        % Even index
        i = kk / 2;
        hsum(kk) = 0;
        for j = (i + 1):d
            summ = 0;
            for i1 = (abs(2 * i - j) + 1):j
                summ = x(i1) + summ;
            end
            hsum(kk) = cos(summ) + hsum(kk);
        end
        hsum(kk) = hsum(kk) + 0.5;
    end
end

% Calculate the maximum value of hsum as the fitness value y
y = max(hsum);

% Check for NaN value and set a large value if necessary
if isnan(y)
    y = 10^100;
end
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = ones(nx, 1).*2*pi;
end

function fmin = get_fmin(~)
    fmin = 0.5;
end

function xmin = get_xmin(~)
    xmin = [5.93411945678072;3.14159265358979;3.14159265358979;2.44346095279206;1.04719755119660;1.04719755119660];
end