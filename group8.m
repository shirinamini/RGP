% Load the dataset (assuming it's in CSV format; you may need to adjust the file type)
data = readtable("Rice_Cammeo_Osmancik.xlsx");  

% View the first few rows of the table to understand its structure
disp(data);

% Filter the data for each class
cammeoData = data(strcmp(data.Class, 'Cammeo'), :);
osmancikData = data(strcmp(data.Class, 'Osmancik'), :);


% Calculate the mean for each class (excluding the last column)
meanCammeo = mean(cammeoData{:, 1:end-1});  
meanOsmancik = mean(osmancikData{:, 1:end-1});  
disp(meanCammeo);
disp(meanOsmancik);

% Calculate the median for each class (excluding the last column)
medianC = median(cammeoData{:, 1:end-1});  
medianO = median(osmancikData{:, 1:end-1}); 
disp(medianC);
disp(medianO);

% Calculate the std for each class (excluding the last column)
stdC = std(cammeoData{:, 1:end-1});  
stdO = std(osmancikData{:, 1:end-1});  
disp(stdC);
disp(stdO);

cammeoData = data(strcmp(data{:, end}, 'Cammeo'), :);
osmancikData = data(strcmp(data{:, end}, 'Osmancik'), :);

% Extract the feature you're interested in (e.g., Area)
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

% Extract the Eccentricity (now assuming it is in the 5th column)
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


