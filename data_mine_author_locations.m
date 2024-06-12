function [coordinates, extractedText] = data_mine_author_locations(year, N)
    %data_mine_author_locations: Create a list of coordinates of ISMRM
    %Annual Meeting first authors based on their insitutions. Only first
    %N abstracts.
    %   Works on ISMRM websites cloned via HTTrack

    arguments
        year = 2019; % which annual meeting?
        N = 100; % first N abstracts
    end
    
    % start stopwatch timer
    tic
    
    % add util path
    addpath(genpath('./util'))
    
    % extract institutions as a string array
    [extractedText, n_abstracts_no_first_author] = extractText(year, N);
    
    % process institution strings
    extractedText = processText(extractedText);
    
    % convert city, (state,) country tokens to coordinates
    coordinates = cell(size(extractedText));
    
    for i = 1:length(extractedText)
        [city, state, country] = parseLocation(extractedText{i});
        
        [latitude, longitude] = getCoordinates(city, state, country);
        coordinates{i} = [latitude, longitude];
        
        if isnan(state)
            disp([num2str(i), '/', num2str(N - n_abstracts_no_first_author), ...
                ' done! ', city, ', ', country])
        else
            disp([num2str(i), '/', num2str(N - n_abstracts_no_first_author), ...
                ' done! ', city, ', ', state, ', ', country])
        end    
    end
    
    % end stopwatch timer
    disp('data_mine_author_locations() has finished running.')
    toc
    
end
