function printPolarHistPDFPNG(InstantaneousPhase, LTR, name, record)
% Copyright (c) 2020 Yuichi Takeuchi
% polarhist figure output


hfig = figure(1);
hph = polarhistogram(InstantaneousPhase, 12);

hpax = gca;

hph.FaceColor = [0 0 0];

% global arameters
fontname = 'Arial';
fontsize = 4;

% figure parameter settings
set(hfig,...
    'PaperUnits', 'centimeters',...
    'PaperPosition', [0.5 0.5 4 4],... % [h distance, v distance, width, height], origin: left lower corner
    'PaperSize', [5 5]... % width, height
    );

% axis parameter settings
set(hpax,...
    'FontName', fontname,...
    'FontSize', fontsize...
    );

strfilename = ['LTR1_' num2str(LTR) '_' name '_closed' num2str(record.closed) '_offset' num2str(record.offset) '_duration' num2str(record.duration) '_delay' num2str(record.delay) '_jitter' num2str(record.jitter)];

print(['../results/' strfilename '.pdf'], '-dpdf')
print(['../results/' strfilename '.png'], '-dpng')

close(hfig)
end




