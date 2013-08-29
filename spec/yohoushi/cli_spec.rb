require 'spec_helper'
require 'yohoushi/cli'

describe Yohoushi::CLI do
  before(:all) { @cli = Yohoushi::CLI.new }

  context "#graph_path" do
    before { @url = 'http://localhost:4804/api/graphs/foo/bar' }
    before { @path = @cli.graph_path(URI.parse(@url).path) }
    it { @path.should == 'foo/bar' }
  end

  context "post" do
    pending
  end
end

