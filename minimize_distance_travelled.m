function [optimal_meeting_location, optimal_distance_travelled, actual_cost, ...
    iteration_cost] = minimize_distance_travelled(coordinates, ...
    initial_location, num_iterations)

    arguments
        coordinates = {[0, 0]; [50, 50]} % if ISMRM had N = 2 attendees
        initial_location = [-53.416, -160.371]%[34.040, -118.269] % coordinates of the Los Angeles Convention Center
        num_iterations = 1000; % adjust this based on convergence
    end
    
    % start stopwatch timer
    tic
    
    % add util path
    addpath(genpath('./util'))
    
    % initialize
    optimal_meeting_location = initial_location;
    
    actual_cost = []; % accepted cost: costs for accepted updates
    iteration_cost = []; % all costs: costs for every iteration
    
    for i = 1:num_iterations
        % latitudes are -90 to +90 and longitudes are -180 to +180
        step_size_lat = rand * 180;
        step_size_lon = rand * 360;

        % Calculate total distance for current meeting location
        current_distance = total_distance_travelled(optimal_meeting_location, coordinates);

        % Randomly select one coordinate and move the meeting location towards it
        random_index = randi(length(coordinates)); % Randomly select an index
        random_coordinate = coordinates{random_index};

        % Calculate the direction vector towards the randomly selected coordinate
        direction_vector = random_coordinate - optimal_meeting_location;
        
        % Normalize the direction vector
        direction_vector_normalized = direction_vector / norm(direction_vector);
        
        % Update meeting location by moving a fixed distance step in the direction
        possibly_optimal_meeting_location = optimal_meeting_location + [step_size_lat, step_size_lon] .* direction_vector_normalized;
        
        % Calculate new total distance
        new_distance = total_distance_travelled(possibly_optimal_meeting_location, coordinates);

        % If the new distance is an improvement, then update the meeting_location
        if new_distance < current_distance
            optimal_meeting_location = possibly_optimal_meeting_location;
        end
        
        % Update actual cost
        difference_deg = (possibly_optimal_meeting_location - optimal_meeting_location);
        if new_distance < current_distance
            actual_cost = [actual_cost, new_distance]; %#ok<AGROW>
        elseif  norm(difference_deg) < (1/3) % if the difference between the two locations is
                                             % less than 20 miles (which corresponds to ~20 minutes,
                                             % which is 1/3 of a degree since there are 60 minutes,
                                             % in 1 degree), count it towards the actual cost
                                             % (helpful for determining convergence behavior)
            actual_cost = [actual_cost, new_distance]; %#ok<AGROW>
        end
        
        % Update iteration cost
        iteration_cost = [iteration_cost, new_distance]; %#ok<AGROW>
    end
    
    if new_distance < current_distance
        optimal_distance_travelled = new_distance;
    else
        optimal_distance_travelled = current_distance;
    end
    
    % end stopwatch timer
    disp('minimize_distance_travelled() has finished running.')
    toc
    
end