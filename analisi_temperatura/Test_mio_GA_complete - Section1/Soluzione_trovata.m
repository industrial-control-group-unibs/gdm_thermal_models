clear all; close all;
%% Find the Optimal Component Values for my friction
%% effort and time data
load('ws_100.mat')
Data100=eff60rmsp;
load('ws_67.mat')
Data67=eff60rmsp;
load('ws_50.mat')
Data50=eff60rmsp;
load('ws_33.mat')
Data33=eff60rmsp;
tempi=tempi*60;
Data=[Data33; Data50; Data67; Data100];
%% Plot the Desired Curve
figure('Position',[50 35 800 520],'Tag','Initial point')
plot(tempi,Data,'*');
title('Target Curve','FontSize',12); 
xlabel('Time (min)'); ylabel('Torque (Nm)')
hold on
%% Temperature and torque Calculations
t=tempi
Tau033 = 27.7618883530146;
Tau050 = 27.9545933093228;
Tau067 = 27.3665697082309;
Tau0100 = 27.2708804661126;
K1 = 1.0e+05 *0.001292793693976;
C1 = 1.0e+05 *0.222546441379368;
K2 = 1.0e+05 *0.001223830512548 ;
C2 = 1.0e+05 *2.175499327790599;
alpha = 1.0e+05 *-0.000000672295878;
beta = 1.0e+05 *0.000010060113568;
Te33 = 1.0e+05 *0.000288824105993;
W33 = 1.0e+05 *0.003869260628553;
Te50 = 1.0e+05 *0.000250651877231;
W50 = 1.0e+05 *0.004558139174921;
Te67 = 1.0e+05 *0.000286970685075;
W67 = 1.0e+05 *0.004999998003488;
Te100 = 1.0e+05 *0.000294734242883;
W100 = 1.0e+05 *0.005861827031619;
%Con soluzione da odes!
%D=33%
T1_33= - (exp(-(t.*((C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W33.*alpha + 2.*C1.*C2.*K2.*W33.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W33.*alpha + C2^2.*W33^2.*alpha^2)^(1/2) + C1.*K1 + C1.*K2 + C2.*K1 - C2.*W33.*alpha))/(2.*C1.*C2)).*((exp((t.*((C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W33.*alpha + 2.*C1.*C2.*K2.*W33.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W33.*alpha + C2^2.*W33^2.*alpha^2)^(1/2) + C1.*K1 + C1.*K2 + C2.*K1 - C2.*W33.*alpha))/(2.*C1.*C2)).*((4.*C1.*C2^2.*(K1.*K2.*Te33 + K1.*W33.*beta - K1.*Te33.*W33.*alpha - K2.*Te33.*W33.*alpha))/((C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W33.*alpha + 2.*C1.*C2.*K2.*W33.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W33.*alpha + C2^2.*W33^2.*alpha^2)^(1/2) + C1.*K1 + C1.*K2 + C2.*K1 - C2.*W33.*alpha) - 2.*C1.*C2.*K2.*Te33))/(2.*C2.*(C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W33.*alpha + 2.*C1.*C2.*K2.*W33.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W33.*alpha + C2^2.*W33^2.*alpha^2)^(1/2)) - (2.*C1.*C2.*K1.*W33.*beta)/(((C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W33.*alpha + 2.*C1.*C2.*K2.*W33.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W33.*alpha + C2^2.*W33^2.*alpha^2)^(1/2) + C1.*K1 + C1.*K2 + C2.*K1 - C2.*W33.*alpha).*(C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W33.*alpha + 2.*C1.*C2.*K2.*W33.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W33.*alpha + C2^2.*W33^2.*alpha^2)^(1/2))).*(C1.*K1 - (C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W33.*alpha + 2.*C1.*C2.*K2.*W33.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W33.*alpha + C2^2.*W33^2.*alpha^2)^(1/2) + C1.*K2 - C2.*K1 + C2.*W33.*alpha))/(2.*C1.*K1) - (exp(-(t.*(C1.*K1 - (C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W33.*alpha + 2.*C1.*C2.*K2.*W33.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W33.*alpha + C2^2.*W33^2.*alpha^2)^(1/2) + C1.*K2 + C2.*K1 - C2.*W33.*alpha))/(2.*C1.*C2)).*((exp((t.*(C1.*K1 - (C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W33.*alpha + 2.*C1.*C2.*K2.*W33.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W33.*alpha + C2^2.*W33^2.*alpha^2)^(1/2) + C1.*K2 + C2.*K1 - C2.*W33.*alpha))/(2.*C1.*C2)).*(2.*C1.*C2.*K2.*Te33 - (4.*C1.*C2^2.*(K1.*K2.*Te33 + K1.*W33.*beta - K1.*Te33.*W33.*alpha - K2.*Te33.*W33.*alpha))/(C1.*K1 - (C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W33.*alpha + 2.*C1.*C2.*K2.*W33.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W33.*alpha + C2^2.*W33^2.*alpha^2)^(1/2) + C1.*K2 + C2.*K1 - C2.*W33.*alpha)))/(2.*C2.*(C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W33.*alpha + 2.*C1.*C2.*K2.*W33.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W33.*alpha + C2^2.*W33^2.*alpha^2)^(1/2)) + (2.*C1.*C2.*K1.*W33.*beta)/((C1.*K1 - (C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W33.*alpha + 2.*C1.*C2.*K2.*W33.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W33.*alpha + C2^2.*W33^2.*alpha^2)^(1/2) + C1.*K2 + C2.*K1 - C2.*W33.*alpha).*(C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W33.*alpha + 2.*C1.*C2.*K2.*W33.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W33.*alpha + C2^2.*W33^2.*alpha^2)^(1/2))).*((C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W33.*alpha + 2.*C1.*C2.*K2.*W33.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W33.*alpha + C2^2.*W33^2.*alpha^2)^(1/2) + C1.*K1 + C1.*K2 - C2.*K1 + C2.*W33.*alpha))/(2.*C1.*K1);
F33 = Tau033.*(alpha.*(T1_33 - Te33) + beta);

