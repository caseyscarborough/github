require 'github_api_v3'
require 'webmock/rspec'
require 'vcr'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.include WebMock::API
  
  CONFIG = nil
  if File.exist?(File.expand_path('../config.yml', __FILE__))
    CONFIG = YAML.load(File.read(File.expand_path('../config.yml', __FILE__)))    
  end
end

VCR.configure do |c|
  c.configure_rspec_metadata!
  
  c.filter_sensitive_data("<TEST_ACCESS_TOKEN>") do
    CONFIG ? CONFIG['test_access_token'] : ENV['GITHUB_API_V3_TEST_ACCESS_TOKEN']
  end
  c.filter_sensitive_data("<TEST_LOGIN>") do
    CONFIG ? CONFIG['test_login'] : ENV['GITHUB_API_V3_TEST_LOGIN']
  end
  c.filter_sensitive_data("<TEST_PASSWORD>") do 
    CONFIG ? CONFIG['test_password'] : ENV['GITHUB_API_V3_TEST_PASSWORD']
  end
  c.filter_sensitive_data("<TEST_CLIENT_ID>") do
    CONFIG ? CONFIG['test_client_id'] : ENV['GITHUB_API_V3_TEST_CLIENT_ID']
  end
  c.filter_sensitive_data("<TEST_CLIENT_SECRET") do
    CONFIG ? CONFIG['test_client_secret'] : ENV['GITHUB_API_V3_TEST_CLIENT_SECRET']
  end
  c.cassette_library_dir = 'spec/cassettes'
  c.default_cassette_options = {
    :serialize_with             => :json,
    :preserve_exact_body_bytes  => true,
    :decode_compressed_response => true
  }
  c.hook_into :webmock
end

def test_login
  CONFIG ? CONFIG['test_login'] : ENV['GITHUB_API_V3_TEST_LOGIN']
end

def test_password
  CONFIG ? CONFIG['test_password'] : ENV['GITHUB_API_V3_TEST_PASSWORD']
end

def test_access_token
  CONFIG ? CONFIG['test_access_token'] : ENV['GITHUB_API_V3_TEST_ACCESS_TOKEN']
end

def test_client_id
  CONFIG ? CONFIG['test_client_id'] : ENV['GITHUB_API_V3_TEST_CLIENT_ID']
end

def test_client_secret
  CONFIG ? CONFIG['test_client_secret'] : ENV['GITHUB_API_V3_TEST_CLIENT_SECRET']
end

def test_basic_client
  GitHub::Client.new(login: test_login, password: test_password)
end

def test_client
  GitHub::Client.new(login: test_login, access_token: test_access_token)
end