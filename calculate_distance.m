function distance = calculate_distance(coord1, coord2)
    %CALCULATE_DISTANCE Calculate the length of the arc connecting two points on the surface of a sphere
    %   Calculate the length of the arc connecting two points on the surface of
    %   a sphere. coord1 and coord2 are a set of coordinates specifying the 
    %   origin and the terminal of the arc. The length is output in units
    %   of kilometers.

    arguments
        coord1 = [0, 0] % units of degrees
        coord2 = [50, 50] % units of degrees
    end
    
    coord1 = deg2rad(coord1);
    coord2 = deg2rad(coord2);
    
    lat1 = coord1(1);
    lon1 = coord1(2);
    lat2 = coord2(1);
    lon2 = coord2(2);

    distance = 2 * asin(sqrt(sin((lat2 - lat1) / 2)^2 + cos(lat1) * cos(lat2) * sin((lon2 - lon1) / 2)^2)); % normalized distance
    distance = earthRadius * distance * 10^-3; % distance in kilometers
    
end