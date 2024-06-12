function formattedString = reformatNumberToFourChars(N)
    % This function takes an integer N and reformats it to a string 4 characters long,
    % padding with leading zeros if necessary. It also checks if N is greater than 9999.

    % Check if the input N is greater than 9999
    if N > 9999
        error('Input error: N is greater than 9999');
    end

    % Create the format specifier for padding with leading zeros to 4 characters
    formatSpec = '%04d';

    % Use the format specifier to create the formatted string
    formattedString = sprintf(formatSpec, N);
end