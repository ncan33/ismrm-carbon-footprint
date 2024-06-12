function trimmedString = keepLast_N_Elements(inputString, n)
    % Split the input string by commas
    parts = strsplit(inputString, ',');
    
    % Ensure there are enough elements separated by commas
    if numel(parts) < n
        error('Input string does not have enough elements separated by commas.');
    end
    
    % Concatenate the last n elements separated by commas
    trimmedString = strjoin(parts(end-n+1:end), ',');
end