module Gatekeeper
  
  def gatekeeper_authenticate
    @gatekeeper_config ||= YAML.load File.open "#{Rails.root}/config/gatekeeper.yml"
    
    @users = {}
    @users[@gatekeeper_config['USERS']['name']] = @gatekeeper_config['USERS']['password']
    
    self.config.secret = @gatekeeper_config['USERS']['secret']
    
    authenticate_or_request_with_http_digest(@gatekeeper_config['USERS']['app_name']) do |name|
      @users[name]
    end
  end
  
end