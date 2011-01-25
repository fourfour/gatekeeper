module Gatekeeper
    
    @vars = YAML.load(File.open("#{Rails.root.to_s}/config/gatekeeper.yml"))[Rails.env]
    
    # @vars = YAML::load(File.open("#{RAILS_ROOT}/config/gatekeeper.yml"))
    # @vars = []
    #     @vars[0] = { "admin" => "123456" }
    #     @vars[1] = 'e1741ea24c3c2464efcb4e5a38289e3db016ee0aa639f717de01946cb1029f22422cfdc1333f98baf959935b14387dd649f4d55e634970b0ec30ab2bfc401bb2'
    USERS = { "admin" => "123456" }
    #     @secret = @vars[1]
  
    def authenticate
      self.config.secret = @vars['USERS']['secret']
      authenticate_or_request_with_http_digest("Application") do |name|
        USERS[name]
      end
    end
  
end