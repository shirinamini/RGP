% Load the dataset 
data = readtable("Rice_Cammeo_Osmancik.xlsx");  
disp(data);

% Check if there are any missing values
if any(ismissing(data))
    disp('Missing values detected in the dataset.');
else
    disp('No missing values found in the dataset.');
end

% Summary statistics
disp('Summary of dataset:');
summary(data)

% Filter the data for each class 
cammeoData = data(strcmp(data.Class, 'Cammeo'), :);
osmancikData = data(strcmp(data.Class, 'Osmancik'), :);


% Calculate the mean for each variable on each class (excluding the last column)
meanCammeo = mean(cammeoData{:, 1:end-1});  
meanOsmancik = mean(osmancikData{:, 1:end-1});  
disp(meanCammeo);
disp(meanOsmancik);

% Calculate the median for each variable on each class (excluding the last column)
medianC = median(cammeoData{:, 1:end-1});  
medianO = median(osmancikData{:, 1:end-1}); 
disp(medianC);
disp(medianO);

% Calculate the std for each variable on each class (excluding the last column)
stdC = std(cammeoData{:, 1:end-1});  
stdO = std(osmancikData{:, 1:end-1});  
disp(stdC);
disp(stdO);

cammeoData = data(strcmp(data{:, end}, 'Cammeo'), :);
osmancikData = data(strcmp(data{:, end}, 'Osmancik'), :);

% Extract the Area in first coloumn 
cammeoArea = cammeoData{:, 1};
osmancikArea = osmancikData{:, 1};  

% Create a histogram for the Area feature
figure;

% Plot the histogram
hold on;
histogram(cammeoArea, 'FaceColor', 'blue', 'EdgeColor', 'black', 'FaceAlpha', 0.5, 'DisplayName', 'Cammeo');
histogram(osmancikArea, 'FaceColor', 'red', 'EdgeColor', 'black', 'FaceAlpha', 0.5, 'DisplayName', 'Osmancik');

% Add labels and title
xlabel('Area');
ylabel('Frequency');
title('Histogram of Rice Size: Cammeo vs Osmancik');
legend('show');

hold off;

% Extract the Eccentricity 
cammeoEccentricity = cammeoData{:, 5}; 
osmancikEccentricity = osmancikData{:, 5};  

% Create a new figure for the histogram
figure;

% Plot histograms for Eccentricity
hold on;  % Hold on to overlay the histograms

% Histogram for Cammeo rice
histogram(cammeoEccentricity, 'FaceColor', 'blue', 'EdgeColor', 'black', 'FaceAlpha', 0.5, 'DisplayName', 'Cammeo');

% Histogram for Osmancik rice
histogram(osmancikEccentricity, 'FaceColor', 'red', 'EdgeColor', 'black', 'FaceAlpha', 0.5, 'DisplayName', 'Osmancik');

% Add labels and title
xlabel('Eccentricity');
ylabel('Frequency');
title('Histogram of Rice Shape: Cammeo vs Osmancik');
legend('show');  

hold off;  

figure;

% Create a boxplot for the Area (Size) comparison
subplot(1, 2, 1);  
boxplot([cammeoArea; osmancikArea],[repmat({'Cammeo'}, length(cammeoArea), 1); repmat({'Osmancik'}, length(osmancikArea), 1)]);
title('Rice Size: Cammeo vs Osmancik');
ylabel('Area');

% Create a boxplot for the Eccentricity (Shape) comparison
subplot(1, 2, 2); 
boxplot([cammeoEccentricity; osmancikEccentricity], [repmat({'Cammeo'}, length(cammeoEccentricity), 1); repmat({'Osmancik'}, length(osmancikEccentricity), 1)]);
title('Rice Shape: Cammeo vs Osmancik');
ylabel('Eccentricity');


