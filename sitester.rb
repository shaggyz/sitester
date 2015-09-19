#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'net/http'
require 'hpricot'
require 'colorize'

#
# Reads a file from path
#
def read_file(file_name)
    file = File.open(file_name, "r") 
    data = file.read
    file.close
    return data
end

#
# Prints a simple report to stdout
#
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

#
# Starts the site scanner
#
def scan(file_path = "./sites.json")
    d = read_file file_path
    sites = JSON.parse(d)
    sites["sites"].each { |site|
        report(site)
    }
end

# 
# static script execution
# 
if __FILE__ == $0
    puts "Sitester"
    puts "Simple and fancy site scanner. Scanning sites...\n\r"
    
    if ARGV[0] == "--example"
        scan "./sites.example.json"
    else
        scan 
    end
    
    puts "Done. Bye!"
    exit 0
end
