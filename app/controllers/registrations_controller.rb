class RegistrationsController < Devise::RegistrationsController
  protected
  skip_before_filter :require_no_authentication 
end