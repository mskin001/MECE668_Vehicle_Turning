function analyzeResults(levelsMatrix, response)
% levelsMatrix is an NxM matrix with N rows equal to the number of experiments
% in and M columns equal to the number of factors such that each row corresponds
% to an experiment. levelsMatrix is in coded values, e.g. 1/-1, for the high and
% low levels respectively.
%
% response is an array with each value being the response for the corresponding
% experiment levels in levelsMatrix. E.g. levelsMatrix(1,:) gives the factor
% levels resulting in response(1).
% The example response vector given below comes from the measured slip values.
% And the levelsMatrix is produced by doeMatrixGen -> doe.mat.
%
% response = [1.3103, 1.6938, 1.8383, 1.3750, 1.8370, 1.7086, 1.4785, 1.5785,
%             1.1925, 0.8996, 0.7973, 1.3158, 1.0454, 0.9224, 1.2194, 0.7700];
%

%% Generate Ordered Data plot and identify the best experiment
data = [levelsMatrix, response'];
[~, cols] = size(data);

[dataSorted, ind] = sortrows(data,cols);

figure(1)
plot(dataSorted(:,end),'b*')

ypos = linspace(0.75, 0.6, (cols - 1));
xpos = zeros(1,length(ypos));
for k = 1:length(dataSorted(:,1))
  xpos = k-0.05;
  for i = 1:length(ypos)
     if dataSorted(k,i) == 1
       t = '+';
     else
       t = '-';
     end

     text(xpos,ypos(i),t);
  end
end

axis([0.5,16.5,0.5,2])
title('Ordered Data Plot')
xlabel('Sorded Data Experiment Number')
ylabel('Response')
disp('The best response is from experiment number: ')
disp(ind(end))

%% Generate main effects and interaction plots
figure(2)
maineffectsplot(response',levelsMatrix, 'varnames', {'x-pos', 'y-pos', 'Length',...
'Thickness', 'Turn Radius', 'Road Surface'})

figure(3)
interactionplot(response',levelsMatrix, 'varnames', {'x-pos', 'y-pos', 'Length',...
'Thickness', 'Turn Radius', 'Road Surface'})

%% Generate Yuden plot
factors = {'a', 'b', 'c', 'd', 'e', 'f', 'ab', 'ac', 'ad', 'ae', 'af', 'bc', 'bd',...
'be', 'bf', 'cd', 'ce', 'cf', 'de', 'df', 'ef'};

extTable = levelsMatrix;
for k = 1:length(factors) - 6
  for j = (k+1):6

    extTable(:,(end+1)) = data(:,k) .* data(:,j);
  end
end
disp(extTable)

for k = 1:length(factors)
  lows = extTable(:,k) == -1;
  highs = extTable(:,k) == 1;

  neg = mean(response(lows));
  pos = mean(response(highs));

  figure(4), hold on
  plot(neg,pos);
  text(neg,pos,factors{k})
end

end
