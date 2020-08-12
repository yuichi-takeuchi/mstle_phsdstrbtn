function [Stack] = stackResultantVectorRecord(RecInfo, DataStruct, closed, channelNos, period, stm_delay, jitter, polarhist)
% Copyright (c) 2020 Yuichi Takeuchi

Stack = [];
for RatNo = 1:length(DataStruct) % for by rat no      
    fprintf('Target: %s\n', DataStruct(RatNo).datafilenamebase)
    fprintf('RatNo: %d\n', RatNo)
    fldrInfolfp = dir(['tmp/' DataStruct(RatNo).datafilenamebase '_LFP500_' num2str(RatNo) '_trial*']);
    channelNo = channelNos(RatNo);
    fldrInfoadc = dir(['tmp/' DataStruct(RatNo).datafilenamebase '_adc_' num2str(RatNo) '_trial*']);
    for TrialNo = 1:length(fldrInfolfp)
        [record, InstantaneousPhase] = resultantVectorRecord(fldrInfolfp, fldrInfoadc, TrialNo, channelNo, RecInfo, RatNo, closed, period, stm_delay, jitter);
        if ~isnan(record.r)
            if isempty(Stack)
                Stack = record;
            else
                Stack = [Stack;record];
            end
        end
        
        % polar histogram output
        if polarhist
           printPolarHistPDFPNG(InstantaneousPhase, RecInfo.LTR(RatNo), fldrInfolfp(TrialNo).name, record) 
        end
    end
end

end

