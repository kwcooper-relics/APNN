
%one input raster

ca3_c = con2seq(rasMid(1:900,:));

ca1_c = con2seq(rasSide(1:900,:));

train_start = 1;
train_end = 5000;

%(layer delays, numlayers, funct)
rastNet = layrecnet(1,10);
rastNet.trainFcn = 'trainbr';
rastNet.trainParam.show;
rastNet.trainParam.epochs = 50;

rastNet = train(rastNet,ca3_c(train_start:train_end), ...
                        ca1_c(train_start:train_end));

                    
start_t = 80000;
end_t = 95000;

% Test output of recurrent neural net 
netOut = rastNet(rasMid(2,:));
%test_out = cell2mat(test_out);

% See how ouput compares to real data
% Get correlation
%[res, r_vals] = corrcoef([netOut dca1(start_t:end_t)]);

