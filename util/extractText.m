function [extractedText, n_abstracts_no_first_author] = extractText(year, N)
    %extractText Exploit .html structure to extract first author institution
    
    arguments
        year = 2019; % which annual meeting?
        N = 10; % first N abstracts
    end
    
    extractedText = cell(N, 1);
    n_abstracts_no_first_author = 0;
    
    for i = 1:N
        text = fileread(['./ismrm_abstracts_httrack/', num2str(year), ...
            '/archive.ismrm.org/', num2str(year), '/', ...
            reformatNumberToFourChars(i),'.html']);
        
        % Define the regular expression pattern to match the text between <sup>1</sup> and <sup>2</sup>
        pattern = '<div class="affOther" id="affOther"><br/><sup>1</sup>([^<]*)<';

        % Use regexp to find the text that matches the pattern
        matches = regexp(text, pattern, 'tokens');

        % Extract the matched text
        if ~isempty(matches)
            extractedText{i, 1} = matches{1}{1};
        else
            disp(['Abstract ', num2str(i), ' has no first author. ', ...
                'Please double check that this is true.']);
            
            extractedText{i, 1} = NaN; % set this to NaN
            
            n_abstracts_no_first_author = n_abstracts_no_first_author + 1;
        end
    end
    
    % pop the NaN elements of the cell array
    extractedText = removeNaNs(extractedText);
end