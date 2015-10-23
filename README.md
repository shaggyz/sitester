# Sitester

Simple ruby script to test website statuses at HTTP level for command line envirnoments.

## Install

- Clone repo 
- bundle install

## Usage

Test with provided example file:

```bash
    ./sitester.rb --example
```

Common usage:

```bash
    cp sites.example.json sites.json
```

Edit sites.json with your own sites, Then:

```bash
    ./sitester.rb
```

## Known issues

- Fake negatives, sometimes Net::HTTP.get_response reports a wrong HTTP response code. 

