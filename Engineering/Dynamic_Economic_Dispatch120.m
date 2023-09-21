function y = Dynamic_Economic_Dispatch120(x)
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
% Known optimal solution:
%   f* = 52961.0974963761
%   x* = [38.7322064503643;98.1018179730096;45.5343411910347;60.5593909162474;
%         170.383343469346;59.6658676432711;74.9725682682578;53.9032079919254;
%         80.3289894531928;169.804766643353;48.2618636917270;55.7216698800624;
%         85.7518176048218;118.783768705467;170.735080117922;59.7938131874639;
%         67.5776917475606;93.8902529006767;168.611179418220;145.485162746078;
%         51.7458692668045;89.8841025603449;105.449083271598;200.037149442194;
%         116.995895459059;36.7371666403130;108.239435535629;132.224412373118;
%         193.534558040224;144.388527410716;49.1581611305656;119.177527890859;
%         109.655403686400;182.250579791481;173.255627500697;69.9329245881799;
%         94.4571462914343;121.795476000788;177.774700850601;198.147652268995;
%         47.2690802942498;114.263792628930;152.236069878103;169.914787589653;
%         215.301769609064;58.3720538174623;102.835976883517;143.229378011399;
%         212.466318612892;196.524272674729;58.3088137835086;80.0818907957716;
%         161.728750528382;201.896944249049;227.773800643289;49.6765551952384;
%         98.6581013659342;159.260851673876;239.963807312495;202.899984452456;
%         53.2706097360965;90.0094807833546;138.664832785080;242.130505660721;
%         189.448071034749;53.5624180583173;117.394323967404;119.523552498034;
%         228.609203971262;180.118501504981;67.5201895057053;109.811476750959;
%         103.950562996896;181.276803770429;199.599166976011;38.1492875532914;
%         85.4440582661004;98.2761809897372;161.748087399823;202.730585791049; 
%         16.4457544257900;101.336763980929;87.7779558707197;155.765023837702;
%         202.585001884860;20.5918363431688;112.448637136976;117.571941360916;
%         166.966594574395;197.417090584545;43.2064377588967;96.7603674746206;
%         150.028863864841;169.407028806994;202.646302094648;52.1271494777772;
%         116.837175433897;125.924455924287;177.793771056804;240.705248107235;
%         48.2611973491261;110.107038029198;127.995021590622;198.909686336951;
%         203.504156694105;39.2531561742244;88.8831263730176;89.1923642682630;
%         202.834115076893;191.854338107602;57.8414051606672;64.2619452850580;
%         89.9176190138443;164.367631122375;155.892199418056;54.2979425534759;
%         60.9267133961590;109.416310037090;131.018286233929;111.404847779344];
%
% Problem Properties:
%   n  = 120
%   #g = 4;
%   #h = 0;
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 120;
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
No_of_Units = 5;

% Reshape the input generations into a matrix
Input_Generations = reshape(x, No_of_Units, No_of_Load_Hours)';

% Retrieve data from the Solvethis function and get Pmin
[~, Data1] = Solvethis;
Pmin = Data1(:, 1)';

% Initialize the Current_Cost variable
Current_Cost = zeros(No_of_Load_Hours, 1);

% Extract data coefficients for the cost function
a = Data1(:, 3)';
b = Data1(:, 4)';
c = Data1(:, 5)';
e = Data1(:, 6)';
f = Data1(:, 7)';

% Loop through each load hour and compute the cost
for j = 1:No_of_Load_Hours
    x = Input_Generations(j, :);

    % Compute the cost for the current load hour
    Current_Cost(j) = sum(a .* (x.^2) + b .* x + c + abs(e .* sin(f .* (Pmin - x))));
end

% Sum up the total cost across all load hours
y = sum(Current_Cost);

% If the result is NaN, set y to a large value
if isnan(y), y = 10^100; end
end

