function cleanedArray = removeNaNs(cellArray)
    % Initialize an empty cell array to store non-NaN elements
    cleanedArray = {};
    
    % Iterate through each element in the cell array
    for i = 1:numel(cellArray)
        % Check if the element is not NaN
        if ~isnan(cellArray{i})
            % Add the non-NaN element to the cleaned array
            cleanedArray{end+1, 1} = cellArray{i};
        end
    end
end