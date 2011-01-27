class ActionController::Base
  before_filter :gatekeeper_authenticate
  def gatekeeper_authenticate
    @gatekeeper_config ||= YAML.load File.open "#{Rails.root}/config/gatekeeper.yml"
    authenticate_or_request_with_http_basic(@gatekeeper_config['USERS']['app_name']) do |username, password|
      username == @gatekeeper_config['USERS']['name'] && password == @gatekeeper_config['USERS']['password']
    end
  end
end
