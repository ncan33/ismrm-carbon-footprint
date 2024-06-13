function corrected_location = correct_coordinates(possibly_optimal_meeting_location)
    % Extract latitude and longitude from the input vector
    latitude = possibly_optimal_meeting_location(1);
    longitude = possibly_optimal_meeting_location(2);

    % Ensure latitude is within [-90, 90]
    latitude = max(min(latitude, 90), -90);
    
    % Ensure longitude is within [-180, 180]
    longitude = mod(longitude + 180, 360) - 180;

    % Return the corrected coordinates
    corrected_location = [latitude, longitude];
end
