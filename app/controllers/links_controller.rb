class LinksController < ApplicationController
  
  def index
    if app_authorized? 
      #After user is authenticated we can fetch links and update database. Commented beacuse it takes lot of time
      #ideally we should do this as a background job for testing, just commenting it
      #current_user.update_links
      @links = Link.joins(:users).order('likes_count desc')
      render :index
    else
      redirect_to '/session/new'
    end
  end
end
