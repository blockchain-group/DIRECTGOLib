function y = Holder_Table(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Holder_Table.m
%
% Original source:
%  - https://www.sfu.ca/~ssurjano/holder.html
%
% Globally optimal solution:
%   f = -19.2085025678867538
%   x = [8.0550234733225885; 9.6645900114093131]
%
% Default variable bounds:
%   -10 <= x(i) <= 10, i = 1...2
%
% Problem Properties:
%   n  = 2;
%   #g = 0;
%   #h = 0;
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 2;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(i) -10;
    y.xu = @(i) +10;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end

fact1 = sin(x(1))*cos(x(2));
fact2 = exp(abs(1 - sqrt(x(1)^2 + x(2)^2)/pi));
y = -abs(fact1*fact2);
end

function fmin = get_fmin(~)
    fmin = -19.2085025678867538;
end

function xmin = get_xmin(~)
    xmin = [8.0550234733225885; 9.6645900114093131];
end