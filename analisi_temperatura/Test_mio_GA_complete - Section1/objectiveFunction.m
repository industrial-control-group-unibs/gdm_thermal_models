function G = objectiveFunction(x,temp,Id_rms,Id,Iq_rms,Iq,vel_rms,vel,Pw_rms,Pws,Realdata)
%% Objective function for the thermistor problem
% Copyright (c) 2012, MathWorks, Inc.

% StdRes = vector of resistor values
% StdTherm_val = vector of nominal thermistor resistances
% StdTherm_Beta = vector of thermistor temeperature coefficients

% Extract component values from tables using integers in x as indices
y = zeros(9,1);
y(1) = x(1);
y(2) = x(2);
y(3) = x(3);
y(4) = x(4);
y(5) = x(5);
y(6) = x(6);
y(7) = x(7);
y(8) = x(8);
y(9) = x(9);

% Calculate temperature curve for a particular set of components
F = TempCompCurve(y,Id_rms,Id,Iq_rms,Iq,vel_rms,vel,Pw_rms,Pws,temp);

% Compare simulated results to desired curve
Residual = F(:,:) - Realdata(:,:);

G =sum(sum(Residual.^2)); % sum of squares
