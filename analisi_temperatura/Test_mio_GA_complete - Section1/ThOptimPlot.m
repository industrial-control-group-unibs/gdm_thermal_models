function [state,options,optchanged] = ThOptimPlot(options,state,flag,temp,Id_rms,Id,Iq_rms,Iq,vel_rms,vel,Pw_rms,Pws,Realdata)
%THOPTIMPLOT plots the best temperature curve at each iteration.
% Copyright (c) 2012, MathWorks, Inc.

optchanged = false;

switch flag
    case 'init'
        f=figure('Position',[1050 35 800 520],'Tag','torqueCurve'); 
        %movegui(f,'south')
        set(gca,'Tag','ax1');
%         set(gca,'YLim',[0.1 0.2]);
        grid on;
        hold on;
        plot(temp,Realdata,'-*b');
        xlabel('time (min)');
        ylabel('Torque (Nm)');
        title('Torque vs time','FontSize',12);
        [~,loc] = min(state.Score); % Find location of best
        bestV = TempCurve(temp,Id_rms,Id,Iq_rms,Iq,vel_rms,vel,Pw_rms,Pws,state.Population(loc,:));
        plotBest = plot(temp,bestV,'-or');
        set(plotBest,'Tag','bestVLine'); % Update voltage curve
        legend('Ideal Curve','GA Solution','Location','southeast');
        drawnow;
    case 'iter'
        fig = findobj(0,'Tag','torqueCurve');
        set(gca,'YLim',[0 30])
        figure(fig(end));
        [~,loc] = min(state.Score); % Find location of best
        bestV = TempCurve(temp,Id_rms,Id,Iq_rms,Iq,vel_rms,vel,Pw_rms,Pws,state.Population(loc,:));
        ax1 = findobj(get(gcf,'Children'),'Tag','ax1');
        plotBest = findobj(get(ax1,'Children'),'Tag','bestVLine');
        set(plotBest, 'Ydata', bestV); % Update voltage curve
        drawnow;
    case 'done'
        fig = findobj(0,'Tag','torqueCurve');
        figure(fig(end));
        [~,loc] = min(state.Score);
        xOpt = state.Population(loc,:);
        s{1} = sprintf('Optimal solution found by Mixed Integer GA solver: \n');
        s{2} = sprintf('K = %f  \n', xOpt(1));
        s{3} = sprintf('k-Id-rms = %f  \n', xOpt(2));
        s{4} = sprintf('k-Id = %f  \n', xOpt(3));
        s{5} = sprintf('k-Iq-rms = %f  \n', xOpt(4));
        s{6} = sprintf('k-Iq = %f  \n', xOpt(5));
        s{7} = sprintf('k-Pw-rms = %f  \n', xOpt(6));
        s{8} = sprintf('k-Pws = %f  \n', xOpt(7));
        s{9} = sprintf('k-vel-rms = %f  \n', xOpt(8));
        s{10} = sprintf('k-vel = %f  \n', xOpt(9));
        % Display the text in "s" in an annotation object on the
        % torque curve figure.  The four-element vector is used to 
        % specify the location.
        annotation(gcf, 'textbox', [0.15 0.45 0.22 0.45], 'String', s,...
            'BackGroundColor','w','FontSize',8);
        hold off;
end
