function [Stack] = stackResultantVectorRecord(RecInfo, DataStruct, closed, channelNos, period, stm_delay, jitter)
% Copyright (c) 2020 Yuichi Takeuchi

polarhist = 1;
Stack = [];
for RatNo = 1:length(DataStruct) % for by rat no      
    fprintf('RatNo: %d\n', RatNo)
    fldrInfolfp = dir(['tmp/' DataStruct(RatNo).datafilenamebase '_LFP500_' num2str(RatNo) '_trial*']);
    channelNo = channelNos(RatNo);
    fldrInfoadc = dir(['tmp/' DataStruct(RatNo).datafilenamebase '_adc_' num2str(RatNo) '_trial*']);
    for TrialNo = 1:length(fldrInfolfp)
        [record] = resultantVectorRecord(fldrInfolfp, fldrInfoadc, TrialNo, channelNo, RecInfo, RatNo, closed, period, stm_delay, jitter, polarhist);
        if isempty(Stack)
            Stack = record;
        else
            Stack = [Stack;record];
        end
    end
end
    
% Count = sum(reshape(N, 20, 18)); % modulation index
% meanCount = mean(Count,2);
% [maxCount, ~] = max(Count);
% [minCount, ~] = min(Count);
% if abs(maxCount - meanCount) > abs(minCount - meanCount)
%     diffCount = maxCount - meanCount;
% else
%     diffCount = minCount - meanCount;
% end
% MI = abs(diffCount/meanCount);

end

