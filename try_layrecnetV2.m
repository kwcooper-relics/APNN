% Beginning script to run RNN (woo!)

% Decimate and normalize ts
% allCa1 = decimate(ca1_ts_m, 10);
% allCa3 = decimate(ca3_ts_m, 10);

<<<<<<< HEAD
% ca1_ts = decimate(ca1_ts_m, 10);
% ca3_ts = decimate(ca3_ts_m, 10);
ca1_ts = decimate(dca1, 10);
ca3_ts = decimate(dca3, 10);

ca1_n = ca1_ts/range(ca1_ts);
ca3_n = ca3_ts/range(ca3_ts);
=======
% ca1_n = allCa1/range(allCa1);
% ca3_n = allCa3/range(allCa3);
>>>>>>> origin/master

% convert time series to cells (for some reason)
ca3_c = con2seq(allCa3(:,1)');
ca1_c = con2seq(allCa1(:,1)');

%mb_size = 10000;
train_start = 1;
train_end = 100000;
eegLen = 10000;
netLayers = 20;

<<<<<<< HEAD
lrn_net = layrecnet(1, 20);
=======
lrn_net = layrecnet(1, netLayers);
>>>>>>> origin/master
lrn_net.trainFcn = 'trainbr';
lrn_net.trainParam.epochs = 50;
%lrn_net.performParam.regularization = 0.1;
% lrn_net = train(lrn_net,ca3_c(train_start:train_end), ...
%     ca1_c(train_start:train_end));

for i = 1:50
    lrn_net = train(lrn_net, con2seq(allCa3(1:eegLen,i)'), con2seq(allCa1(1:eegLen,i)'));
    fprintf('.')
end


start_t = 1;
end_t = 160000;
% Test output of recurrent neural net 
test_out = lrn_net(ca3_c(start_t:end_t));
test_out = cell2mat(test_out);

% See how ouput compares to real data
% Get correlation
emp_ts = ca1_c(start_t:end_t);
%[res, p_vals] = corrcoef([test_out' ca1_n(start_t:end_t)]);
[res, p_vals] = corrcoef([test_out' cell2mat(ca1_c(start_t:end_t)')]);

% Also test for peaks in data and find overlap

emp_90 = prctile(emp_ts, 90);
[~, emp_loc, emp_w] =  findpeaks(emp_ts, 'MinPeakHeight', emp_90);

sim_90 = prctile(test_out, 90);
[~, net_loc, net_w] =  findpeaks(test_out, 'MinPeakHeight', sim_90);

emp_spikes = zeros(size(emp_ts));
for i = 1:length(emp_loc)
    s_s = emp_loc(i) - floor((emp_w(i))/2);
    s_e = emp_loc(i) + floor((emp_w(i))/2);
    emp_spikes(s_s:s_e) = 1;
end

net_spikes = zeros(size(test_out));
for i = 1:length(net_loc)
    s_s = net_loc(i) - floor((net_w(i))/2);
    s_e = net_loc(i) + floor((net_w(i))/2);
    net_spikes(s_s:s_e) = 1;
end

window = 5;
overlap_peaks = 0;
for i = 1:length(emp_loc)
    low = emp_loc(i) - window;
    high = emp_loc(i) + window;
    for j = 1:length(net_loc)
        if low < net_loc(j) && net_loc(j) < high
            overlap_peaks = overlap_peaks + 1;
        end
    end
end

peak_pct = length(overlap_peaks)/length(emp_loc);
