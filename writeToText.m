fid = fopen('/Users/W/Desktop/eegPerdict/Bon/ca1/allCa11.txt','w+');
tic
for i = 1:length(allCa11)
fprintf(fid, '\n', allCa11(i,:));
end

fclose(fid)
tock