function is_separated = city_separation_constraint(...
    possibly_optimal_meeting_location, optimal_meeting_locations, i)
%city_separation_constraint Returns true if a given coordinate is at least
% 3000 km away from the first i coordinates in a specified set, using the
% Haversine formula for distance calculation.
    
    arguments
        possibly_optimal_meeting_location = [34.040, -118.269] % coordinates of the Los Angeles Convention Center
        optimal_meeting_locations = [0,0; 20,20; 30,30; 50,50; 70,70]
        i = 5
    end
    
    % Add util path
    addpath(genpath('./util'))
    
    % Required separation distance in kilometers
    separation_distance_km = 3000; 

    % Initialize the result to true
    is_separated = true;

    for k = 1:i
        % Get the k-th optimal meeting location
        current_location = optimal_meeting_locations(k, :);

        distance = calculate_distance(current_location, possibly_optimal_meeting_location);

        % Check if the distance is less than the required separation distance
        if distance < separation_distance_km
            is_separated = false;
        end
    end
end
