class ImgsController < ApplicationController

  def create
    @img = Img.new(params[:img])
    @img.arxiv_id = -1
    @img.user_id = current_user.id
    @img.save 
    @imgs = Img.find(:all, :conditions =>"((arxiv_id = '-1')AND(user_id = '#{current_user.id}'))" )
    @userin = true
    respond_to do |format|
      format.html {redirect_to :controller => "arxivs", :action => "chengerada"}
      format.js
    end
    
  end

end
