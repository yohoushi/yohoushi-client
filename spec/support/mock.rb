# -*- encoding: utf-8 -*-

shared_context "stub_get_graph" do
  proc = Proc.new do
    stub_request(:get, "#{base_uri}/api/graphs/#{escape graph['path']}").
    to_return(:status => 200, :body => graph_example.to_json)
  end
  before(:each, &proc)
end

shared_context "stub_post_graph" do
  include_context "stub_get_graph"
  before do
    stub_request(:post, "#{base_uri}/api/graphs/#{escape graph['path']}").
    to_return(:status => 200, :body => { "error" => 0, "data" => graph_example }.to_json)
  end
end
