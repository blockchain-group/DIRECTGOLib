function y = Frequency_Modulated_Sound_Waves(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Frequency_Modulated_Sound_Waves.m
%
% References:				
%  - Das, Swagatam, and Ponnuthurai N. Suganthan. "Problem definitions and 
%    evaluation criteria for CEC 2011 competition on testing evolutionary 
%    algorithms on real world optimization problems." Jadavpur University, 
%    Nanyang Technological University, Kolkata (2010): 341-359.																			
%
% Known optimal solution for sixth dimension case:
%   f* = 4.99480067636124e-12
%   x* = [-1.00000205067884;-3.21865398289489e-05;-1.49985680732802;
%         0.199997526524726;2.00023611496448;5.09999751142486]
%
% Problem Properties:
%   n  = perfectly divisible by 6
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
if size(x, 2) > size(x, 1), x = x'; end

% Define the value of theta
theta = 2 * pi / 10;

% Initialize the output value y
y = 0;

% Determine the number of groups 'g' based on the length of x
g = length(x) / 6;

% Iterate over each group 'j'
for j = 1:g
    % Iterate over 't' from 1 to 10
    for t = 1:10
        y_t = x(1 + 6 * (j - 1)) * sin(x(2 + 6 * (j - 1)) * t * theta + x(3 + 6 * (j - 1)) * sin(x(4 + 6 * (j - 1)) * t * theta + x(5 + 6 * (j - 1)) * sin(x(6 + 6 * (j - 1)) * t * theta)));
        y_0_t = 1 * sin(5 * t * theta - 1.5 * sin(4.8 * t * theta + 2 * sin(4.9 * t * theta)));
        y = y + (y_t - y_0_t)^2;
    end
end
end

function xl = get_xl(nx)
    xl = -ones(nx, 1).*6.4;
end

function xu = get_xu(nx)
    xu = ones(nx, 1).*6.35;
end

function fmin = get_fmin(~)
    fmin = 4.99480067636124e-12;
end

function xmin = get_xmin(~)
    xmin = [-1.00000205067884;-3.21865398289489e-05;-1.49985680732802;0.199997526524726;2.00023611496448;5.09999751142486];
end