%D=50%
T1_50= - (exp(-(t.*((C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W50.*alpha + 2.*C1.*C2.*K2.*W50.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W50.*alpha + C2^2.*W50^2.*alpha^2)^(1/2) + C1.*K1 + C1.*K2 + C2.*K1 - C2.*W50.*alpha))/(2.*C1.*C2)).*((exp((t.*((C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W50.*alpha + 2.*C1.*C2.*K2.*W50.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W50.*alpha + C2^2.*W50^2.*alpha^2)^(1/2) + C1.*K1 + C1.*K2 + C2.*K1 - C2.*W50.*alpha))/(2.*C1.*C2)).*((4.*C1.*C2^2.*(K1.*K2.*Te50 + K1.*W50.*beta - K1.*Te50.*W50.*alpha - K2.*Te50.*W50.*alpha))/((C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W50.*alpha + 2.*C1.*C2.*K2.*W50.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W50.*alpha + C2^2.*W50^2.*alpha^2)^(1/2) + C1.*K1 + C1.*K2 + C2.*K1 - C2.*W50.*alpha) - 2.*C1.*C2.*K2.*Te50))/(2.*C2.*(C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W50.*alpha + 2.*C1.*C2.*K2.*W50.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W50.*alpha + C2^2.*W50^2.*alpha^2)^(1/2)) - (2.*C1.*C2.*K1.*W50.*beta)/(((C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W50.*alpha + 2.*C1.*C2.*K2.*W50.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W50.*alpha + C2^2.*W50^2.*alpha^2)^(1/2) + C1.*K1 + C1.*K2 + C2.*K1 - C2.*W50.*alpha).*(C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W50.*alpha + 2.*C1.*C2.*K2.*W50.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W50.*alpha + C2^2.*W50^2.*alpha^2)^(1/2))).*(C1.*K1 - (C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W50.*alpha + 2.*C1.*C2.*K2.*W50.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W50.*alpha + C2^2.*W50^2.*alpha^2)^(1/2) + C1.*K2 - C2.*K1 + C2.*W50.*alpha))/(2.*C1.*K1) - (exp(-(t.*(C1.*K1 - (C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W50.*alpha + 2.*C1.*C2.*K2.*W50.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W50.*alpha + C2^2.*W50^2.*alpha^2)^(1/2) + C1.*K2 + C2.*K1 - C2.*W50.*alpha))/(2.*C1.*C2)).*((exp((t.*(C1.*K1 - (C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W50.*alpha + 2.*C1.*C2.*K2.*W50.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W50.*alpha + C2^2.*W50^2.*alpha^2)^(1/2) + C1.*K2 + C2.*K1 - C2.*W50.*alpha))/(2.*C1.*C2)).*(2.*C1.*C2.*K2.*Te50 - (4.*C1.*C2^2.*(K1.*K2.*Te50 + K1.*W50.*beta - K1.*Te50.*W50.*alpha - K2.*Te50.*W50.*alpha))/(C1.*K1 - (C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W50.*alpha + 2.*C1.*C2.*K2.*W50.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W50.*alpha + C2^2.*W50^2.*alpha^2)^(1/2) + C1.*K2 + C2.*K1 - C2.*W50.*alpha)))/(2.*C2.*(C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W50.*alpha + 2.*C1.*C2.*K2.*W50.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W50.*alpha + C2^2.*W50^2.*alpha^2)^(1/2)) + (2.*C1.*C2.*K1.*W50.*beta)/((C1.*K1 - (C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W50.*alpha + 2.*C1.*C2.*K2.*W50.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W50.*alpha + C2^2.*W50^2.*alpha^2)^(1/2) + C1.*K2 + C2.*K1 - C2.*W50.*alpha).*(C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W50.*alpha + 2.*C1.*C2.*K2.*W50.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W50.*alpha + C2^2.*W50^2.*alpha^2)^(1/2))).*((C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W50.*alpha + 2.*C1.*C2.*K2.*W50.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W50.*alpha + C2^2.*W50^2.*alpha^2)^(1/2) + C1.*K1 + C1.*K2 - C2.*K1 + C2.*W50.*alpha))/(2.*C1.*K1);
F50 = Tau050.*(alpha.*(T1_50 - Te50) + beta);

