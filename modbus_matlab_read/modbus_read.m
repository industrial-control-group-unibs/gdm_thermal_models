clear all;clc;close all
Motor = OpenDriveConnection(38400,'6'); 

% Mdplc, in params:
% ipa 11000 sono parametri settabili
% ipa 12000 sono parametri in sola lettura
x=1;
set(Load.Modbus,'ParDword',3700,0,x);
y=get(Motor.Modbus,'ParDWord',12010,0);
