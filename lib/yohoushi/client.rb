# -*- encoding: utf-8 -*-
require 'httpclient'
require 'json'
require 'cgi'
require 'pp'

module Yohoushi
  class Error < StandardError; end
  class NotFound < Error; end
  class AlreadyExists < Error; end

  class Client
    attr_accessor :debug
    attr_accessor :client
    attr_reader   :debug_dev
    attr_reader   :base_uri

    # @param [String] base_uri The base uri of Yohoushi
    def initialize(base_uri = 'http://127.0.0.1:4804')
      @base_uri = base_uri
    end

    def client
      @client ||= HTTPClient.new
    end

    # set the `debug_dev` attribute of HTTPClient
    # @param [IO] debug_dev such as STDOUT
    def debug_dev=(debug_dev)
      client.debug_dev = debug_dev
    end

    def last_response
      @res
    end

    # GET the JSON API
    # @param [String] path
    # @return [Hash] response body
    def get_json(path)
      @res = client.get("#{@base_uri}#{path}")
      handle_error(@res)
      JSON.parse(@res.body)
    end

    # POST the JSON API
    # @param [String] path
    # @param [Hash] data 
    # @return [Hash] response body
    def post_json(path, data = {})
      pp data if @debug
      @res = client.post("#{@base_uri}#{path}", data)
      handle_error(@res)
      JSON.parse(@res.body)
    end

    # Post parameters to a graph, POST /api/graphs/:path
    # @param [String] path
    # @param [Hash] params The POST parameters. 
    # @return [Hash] the error code and graph property
    # @example
    # {"error":0,
    # "data":{
    #   "number":"1",
    #   "llimit":"-1000000000",
    #   "mode":"gauge",
    #   "stype":"AREA",
    #   "adjustval":"1",
    #   "meta":"",
    #   "service_name":"multiforecast",
    #   "gmode":"gauge",
    #   "color":"#cc6633",
    #   "created_at":"2013/08/29 11:58:15",
    #   "section_name":"foo%2Fbar%2Ffoo",
    #   "ulimit":"1000000000",
    #   "id":"2",
    #   "graph_name":"bar",
    #   "description":"",
    #   "sulimit":"100000",
    #   "unit":"","sort":"0",
    #   "updated_at":"2013/08/29 11:58:15",
    #   "adjust":"*",
    #   "path":"foo/bar/foo/bar",
    #   "type":"AREA",
    #   "sllimit":"-100000",
    #   "md5":"c81e728d9d4c2f636f067f89cc14862c"}
    def post_graph(path, params)
      post_json("/api/graphs/#{escape path}", params)
    end

    # Get parameters from a graph, GET /api/graphs/:path
    # @param [String] path
    # @return [Hash] the graph property
    # @example
    # {
    #   "number":"1",
    #   "llimit":"-1000000000",
    #   "mode":"gauge",
    #   "stype":"AREA",
    #   "adjustval":"1",
    #   "meta":"",
    #   "service_name":"multiforecast",
    #   "gmode":"gauge",
    #   "color":"#cc6633",
    #   "created_at":"2013/08/29 11:58:15",
    #   "section_name":"foo%2Fbar%2Ffoo",
    #   "ulimit":"1000000000",
    #   "id":"2",
    #   "graph_name":"bar",
    #   "description":"",
    #   "sulimit":"100000",
    #   "unit":"","sort":"0",
    #   "updated_at":"2013/08/29 11:58:15",
    #   "adjust":"*",
    #   "path":"foo/bar/foo/bar",
    #   "type":"AREA",
    #   "sllimit":"-100000",
    #   "md5":"c81e728d9d4c2f636f067f89cc14862c"}
    def get_graph(path)
      get_json("/api/graphs/#{escape path}")
    end

    private

    def escape(str)
      URI.escape(str) if str
    end

    def handle_error(res)
      case res.status
      when 200
      when 201
      when 404
        raise NotFound.new(error_message(res))
      when 409
        raise AlreadyExists.new(error_message(res))
      else
        raise Error.new(error_message(res))
      end
    end

    def error_message(res)
      "status:#{res.status}\turi:#{res.http_header.request_uri.to_s}\tmessage:#{res.body}"
    end
  end
end

