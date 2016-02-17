# encoding: UTF-8
require 'net/http'
require 'date'

class Fluent::SumologicOutput< Fluent::BufferedOutput
  Fluent::Plugin.register_output('sumologic', self)

  config_param :host, :string,  :default => 'collectors.sumologic.com'
  config_param :port, :integer, :default => 443
  config_param :proxy, :string, :default => nil
  config_param :verify_ssl, :bool, :default => true
  config_param :path, :string,  :default => '/receiver/v1/http/XXX'
  config_param :format, :string, :default => 'json'
  config_param :source_name_key, :string, :default => ''

  include Fluent::SetTagKeyMixin
  config_set_default :include_tag_key, false

  include Fluent::SetTimeKeyMixin
  config_set_default :include_time_key, false

  def initialize
    super
  end

  def configure(conf)
    super
  end

  def start
    super
  end

  def format(tag, time, record)
    [tag, time, record].to_msgpack
  end

  def shutdown
    super
  end

  def write(chunk)
    messages_list = {}

    case @format
      when 'json'
        chunk.msgpack_each do |tag, time, record|
          if @include_tag_key
            record.merge!(@tag_key => tag)
          end
          if @include_time_key
            record.merge!(@time_key => @timef.format(time))
          end
          source_name = record[@source_name_key] || ''
          record.delete(@source_name_key)
          messages_list[source_name] = [] unless messages_list[source_name]
          messages_list[source_name] << record.to_json
        end
      when 'text'
        chunk.msgpack_each do |tag, time, record|
          source_name = record[@source_name_key] || ''
          messages_list[source_name] = [] unless messages_list[source_name]
          messages_list[source_name] << record['message']
        end
    end

    http = Net::HTTP.new(@host, @port.to_i)
    proxy_string = if ENV['http_proxy'] then ENV['http_proxy'] else @proxy end
    if(proxy_string){
        (proxy,proxy_port) = proxy_string.split(':')
        http = Net::HTTP::Proxy(proxy,proxy_port).new(@host, @port.to_i)
    }
    http.use_ssl = true
    http.verify_mode = @verify_ssl ? OpenSSL::SSL::VERIFY_PEER : OpenSSL::SSL::VERIFY_NONE
    http.set_debug_output $stderr

    messages_list.each do |source_name, messages|
      request = Net::HTTP::Post.new(@path)
      request['X-Sumo-Name'] = source_name unless source_name.empty?
      request.body = messages.join("\n")
      response = http.request(request)
      unless response.is_a?(Net::HTTPSuccess)
        raise "Failed to send data to #{@host}. #{response.code} #{response.message}"
      end
    end
  end
end
