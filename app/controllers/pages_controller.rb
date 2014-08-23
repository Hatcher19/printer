class PagesController < ApplicationController
	skip_before_filter :trial_expired

  def home
  	@current_user = current_user
  end

end