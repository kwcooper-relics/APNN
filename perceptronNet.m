%A Perceptron to train a neural network... .
%% Situate Data
%x = [0 0 1 1; 0 1 0 1];
%t = [0 1 1 1];

% [rasMid, tVec] = distroSpikeGen(2, 100, 0, 50);
% [rasSide, tVec] = distroSpikeGen(2, 100, 50, 0);
% 
% x = rasMid; 
% t = rasSide;


x = con2seq(allCa3(:,1)');
t = con2seq(allCa1(:,1)');


%% Create the neural net
net = perceptron;
%Set the epochs 
net.trainParam.epochs = 1;

fprintf('iteration: ')
for i = 1:size(x, 1)
    if mod(i, 10) == 0; fprintf(num2str(i), ' '); end
net = train(net,x(i,:),t(i,:));
end

%net = train(net,x,t);
%view(net)

%% Test 
%[rasMidTst, tVec] = distroSpikeGen(2, 1, 0, 50);

start_t = 1;
end_t = 160000;
%y = net(x);
rasMidTst = ca3_c(start_t:end_t)
y = net(rasMidTst);

%HeatMap(y)

