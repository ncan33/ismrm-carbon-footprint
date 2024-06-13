function [optimal_meeting_locations, optimal_distances_travelled, actual_cost, ...
    iteration_cost] = five_optimal_cities(coordinates, num_iterations)

    arguments
        coordinates = {[0, 0]; [50, 50]} % if ISMRM had N = 2 attendees
        num_iterations = 2000; % adjust this based on convergence
    end
    
    % add util path
    addpath(genpath('./util'))
    
    % start stopwatch timer
    tic

    optimal_meeting_locations = repmat([-90, 0], 5, 1);
    optimal_distances_travelled = zeros(5, 1);
    
    actual_cost = zeros(5, num_iterations); % accepted cost: costs for accepted updates
    iteration_cost = zeros(5, num_iterations); % all costs: costs for every iteration
    actual_cost_counter = 1; % counter for populating actual_cost matrix
    
    for i = 1:5
        for j = 1:num_iterations
            % latitudes are -90 to +90 and longitudes are -180 to +180
            step_size_lat = rand * 180;
            step_size_lon = rand * 360;
            
            % Calculate total distance for current meeting location
            current_distance = total_distance_travelled(optimal_meeting_locations(i, :), coordinates);

            % Randomly select one coordinate and move the meeting location towards it
            random_index = randi(length(coordinates)); % Randomly select an index
            random_coordinate = coordinates{random_index};

            % Calculate the direction vector towards the randomly selected coordinate
            direction_vector = random_coordinate - optimal_meeting_locations(i, :);

            % Normalize the direction vector
            direction_vector_normalized = direction_vector / norm(direction_vector);

            % Update meeting location by moving a fixed distance step in the direction
            possibly_optimal_meeting_location = optimal_meeting_locations(i, :) + [step_size_lat, step_size_lon] .* direction_vector_normalized;
            
            % Ensure that the latitudes are within [-90, 90] and longitudes
            % are within [-180, 180]
            possibly_optimal_meeting_location = correct_coordinates(possibly_optimal_meeting_location);
            
            % Calculate new total distance
            new_distance = total_distance_travelled(possibly_optimal_meeting_location, coordinates);
            
            % if statement enforces the constraint that all optimal cities
            % are in unique regions (3,000 km away minimum)
            if (i == 1) || city_separation_constraint(possibly_optimal_meeting_location, optimal_meeting_locations, i)
                
                % If the new distance is an improvement, then update the meeting_location
                if new_distance < current_distance
                    optimal_meeting_locations(i, :) = possibly_optimal_meeting_location;
                end
                
                % Update actual cost
                difference_deg = (possibly_optimal_meeting_location - optimal_meeting_locations(i, :));

                if new_distance < current_distance
                    actual_cost(i, actual_cost_counter) = new_distance;
                    actual_cost_counter = actual_cost_counter + 1;
                elseif  norm(difference_deg) < (1/3) % if the difference between the two locations is
                                                     % less than 20 miles (which corresponds to ~20 minutes,
                                                     % which is 1/3 of a degree since there are 60 minutes,
                                                     % in 1 degree), count it towards the actual cost
                                                     % (helpful for determining convergence behavior)
                    actual_cost(i, actual_cost_counter) = new_distance;
                    actual_cost_counter = actual_cost_counter + 1;
                end

                % Update iteration cost
                iteration_cost(i, j) = new_distance;
            end
        end

        if new_distance < current_distance
            optimal_distances_travelled(i) = new_distance;
        else
            optimal_distances_travelled(i) = current_distance;
        end
    end
    
    % trim the zero values of actual_cost
    actual_cost = trimZeros(actual_cost);
    
    % end stopwatch timer
    disp('minimize_distance_travelled() has finished running.')
    toc
    
end