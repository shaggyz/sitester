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
    cp sites.example.json sites.example
```

Edit sites.json with your own sites, Then:

```bash
    ./sitester.rb
```
