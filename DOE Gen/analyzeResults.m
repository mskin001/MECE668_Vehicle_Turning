function analyzeResults(levelsMatrix, response)

data = [levelsMatrix, response];
dataSorted = sortrows(data,end);

plot(dataSorted(:,6),'b*')

for k = 1:length(dataSorted(:,1))
  pos = [k, (dataSorted(1,end)-1)];
  t = num2str( dataSorted( k,1:(end-1) ) );
  text(pos(1),pos(2),t)
end

end
