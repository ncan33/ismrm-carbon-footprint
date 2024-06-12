function [city, state, country] = parseLocation(locationString)
    % Split the input string by commas
    parts = strsplit(locationString, ',');
    
    % Determine the number of elements after splitting
    numParts = numel(parts);
    
    % Check the number of parts and assign variables accordingly
    if numParts == 3
        city = strtrim(parts{1});
        state = strtrim(parts{2});
        country = strtrim(parts{3});
    elseif numParts == 2
        city = strtrim(parts{1});
        state = NaN;
        country = strtrim(parts{2});
    else
        error('Invalid location format.');
    end
end
