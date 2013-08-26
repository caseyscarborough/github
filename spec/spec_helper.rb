require 'github_api_v3'
require 'webmock/rspec'
require 'vcr'

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.run_all_when_everything_filtered = true
  c.filter_run :focus
  c.include WebMock::API
  
  if File.exist?(File.expand_path('../config.yml', __FILE__))
    config = YAML.load(File.read(File.expand_path('../config.yml', __FILE__)))    
    config.each { |k,v| ENV[k] = v unless v.kind_of? Hash }
  end
end

VCR.configure do |c|
  c.configure_rspec_metadata!
  c.filter_sensitive_data("<TEST_ACCESS_TOKEN>") { ENV['GITHUB_API_V3_TEST_ACCESS_TOKEN'] }
  c.filter_sensitive_data("<TEST_LOGIN>") { ENV['GITHUB_API_V3_TEST_LOGIN'] }
  c.filter_sensitive_data("<TEST_PASSWORD>") { ENV['GITHUB_API_V3_TEST_PASSWORD'] }
  c.filter_sensitive_data("<TEST_CLIENT_ID>") { ENV['GITHUB_API_V3_TEST_CLIENT_ID'] }
  c.filter_sensitive_data("<TEST_CLIENT_SECRET>") { ENV['GITHUB_API_V3_TEST_CLIENT_SECRET'] }
  c.cassette_library_dir = 'spec/cassettes'
  c.default_cassette_options = {
    :serialize_with             => :json,
    :preserve_exact_body_bytes  => true,
    :decode_compressed_response => true
  }
  c.hook_into :webmock
end

def test_login
  ENV['GITHUB_API_V3_TEST_LOGIN']
end

def test_password
  ENV['GITHUB_API_V3_TEST_PASSWORD']
end

def test_access_token
  ENV['GITHUB_API_V3_TEST_ACCESS_TOKEN']
end

def test_client_id
  ENV['GITHUB_API_V3_TEST_CLIENT_ID']
end

def test_client_secret
  ENV['GITHUB_API_V3_TEST_CLIENT_SECRET']
end

def test_basic_client
  GitHub::Client.new(:login => test_login, :password => test_password)
end

def test_client
  GitHub::Client.new(:login => test_login, :access_token => test_access_token)
end