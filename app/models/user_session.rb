class UserSession < Authlogic::Session::Base
  single_access_allowed_request_types :any
  params_key :api_key
end
