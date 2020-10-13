%% mstle_phsdstrbtn analysis
% Copyright � 2020 Yuichi Takeuchi
%% initialization

clear; clc
%% path
%%
addpath(genpath('helper'))
addpath(genpath('lib'))
%% metainfo
%%
ID = 'LTR1_99_100';
closed = 1; % 0 and 1 for open-loop and closed-loop control
metainfo = {
    'AP', 181108, 1, 1, [99 100], [7 24]; % prefix, date, expNo1, expNo2, LTR, specific ch
    'AP', 181108, 1, 2, [99 100], [7 24];
    'AP', 181109, 1, 1, [99 100], [7 24];
    'AP', 181110, 1, 1, [99 100], [7 24];
    'AP', 181110, 1, 2, [99 100], [7 24];
    'AP', 181110, 1, 3, [99 100], [7 24];
    'AP', 181111, 1, 1, [99 100], [7 24];
    };
%% Downsampling and channel reorganization
%%
for i = 1:size(metainfo,1)
    ds_Takeuchi3dual_2A1D_500_to_500(metainfo{i,1}, metainfo{i,2}, metainfo{i,3}, metainfo{i,4})
end
clear i
%% Get timestamps of seizure induction (digital channel bit 0)
%%
% get timestamps of seizure induction, detections of rat 1, rat 2
[RecInfo,DataStruct] = getTspSeizureInduction2(metainfo, ID, closed)
%% Manual curation of timestamp
%%
load(['tmp/' ID '_' num2str(closed) '_RecInfo.mat' ], 'RecInfo')
load(['tmp/' ID '_' num2str(closed) '_DataStruct.mat'], 'DataStruct')
cidx = {
    1, 1, [2 6], repmat([1 0],1,2); % record num of metainfo, rat No, rejection trial no, trues for trials to be analyzed
    1, 2, [2 6], repmat([0 1],1,2);
    2, 1, [1], repmat([1 0],1,1); % record num of metainfo, rat No, rejection trial no, trues for trials to be analyzed
    2, 2, [1], repmat([0 1],1,1);
    3, 1, [5 6], repmat([1 0],1,3); % record num of metainfo, rat No, rejection trial no, trues for trials to be analyzed
    3, 2, [1:6], repmat([0 1],1,1);
    4, 1, [], repmat([1 0],1,1); % record num of metainfo, rat No, rejection trial no, trues for trials to be analyzed
    4, 2, [], repmat([0 1],1,1);
    5, 1, [3:6], repmat([1 0],1,1); % record num of metainfo, rat No, rejection trial no, trues for trials to be analyzed
    5, 2, [3:6], repmat([0 1],1,1);
    6, 1, [3:6], repmat([1 0],1,1); % record num of metainfo, rat No, rejection trial no, trues for trials to be analyzed
    6, 2, [3:6], repmat([0 1],1,1);
    7, 1, [7 10:13 16 17], repmat([1 0],1,5); % record num of metainfo, rat No, rejection trial no, trues for trials to be analyzed
    7, 2, [1:4 7 14 15], repmat([0 1],1,4);
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
    [flag] = cut_postInductionTime_Takeuchi3_dual(RecInfo{i}, DataStruct{i}, closed);
end
disp('trial extraction done')
clear i flag
%% Circular phase analysis
%%
tic
circularPhaseAnalysis(closed, RecInfo, DataStruct, metainfo, ID)
toc