class UserSession < Authlogic::Session::Base
  include Mongoid::Document
  single_access_allowed_request_types :any
  params_key :api_key
end
