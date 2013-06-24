class SplashController < ApplicationController
  def index
  	if user_signed_in?
  		redirect_to :purchases
  	end
  end
end
