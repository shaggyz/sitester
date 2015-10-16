
require 'json'
require './src/presenter'

class SiteFile

    # Reads a sites file
    def initialize(file_name)
        @file_name = file_name
        @sites = []
        read
    end

    # Reads a JSON file from path
    def read
        begin
            file = File.open(@file_name, "r")
            parse file.read
            file.close
        rescue
            Presenter.error "Error opening file #{@file_name.to_s}"
            exit false
        end
    end

    # Parses the JSON file
    def parse(raw_data)
        @sites = JSON.parse(raw_data)
    end

    # returns collected sites
    def get
        @sites['sites']
    end
end