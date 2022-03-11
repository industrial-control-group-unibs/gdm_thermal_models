function Vdata = TempCurve(temp,Id_rms,Id,Iq_rms,Iq,vel_rms,vel,Pw_rms,Pws,x)
%% Calculate temperature Curve given Indices (x)
%% Index into arrays to extract component values
y(1) = x(1);
y(2) = x(2);
y(3) = x(3);
y(4) = x(4);
y(5) = x(5);
y(6) = x(6);
y(7) = x(7);
y(8) = x(8);
y(9) = x(9);

%% Calculate temperature curve for a particular default value
Vdata = TempCompCurve(y,Id_rms,Id,Iq_rms,Iq,vel_rms,vel,Pw_rms,Pws,temp);