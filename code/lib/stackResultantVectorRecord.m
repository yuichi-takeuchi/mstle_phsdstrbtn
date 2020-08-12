function [StackTb, StackInstPhase] = stackResultantVectorRecord(RecInfo, DataStruct, closed, channelNos, period, stm_delay, jitter, polarhist)
% Copyright (c) 2020 Yuichi Takeuchi

StackTb = [];
StackInstPhase = {};
for RatNo = 1:length(DataStruct) % for by rat no      
    fprintf('Target: %s\n', DataStruct(RatNo).datafilenamebase)
    fprintf('RatNo: %d\n', RatNo)
    fldrInfolfp = dir(['tmp/' DataStruct(RatNo).datafilenamebase '_LFP500_' num2str(RatNo) '_trial*']);
    channelNo = channelNos(RatNo);
    fldrInfoadc = dir(['tmp/' DataStruct(RatNo).datafilenamebase '_adc_' num2str(RatNo) '_trial*']);
    for TrialNo = 1:length(fldrInfolfp)
        [record, instantaneousPhase] = resultantVectorRecord(fldrInfolfp, fldrInfoadc, TrialNo, channelNo, RecInfo, RatNo, closed, period, stm_delay, jitter);
        if ~isnan(record.r)
            tmpInstPhaseCell{1} = instantaneousPhase;
            tmpInstphaseCell = [tmpInstPhaseCell table2cell(record)];
            if isempty(StackTb)
                StackTb = record;
                StackInstPhase = tmpInstphaseCell;
            else
                StackTb = [StackTb;record];
                StackInstPhase = [StackInstPhase; tmpInstphaseCell];
            end
        end
        
        % polar histogram output
        if polarhist
           printPolarHistPDFPNG(instantaneousPhase, record) 
        end
    end
end

end

