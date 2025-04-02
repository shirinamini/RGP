% Mary Vennam
% STUDENT id: 300248201
% Task: Analyse relationships between features
% Compute correlation matrix, Analyze relationships and create Correlation Heatmap & Scatter Plots

% Load the dataset
filename = 'Rice_Cammeo_Osmancik.xlsx';
sheet = 'Rice';
data = readtable(filename, 'Sheet', sheet);

% Display the first few rows of data
disp(head(data));

% Extract numerical features (excluding 'Class')
numericalData = data{:, 1:end-1}; % Assuming 'Class' is the last column

% Compute the correlation matrix
correlationMatrix = corr(numericalData);

% Display the correlation matrix
disp('Correlation Matrix:');
disp(correlationMatrix);

% Create a heatmap for the correlation matrix
figure;
heatmap(data.Properties.VariableNames(1:end-1), ...
    data.Properties.VariableNames(1:end-1), ...
    correlationMatrix, ...
    'Colormap', parula, ...
    'ColorLimits', [-1, 1]);
title('Correlation Matrix Heatmap');

% Example: Scatter plot for 'Area' vs 'Perimeter'
figure;
scatter(numericalData(:, 1), numericalData(:, 2), 'filled'); % Area vs Perimeter
xlabel('Area');
ylabel('Perimeter');
title('Scatter Plot: Area vs Perimeter');

% Example: Scatter plot for 'Area' vs 'Major_Axis_Length'
figure;
scatter(numericalData(:, 1), numericalData(:, 3), 'filled'); % Area vs Major_Axis_Length
xlabel('Area');
ylabel('Major Axis Length');
title('Scatter Plot: Area vs Major Axis Length');

% Analysis and Interpretation
disp('Analyzing the Correlation Matrix and Scatter Plots:');

% Strong Positive Correlations
strongPositive = correlationMatrix > 0.9;
disp('Strong Positive Correlations (greater than 0.9):');

% Find features with strong positive correlations
[row, col] = find(strongPositive);
correlatedFeatureIndices = unique([row; col]);

% Get feature names, exclude the diagonal
numFeatures = size(correlationMatrix, 1);
correlatedFeatureNames = {};
for i = 1:numFeatures
    for j = 1:numFeatures
        if strongPositive(i, j) && i ~= j
            featureName1 = data.Properties.VariableNames{i};
            featureName2 = data.Properties.VariableNames{j};
            if ~ismember(featureName1, correlatedFeatureNames)
                correlatedFeatureNames{end+1} = featureName1;
            end
            if ~ismember(featureName2, correlatedFeatureNames)
                correlatedFeatureNames{end+1} = featureName2;
            end
        end
    end
end

% Display correlated features
if ~isempty(correlatedFeatureNames)
    disp(correlatedFeatureNames);
else
    disp('None');
end

% Strong Negative Correlations
strongNegative = correlationMatrix < -0.9;
disp('Strong Negative Correlations (less than -0.9):');
if any(strongNegative, 'all')
    correlatedFeatures = data.Properties.VariableNames(any(strongNegative));
    disp(correlatedFeatures);
else
    disp('None');
end

% Scatter Plot Interpretation (Example: Area vs Perimeter)
disp('Scatter Plot Interpretation (Example: Area vs Perimeter):');
disp('The scatter plot of Area vs Perimeter shows a strong positive linear relationship.');
disp('This indicates that as the Area of the rice grain increases, the Perimeter also tends to increase.');

% General Interpretation
disp('General Interpretation:');
disp('Features with high correlation coefficients (close to 1 or -1) are highly related.');
disp('These relationships can be useful for feature selection and model building.');
disp('Weak correlations (close to 0) suggest that the features are not linearly related.');

% Conclusion
disp('Conclusion:');
disp('The analysis of the correlation matrix and scatter plots reveals strong positive correlations between several features of the rice grains, including Area, Perimeter, MajorAxisLength, and ConvexArea.  These features provide similar information, and one might consider using only a subset of these features in subsequent analysis to reduce dimensionality.  Extent shows little to no correlation with the other features.');
