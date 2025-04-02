% Willayne Morota (#219783992)
% Description: Which feature combination works best? Compare different features for classification accuracy.

% reading dataset file
data = readtable('Rice_Cammeo_Osmancik.xlsx');

% converts class labels to binary (0 for Cammeo, 1 for Osmancik)
data.Class = double(strcmp(data.Class, 'Osmancik'));

% list of features to analyze
features = {'Area', 'Perimeter', 'Major_Axis_Length', 'Minor_Axis_Length', ...
            'Eccentricity', 'Convex_Area', 'Extent'};

num_features = numel(features);  % number of features (7)
accuracy_results = zeros(num_features, 1);  % stores accuracy results

% calculate accuracy for each feature
disp('Single Feature Accuracy:');
for i = 1:num_features
    feature_data = data{:, features{i}};
    
    % using the mean as the threshold for classification
    threshold = mean(feature_data);
    
    % predicting the class based on threshold
    predictions = feature_data > threshold;
    
    % calculate accuracy
    accuracy_results(i) = sum(predictions == data.Class) / numel(data.Class);
end

% displaying accuracy for each feature
accuracy_table = table(features', accuracy_results, 'VariableNames', {'Feature', 'Accuracy'});
disp(accuracy_table);

% testing accuracy for combinations of two features
disp('Testing Two-Feature Combinations...');
best_accuracy = 0;
best_pair = [];
pair_combinations = cell(num_features * (num_features - 1) / 2, 2);  % stores pairs
pair_accuracy = zeros(num_features * (num_features - 1) / 2, 1);      % stores pair accuracies

pair_idx = 1;  % index for storing pairs
for i = 1:num_features
    for j = i+1:num_features

        % getting data for the two features
        feature1 = data{:, features{i}};
        feature2 = data{:, features{j}};
        
        % classifying based on both features mean values
        threshold1 = mean(feature1);
        threshold2 = mean(feature2);
        
        predictions = (feature1 > threshold1) & (feature2 > threshold2);
        
        % calculating accuracy
        accuracy = sum(predictions == data.Class) / numel(data.Class);
        
        % updates / replaces best accuracy and pair
        if accuracy > best_accuracy
            best_accuracy = accuracy;
            best_pair = {features{i}, features{j}};
        end
        
        % store feature pairs and their accuracy
        pair_combinations{pair_idx, 1} = features{i};
        pair_combinations{pair_idx, 2} = features{j};
        pair_accuracy(pair_idx) = accuracy;
        
        pair_idx = pair_idx + 1;
    end
end

% display the best two-feature combination
fprintf('Best Two-Feature Combination: %s & %s (Accuracy = %.2f)\n', best_pair{1}, best_pair{2}, best_accuracy);

% Create scatter plot for the best feature pair
cammeo_idx = data.Class == 0;
osmancik_idx = data.Class == 1;

figure; hold on;  % keeps the plot open for both classes

% plotting Cammeo points
scatter(data{cammeo_idx, best_pair{1}}, data{cammeo_idx, best_pair{2}}, 40, 'b', 'filled', ...
        'MarkerFaceAlpha', 0.5, 'MarkerEdgeColor', 'k', 'DisplayName', 'Cammeo');

% plotting Osmancik points
scatter(data{osmancik_idx, best_pair{1}}, data{osmancik_idx, best_pair{2}}, 40, 'r', 'filled', ...
        'MarkerFaceAlpha', 0.5, 'MarkerEdgeColor', 'k', 'DisplayName', 'Osmancik');

% axis labels and title
xlabel(best_pair{1}, 'FontSize', 12, 'FontWeight', 'bold');
ylabel(best_pair{2}, 'FontSize', 12, 'FontWeight', 'bold');
title('Best Feature Combination for Classification', 'FontSize', 14, 'FontWeight', 'bold');

% legend
legend('show', 'Location', 'Best', 'FontSize', 12);

grid on;
axis tight;
hold off;
