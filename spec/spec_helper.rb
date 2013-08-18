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
  c.filter_sensitive_data("<TEST_ACCESS_TOKEN>") do
    CONFIG['test_access_token']
  end
  c.filter_sensitive_data("<TEST_LOGIN>") do
    CONFIG['test_login']
  end
  c.filter_sensitive_data("<TEST_PASSWORD>") do
    CONFIG['test_password']
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
  CONFIG['test_login']
end

def test_password
  CONFIG['test_password']
end

def test_access_token
  CONFIG['test_access_token']
end

def test_client(login=CONFIG['test_login'], access_token=CONFIG['test_access_token'])
  GitHub::Client.new(login: login, access_token: access_token)
end