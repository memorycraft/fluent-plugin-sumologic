# Fluent::Plugin::Sumologic, a plugin for [Fluentd](http://fluentd.org)

fluent output plugin for Sumologic

## Fluentd
http://fluentd.org/

## Sumologic
http://www.sumologic.com/

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
      proxy 10.0.0.1:3128
      format json|text
      path /receiver/v1/http/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX==
	</match>


#### type
- sumologic

#### host
- Hostname of HTTP Collectors URL

#### port
- Port of HTTP Collectors URL

#### proxy
- HTTP proxy address including port

#### path
- Path of HTTP Collectors URL

#### format
- json: send as json format in fluent way
- text: send as raw text format (ex: using "parse using public/apache/access")

#### verify_ssl
- Verify ssl certificate. Default is true.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
