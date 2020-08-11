function [Tb] = tableResultantVectorStacks(closed, RecInfo, DataStruct, channelNos, polarhist)
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
[Stack] = stackResultantVectorRecord(RecInfo, DataStruct, closed, channelNos, period, stm_delay, jitter, polarhist);
Tb = Stack;

offset = 20;
fprintf('offset = %d\n', offset)
period = [offset offset+drtn];
[Stack] = stackResultantVectorRecord(RecInfo, DataStruct, closed, channelNos, period, stm_delay, jitter, polarhist);
Tb = [Tb;Stack];

offset = 0;
fprintf('offset = %d\n', offset)
period = [offset offset+drtn];
jitter = 1;
disp('jittr on')
[Stack] = stackResultantVectorRecord(RecInfo, DataStruct, closed, channelNos, period, stm_delay, jitter, polarhist);
Tb = [Tb;Stack];

jitter = 0;
disp('jittr off')
for stm_delay = delayVector
    fprintf('stm_delay = %d\n', stm_delay)
    [Stack] = stackResultantVectorRecord(RecInfo, DataStruct, closed, channelNos, period, stm_delay, jitter, polarhist);
    Tb = [Tb;Stack];
end

end

