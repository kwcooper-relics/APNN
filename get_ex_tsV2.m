% Script to extract info about eeg data from rat 

day = 3;
epoch = 1;
ca3_tets = [];
ca1_tets = [];

% load tetrode info for the given day and epoch
tetinfo = load('bontetinfo.mat');
tets = tetinfo.tetinfo{day}{epoch};

% Go through and see which ca3 tetrodes have data
ca3 = [];
ca1 = [];

for i = 1:length(tets)
    if isstruct(tets{i})
        if tets{i}.numcells > 0
            if strcmp(tets{i}.area, 'CA3')
                ca3 = [ca3 i];
            else
                ca1 = [ca1 i];
            end
        end
            
    end
end
    
ind = ca3(end);

ex_ca3_eeg = load(['EEG/boneeg0' num2str(day) '-' num2str(epoch) ...
    '-' num2str(ind) '.mat']);

ca3_ts = ex_ca3_eeg.eeg{day}{epoch}{ca3(end)}.data;

% average time series from each tetrod
for i = 1:length(ca3)
    ind = ca3(i);
    
    if ind > 9
        ex_ca3_eeg = load(['EEG/boneeg0' num2str(day) '-' num2str(epoch) ...
        '-' num2str(ind) '.mat']);
    else
        ex_ca3_eeg = load(['EEG/boneeg0' num2str(day) '-' num2str(epoch) ...
        '-0' num2str(ind) '.mat']);
    end

    ca3_ts_i = ex_ca3_eeg.eeg{day}{epoch}{ca3(i)}.data;
    
    if i == 1
        ca3_ts_m = ca3_ts_i;
    else
        if length(ca3_ts_m) == length(ca3_ts_i)
            ca3_ts_m = ca3_ts_m + ca3_ts_i;
        elseif length(ca3_ts_i) < length(ca3_ts_m)
            ca3_ts_m = ca3_ts_m(1:length(ca3_ts_i));
            ca3_ts_m = ca3_ts_m + ca3_ts_i;
        else
            ca3_ts_i = ca3_ts_i(1:length(ca3_ts_m));
            ca3_ts_m = ca3_ts_m + ca3_ts_i;
        end
    end
end


% Get time series from one ca1 tetrode
ex_ca1_ind = ca1(end);

ex_ca1_eeg = load(['EEG/boneeg0' num2str(day) '-' num2str(epoch) ...
    '-' num2str(ex_ca1_ind) '.mat']);

ca1_ts = ex_ca1_eeg.eeg{day}{epoch}{ca1(end)}.data;

%ca3_ts = ca3_ts(1:(end-3));

for i = 1:length(ca1)
    ind = ca1(i);
    
    if ind > 9
        ex_ca1_eeg = load(['EEG/boneeg0' num2str(day) '-' num2str(epoch) ...
        '-' num2str(ind) '.mat']);
    else
        ex_ca1_eeg = load(['EEG/boneeg0' num2str(day) '-' num2str(epoch) ...
        '-0' num2str(ind) '.mat']);
    end

    ca1_ts_i = ex_ca1_eeg.eeg{day}{epoch}{ca1(i)}.data;
    
    if i == 1
        ca1_ts_m = ca1_ts_i;
    else
        if length(ca1_ts_m) == length(ca1_ts_i)
            ca1_ts_m = ca1_ts_m + ca1_ts_i;
        elseif length(ca1_ts_i) < length(ca1_ts_m)
            ca1_ts_m = ca1_ts_m(1:length(ca1_ts_i));
            ca1_ts_m = ca1_ts_m + ca1_ts_i;
        else
            ca1_ts_i = ca1_ts_i(1:length(ca1_ts_m));
            ca1_ts_m = ca1_ts_m + ca1_ts_i;
        end
    end
end
