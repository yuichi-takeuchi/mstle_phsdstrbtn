%% mstle_phsdstrbtn analysis
% Copyright © 2020 Yuichi Takeuchi
%% initialization

clear; clc
%% path
%%
addpath(genpath('helper'))
addpath(genpath('lib'))
%% metainfo
%%
ID = 'LTR1_80';
closed = 0; % 0 and 1 for open-loop and closed-loop control
metainfo = {
    'AP', 180628, 1, 3, [80], [10]; % prefix, date, expNo1, expNo2, LTR, specific ch
    'AP', 180629, 1, 1, [80], [10];
    'AP', 180629, 1, 2, [80], [10];
    'AP', 180630, 1, 3, [80], [10];
};
%% Downsampling and channel reorganization
%%
for i = 1:size(metainfo,1)
    ds_Takeuchi3_1A1D_20k_to_500(metainfo{i,1}, metainfo{i,2}, metainfo{i,3}, metainfo{i,4})
end
clear i
%% Get timestamps of seizure induction
%%
% get timestamps of seizure induction, detections of rat 1
[RecInfo,DataStruct] = getTspSeizureInduction1(metainfo, ID, closed)
%% Manual curation of timestamp
%%
load(['tmp/' ID '_' num2str(closed) '_RecInfo.mat' ], 'RecInfo')
load(['tmp/' ID '_' num2str(closed) '_DataStruct.mat'], 'DataStruct')
cidx = {
    1, 1, [11:14], repmat([1 0],1,4); % record num of metainfo, rat No, rejection trial no, trues for trials to be analyzed
    2, 1, [3 4], repmat([0 1],1,2);
    3, 1, [7:10], repmat([1 0],1,3); % record num of metainfo, rat No, rejection trial no, trues for trials to be analyzed
    4, 1, [1:4 7 8], repmat([0 1],1,1);
    };
for i = 1:size(cidx, 1)
    DataStruct{1,cidx{i,1}}(cidx{i,2}).Timestamp{1, 1}(cidx{i,3},:) = [];
    DataStruct{1,cidx{i,1}}(cidx{i,2}).TimestampMin(cidx{i,3},:) = [];
    DataStruct{1,cidx{i,1}}(cidx{i,2}).idxslct = cidx{i,4};
end
save(['tmp/' ID '_' num2str(closed) '_DataStruct_curated.mat'], 'DataStruct')
clear cidx i
%% Trial file extraction, Filtering, define detection timestamps
%%
for i = 1:size(metainfo,1)
    [flag] = cut_postInductionTime_Takeuchi3(RecInfo{i}, DataStruct{i});
end
clear i flag
%% Circular phase analysis
%%
tic
circularPhaseAnalysis(closed, RecInfo, DataStruct, metainfo, ID)
toc