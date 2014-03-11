class RegistrationsController < Devise::RegistrationsController
  protected
  skip_before_filter :require_no_authentication 

  # def after_sign_up_path_for(resource)
  #   flash[:analytics] = "/goals/signup"
  #   new_ga_service_path
  # end
end