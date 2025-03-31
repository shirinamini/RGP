% feature_accuracy_comparison.m
% Author: Shirin
% Date: March 30, 2025
% Description: Compares individual features to find the best one for classifying rice type using threshold.

% Load dataset
data = readtable('Rice_Cammeo_Osmancik.xlsx');

% Identify numeric features and extract names
numericCols = varfun(@isnumeric, data, 'OutputFormat', 'uniform');
featureNames = data.Properties.VariableNames(numericCols);
actualClass = data.Class;
trueLabels = strcmp(actualClass, 'Cammeo');  % Cammeo = 1, Osmancik = 0

% Initialize storage
numFeatures = length(featureNames);
bestAcc = 0;
bestFeature = "";
allAccuracies = zeros(numFeatures, 1);
bestThresholds = zeros(numFeatures, 1);

% Loop through each feature to evaluate it
for i = 1:numFeatures
    feature = normalize(data.(featureNames{i}));

    % Try multiple thresholds
    minVal = min(feature);
    maxVal = max(feature);
    threshVals = linspace(minVal, maxVal, 1000);
    acc = zeros(size(threshVals));

    for j = 1:length(threshVals)
        t = threshVals(j);
        predicted = feature > t;
        acc(j) = sum(predicted == trueLabels) / length(trueLabels);
    end

    % Store best accuracy and threshold for this feature
    [maxAcc, idx] = max(acc);
    allAccuracies(i) = maxAcc;
    bestThresholds(i) = threshVals(idx);

    % Plot accuracy vs threshold for this feature
    figure;
    plot(threshVals, acc, 'LineWidth', 2);
    title(['Accuracy vs Threshold for Feature: ', featureNames{i}]);
    xlabel('Threshold Value');
    ylabel('Accuracy');
    grid on;

    % Update best feature
    if maxAcc > bestAcc
        bestAcc = maxAcc;
        bestFeature = featureNames{i};
    end
end

% Final report
fprintf('--- Individual Feature Evaluation ---\n');
for i = 1:numFeatures
    fprintf('Feature: %s | Best Accuracy: %.2f%% | Best Threshold: %.4f\n', ...
        featureNames{i}, allAccuracies(i) * 100, bestThresholds(i));
end
fprintf('\nBest Feature: %s with Accuracy: %.2f%%\n', bestFeature, bestAcc * 100);

% Plot all feature accuracies together
figure;
bar(allAccuracies * 100);
set(gca, 'XTickLabel', featureNames, 'XTickLabelRotation', 45);
title('Best Accuracy of Each Feature');
ylabel('Accuracy (%)');
xlabel('Features');
grid on;
