module Yohoushi::SpecHelper
  def escape(str)
    URI.escape(str) if str
  end

  def base_uri
    'http://localhost:4804'
  end

  def client
    Yohoushi::Client.new(base_uri)
  end

  def graph_example
    {
      "number"=>0,
      "llimit"=>-1000000000,
      "mode"=>"gauge",
      "stype"=>"AREA",
      "adjustval"=>"1",
      "meta"=>"",
      "service_name"=>"multiforecast",
      "gmode"=>"gauge",
      "color"=>"#cc6633",
      "created_at"=>"2013/02/02 00:41:11",
      "section_name"=>"foo%2Fbar%2Ffoo",
      "ulimit"=>1000000000,
      "id"=>1,
      "graph_name"=>"bar",
      "description"=>"",
      "sulimit"=>100000,
      "unit"=>"",
      "sort"=>0,
      "updated_at"=>"2013/02/02 02:32:10",
      "adjust"=>"*",
      "path"=>"foo/bar/foo/bar",
      "type"=>"AREA",
      "sllimit"=>-100000,
      "md5"=>"3c59dc048e8850243be8079a5c74d079"
    }
  end
end
