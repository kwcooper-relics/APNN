% Beginning script to run RNN (woo!)
%one input series
% convert time series to cells (for some reason)
ca3_c = con2seq(ca3_ts');

ca1_c = con2seq(ca1_ts');

train_start = 1;
train_end = 1000;

lrn_net = layrecnet(1,10);
lrn_net.trainFcn = 'trainbr';
lrn_net.trainParam.show;
lrn_net.trainParam.epochs = 50;
lrn_net = train(lrn_net,ca3_c(train_start:train_end), ...
    ca1_c(train_start:train_end));

start_t = 500000;
end_t = 1000000;

% Test output of recurrent neural net 
test_out = lrn_net(ca3_c(start_t:end_t));
test_out = cell2mat(test_out);

% See how ouput compares to real data
% Get correlation
[res, r_vals] = corrcoef([test_out' ca1_ts(start_t:end_t)]);

