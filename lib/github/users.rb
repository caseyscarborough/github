module GitHub
  class Users

    attr_accessor :username

    include HTTParty
    base_uri 'https://api.github.com'

    def initialize(username)
      self.username = username
    end

    def info
      self.class.get "/users/#{self.username}"
    end

    private 
      def method_missing(name, *args, &block)
        info.has_key?(name.to_s) ? info[name.to_s] : super
      end 

  end
end