function [flag] = writeResultantVectorStacks(ID, closed, RecInfo, DataStruct, channelNos, compassFigure)
% Copyright (c) 2020 Yuichi Takeuchi

flag = 0;

% parameters
drtn = 20; % in second
delayVector = [0 20 40 60];
%

offset = 40;
fprintf('offset = %d\n', offset)
period = [offset offset+drtn];
stm_delay = 0;
jitter = 0;
[Stack] = stackResultantVectorRecord(RecInfo, DataStruct, closed, channelNos, period, stm_delay, jitter);
Tb = Stack;

offset = 20;
fprintf('offset = %d\n', offset)
period = [offset offset+drtn];
[Stack] = stackResultantVectorRecord(RecInfo, DataStruct, closed, channelNos, period, stm_delay, jitter);
Tb = [Tb;Stack];

offset = 0;
fprintf('offset = %d\n', offset)
period = [offset offset+drtn];
jitter = 1;
disp('jittr on')
[Stack] = stackResultantVectorRecord(RecInfo, DataStruct, closed, channelNos, period, stm_delay, jitter);
Tb = [Tb;Stack];

jitter = 0;
disp('jittr off')
for stm_delay = delayVector
    fprintf('stm_delay = %d\n', stm_delay)
    [Stack] = stackResultantVectorRecord(RecInfo, DataStruct, closed, channelNos, period, stm_delay, jitter);
    Tb = [Tb;Stack];
end

% csv. file output
writetable(Tb, ['../results' ID '_closed_resultantVec.csv'])

% comppass figure output
if compassFigure
    for i = 1:height(Tb)
        hfig = figure(1);
        
        hcmpss = compass(Tb.U(i),Tb.V(i));
        hax = gca;

        % global arameters
        fontname = 'Arial';
        fontsize = 5;

        % figure parameter settings
        set(hfig,...
            'PaperUnits', 'centimeters',...
            'PaperPosition', [0.5 0.5 4 4],... % [h distance, v distance, width, height], origin: left lower corner
            'PaperSize', [5 5]... % width, height
            );

        % axis parameter settings
        set(hax,...
            'FontName', fontname,...
            'FontSize', fontsize...
            );

        print(['../results/compass_' ID '_' num2str(i) '.pdf'], '-dpdf')
        print(['../results/compass_' ID '_' num2str(i) '.png'], '-dpng')
        
        close all    
    end
end

flag = 1;

end

