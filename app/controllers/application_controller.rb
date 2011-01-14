class ApplicationController < ActionController::Base
  #protect_from_forgery
  helper_method :current_user


  private  


  def current_user  
    @current_user 
  end  



  # Checking signed_request seems to be the only consistent way.
  # Other methods like storing user_id in sessions fail, also initializes
  # current_user for every request
  #
  #
  # We can actually simply check length to make our decision.
  def app_authorized?
    user_info=JSON.parse(base64_url_decode(params[:signed_request].split('.')[1]))
    user_info.has_key?('user_id') &&  (@current_user ||= User.find_by_fb_id(user_info['user_id']))
  end

  # Lifted from mini_fb
  def base64_url_decode(str)
    str = str + "=" * (4 - str.size % 4) unless str.size % 4 == 0
    return Base64.decode64(str.tr("-_", "+/"))
  end

end
