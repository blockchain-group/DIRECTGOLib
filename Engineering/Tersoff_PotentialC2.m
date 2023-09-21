function y = Tersoff_PotentialC2(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Tersoff_PotentialC2.m
%
% References:				
%  - Das, Swagatam, and Ponnuthurai N. Suganthan. "Problem definitions and 
%    evaluation criteria for CEC 2011 competition on testing evolutionary 
%    algorithms on real world optimization problems." Jadavpur University, 
%    Nanyang Technological University, Kolkata (2010): 341-359.																			
%
% Known optimal solution for sixth dimension case:
%   f* = -2.66601677117527
%   x* = [-0.0249986836008560;-0.0250000000000004;1.14043145493440;
%         -0.0250004936496797;-0.0249965883322210;-1.15473249460743]
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

% Reshape the input vector x into a 2D matrix
p = size(x);
NP = p(2) / 3;
x = reshape(x, 3, NP)';

% Define constants and parameters
R1 = 2.85;
R2 = 0.15;
A = 1.8308e+3;
B = 4.7118e+2;
lemda1 = 2.4799;
lemda2 = 1.7322;
lemda3 = 1.7322;
c = 1.0039e+05;
d = 1.6218e+01;
n1 = 7.8734e-01;
gama = 1.0999e-06;
h = -5.9826e-01;

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

% Compute the energy contribution for each point
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

% Sum all the energy contributions to get the fitness value 'y'
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
    fmin = -2.66601677117527;
end

function xmin = get_xmin(~)
    xmin = [-0.0249986836008560;-0.0250000000000004;1.14043145493440;-0.0250004936496797;-0.0249965883322210;-1.15473249460743];
end