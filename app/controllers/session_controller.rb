class SessionController < ApplicationController
 
  #Load some javascript instead of direct redirection to 
  #oauth_authorize_url. Needed for redirecting IFRAME by javascript
  def new
    #new session
  end
  
  
  #Create user session and redirect to app
  def create
    auth = request.env["omniauth.auth"]  
    user = User.find_by_fb_id(auth["uid"]) || User.create_with_omniauth(auth)  
    #for those update from feeds
    if user.access_token.empty?
      user.access_token = auth["credentials"]["token"]
      user.save
    end
    redirect_to  FB_APP_URL 
  end

end
