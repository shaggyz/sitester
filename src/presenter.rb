
require 'colorize'

class Presenter
    # Prints a simple report to stdout
    def report(url)
        begin
            response = request(url)
            valid = response.is_a?(Net::HTTPSuccess)
        rescue
            print "• ".colorize(:red)
            puts "Cannot connect with: " + url.colorize(:red) + "\n\n"
            return
        end

        color = valid ? :green : :red

        print "• ".colorize(color)
        puts "Site: " + url.colorize(color)
        puts "HTTP Code: " + response.code.colorize(:cyan) + " HTTP status: " \
            + response.message.colorize(:cyan)

        doc = Hpricot(response.body)
        puts "Page title: " + doc.search("title").inner_html.colorize(:cyan)
        puts "\n"
    end

    # shows an error
    def self.error(message)
        m = "ERROR".colorize(:red) + ": "
        m += message
        puts m
    end
end