%D=67%
T1_67= - (exp(-(t.*((C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W67.*alpha + 2.*C1.*C2.*K2.*W67.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W67.*alpha + C2^2.*W67^2.*alpha^2)^(1/2) + C1.*K1 + C1.*K2 + C2.*K1 - C2.*W67.*alpha))/(2.*C1.*C2)).*((exp((t.*((C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W67.*alpha + 2.*C1.*C2.*K2.*W67.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W67.*alpha + C2^2.*W67^2.*alpha^2)^(1/2) + C1.*K1 + C1.*K2 + C2.*K1 - C2.*W67.*alpha))/(2.*C1.*C2)).*((4.*C1.*C2^2.*(K1.*K2.*Te67 + K1.*W67.*beta - K1.*Te67.*W67.*alpha - K2.*Te67.*W67.*alpha))/((C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W67.*alpha + 2.*C1.*C2.*K2.*W67.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W67.*alpha + C2^2.*W67^2.*alpha^2)^(1/2) + C1.*K1 + C1.*K2 + C2.*K1 - C2.*W67.*alpha) - 2.*C1.*C2.*K2.*Te67))/(2.*C2.*(C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W67.*alpha + 2.*C1.*C2.*K2.*W67.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W67.*alpha + C2^2.*W67^2.*alpha^2)^(1/2)) - (2.*C1.*C2.*K1.*W67.*beta)/(((C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W67.*alpha + 2.*C1.*C2.*K2.*W67.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W67.*alpha + C2^2.*W67^2.*alpha^2)^(1/2) + C1.*K1 + C1.*K2 + C2.*K1 - C2.*W67.*alpha).*(C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W67.*alpha + 2.*C1.*C2.*K2.*W67.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W67.*alpha + C2^2.*W67^2.*alpha^2)^(1/2))).*(C1.*K1 - (C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W67.*alpha + 2.*C1.*C2.*K2.*W67.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W67.*alpha + C2^2.*W67^2.*alpha^2)^(1/2) + C1.*K2 - C2.*K1 + C2.*W67.*alpha))/(2.*C1.*K1) - (exp(-(t.*(C1.*K1 - (C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W67.*alpha + 2.*C1.*C2.*K2.*W67.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W67.*alpha + C2^2.*W67^2.*alpha^2)^(1/2) + C1.*K2 + C2.*K1 - C2.*W67.*alpha))/(2.*C1.*C2)).*((exp((t.*(C1.*K1 - (C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W67.*alpha + 2.*C1.*C2.*K2.*W67.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W67.*alpha + C2^2.*W67^2.*alpha^2)^(1/2) + C1.*K2 + C2.*K1 - C2.*W67.*alpha))/(2.*C1.*C2)).*(2.*C1.*C2.*K2.*Te67 - (4.*C1.*C2^2.*(K1.*K2.*Te67 + K1.*W67.*beta - K1.*Te67.*W67.*alpha - K2.*Te67.*W67.*alpha))/(C1.*K1 - (C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W67.*alpha + 2.*C1.*C2.*K2.*W67.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W67.*alpha + C2^2.*W67^2.*alpha^2)^(1/2) + C1.*K2 + C2.*K1 - C2.*W67.*alpha)))/(2.*C2.*(C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W67.*alpha + 2.*C1.*C2.*K2.*W67.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W67.*alpha + C2^2.*W67^2.*alpha^2)^(1/2)) + (2.*C1.*C2.*K1.*W67.*beta)/((C1.*K1 - (C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W67.*alpha + 2.*C1.*C2.*K2.*W67.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W67.*alpha + C2^2.*W67^2.*alpha^2)^(1/2) + C1.*K2 + C2.*K1 - C2.*W67.*alpha).*(C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W67.*alpha + 2.*C1.*C2.*K2.*W67.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W67.*alpha + C2^2.*W67^2.*alpha^2)^(1/2))).*((C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W67.*alpha + 2.*C1.*C2.*K2.*W67.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W67.*alpha + C2^2.*W67^2.*alpha^2)^(1/2) + C1.*K1 + C1.*K2 - C2.*K1 + C2.*W67.*alpha))/(2.*C1.*K1);
F67 = Tau067.*(alpha.*(T1_67 - Te67) + beta);

