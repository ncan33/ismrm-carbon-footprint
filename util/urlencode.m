function str = urlencode(str)
    str = matlab.net.URI.encode(str, 'scheme', 'percent-encoding');
end
