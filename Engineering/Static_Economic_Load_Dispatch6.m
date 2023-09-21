function y = Static_Economic_Load_Dispatch6(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Static_Economic_Load_Dispatch6.m
%
% Original source: 
% - Das, S., & Suganthan, P. N. (2010). Problem definitions and evaluation 
%   criteria for CEC 2011 competition on testing evolutionary algorithms on 
%   real world optimization problems. Jadavpur University, Nanyang 
%   Technological University, Kolkata, 341-359.
%
% Known optimal solution:
%   f* = 15447.4428525634
%   x* = [434.390562362830;181.320668922663;257.924552759678;139.724598374641;165.856094826576;96.2876227536128]
%     
% Problem Properties:
%   n  = 6;
%   #g = 4;
%   #h = 0;  
% ------------------------------------------------------------------------- 
if nargin == 0
    y.nx = 6;
    y.ng = 4;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) confun(i);
    return
end
if size(x, 1) > size(x, 2), x = x'; end

% Extract data coefficients for the cost function
Data1 = get_data; 
a = Data1(:, 3)'; 
b = Data1(:, 4)'; 
c = Data1(:, 5)';

% Sum up the total cost
y = sum(a.*(x.^2) + b.*x + c);
end

function [c, ceq] = confun(x)
    % Ensure x is a row vector
    if size(x, 1) > size(x, 2), x = x'; end

    % Power demand value
    Power_Demand = 1263;

    % Get data from the get_data function
    [Data1, Data2, B1, B2, B3] = get_data;

    % Extract data from Data1
    Pmin = Data1(:, 1)';
    Pmax = Data1(:, 2)';

    % Extract data from Data2
    Initial_Generations = Data2(:, 1)';
    Up_Ramp = Data2(:, 2)';
    Down_Ramp = Data2(:, 3)';
    Up_Ramp_Limit = min(Pmax, Initial_Generations + Up_Ramp);
    Down_Ramp_Limit = max(Pmin, Initial_Generations - Down_Ramp);

    % Extract prohibited operating zones data from Data2
    Prohibited_Operating_Zones_POZ = Data2(:, 4:end)';
    No_of_POZ_Limits = size(Prohibited_Operating_Zones_POZ, 1);
    POZ_Lower_Limits = Prohibited_Operating_Zones_POZ(1:2:No_of_POZ_Limits, :);
    POZ_Upper_Limits = Prohibited_Operating_Zones_POZ(2:2:No_of_POZ_Limits, :);

    % Compute power loss
    Power_Loss = (x * B1 * x') + (B2 * x') + B3;
    Power_Loss = round(Power_Loss * 10000) / 10000;

    % Calculate the constraint values
    c(1) = abs(Power_Demand + Power_Loss - sum(x));
    c(2) = sum(abs(x - Pmin) - (x - Pmin)) + sum(abs(Pmax - x) - (Pmax - x));
    c(3) = sum(abs(x - Down_Ramp_Limit) - (x - Down_Ramp_Limit)) + sum(abs(Up_Ramp_Limit - x) - (Up_Ramp_Limit - x));

    % Repeat the x vector to compare with POZ limits
    temp_x = repmat(x, No_of_POZ_Limits / 2, 1);
    c(4) = sum(sum((POZ_Lower_Limits < temp_x & temp_x < POZ_Upper_Limits) .* min(temp_x - POZ_Lower_Limits, POZ_Upper_Limits - temp_x)));

    % No equality constraints, set ceq as an empty array
    ceq = [];
end


function xl = get_xl(~)
    xl = [100; 50; 80; 50; 50; 50];
end

function xu = get_xu(~)
    xu = [500; 200; 300; 150; 200; 120];
end

function fmin = get_fmin(~)
    fmin = 15447.4428525634;
end

function xmin = get_xmin(~)
    xmin = [434.390562362830;181.320668922663;257.924552759678;139.724598374641;165.856094826576;96.2876227536128];
end

function [Data1, Data2, B1, B2, B3] = get_data(~)
    Data1 = [100, 500, 0.0070, 7.0,  240;
             50,  200, 0.0095, 10.0, 200;
             80,  300, 0.0090, 8.5,  220;
             50,  150, 0.0090, 11.0, 200;
             50,  200, 0.0080, 10.5, 220;
             50,  120, 0.0075, 12.0, 190];
    Data2 = [440, 80,  120, 210, 240, 350, 380;
             170, 50,  90,  90,  110, 140, 160;
             200, 65,  100, 150, 170, 210, 240;
             150, 50,  90,  80,  90,  110, 120;
             190, 50,  90,  90,  110, 140, 150;
             150, 50,  90,  75,  85,  100, 105];
    B1 = [1.7,  1.2,  0.7, -0.1,  -0.5,  -0.2;
          1.2,  1.4,  0.9,  0.1,  -0.6,  -0.1;
          0.7,  0.9,  3.1,  0.0,  -1.0,  -0.6;
         -0.1,  0.1,  0.0,  0.24, -0.6,  -0.8;
         -0.5, -0.6, -0.1, -0.6,   12.9, -0.2;
          0.2, -0.1, -0.6, -0.8,  -0.2,   15];
    B1 = B1.*10^-5;
    B2 = [-0.3908, -0.1297, 0.7047, 0.0591, 0.2161, -0.6635].*10^-5;
    B3 = 0.0056*10^(-2);
end