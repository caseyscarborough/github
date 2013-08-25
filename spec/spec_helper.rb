require 'github_api_v3'
require 'webmock/rspec'
require 'vcr'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.include WebMock::API

  CONFIG = YAML.load(File.read(File.expand_path('../config.yml', __FILE__)))
end

VCR.configure do |c|
  c.configure_rspec_metadata!
  
  c.filter_sensitive_data("<TEST_ACCESS_TOKEN>") { CONFIG['test_access_token'] }
  c.filter_sensitive_data("<TEST_LOGIN>") { CONFIG['test_login'] }
  c.filter_sensitive_data("<TEST_PASSWORD>") { CONFIG['test_password'] }
  c.filter_sensitive_data("<TEST_CLIENT_ID>") { CONFIG['test_client_id'] }
  c.filter_sensitive_data("<TEST_CLIENT_SECRET") { CONFIG['test_client_secret'] }

  c.cassette_library_dir = 'spec/cassettes'
  c.default_cassette_options = {
    :serialize_with             => :json,
    :preserve_exact_body_bytes  => true,
    :decode_compressed_response => true
  }
  c.hook_into :webmock
end

def test_login
  CONFIG['test_login']
end

def test_password
  CONFIG['test_password']
end

def test_access_token
  CONFIG['test_access_token']
end

def test_client_id
  CONFIG['test_client_id']
end

def test_client_secret
  CONFIG['test_client_secret']
end

def test_basic_client
  GitHub::Client.new(login: test_login, password: test_password)
end

def test_client
  GitHub::Client.new(login: test_login, access_token: test_access_token)
end