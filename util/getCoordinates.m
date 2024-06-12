function [latitude, longitude] = getCoordinates(city, state, country)
    % OpenStreetMap Nominatim API URL
    apiUrl = 'https://nominatim.openstreetmap.org/search?format=json&';
    
    % Construct the query
    if isnan(state)
        addressQuery = sprintf('q=%s,%s', city, country);
    else
        addressQuery = sprintf('q=%s,%s,%s', city, state, country);
    end
    
    % Construct the full URL
    fullUrl = strcat(apiUrl, addressQuery);
    
    % Make the API request
    response = webread(fullUrl);
    
    % Check if response is not empty
    if ~isempty(response)
        % Extract latitude and longitude from the first result
        latitude = str2double(response(1).lat);
        longitude = str2double(response(1).lon);
    else
        error('Error fetching coordinates. No results found.');
    end
end
