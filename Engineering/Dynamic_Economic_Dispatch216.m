function y = Dynamic_Economic_Dispatch216(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Dynamic_Economic_Dispatch120.m
%
% Original source: 
% - Das, S., & Suganthan, P. N. (2010). Problem definitions and evaluation 
%   criteria for CEC 2011 competition on testing evolutionary algorithms on 
%   real world optimization problems. Jadavpur University, Nanyang 
%   Technological University, Kolkata, 341-359.
%
% Unknown feasible solution optimal solution:
%   f* = -
%   x* = -
%
% Problem Properties:
%   n  = 216
%   #g = 4
%   #h = 0
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 216;
    y.ng = 4;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) confun(i);
    return
end
% Ensure x is a row vector
if size(x, 1) > size(x, 2), x = x'; end

% Number of load hours and units
No_of_Load_Hours = 24;
No_of_Units = 10;

% Append additional values (55) to x to make it suitable for Input_Generations
x = [x, ones(1, 24) * 55];

% Reshape the input generations into a matrix
Input_Generations = reshape(x, No_of_Units, No_of_Load_Hours)';

% Retrieve data from the Solvethis function
[~, Data1, ~] = Solvethis;

% Extract data from Data1
Pmin = Data1(:, 1)';
a = Data1(:, 3)';
b = Data1(:, 4)';
c = Data1(:, 5)';
e = Data1(:, 6)';
f = Data1(:, 7)';

% Initialize Current_Cost vector
Current_Cost = zeros(No_of_Load_Hours, 1);

% Loop through each load hour and compute the current cost
for j = 1:No_of_Load_Hours
    x = Input_Generations(j, :);
    Current_Cost(j) = sum(a.*(x.^2) + b.*x + c + abs(e.*sin(f.*(Pmin - x))));
end

% Compute the total cost (sum of Current_Cost) and set a large value (10^100) if y is NaN
y = sum(Current_Cost);
if isnan(y)
    y = 10^100;
end
end

function [c, ceq] = confun(x)
    % Ensure x is a row vector
    if size(x, 1) > size(x, 2), x = x'; end

    % Number of load hours and units
    No_of_Load_Hours = 24;
    No_of_Units = 10;

    % Append additional values (55) to x to make it suitable for Input_Generations
    x = [x, ones(1, 24) * 55];

    % Reshape the input generations into a matrix
    Input_Generations = reshape(x, No_of_Units, No_of_Load_Hours)';

    % Retrieve data from the Solvethis function
    [Power_Demand, Data1, Data2] = Solvethis;

    % Initialize matrices B1, B2, and B3
    B1 = zeros(10, 10);
    B2 = zeros(1, 10);
    B3 = 0;

    % Extract data from Data1
    Pmin = Data1(:, 1)';
    Pmax = Data1(:, 2)';

    % Extract data from Data2
    Previous_Generations = Data2(:, 1)';
    Up_Ramp = Data2(:, 2)';
    Down_Ramp = Data2(:, 3)';
    Prohibited_Operating_Zones_POZ = Data2(:, 4:end)';
    No_of_POZ_Limits = size(Prohibited_Operating_Zones_POZ, 1);
    POZ_Lower_Limits = Prohibited_Operating_Zones_POZ(1:2:No_of_POZ_Limits, :);
    POZ_Upper_Limits = Prohibited_Operating_Zones_POZ(2:2:No_of_POZ_Limits, :);

    % Initialize penalty matrices
    Power_Balance_Penalty = zeros(No_of_Load_Hours, 1);
    Capacity_Limits_Penalty = zeros(No_of_Load_Hours, 1);
    Up_Ramp_Limit = zeros(No_of_Load_Hours, No_of_Units);
    Down_Ramp_Limit = zeros(No_of_Load_Hours, No_of_Units);
    Ramp_Limits_Penalty = zeros(No_of_Load_Hours, 1);
    POZ_Penalty = zeros(No_of_Load_Hours, 1);
    Power_Loss = zeros(No_of_Load_Hours, 1);

    % Loop through each load hour and compute the penalties
    for j = 1:No_of_Load_Hours
        x = Input_Generations(j, :);

        % Compute power loss for the current load hour
        Power_Loss(j) = (x * B1 * x') + (B2 * x') + B3;

        % Compute power balance penalty for the current load hour
        Power_Balance_Penalty(j) = abs(Power_Demand(j) + Power_Loss(j) - sum(x));

        % Compute capacity limits penalty for the current load hour
        Capacity_Limits_Penalty(j) = sum(abs(x - Pmin) - (x - Pmin)) + sum(abs(Pmax - x) - (Pmax - x));

        % Compute ramp limits penalty for the current load hour (except the first load hour)
        if j > 1
            Up_Ramp_Limit(j, :) = min(Pmax, Previous_Generations + Up_Ramp);
            Down_Ramp_Limit(j, :) = max(Pmin, Previous_Generations - Down_Ramp);
            Ramp_Limits_Penalty(j) = sum(abs(x - Down_Ramp_Limit(j, :)) - (x - Down_Ramp_Limit(j, :))) + sum(abs(Up_Ramp_Limit(j, :) - x) - (Up_Ramp_Limit(j, :) - x));
        end

        % Update Previous_Generations for the next iteration
        Previous_Generations = x;

        % Compute penalty for prohibited operating zones (POZ) for the current load hour
        temp_x = repmat(x, No_of_POZ_Limits / 2, 1);
        POZ_Penalty(j) = sum(sum((POZ_Lower_Limits < temp_x & temp_x < POZ_Upper_Limits) .* min(temp_x - POZ_Lower_Limits, POZ_Upper_Limits - temp_x)));
    end

    % Set up the constraints (inequalities c and equalities ceq)
    c(1) = sum(Power_Balance_Penalty);
    c(2) = sum(Capacity_Limits_Penalty);
    c(3) = sum(Ramp_Limits_Penalty);
    c(4) = sum(POZ_Penalty);
    ceq = [];
end


function xl = get_xl(~)
    xl = repmat([150; 135; 73; 60; 73; 57; 20; 47; 20], 24, 1);
end

function xu = get_xu(~)
    xu = repmat([470; 460; 340; 300; 243; 160; 130; 120; 80], 24, 1);
end

function fmin = get_fmin(~)
    fmin = -inf;
end

function xmin = get_xmin(nx)
    xmin = nan(nx, 1);
end

function [Power_Demand, Data1, Data2] = Solvethis
    Power_Demand = [1036,1110,1258,1406,1480,1628,1702,1776,1924,2072,2146,...
                    2220,2072,1924,1776,1554,1480,1628,1776,2072,1924,1628,1332,1184];
    Data1= [150,470,0.00043,21.6,958.2,450,0.041;135,460,0.00063,21.05,1313.6,600,0.036;
            73,340,0.00039,20.81,604.97,320,0.028;60,300,0.0007,23.9,471.6,260,0.052;
            73,243,0.00079,21.62,480.29,280,0.063;57,160,0.00056,17.87,601.75,310,0.048;
            20,130,0.00211,16.51,502.7,300,0.086;47,120,0.0048,23.23,639.4,340,0.082;
            20,80,0.10908,19.58,455.6,270,0.098;55,55,0.00951,22.54,692.4,380,0.094];
    Data2 = [NaN,80,80;NaN,80,80;NaN,80,80;NaN,50,50;NaN,50,50;NaN,50,50;
             NaN,30,30;NaN,30,30;NaN,30,30;NaN,30,30];
end