function extractedText = processText(extractedText)
    %processText: turn raw text from author institutions array to clean
    %format matching "City, Country" for non-American locations and "City,
    %State, Country" for US locations
    
    %% remove comma if it exists
    for i = 1:length(extractedText)
        fullInstitutionString = extractedText{i};
        
        if strcmp(fullInstitutionString(end-1:end), ', ')
            extractedText{i} = fullInstitutionString(1:end-2);
        end
    end
    
    %% trim such that only city exists
    for i = 1:length(extractedText)
        fullInstitutionString = extractedText{i};
        
        % Split the input string by commas
        parts = strsplit(fullInstitutionString, ',');
        
        % Get the last part after the last comma
        country = strtrim(parts{end});
        
        if strcmp(country, 'United States') || strcmp(country, 'Canada')
            extractedText{i} = keepLast_N_Elements(fullInstitutionString, 3);
        else
            extractedText{i} = keepLast_N_Elements(fullInstitutionString, 2);
        end
    end
end