function [c, ceq] = confun(x)
    if size(x, 1) > size(x, 2), x = x'; end

    % Number of load hours and units
    No_of_Load_Hours = 24;
    No_of_Units = 5;

    % Reshape the input generations into a matrix
    Input_Generations = reshape(x, No_of_Units, No_of_Load_Hours)';

    % Retrieve data and coefficients from the Solvethis function
    [Power_Demand, Data1, Data2, B1] = Solvethis;
    B2 = zeros(1, 5);
    B3 = 0;
    Pmin = Data1(:, 1)';
    Pmax = Data1(:, 2)';
    Previous_Generations = Data2(:, 1)';
    Up_Ramp = Data2(:, 2)';
    Down_Ramp = Data2(:, 3)';
    Prohibited_Operating_Zones_POZ = Data2(:, 4:end)';
    No_of_POZ_Limits = size(Prohibited_Operating_Zones_POZ, 1);
    POZ_Lower_Limits = Prohibited_Operating_Zones_POZ(1:2:No_of_POZ_Limits, :);
    POZ_Upper_Limits = Prohibited_Operating_Zones_POZ(2:2:No_of_POZ_Limits, :);

    % Initialize penalty and power loss variables
    Power_Balance_Penalty = zeros(No_of_Load_Hours, 1);
    Capacity_Limits_Penalty = zeros(No_of_Load_Hours, 1);
    Up_Ramp_Limit = zeros(No_of_Load_Hours, No_of_Units);
    Down_Ramp_Limit = zeros(No_of_Load_Hours, No_of_Units);
    Ramp_Limits_Penalty = zeros(No_of_Load_Hours, 1);
    POZ_Penalty = zeros(No_of_Load_Hours, 1);
    Power_Loss = zeros(No_of_Load_Hours, 1);

    % Loop through each load hour and compute penalties
    for j = 1:No_of_Load_Hours
        x = Input_Generations(j, :);

        % Compute power loss and update it to the nearest 4 decimal places
        Power_Loss(j) = (x * B1 * x') + (B2 * x') + B3;
        Power_Loss(j) = round(Power_Loss(j) * 10000) / 10000;

        % Compute power balance penalty
        Power_Balance_Penalty(j) = abs(Power_Demand(j) + Power_Loss(j) - sum(x));

        % Compute capacity limits penalty
        Capacity_Limits_Penalty(j) = sum(abs(x - Pmin) - (x - Pmin)) + sum(abs(Pmax - x) - (Pmax - x));

        % Compute ramp limits penalty (except for the first load hour)
        if j > 1
            Up_Ramp_Limit(j, :) = min(Pmax, Previous_Generations + Up_Ramp);
            Down_Ramp_Limit(j, :) = max(Pmin, Previous_Generations - Down_Ramp);
            Ramp_Limits_Penalty(j) = sum(abs(x - Down_Ramp_Limit(j, :)) - (x - Down_Ramp_Limit(j, :))) + sum(abs(Up_Ramp_Limit(j, :) - x) - (Up_Ramp_Limit(j, :) - x));
        end

        % Compute the penalty for operating within prohibited zones
        Previous_Generations = x;
        temp_x = repmat(x, No_of_POZ_Limits / 2, 1);
        POZ_Penalty(j) = sum(sum((POZ_Lower_Limits < temp_x & temp_x < POZ_Upper_Limits) .* min(temp_x - POZ_Lower_Limits, POZ_Upper_Limits - temp_x)));
    end

    % Set up inequality constraints (sum of penalties)
    c(1) = sum(Power_Balance_Penalty);
    c(2) = sum(Capacity_Limits_Penalty);
    c(3) = sum(Ramp_Limits_Penalty);
    c(4) = sum(POZ_Penalty);

    % No equality constraints, set ceq to empty
    ceq = [];
end


function xl = get_xl(~)             
    xl = repmat([10; 20; 30; 40; 50], 24, 1);       
end

function xu = get_xu(~)
    xu = repmat([75; 125; 175; 250; 300], 24, 1); 
end

function fmin = get_fmin(~)
    fmin = 52961.0974963761;
end

function xmin = get_xmin(~)
    xmin = [38.7322064503643;98.1018179730096;45.5343411910347;60.5593909162474;170.383343469346;59.6658676432711;74.9725682682578;53.9032079919254;80.3289894531928;169.804766643353;48.2618636917270;55.7216698800624;85.7518176048218;118.783768705467;170.735080117922;59.7938131874639;67.5776917475606;93.8902529006767;168.611179418220;145.485162746078;51.7458692668045;89.8841025603449;105.449083271598;200.037149442194;116.995895459059;36.7371666403130;108.239435535629;132.224412373118;193.534558040224;144.388527410716;49.1581611305656;119.177527890859;109.655403686400;182.250579791481;173.255627500697;69.9329245881799;94.4571462914343;121.795476000788;177.774700850601;198.147652268995;47.2690802942498;114.263792628930;152.236069878103;169.914787589653;215.301769609064;58.3720538174623;102.835976883517;143.229378011399;212.466318612892;196.524272674729;58.3088137835086;80.0818907957716;161.728750528382;201.896944249049;227.773800643289;49.6765551952384;98.6581013659342;159.260851673876;239.963807312495;202.899984452456;53.2706097360965;90.0094807833546;138.664832785080;242.130505660721;189.448071034749;53.5624180583173;117.394323967404;119.523552498034;228.609203971262;180.118501504981;67.5201895057053;109.811476750959;103.950562996896;181.276803770429;199.599166976011;38.1492875532914;85.4440582661004;98.2761809897372;161.748087399823;202.730585791049;16.4457544257900;101.336763980929;87.7779558707197;155.765023837702;202.585001884860;20.5918363431688;112.448637136976;117.571941360916;166.966594574395;197.417090584545;43.2064377588967;96.7603674746206;150.028863864841;169.407028806994;202.646302094648;52.1271494777772;116.837175433897;125.924455924287;177.793771056804;240.705248107235;48.2611973491261;110.107038029198;127.995021590622;198.909686336951;203.504156694105;39.2531561742244;88.8831263730176;89.1923642682630;202.834115076893;191.854338107602;57.8414051606672;64.2619452850580;89.9176190138443;164.367631122375;155.892199418056;54.2979425534759;60.9267133961590;109.416310037090;131.018286233929;111.404847779344];
end

function [Power_Demand, Data1, Data2, B1] = Solvethis
    Power_Demand = [410,435,475,530,558,608,626,654,690,704,720,740,704,690,654,580,558,608,654,704,680,605,527,463];
    Data1 = [10,75,0.008,2,25,100,0.042; 20,125,0.003,1.8,60,140,0.04;
             30,175,0.0012,2.1,100,160,0.038; 40,250,0.001,2,120,180,0.037;
             50,300,0.0015,1.8,40,200,0.035];
    Data2 = [NaN,30,30,10,10,10,10; NaN,30,30,20,20,20,20;
             NaN,40,40,30,30,30,30; NaN,50,50,40,40,40,40;
             NaN,50,50,50,50,50,50];
    B1 = [0.000049,0.000014,0.000015,0.000015,0.00002; 0.000014,0.000045,0.000016,0.00002,0.000018;				
          0.000015,0.000016,0.000039,0.00001,0.000012; 0.000015,0.00002,0.00001,0.00004,0.000014;				
          0.00002,0,0.000012,0,0.000035];
end