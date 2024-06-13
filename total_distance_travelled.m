function total_distance = total_distance_travelled(meeting_location, coordinates)
%total_distance_travelled Calculates the total distance travelled by ISMRM
%attendees for a given meeting_location. Travel distances of less than 300
%miles are assumed to be non-air travel and to have negligible emissions.
%The units of the output (total_distance) is km.
% coordinates is a Nx1 cell. Each element of this cell is a 1x2 vector
% corresponding to the coordinates of each first author from a set of N
% first authors. meeting_location is a 1x2 coordinate vector
    
    arguments
        meeting_location = [34.040, -118.269] % coordinates of the Los Angeles Convention Center
        coordinates = {[0, 0]; [50, 50]} % if ISMRM had N = 2 attendees
    end
    
    % add util path
    addpath(genpath('./util'))
    
    total_distance = 0;
    
    for i = 1:length(coordinates)
        distance = calculate_distance(meeting_location, coordinates{i});
        
        if distance > 300 * 1.609 % 300 miles to km
            total_distance = total_distance + distance;
        end
    end
end