%D=100%
T1_100= - (exp(-(t.*((C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W100.*alpha + 2.*C1.*C2.*K2.*W100.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W100.*alpha + C2^2.*W100^2.*alpha^2)^(1/2) + C1.*K1 + C1.*K2 + C2.*K1 - C2.*W100.*alpha))/(2.*C1.*C2)).*((exp((t.*((C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W100.*alpha + 2.*C1.*C2.*K2.*W100.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W100.*alpha + C2^2.*W100^2.*alpha^2)^(1/2) + C1.*K1 + C1.*K2 + C2.*K1 - C2.*W100.*alpha))/(2.*C1.*C2)).*((4.*C1.*C2^2.*(K1.*K2.*Te100 + K1.*W100.*beta - K1.*Te100.*W100.*alpha - K2.*Te100.*W100.*alpha))/((C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W100.*alpha + 2.*C1.*C2.*K2.*W100.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W100.*alpha + C2^2.*W100^2.*alpha^2)^(1/2) + C1.*K1 + C1.*K2 + C2.*K1 - C2.*W100.*alpha) - 2.*C1.*C2.*K2.*Te100))/(2.*C2.*(C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W100.*alpha + 2.*C1.*C2.*K2.*W100.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W100.*alpha + C2^2.*W100^2.*alpha^2)^(1/2)) - (2.*C1.*C2.*K1.*W100.*beta)/(((C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W100.*alpha + 2.*C1.*C2.*K2.*W100.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W100.*alpha + C2^2.*W100^2.*alpha^2)^(1/2) + C1.*K1 + C1.*K2 + C2.*K1 - C2.*W100.*alpha).*(C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W100.*alpha + 2.*C1.*C2.*K2.*W100.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W100.*alpha + C2^2.*W100^2.*alpha^2)^(1/2))).*(C1.*K1 - (C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W100.*alpha + 2.*C1.*C2.*K2.*W100.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W100.*alpha + C2^2.*W100^2.*alpha^2)^(1/2) + C1.*K2 - C2.*K1 + C2.*W100.*alpha))/(2.*C1.*K1) - (exp(-(t.*(C1.*K1 - (C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W100.*alpha + 2.*C1.*C2.*K2.*W100.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W100.*alpha + C2^2.*W100^2.*alpha^2)^(1/2) + C1.*K2 + C2.*K1 - C2.*W100.*alpha))/(2.*C1.*C2)).*((exp((t.*(C1.*K1 - (C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W100.*alpha + 2.*C1.*C2.*K2.*W100.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W100.*alpha + C2^2.*W100^2.*alpha^2)^(1/2) + C1.*K2 + C2.*K1 - C2.*W100.*alpha))/(2.*C1.*C2)).*(2.*C1.*C2.*K2.*Te100 - (4.*C1.*C2^2.*(K1.*K2.*Te100 + K1.*W100.*beta - K1.*Te100.*W100.*alpha - K2.*Te100.*W100.*alpha))/(C1.*K1 - (C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W100.*alpha + 2.*C1.*C2.*K2.*W100.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W100.*alpha + C2^2.*W100^2.*alpha^2)^(1/2) + C1.*K2 + C2.*K1 - C2.*W100.*alpha)))/(2.*C2.*(C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W100.*alpha + 2.*C1.*C2.*K2.*W100.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W100.*alpha + C2^2.*W100^2.*alpha^2)^(1/2)) + (2.*C1.*C2.*K1.*W100.*beta)/((C1.*K1 - (C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W100.*alpha + 2.*C1.*C2.*K2.*W100.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W100.*alpha + C2^2.*W100^2.*alpha^2)^(1/2) + C1.*K2 + C2.*K1 - C2.*W100.*alpha).*(C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W100.*alpha + 2.*C1.*C2.*K2.*W100.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W100.*alpha + C2^2.*W100^2.*alpha^2)^(1/2))).*((C1^2.*K1^2 + 2.*C1^2.*K1.*K2 + C1^2.*K2^2 + 2.*C1.*C2.*K1^2 - 2.*C1.*C2.*K1.*K2 + 2.*C1.*C2.*K1.*W100.*alpha + 2.*C1.*C2.*K2.*W100.*alpha + C2^2.*K1^2 - 2.*C2^2.*K1.*W100.*alpha + C2^2.*W100^2.*alpha^2)^(1/2) + C1.*K1 + C1.*K2 - C2.*K1 + C2.*W100.*alpha))/(2.*C1.*K1);
F100 = Tau0100.*(alpha.*(T1_100 - Te100) + beta);

F=[F33; F50; F67; F100];
plot(tempi,F,'-o')
