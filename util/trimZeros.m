function trimmedMatrix = trimZeros(matrix)
    % Find the last row and column that are not all zeros
    lastRow = find(any(matrix, 2), 1, 'last');
    lastCol = find(any(matrix, 1), 1, 'last');
    
    % Trim the matrix to the last non-zero row and column
    trimmedMatrix = matrix(1:lastRow, 1:lastCol);
end