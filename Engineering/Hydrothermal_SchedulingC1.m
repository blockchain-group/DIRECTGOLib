function y = Hydrothermal_SchedulingC1(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Hydrothermal_SchedulingC1.m
%
% Original source: 
% - Das, S., & Suganthan, P. N. (2010). Problem definitions and evaluation 
%   criteria for CEC 2011 competition on testing evolutionary algorithms on 
%   real world optimization problems. Jadavpur University, Nanyang 
%   Technological University, Kolkata, 341-359.
%
% Known optimal solution:
%   f* = 941784.1712774395
%   x* = [6.46646051789355;6.69407031013254;29.3592684813871;13.5749902141818;
%         5.61630391726921;6.74500282190671;15.8228639017726;14.3715764151970;
%         6.87056326533850;7.80168142236105;28.7008204873291;13.1414788309645;
%         9.68368208108362;9.69828950024570;27.2246800651134;13.7642567966538;
%         10.2253039664261;11.7164404696569;14.2605433096725;14.1952705591002;
%         7.32357136217277;14.2220938620550;13.1614083342986;13.0632244188319;
%         6.16775158419984;13.7935451274776;14.1172914732308;14.8149304211109;
%         12.1145578894323;8.19146484619378;14.7653922529743;13.7782392580924;
%         6.41709485846664;7.28775613615612;22.1768957533648;17.4477658576516;
%         6.40272153421745;6.17425445038285;23.3895748119996;13.0403189512690;  
%         13.7643743754868;8.76510144432734;14.1702045804178;18.9150876670330;
%         5.90952383283244;6.86240290002607;14.7406949616510;15.5638925045513;
%         6.23602004334378;8.37262608041386;18.2369743046879;14.7043798881754;
%         9.55391636973624;7.54360094114979;14.7391552837211;15.1399558801042;
%         6.27170767631530;7.02109928303095;26.8651380356955;14.7475914068377;
%         14.9426662251807;6.05663451313079;14.9109621160673;14.5636174264354;
%         6.86703654062140;6.25761701553054;13.5381278821249;13.0450134197420;
%         7.29801427514997;9.10516771989485;17.9059319953939;15.9614268988180;
%         6.68508833461185;7.98268581721020;16.5338012128211;13.2323610474550;
%         6.32116735680104;9.66609814028909;10.9130983834339;15.5681993021467;
%         5.10825453141927;10.1223529413997;10.2511318264659;13.0953622596750;
%         8.73957976821581;7.52553098829701;15.5303783740867;13.7970454694936; 
%         9.15702554410396;7.36088063476790;12.0811253209973;19.6975184762366;
%         10.8576141496814;7.03360263396362;13.9698829004790;13.1093242574001]
%  
% Problem Properties:
%   n  = 96;
%   #g = 5;
%   #h = 0;  
% ------------------------------------------------------------------------- 
if nargin == 0
    y.nx = 96;
    y.ng = 5;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx);
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) confun(i);
    return
end

if size(x, 1) > size(x, 2)
    x = x';
end

% Constants for the problem
No_of_Load_Hours = 24;
No_of_Units = 4;

% Reshape the input vector to Discharges matrix
Input_Discharges = reshape(x, No_of_Units, No_of_Load_Hours);

% Get data for the problem
[Power_Demand, Inflow_Rate, Spillages, ~, ~, ~, ~, c1, c2, c3, c4, c5, c6, Delay_Time, No_of_Upstreams, ~, ~, V_Initial, ~, ~, ~] = get_data(No_of_Units, No_of_Load_Hours);

