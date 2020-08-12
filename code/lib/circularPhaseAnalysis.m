function circularPhaseAnalysis(closed, RecInfo, DataStruct, metainfo, ID)

polarhist = 1;
clear Tb instPhases
for i = 1:size(metainfo,1)  % for by dat file
    [tmpTb, tmpInstPhases] = tableResultantVectorStacks(closed, RecInfo{i}, DataStruct{i}, metainfo{i,6}, polarhist);
    if i == 1
        Tb = tmpTb;
        instPhases = tmpInstPhases;
    else
        Tb = [Tb;tmpTb];
        instPhases = [instPhases; tmpInstPhases];
    end
end

instPhaseLabel{1, 1} = 'instPhase';
varLabel = [instPhaseLabel Tb.Properties.VariableNames];
instPhases = [varLabel;instPhases];

% csv and compass file outputs
writetable(Tb, ['../results/' ID '_closed' num2str(closed) '_resultantVec.csv'])
save(['../results/' ID '_closed' num2str(closed) '_instPhases.mat'],'instPhases')
printCompassPDFPNG(Tb)
disp('done')

end


