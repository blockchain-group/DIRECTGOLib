function y = Tersoff_PotentialC1(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Tersoff_PotentialC1.m
%
% References:				
%  - Das, Swagatam, and Ponnuthurai N. Suganthan. "Problem definitions and 
%    evaluation criteria for CEC 2011 competition on testing evolutionary 
%    algorithms on real world optimization problems." Jadavpur University, 
%    Nanyang Technological University, Kolkata (2010): 341-359.																			
%
% Known optimal solution for sixth dimension case:
%   f* = -2.62368730772938
%   x* = [-0.0250007898394866;-0.0249999012700641;-1.16495716421699;-0.0250003949197435;-0.0249997038101926;1.14822204402050]
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

% Reshape the input vector x into a matrix
p = size(x);
NP = p(2) / 3;
x = reshape(x, 3, NP)';

% Define constants and parameters
R1 = 3.0;
R2 = 0.2;
A = 3.2647e+3;
B = 9.5373e+1;
lemda1 = 3.2394;
lemda2 = 1.3258;
lemda3 = 1.3258;
c = 4.8381;
d = 2.0417;
n1 = 22.956;
gama = 0.33675;
h = 0;

% Initialize variables
E = zeros(1, NP);
r = zeros(NP);
% Compute pairwise distances and functions for each point pair
for i = 1:NP
    for j = 1:NP
        r(i, j) = sqrt(sum((x(i, :) - x(j, :)).^2));
        if r(i, j) < (R1 - R2)
            fcr(i, j) = 1;
        elseif r(i, j) > (R1 + R2)
            fcr(i, j) = 0;
        else
            fcr(i, j) = 0.5 - 0.5 * sin(pi / 2 * (r(i, j) - R1) / R2);
        end

        VRr(i, j) = A * exp(-lemda1 * r(i, j));
        VAr(i, j) = B * exp(-lemda2 * r(i, j));
    end
end
% Compute E
for i = 1:NP
    for j = 1:NP
        if i == j
            continue;
        end
        jeta = zeros(NP, NP);
        for k = 1:NP
            if i == k || j == k
                continue;
            end
            rd1 = sqrt(sum((x(i, :) - x(k, :)).^2));
            rd3 = sqrt(sum((x(k, :) - x(j, :)).^2));
            rd2 = sqrt(sum((x(i, :) - x(j, :)).^2));
            ctheta_ijk = (rd1^2 + rd2^2 - rd3^3) / (2 * rd1 * rd2);
            G_th_ijk = 1 + (c^2) / (d^2) - (c^2) / (d^2 + (h - ctheta_ijk)^2);
            jeta(i, j) = jeta(i, j) + fcr(i, k) * G_th_ijk * exp(lemda3^3 * (r(i, j) - r(i, k))^3);
        end
        Bij = (1 + (gama * jeta(i, j))^n1)^(-0.5 / n1);
        E(i) = E(i) + fcr(i, j) * (VRr(i, j) - Bij * VAr(i, j)) / 2;
    end
end
% Sum all the E
y = sum(E);

% Check for NaN value and set a large value if necessary
if isnan(y)
    y = 10^100;
end
end

function xl = get_xl(nx)
    xl = -ones(nx, 1).*6.4;
end

function xu = get_xu(nx)
    xu = ones(nx, 1).*6.35;
end

function fmin = get_fmin(nx)
    fmin = -2.62368730772938;
end

function xmin = get_xmin(~)
    xmin = [-0.0250007898394866;-0.0249999012700641;-1.16495716421699;-0.0250003949197435;-0.0249997038101926;1.14822204402050];
end