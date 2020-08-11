function [record, InstantaneousPhase] = resultantVectorRecord(fldrInfolfp, fldrInfoadc, trialNo, channelNo, RecInfo, ratNo, closed, period, stm_delay, jitter)
% record is an one row table
% Copyright (c) 2020 Yuichi Takeuchi

threshold = 1000;
FreqTb = [10 25];
sr = RecInfo.srLFP;

% find detection time stamps
madc = memmapfile(['tmp/' fldrInfoadc(trialNo).name], 'format', 'int16');
dataadc = madc.data(period(1)*sr+1:period(2)*sr);
dtctlogical = dataadc > threshold;
[~,tempR,~] = ssf_FindConsecutiveTrueChunks(dtctlogical');
dtctn = uint64(tempR)';

if jitter
    tsp = uint64(floor(double(dtctn) + sr*(stm_delay/1000 + 0.1*rand(size(dtctn,1), size(dtctn,2)))));
else
    tsp = uint64(dtctn + sr*(stm_delay/1000));
end
tsp(tsp > length(dataadc)) = []; % rejection of overrun

if length(tsp) < 10
    tsp = [];
end

% data retrieval
mlfp = memmapfile(['tmp/' fldrInfolfp(trialNo).name], 'format', 'int16');
lfpdata = reshape(mlfp.data, 30, []);
lfpdata1ch = lfpdata(channelNo, period(1)*sr+1:period(2)*sr); % channel extraction

tmpdata = filtf_LowPassButter3(lfpdata1ch, FreqTb(2), 3, sr);
FltdLFP = filtf_HighPassButter3(tmpdata, FreqTb(1), 3, sr);
y = hilbert(FltdLFP);
phase = angle(y) + pi;

InstantaneousPhase = phase(tsp);

% circular histograph
edges = linspace(0, 2*pi, 360);
[N, edges] = histcounts(InstantaneousPhase,edges);
N = [N 0];

r = circ_r(edges, N); % r = circ_r(alpha, w, d, dim)
% fprintf('r = %d\n', r)

[mu, ~, ~] = circ_mean(edges, N); % [mu, ul, ll] = circ_mean(alpha, w, dim)
% fprintf('mu = %d\n', mu)

U = r*cos(mu);
V = r*sin(mu);

% Rayleigh test
[pval, z] = circ_rtest(edges, N); % [pval, z] = circ_rtest(alpha, w, d)

% output table
varNames = {'LTR'; 'date'; 'expNo'; 'sessionNo'; 'ratNo'; 'trialNo'; 'closed'; 'offset'; 'duration'; 'delay'; 'jitter'; 'r'; 'theta'; 'X'; 'Y'; 'pval'; 'z'};
record = table(RecInfo.LTR(ratNo), RecInfo.date, RecInfo.expnum1, RecInfo.expnum2, ratNo, trialNo, closed, period(1), period(2), stm_delay, jitter, r, mu, U, V, pval, z, 'VariableNames', varNames);

end
