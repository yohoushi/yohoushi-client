# -*- encoding: utf-8 -*-
# An example to create complex graphs

# require anyway
require 'yohoushi-client'

# Create a Yohoushi Client, given the base URI of Yohoushi
client = Yohoushi::Client.new('http://localhost:4804')

# Create a graph!
path = "foo/bar"
number = 10.1
begin
  client.debug_dev = STDOUT
  client.post_graph(path, {"number" => number})
rescue Yohoushi::AlreadyExists => e
  puts "\tclass:#{e.class}\t#{e.message}"
rescue Yohoushi::NotFound => e
  puts "\tclass:#{e.class}\t#{e.message}"
end
