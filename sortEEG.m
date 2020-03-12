%This file is part of APNN
%Created by Keiland and Zach

% Script to extract info about eeg data from one rat
% Creates two arrays with the sorted eeg data

disp('Welcome to APANN')
disp('lets sort some channels')

load('bontetinfo.mat');
allCa1 = [zeros(2100000,500)];
allCa3 = [zeros(2100000,500)];
ca1list = [];
ca3_tets = [];
ca1_tets = [];

unkSites = 0;
ca1Add = 0;
ca3Add = 0;

lenArray = [zeros(2100000, 1)];
epochIt = 0;

elapsedTime = [];


for d = 1:length(tetinfo)
    disp(['Day: ' num2str(d)])
    for e  = 1:length(tetinfo{d})
        
        fprintf(['Epoch ' num2str(e)])
        for t = 1:length(tetinfo{d}{e})
            fprintf('.');
            for c = 1:length(tetinfo{d}{e}{t})
                tic
                if isfield(tetinfo{d}{e}{t}, 'area') == 1
                    %if tetinfo{d}{e}{t}.numcells > 0
                        if strcmp(tetinfo{d}{e}{t}.area, 'CA3')
                            %adjust for the 01
                            if t < 10
                                t = strcat('0',num2str(t));
                            end
                            
                            if d < 10
                                dyct = strcat('0',num2str(d));
                            else
                                dyct = d;
                                
                            end
                            ca3eeg = load(['EEG/boneeg' dyct '-' num2str(e) '-' num2str(t) '.mat']);
                            %convert it back
                            if isstr(t)
                               t = str2num(t); 
                            end
                            %convert and save to .txt
                            %save tst.txt data -ascii
                            data = ca3eeg.eeg{d}{e}{t}.data;
                            %copyfile( data, '/Users/W/Desktop/eegPerdict/Bon/ca1')
                            
                            %hard coded length adjustment, adds 0 at the end
                            data(numel(lenArray)) = 0;
                            
                            %allCa3 = [allCa3 data]; %memory hog
                            allCa3(:,ca3Add) = data;
                            ca3Add = ca3Add + 1;
                            
                        elseif strcmp(tetinfo{d}{e}{t}.area, 'CA1')
                            if t < 10
                                t = strcat('0',num2str(t));
                            end
                            if d < 10
                                dyct = strcat('0',num2str(d));
                            else
                                dyct = d;
                            end
                            ca1eeg = load(['EEG/boneeg' dyct '-' num2str(e) '-' num2str(t) '.mat']);
                            if isstr(t)
                               t = str2num(t); 
                            end
                            data = ca1eeg.eeg{d}{e}{t}.data;
                            %hard coded length adjustment, adds 0 at the end
                            data(numel(lenArray)) = 0;
                            
                            %allCa1 = [allCa1 data];
                            allCa1(:,ca1Add) = data;
                            ca1Add = ca1Add + 1;
                        else
                            %Keep Track of non-labeled sites
                            unkSites = unkSites + 1;
                        end
                     %end
                end
               elapsedTime(end+1) = toc; 
            end
        end
        disp(' ')
    end
end

disp(['There were ' num2str(unkSites) 'unknown sites'])
disp([num2str(ca1Add) 'Epochs added from Ca1'])
disp([num2str(ca3Add) 'Epochs added from Ca3'])

plot(elapsed_time_array)



