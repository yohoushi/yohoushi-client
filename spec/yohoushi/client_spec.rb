require 'spec_helper'

describe Yohoushi::Client do
  include Yohoushi::SpecHelper

  graph_keys = %w[number llimit mode stype adjustval gmode color created_at ulimit description
                  sulimit unit sort updated_at adjust type sllimit meta md5 path]

  context "#post_graph" do
    include_context "stub_post_graph" if ENV['MOCK'] == 'on'
    include_context "stub_get_graph" if ENV['MOCK'] == 'on'
    params = {
      'number' => 0,
    }
    let(:graph) { graph_example }
    subject { client.post_graph(graph["path"], params) }
    it { subject["error"].should == 0 }
    # params.keys.each {|key| it { subject["data"][key].should == params[key] } }
  end

  describe 'http://blog.64p.org/?page=1366971426' do
    before { @client ||= client }
    context "#client=" do
      before { @client.client = HTTPClient.new(agent_name: 'TestAgent/0.1') }
      it { @client.client.agent_name.should == 'TestAgent/0.1' }
    end
  end
end

