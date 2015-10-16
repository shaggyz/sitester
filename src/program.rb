
# http://ruby-doc.org/stdlib-2.0.0/libdoc/optparse/rdoc/OptionParser.html
require 'optparse'
# http://ruby-doc.org/stdlib-2.0.0/libdoc/ostruct/rdoc/OpenStruct.html
require 'ostruct'

require './src/site_file'

class Program
    # creates an empty options struct
    def initialize
        @options = OpenStruct.new
    end

    # configures CLI options and arguments
    def set_options!(arguments)
        # show help without arguments
        # arguments << '-h' if arguments.empty?

        # options and default values
        @options.file = "./sites.json"
        @options.sites = []

        option_parser = OptionParser.new do |o|
            o.banner = "Usage: sitetester.rb [options]"
            o.separator ""
            o.separator "Specific options:"

            o.on("-f", "--file [file_path]", "Specifies the sites JSON file path, ./sites.json is the default.") do |v|
                @options.file = v
            end

            o.on("--sites s1,s2,s3", Array, "Optional list of sites.") do |sites|
                @options.sites = sites
            end

            o.on_tail("-h", "--help", "Show this message") do
                puts o
                exit
            end
        end

        option_parser.parse!(arguments)
        run
    end

    # executes the program
    def run
        if @options.sites.empty?
            sites = SiteFile.new(@options.file).get
        else
            sites = @options.sites
        end
        sites
    end
end