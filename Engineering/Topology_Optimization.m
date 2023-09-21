function y = Topology_Optimization(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Topology_Optimization.m
%
% Original source: 
% - Kumar, A., Wu, G., Ali, M. Z., Mallipeddi, R., Suganthan, P. N., & 
%   Das, S. (2020). A test-suite of non-convex constrained optimization 
%   problems from the real-world and some baseline results. Swarm and 
%   Evolutionary Computation, 56, 100693.
%
% Known optimal solution:
%   f* = 2.639346497036027
%   x = ones(nx, 1);
%      
% Problem Properties:
%   n  = 30;
%   #g = 30;
%   #h = 0;  
% ------------------------------------------------------------------------- 
if nargin == 0
    y.nx = 30;
    y.ng = 30;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) ConFun(i);
    return
end
% Ensure that x is a column vector
if size(x, 1) > size(x, 2)
    x = x';
end
nely = 10; % Number of elements in y-direction
nelx = 3;  % Number of elements in x-direction
penal = 3; % Penalty parameter
X = [x(1:10); x(11:20); x(21:30)]'; % Reshape input x to form X matrix
U = FE(3, 10, X, 3); % Calculate displacements using Finite Element analysis
KE = lk; % Calculate stiffness matrix
y = 0; % Initialize the objective function value

% Loop through each element to calculate the objective function
for ely = 1:nely
    for elx = 1:nelx
        n1 = (nely + 1) * (elx - 1) + ely;
        n2 = (nely + 1) * elx + ely;
        Ue = U([2 * n1 - 1; 2 * n1; 2 * n2 - 1; 2 * n2; 2 * n2 + 1; 2 * n2 + 2; 2 * n1 + 1; 2 * n1 + 2], 1);
        y = y + X(ely, elx)^penal * Ue' * KE * Ue;
    end
end
end

function [g, ceq] = ConFun(x)
    % If x is given as a row vector, convert it to a column vector
    if size(x, 1) > size(x, 2)
        x = x';
    end
    
    % Define problem parameters
    nely = 10;
    nelx = 3;
    penal = 3;
    
    % Extract design variables from the input vector x
    X = [x(1:10); x(11:20); x(21:30)]';
    
    % Perform Finite Element analysis to get displacement field U
    U = FE(3, 10, X, 3);
    
    % Define element stiffness matrix KE 
    KE = lk;
    
    % Initialize density sensitivity matrix dc
    dc = zeros(nely, nelx);
    
    % Calculate density sensitivities
    for ely = 1:nely
        for elx = 1:nelx
            n1 = (nely + 1) * (elx - 1) + ely;
            n2 = (nely + 1) * elx + ely;
            Ue = U([2 * n1 - 1; 2 * n1; 2 * n2 - 1; 2 * n2; 2 * n2 + 1; 2 * n2 + 2; 2 * n1 + 1; 2 * n1 + 2], 1);
            dc(ely, elx) = -penal * X(ely, elx)^(penal - 1) * Ue' * KE * Ue;
        end
    end
    
    % Check and modify density values based on the volume constraint
    dc = check(3, 10, 1.5, X, dc);
    
    % The inequality constraints (g) are the density sensitivities dc
    g = dc(:);
    
    % No equality constraints
    ceq = [];
end


function xl = get_xl(nx)
    xl = 0.001.*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 2.639346497036027;
end

function xmin = get_xmin(nx)
    xmin = ones(nx, 1);
end

function dcn = check(nelx, nely, rmin, x, dc)
    dcn = zeros(nely, nelx);
    for i = 1:nelx
        for j = 1:nely
            sum = 0;
            for k = max(i - floor(rmin), 1):min(i + floor(rmin), nelx)
                for l = max(j - floor(rmin), 1):min(j + floor(rmin), nely)
                    fac = rmin - sqrt((i - k)^2 + (j - l)^2);
                    sum = sum + max(0, fac);
                    dcn(j, i) = dcn(j, i) + max(0, fac) * x(l, k) * dc(l, k);
                end
            end
            dcn(j, i) = dcn(j, i) / (x(j, i) * sum);
        end
    end
end

function U = FE(nelx, nely, x, penal)
    % Define element stiffness matrix KE (assumed to be defined elsewhere)
    KE = lk;
    
    % Initialize global stiffness matrix K, load vector F, and displacement vector U
    K = sparse(2 * (nelx + 1) * (nely + 1), 2 * (nelx + 1) * (nely + 1));
    F = sparse(2 * (nely + 1) * (nelx + 1), 1);
    U = zeros(2 * (nely + 1) * (nelx + 1), 1);
    
    % Assemble the global stiffness matrix K
    for elx = 1:nelx
        for ely = 1:nely
            n1 = (nely + 1) * (elx - 1) + ely;
            n2 = (nely + 1) * elx + ely;
            edof = [2 * n1 - 1; 2 * n1; 2 * n2 - 1; 2 * n2; 2 * n2 + 1; 2 * n2 + 2; 2 * n1 + 1; 2 * n1 + 2];
            K(edof, edof) = K(edof, edof) + x(ely, elx)^penal * KE;
        end
    end
    
    % Apply boundary conditions and solve for displacements
    F(2 * (nely + 1) * (nelx + 1), 1) = -10000;
    fixeddofs = 1:2 * (nely + 1);
    alldofs = 1:2 * (nely + 1) * (nelx + 1);
    freedofs = setdiff(alldofs, fixeddofs);
    U(freedofs, :) = K(freedofs, freedofs) \ F(freedofs, :);
    U(fixeddofs, :) = 0;
end

function KE = lk
    % Define material properties
    E = 206000000;
    nu = 0.3;
    
    % Coefficients for the 8x8 stiffness matrix calculation
    k = [1/2 - nu/6, 1/8 + nu/8, -1/4 - nu/12, -1/8 + 3*nu/8, ...
         -1/4 + nu/12, -1/8 - nu/8, nu/6, 1/8 - 3*nu/8];
    
    % Calculate the 8x8 stiffness matrix KE
    KE = E / (1 - nu^2) * [k(1), k(2), k(3), k(4), k(5), k(6), k(7), k(8);
                           k(2), k(1), k(8), k(7), k(6), k(5), k(4), k(3);
                           k(3), k(8), k(1), k(6), k(7), k(4), k(5), k(2);
                           k(4), k(7), k(6), k(1), k(8), k(3), k(2), k(5);
                           k(5), k(6), k(7), k(8), k(1), k(2), k(3), k(4);
                           k(6), k(5), k(4), k(3), k(2), k(1), k(8), k(7);
                           k(7), k(4), k(5), k(2), k(3), k(8), k(1), k(6);
                           k(8), k(3), k(2), k(5), k(4), k(7), k(6), k(1)];
end