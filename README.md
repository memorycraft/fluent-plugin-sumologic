# Fluent::Plugin::Sumologic

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'fluent-plugin-sumologic'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fluent-plugin-sumologic

## Usage

<match *.apache.*>
  type sumologic
  host collectors.sumologic.com
  port 443
  format json|text
  path /receiver/v1/http/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX==
</match>

type: sumologic
host: hostname of HTTP Collectors URL
port: port of HTTP Collectors URL
path: path of HTTP Collectors URL
format: json - send as json format in fluent way
        text - send as raw text format (ex: using "parse using public/apache/access")

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
