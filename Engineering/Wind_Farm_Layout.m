function y = Wind_Farm_Layout(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%    Wind_Farm_Layout.m
%
% Original source: 
% - Kumar, A., Wu, G., Ali, M. Z., Mallipeddi, R., Suganthan, P. N., & 
%   Das, S. (2020). A test-suite of non-convex constrained optimization 
%   problems from the real-world and some baseline results. Swarm and 
%   Evolutionary Computation, 56, 100693.
%
% Known optimal solution:
%   f* = -6242.07333766252
%   x* = [1875.76952055053;1680.47921789039;1820.81032806370;1008.96990082035;
%         1544.15981221053;1217.45086053265;1808.08149455726;85.6431865122777;
%         1897.11119324528;533.120751317391;794.471598373639;1944.32432946944;
%         1725.15634278157;1460.85181014048;1052.74320712697;86.4656395453141;
%         1051.43320811348;303.981865599011;1827.02400938844;1955.19800463589;
%         146.308060931250;1131.79970897197;740.722130566540;1716.64949122488;
%         207.105026583129;533.764950526518;1061.22614030787;544.273014022137;
%         265.525479652530;91.6091421756633]
%     
% Problem Properties:
%   n  = 30;
%   #g = 91;
%   #h = 0;  
% ------------------------------------------------------------------------- 
if nargin == 0
    y.nx = 30;
    y.ng = 91;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) ConFun(i);
    return
end
if size(x, 1) > size(x, 2), x = x'; end

% Constants and parameters for the wind turbine simulation
interval = 15;
interval_num = fix(360 / interval);
cut_in_speed = 3.5;
rated_speed = 14;
cut_out_speed = 25;
R = 40;
CT = 0.8;
a = 1 - sqrt(1 - CT);
kappa = 0.01;
N = 15;
k(1:interval_num) = 2;

% Coefficients for the wind turbine simulation
c = [7, 5, 5, 5, 5, 4, 5, 6, 7, 7, 8, 9.5, 10, 8.5, 8.5, 6.5, 4.6, 2.6, 8, 5, 6.4, 5.2, 4.5, 3.9];

% Frequency of wind speeds at each wind direction
fre = [0.0003, 0.0072, 0.0237, 0.0242, 0.0222, 0.0301, 0.0397, 0.0268, 0.0626, ...
    0.0801, 0.1025, 0.1445, 0.1909, 0.1162, 0.0793, 0.0082, 0.0041, 0.0008, ...
    0.0010, 0.0005, 0.0013, 0.0031, 0.0085, 0.0222];

% Evaluate the fitness function using the Fitness function
y = -Fitness(interval_num, interval, fre, N, x, a, kappa, R, k, c, cut_in_speed, rated_speed, cut_out_speed);
end

function [g, ceq] = ConFun(x)
    % Transpose x if it is a row vector
    if size(x, 1) > size(x, 2)
        x = x';
    end
    
    % Define the radius R and preallocate arrays XX and YY
    R = 40;
    [XX, YY] = deal(zeros(1, 11));
    
    k = 1; % Initialize index k
    g = zeros(1, 91); % Initialize the constraint vector g with zeros
    
    % Extract XX and YY from x
    for i = 1:(0.5 * length(x))
        XX(:, i) = x(:, 2 * i - 1);
        YY(:, i) = x(:, 2 * i);
    end
    
    % Calculate the distance constraints and store them in the vector g
    for i = 1:(0.5 * length(x))
        for j = (i + 1):(0.5 * length(x)) - 1
            g(:, k) = 5 * R - sqrt((XX(:, i) - XX(:, j))^2 + (YY(:, i) - YY(:, j))^2);
            k = k + 1; % Increment the index k
        end
    end
    
    ceq = []; % No equality constraints, set ceq as an empty array
end

function xl = get_xl(nx)
    xl = 40*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 1960*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -6242.07333766252;
end

function xmin = get_xmin(~)
    xmin = [1875.76952055053;1680.47921789039;1820.81032806370;1008.96990082035;1544.15981221053;1217.45086053265;1808.08149455726;85.6431865122777;1897.11119324528;533.120751317391;794.471598373639;1944.32432946944;1725.15634278157;1460.85181014048;1052.74320712697;86.4656395453141;1051.43320811348;303.981865599011;1827.02400938844;1955.19800463589;146.308060931250;1131.79970897197;740.722130566540;1716.64949122488;207.105026583129;533.764950526518;1061.22614030787;544.273014022137;265.525479652530;91.6091421756633];
