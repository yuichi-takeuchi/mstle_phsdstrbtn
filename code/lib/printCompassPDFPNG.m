function printCompassPDFPNG(Tb, ID)
% Copyright (c) 2020 Yuichi Takeuchi
% comppass figure output

for i = 1:height(Tb)
    hfig = figure(1);

    hcmpss = compass(Tb.X(i),Tb.Y(i));

%         ylim([0 1])
%         yticks([0.5 1.0])
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

    suffix = ['_closed' num2str(Tb.closed(i)) ...
              '_offset' num2str(Tb.offset(i)) ...
              '_duration' num2str(Tb.duration(i)) ...
              '_delay' num2str(Tb.delay(i)) ...
              '_jitter' num2str(Tb.jitter(i))];
    
    print(['../results/' ID suffix '.pdf'], '-dpdf')
    print(['../results/' ID suffix '.png'], '-dpng')

    close all    
end


end

