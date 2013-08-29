# -*- encoding: utf-8 -*-
require 'thor'
require 'yohoushi-client'

class Yohoushi::CLI < Thor
  class_option :silent, :aliases => ["-S"], :type => :boolean

  desc 'post <json> <url>', 'Post a parameter to a graph'
  long_desc <<-LONGDESC
    Post a parameter to a graph

    ex)
    $ yohoushi-client post '{"number":0}' http://localhost:4804/api/graphs/foo/bar
  LONGDESC
  def post(json, url)
    uri = URI.parse(url)
    client = client(uri)
    path = graph_path(uri.path)
    begin
      res = client.post_graph(path, JSON.parse(json))
      $stdout.puts res unless @options['silent']
    rescue => e
      $stderr.puts "\tclass:#{e.class}\t#{e.message}"
    end
  end

  no_tasks do
    def graph_path(path)
      path.split("/api/graphs/").last
    end

    def client(uri)
      Yohoushi::Client.new("#{uri.scheme}://#{uri.host}:#{uri.port}")
    end
  end
end

