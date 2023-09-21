function y = Static_Economic_Load_Dispatch13(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Static_Economic_Load_Dispatch.m
%
% Original source: 
% - Das, S., & Suganthan, P. N. (2010). Problem definitions and evaluation 
%   criteria for CEC 2011 competition on testing evolutionary algorithms on 
%   real world optimization problems. Jadavpur University, Nanyang 
%   Technological University, Kolkata, 341-359.
%
% Known optimal solution:
%   f* = 18320.2272779774
%   x* = [269.327097450086;149.590552852669;322.201038541301;110.339019250626;
%         160.999468828583;109.912356240450;110.024950451442;111.683043705289;
%         113.707872308081;79.8931329678040;77.4027913291496;92.4021950559332;
%         92.5164810185871]
%     
% Problem Properties:
%   n  = 13;
%   #g = 2;
%   #h = 0;   
% ------------------------------------------------------------------------- 
if nargin == 0
    y.nx = 13;
    y.ng = 2;
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
Data1 = get_data(x); 
Pmin = Data1(:, 1)'; 
a = Data1(:, 3)';
b = Data1(:, 4)'; 
c = Data1(:, 5)';
e = Data1(:, 6)';
f = Data1(:, 7)';

% Sum up the total cost
y = sum(a.*(x.^2) + b.*x + c + abs(e.*sin(f.*(Pmin - x))));
end

function [c, ceq] = confun(x)
    % Ensure x is a row vector
    if size(x, 1) > size(x, 2), x = x'; end

    % Power demand value
    Power_Demand = 1800;

    % Get data from the get_data function with input x
    [Data1, B1, B2, B3] = get_data(x);

    % Extract Pmax and Pmin from Data1
    Pmax = Data1(:, 2)';
    Pmin = Data1(:, 1)';

    % Compute power loss
    Power_Loss = (x * B1 * x') + (B2 * x') + B3;
    Power_Loss = round(Power_Loss * 10000) / 10000;

    % Calculate the constraint values
    c(1) = abs(Power_Demand + Power_Loss - sum(x));
    c(2) = sum(abs(x - Pmin) - (x - Pmin)) + sum(abs(Pmax - x) - (Pmax - x));

    % No equality constraints, set ceq as an empty array
    ceq = [];
end


function xl = get_xl(~)
    xl = [0;0;0;60;60;60;60;60;60;40;40;55;55];
end

function xu = get_xu(~)
    xu = [680;360;360;180;180;180;180;180;180;120;120;120;120];
end

function fmin = get_fmin(~)
    fmin = 18320.2272779774;
end

function xmin = get_xmin(~)
    xmin = [269.327097450086;149.590552852669;322.201038541301;...
        110.339019250626;160.999468828583;109.912356240450;...
        110.024950451442;111.683043705289;113.707872308081;...
        79.8931329678040;77.4027913291496;92.4021950559332;92.5164810185871];
end

function [Data1, B1, B2, B3] = get_data(x)
    Data1 = [0,  680, 0.00028, 8.1,  550, 300, 0.035;
             0,  360, 0.00056, 8.1,  309, 200, 0.042;
             0,  360, 0.00056, 8.1,  307, 200, 0.042;
             60, 180, 0.00324, 7.74, 240, 150, 0.063;
             60, 180, 0.00324, 7.74, 240, 150, 0.063;
             60, 180, 0.00324, 7.74, 240, 150, 0.063;
             60, 180, 0.00324, 7.74, 240, 150, 0.063;
             60, 180, 0.00324, 7.74, 240, 150, 0.063;
             60, 180, 0.00324, 7.74, 240, 150, 0.063;
             40, 120, 0.00284, 8.6,  126, 100, 0.084;
             40, 120, 0.00284, 8.6,  126, 100, 0.084;
             55, 120, 0.00284, 8.6,  126, 100, 0.084;
             55, 120, 0.00284, 8.6,  126, 100, 0.084];
    B1 = zeros(length(x), length(x));
    B2 = zeros(1, length(x));
    B3 = 0;
end