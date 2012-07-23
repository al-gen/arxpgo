# encoding: utf-8

class VillagesController < ApplicationController
  before_filter :authenticate_user!
  # GET /villages
  # GET /villages.json
  def index
   id_council = getcouncil(params[:council])
   @council =  Council.find(id_council)
   @villages =  @council.villages.order('id')
  end

  # GET /villages/1
  # GET /villages/1.json
  def show
    @village = Village.find(params[:id])
    @council = Council.find(@village.council_id)
  end

  # GET /villages/new
  # GET /villages/new.json
  def new
   id_council = getcouncil(params[:council])

    @council =  Council.find(id_council)
    @village = Council.find(id_council).villages.new
  end

  # GET /villages/1/edit
  def edit
    @village = Village.find(params[:id])
    @council = Council.find(@village.council_id)
  end

  # POST /villages
  # POST /villages.json
  def create
   id_council = getcouncil(params[:council])
 
   @council = Council.find(id_council)
    @village = Council.find(id_council).villages.new(params[:village])

 
      if @village.save then
         redirect_to @village, notice: 'Населений пункт було створено'
       
      else
       render action: "new" 

      end

  end

  # PUT /villages/1
  # PUT /villages/1.json
  def update
    @village = Village.find(params[:id])
    @council = Council.find(@village.council_id)

      if @village.update_attributes(params[:village])
       redirect_to @village, notice: 'Населений пункт успішно змінено'
      else
        render action: "edit"

      end

  end

  # DELETE /villages/1
  # DELETE /villages/1.json
  def destroy
    @village = Village.find(params[:id])
    id_council = @village.council_id
    @village.destroy
    redirect_to villages_url(:council => id_council)
  end
  
  def selcouncil
    if not params[:Council].nil? then 
      id_council = params[:Council][:id].to_i 
            
    end

    redirect_to :action => "index", :council => id_council    
  end
end
