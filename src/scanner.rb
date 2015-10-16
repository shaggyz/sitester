
require 'net/http'

class Scanner
    #
    # Performs a HTTP request to given URI
    #
    def request(uri_str, limit = 5)
        raise ArgumentError, 'too many HTTP redirects' if limit == 0

        response = Net::HTTP.get_response(URI(uri_str))

        case response
            when Net::HTTPSuccess then
                response
            when Net::HTTPRedirection then
                location = response['location']
                print "• ".colorize(:yellow)
                warn "Redirection: " + uri_str.colorize(:cyan) + " => " + location.colorize(:cyan)
                request(location, limit - 1)
            else
                response.value
        end
    end
end