# encoding: utf-8

class CouncilsController < ApplicationController
  before_filter :authenticate_user!
  # GET /councils
  # GET /councils.json
  def index
    if get_role != 0 then redirect_to :action => "access_denied" , :controller => "allpgo" end
    @councils = Council.order('id')
  end

  # GET /councils/1
  # GET /councils/1.json
  def show
    @council = Council.find(params[:id])
  end

  # GET /councils/new
  # GET /councils/new.json
  def new
    @council = Council.new
    
  end

  # GET /councils/1/edit
  def edit
   @council = Council.find(params[:id])

  end

  # POST /councils
  # POST /councils.json
  def create
    @council = Council.new(params[:council])

 
      if @council.save then
        redirect_to @council,  notice: 'Рада успішно створена'
      else
        render action: "new"
      end

  end

  # PUT /councils/1
  # PUT /councils/1.json
  def update
    @council = Council.find(params[:id])

      if @council.update_attributes(params[:council]) then
        redirect_to @council, notice: 'Зміни успішно збережені'
      else
        render action: "edit"
      end
  end

  # DELETE /councils/1
  # DELETE /councils/1.json
  def destroy
    @council = Council.find(params[:id])
    @council.destroy
    redirect_to councils_url
  end
  

end
