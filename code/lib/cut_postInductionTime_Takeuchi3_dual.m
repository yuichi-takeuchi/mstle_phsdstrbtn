function [flag] = cut_postInductionTime_Takeuchi3_dual(RecInfo, DataStruct)
% Copyright (C) 2020 Yuichi Takeuchi

%% Set params for main processes
cParams.sr = RecInfo.srLFP;
cParams.TSbit = 1; % bit of digital channel for timestamp stimulus onset detection
cParams.nChannel = 30; % total number of channel of each rat
cParams.ChLabel = ["MEC" "rHPC" "lHPC" "Ctx"];
cParams.ChOrder = {1:6 7:15 16:24 25:30}; % {1:6 7:15 16:24 25:30}
cParams.BaselineDrtn = uint64(floor(0*cParams.sr)); % 0 s baseline before stimulation
cParams.TestDrtn = uint64(floor(120*cParams.sr)); % 120 s test period after stimulation

%% Seizure detection: Band-pass filt-Rectification-movmean filtfilt signal pre-processing, RMS thresholding
[ flag ] = eplpsyf_cutPostInductionTime2(DataStruct, cParams);
[ flag ] = eplpsyf_cutPostInductionTimeACh1(DataStruct, cParams);

end