% Initialize matrices and arrays
Storage_Volume = [V_Initial', zeros(No_of_Units, No_of_Load_Hours)];
Max_Delay = max(Delay_Time);
Initial_Discharges = zeros(No_of_Units, Max_Delay);
Initial_Spillages = zeros(No_of_Units, Max_Delay);
All_Spillages = [Initial_Spillages, Spillages];
All_Discharges = [Initial_Discharges, Input_Discharges];
Upstream_Carry = zeros(No_of_Units, No_of_Load_Hours);

% Calculate Upstream Carry for each unit
for i = 1:No_of_Units
    for j = 1:No_of_Load_Hours
        Upstream_Volume = 0;
        for k = (i - No_of_Upstreams(i)):(i - 1)
            Upstream_Volume = Upstream_Volume + All_Discharges(k, j + Max_Delay - Delay_Time(k)) + All_Spillages(k, j + Max_Delay - Delay_Time(k));
        end
        Upstream_Carry(i, j) = Upstream_Volume;
        Storage_Volume(i, j + 1) = Storage_Volume(i, j) + Upstream_Volume - Input_Discharges(i, j) - Spillages(i, j) + Inflow_Rate(i, j);
    end
end

% Initialize cost and loss arrays
Current_Cost = zeros(No_of_Load_Hours, 1);
Power_Loss = zeros(No_of_Load_Hours, 1);

% Calculate cost and loss for each load hour
for j = 1:No_of_Load_Hours
    q = Input_Discharges(:, j)';
    v = Storage_Volume(:, j + 1)';
    Ph = c1 .* (v.^2) + c2 .* (q.^2) + c3 .* (v .* q) + c4 .* (v) + c5 .* (q) + c6;
    Ph = Ph .* (Ph > 0);
    P_Thermal = Power_Demand(j) + Power_Loss(j) - sum(Ph);
    Current_Cost(j) = 5000 + 19.2 * P_Thermal + 0.002 * (P_Thermal^2);
end

% Calculate the total cost
y = sum(Current_Cost);
if isnan(y)
    y = 10^100;
end
end

function [c, ceq] = confun(x)
    if size(x, 1) > size(x, 2)
        x = x';
    end
    
    % Constants for the problem
    No_of_Load_Hours = 24;
    No_of_Units = 4;
    
    % Reshape the input vector to Discharges matrix
    Input_Discharges = reshape(x, No_of_Units, No_of_Load_Hours);

    % Get data for the problem
    [Power_Demand, Inflow_Rate, Spillages, Ptmin, Ptmax, PHmin, PHmax, c1, c2, c3, c4, c5, c6, Delay_Time, No_of_Upstreams, Vmin, Vmax, V_Initial, V_Final, Qmin, Qmax] = get_data(No_of_Units, No_of_Load_Hours);
    
    % Initialize matrices and arrays
    Storage_Volume = [V_Initial', zeros(No_of_Units, No_of_Load_Hours)];
    Max_Delay = max(Delay_Time);
    Initial_Discharges = zeros(No_of_Units, Max_Delay);
    Initial_Spillages = zeros(No_of_Units, Max_Delay);
    All_Spillages = [Initial_Spillages, Spillages];
    All_Discharges = [Initial_Discharges, Input_Discharges];
    Upstream_Carry = zeros(No_of_Units, No_of_Load_Hours);

    % Calculate Upstream Carry for each unit
    for i = 1:No_of_Units
        for j = 1:No_of_Load_Hours
            Upstream_Volume = 0;
            for k = (i - No_of_Upstreams(i)):(i - 1)
                Upstream_Volume = Upstream_Volume + All_Discharges(k, j + Max_Delay - Delay_Time(k)) + All_Spillages(k, j + Max_Delay - Delay_Time(k));
            end
            Upstream_Carry(i, j) = Upstream_Volume;
            Storage_Volume(i, j + 1) = Storage_Volume(i, j) + Upstream_Volume - Input_Discharges(i, j) - Spillages(i, j) + Inflow_Rate(i, j);
        end
    end

    % Initialize penalty and result matrices
    Discharge_Rate_Limits_Penalty = zeros(No_of_Load_Hours, 1);
    Storage_Volume_Limits_Penalty = zeros(No_of_Load_Hours, 1);
    Capacity_Limits_Penalty_H = zeros(No_of_Load_Hours, 1);
    Capacity_Limits_Penalty_T = zeros(No_of_Load_Hours, 1);
    Power_Balance_Penalty = zeros(No_of_Load_Hours, 1);
    Current_Cost = zeros(No_of_Load_Hours, 1);
    Power_Loss = zeros(No_of_Load_Hours, 1);
    Hydro_Generations = zeros(No_of_Load_Hours, No_of_Units);
    Thermal_Generations = zeros(No_of_Load_Hours, 1);

    % Calculate penalty and generation values for each load hour
    for j = 1:No_of_Load_Hours
        q = Input_Discharges(:, j)';
        v = Storage_Volume(:, j + 1)';
        Discharge_Rate_Limits_Penalty(j) = sum(abs(q - Qmin) - (q - Qmin)) + sum(abs(Qmax - q) - (Qmax - q));
        Storage_Volume_Limits_Penalty(j) = sum(abs(v - Vmin) - (v - Vmin)) + sum(abs(Vmax - v) - (Vmax - v));
        Ph = c1 .* (v.^2) + c2 .* (q.^2) + c3 .* (v .* q) + c4 .* (v) + c5 .* (q) + c6;
        Ph = Ph .* (Ph > 0);
        Hydro_Generations(j, :) = Ph;
        Capacity_Limits_Penalty_H(j) = sum(abs(Ph - PHmin) - (Ph - PHmin)) + sum(abs(PHmax - Ph) - (PHmax - Ph));
        P_Thermal = Power_Demand(j) + Power_Loss(j) - sum(Ph);
        Thermal_Generations(j) = P_Thermal;
        Capacity_Limits_Penalty_T(j) = sum(abs(P_Thermal - Ptmin) - (P_Thermal - Ptmin)) + sum(abs(Ptmax - P_Thermal) - (Ptmax - P_Thermal));
        Power_Balance_Penalty(j) = abs(Power_Demand(j) + Power_Loss(j) - sum(Ph) - P_Thermal);
        Current_Cost(j) = 5000 + 19.2 * P_Thermal + 0.002 * (P_Thermal^2);
    end

    % Calculate the constraint values
    c(1) = sum(Power_Balance_Penalty);
    c(2) = sum(Capacity_Limits_Penalty_H);
    c(3) = sum(Discharge_Rate_Limits_Penalty);
    c(4) = sum(Storage_Volume_Limits_Penalty);
    c(5) = sum(abs(Storage_Volume(:, 1) - V_Initial')) + sum(abs(Storage_Volume(:, end) - V_Final'));
    
    % There are no equality constraints
    ceq = [];
end

function xl = get_xl(~)
    xl = repmat([5; 6; 10; 13], 24, 1);
end

function xu = get_xu(~)
    xu = repmat([15; 15; 30; 25], 24, 1);
end

function fmin = get_fmin(~)
    fmin = 941784.1712774395;
end

function xmin = get_xmin(~)
    xmin = [6.46646051789355;6.69407031013254;29.3592684813871;13.5749902141818;5.61630391726921;6.74500282190671;15.8228639017726;14.3715764151970;6.87056326533850;7.80168142236105;28.7008204873291;13.1414788309645;9.68368208108362;9.69828950024570;27.2246800651134;13.7642567966538;10.2253039664261;11.7164404696569;14.2605433096725;14.1952705591002;7.32357136217277;14.2220938620550;13.1614083342986;13.0632244188319;6.16775158419984;13.7935451274776;14.1172914732308;14.8149304211109;12.1145578894323;8.19146484619378;14.7653922529743;13.7782392580924;6.41709485846664;7.28775613615612;22.1768957533648;17.4477658576516;6.40272153421745;6.17425445038285;23.3895748119996;13.0403189512690;13.7643743754868;8.76510144432734;14.1702045804178;18.9150876670330;5.90952383283244;6.86240290002607;14.7406949616510;15.5638925045513;6.23602004334378;8.37262608041386;18.2369743046879;14.7043798881754;9.55391636973624;7.54360094114979;14.7391552837211;15.1399558801042;6.27170767631530;7.02109928303095;26.8651380356955;14.7475914068377;14.9426662251807;6.05663451313079;14.9109621160673;14.5636174264354;6.86703654062140;6.25761701553054;13.5381278821249;13.0450134197420;7.29801427514997;9.10516771989485;17.9059319953939;15.9614268988180;6.68508833461185;7.98268581721020;16.5338012128211;13.2323610474550;6.32116735680104;9.66609814028909;10.9130983834339;15.5681993021467;5.10825453141927;10.1223529413997;10.2511318264659;13.0953622596750;8.73957976821581;7.52553098829701;15.5303783740867;13.7970454694936;9.15702554410396;7.36088063476790;12.0811253209973;19.6975184762366;10.8576141496814;7.03360263396362;13.9698829004790;13.1093242574001];
end

function [Power_Demand, Inflow_Rate, Spillages, Ptmin, Ptmax, PHmin, PHmax, c1, c2, c3, c4, c5, c6, Delay_Time, No_of_Upstreams, Vmin, Vmax, V_Initial, V_Final, Qmin, Qmax] = get_data(No_of_Units, No_of_Load_Hours)

    % Power demand in MW
    Power_Demand = [1370, 1390, 1360, 1290, 1290, 1410, 1650, 2000, 2240, 2320, 2230, 2310, 2230, 2200, 2130, 2070, 2130, 2140, 2240, 2280, 2240, 2120, 1850, 1590];

    % Cost coefficients for each unit
    C_Coefficients = [
        -0.0042, -0.42, 0.030, 0.90, 10.0, -50;
        -0.0040, -0.30, 0.015, 1.14, 9.5, -70;
        -0.0016, -0.30, 0.014, 0.55, 5.5, -40;
        -0.0030, -0.31, 0.027, 1.44, 14.0, -90
    ];

    % Inflow rates for each unit at different load hours
    Inflow_Rate = [
        10, 9, 8, 7, 6, 7, 8, 9, 10, 11, 12, 10, 11, 12, 11, 10, 9, 8, 7, 6, 7, 8, 9, 10;
        8, 8, 9, 9, 8, 7, 6, 7, 8, 9, 9, 8, 8, 9, 9, 8, 7, 6, 7, 8, 9, 9, 8, 8;
        8.1, 8.2, 4, 2, 3, 4, 3, 2, 1, 1, 1, 2, 4, 3, 3, 2, 2, 2, 1, 1, 2, 2, 1, 0;
        2.8, 2.4, 1.6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    ];

    % Initialize spillages matrix
    Spillages = zeros(No_of_Units, No_of_Load_Hours);

    % Constants for Power Min and Max
    Ptmin = 500;
    Ptmax = 2500;

    % Constants for Hydropower Min and Max
    PHmin = [0, 0, 0, 0];
    PHmax = [500, 500, 500, 500];

    % Cost coefficients for each unit (transposed for convenience)
    c1 = C_Coefficients(:, 1)';
    c2 = C_Coefficients(:, 2)';
    c3 = C_Coefficients(:, 3)';
    c4 = C_Coefficients(:, 4)';
    c5 = C_Coefficients(:, 5)';
    c6 = C_Coefficients(:, 6)';

    % Delay time, number of upstreams, and voltage constraints for each unit
    Delay_Time = [2, 3, 4, 0];
    No_of_Upstreams = [0, 0, 2, 1];
    Vmin = [80, 60, 100, 70];
    Vmax = [150, 120, 240, 160];
    V_Initial = [100, 80, 170, 120];
    V_Final = [120, 70, 170, 140];

    % Flow rate constraints for each unit
    Qmin = [5, 6, 10, 13];
    Qmax = [15, 15, 30, 25];
end