end

function all_power = Fitness(interval_num, interval, fre, N, coordinate, a, kappa, R, k, c, cut_in_speed, rated_speed, cut_out_speed)
    all_power = 0;                 
    for i = 1:interval_num
        interval_dir = (i - 0.5)*interval;
        power_eva = eva_power(i, interval_dir, N, coordinate, a, kappa, R,k(i), c(i), cut_in_speed, rated_speed, cut_out_speed);
        all_power = all_power + fre(i)*sum(power_eva);
    end
end

function power_eva = eva_power(interval_dir_num, interval_dir, N, coordinate, a, kappa, R, k, c, cut_in_speed, rated_speed, cut_out_speed)
    % Calculate velocity deficits using eva_func_deficit function
    vel_def = eva_func_deficit(interval_dir_num, N, coordinate, interval_dir, a, kappa, R);
    
    % Initialize interval_c array with zeros
    interval_c(1:N) = 0;
    
    % Calculate the interval constants for each wind direction
    for i = 1:N
       interval_c(i) = c * (1 - vel_def(i)); 
    end
    
    % Calculate the number of wind speeds within the range
    n_ws = (rated_speed - cut_in_speed) / 0.3;
    
    % Initialize power_eva array with zeros
    power_eva(1:N) = 0;
    
    % Calculate the power for each wind direction and wind speed interval
    for i = 1:N
        for j = 1:n_ws
            v_j_1 = cut_in_speed + (j - 1) * 0.3;
            v_j = cut_in_speed + j * 0.3;
            power_eva(i) = power_eva(i) + 1500 * exp((v_j_1 + v_j) / 2 - 7.5) / (5 + exp((v_j_1 + v_j) / 2 - 7.5)) * ...
                (exp(-(v_j_1 / interval_c(i))^k) - exp(-(v_j / interval_c(i))^k));
        end
        power_eva(i) = power_eva(i) + 1500 * (exp(-(rated_speed / interval_c(i))^k) - exp(-(cut_out_speed / interval_c(i))^k));
    end
end


function vel_def = eva_func_deficit(interval_dir_num, N, coordinate, theta, a, kappa, R)
    % Define a global variable to store thetaVeldefijMatrix (if not already defined)
    global thetaVeldefijMatrix; %#ok<GVMIS>
    
    % Initialize vel_def array to zeros
    vel_def(1:N) = 0;
    
    % Loop through each downstream turbine (i) to evaluate the velocity deficit
    for i = 1:N
        vel_def_i = 0;
        
        % Loop through each upstream turbine (j) to check if it affects the downstream turbine (i)
        for j = 1:N   
            % Check if the downstream turbine (i) is affected by the wake of the upstream turbine (j)
            [affected, dij] = downstream_wind_turbine_is_affected(coordinate, j, i, theta, kappa, R);
            
            % If affected, calculate the velocity deficit and store it in thetaVeldefijMatrix
            if(affected)  
                def = a / (1 + kappa * dij / R)^2;
                thetaVeldefijMatrix(i, j, interval_dir_num) = def;
                vel_def_i = vel_def_i + def^2;  
            else
                thetaVeldefijMatrix(i, j, interval_dir_num) = 0;
            end  
        end
        
        % Calculate the velocity deficit for the downstream turbine (i) and store it in vel_def
        vel_def(i) = sqrt(vel_def_i);
    end
end


function [affected, dij] = downstream_wind_turbine_is_affected(coordinate, upstream_wind_turbine, downstream_wind_turbine, theta, kappa, R)
    % Initialize affected flag to 0 (not affected)
    affected = 0;
    
    % Calculate the distance between upstream and downstream wind turbines in x and y direction
    Tijx = (coordinate(2 * downstream_wind_turbine - 1) - coordinate(2 * upstream_wind_turbine - 1));
    Tijy = (coordinate(2 * downstream_wind_turbine) - coordinate(2 * upstream_wind_turbine));
    
    % Calculate the projected distance between the two turbines in the direction of the wind
    dij = cosd(theta) * Tijx + sind(theta) * Tijy;
    
    % Calculate the perpendicular distance between the two turbines
    lij = sqrt((Tijx^2 + Tijy^2) - (dij)^2);
    
    % Calculate the safety distance
    l = dij * kappa + R;
    
    % Check if downstream turbine is affected by the wake of the upstream turbine
    if ((upstream_wind_turbine ~= downstream_wind_turbine) && (l > lij - R) && (dij > 0))
        affected = 1; % Set affected flag to 1 (affected)
    end
end