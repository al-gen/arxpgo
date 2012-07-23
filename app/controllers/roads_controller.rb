# encoding: utf-8

class RoadsController < ApplicationController
  before_filter :authenticate_user!
  # GET /roads
  # GET /roads.json
  def index
    
   id_council = getcouncil(params[:council])

   @council =  Council.find(id_council)

     id_city = params[:city] 
     if id_city ==  nil then 
       if Council.find(id_council).villages.order('id').first != nil then
        id_city = Council.find(id_council).villages.order('id').first.id 
       else 
         id_city = nil 
       end
     end
     if id_city != nil then
       @village = Village.find(id_city)
       @roads  =  Village.find(id_city).roads.order('id')
     else 
       @roads  = nil 
     end

  end

  # GET /roads/1
  # GET /roads/1.json
  def show
    @road = Road.find(params[:id])
    @village  = Village.find(@road.city_id)
    @council = Council.find(@village.council_id)
  end

  # GET /roads/new
  # GET /roads/new.json
  def new
   id_council = getcouncil(params[:council])
    @council =  Council.find(id_council)
    
    id_city = params[:city]
    @village = Village.find(id_city)
    @road =  @village.roads.new

  end

  # GET /roads/1/edit
  def edit
    @road = Road.find(params[:id])
    @village  = Village.find(@road.city_id)
     @council = Council.find(@village.council_id)
  end

  # POST /roads
  # POST /roads.json
  def create
   id_council = getcouncil(params[:council])    
   @council = Council.find(id_council)    
    id_city = params[:city]
    @village  = Village.find(id_city)
    @road = @village.roads.new(params[:road])

  
      if @road.save then
        redirect_to @road, notice: 'Вулиця була додана успішно'
        
      else
        render action: "new"
       
      end

  end

  # PUT /roads/1
  # PUT /roads/1.json
  def update
    @road = Road.find(params[:id])
    @village  = Village.find(@road.city_id)
    @council = Council.find(@village.council_id)

      if @road.update_attributes(params[:road]) then
       redirect_to @road, notice: 'Вулиця збережена успішно' 
      else
        render action: "edit" 
      end
   
  end

  # DELETE /roads/1
  # DELETE /roads/1.json
  def destroy
    @road = Road.find(params[:id])
    id_city = @road.city_id
    id_council = Village.find(id_city).council_id
    
    @road.destroy
    
    

     redirect_to roads_url(:city => id_city, :council => id_council)
  end
  
  def selcity
    
    if not params[:Council].nil? then 
      id_council = params[:Council][:id].to_i 
      if Council.find(id_council).villages.first != nil then id_city = Council.find(id_council).villages.order('id').first.id 
      
      else id_city = nil end
  
    end    
    

    if not params[:Village].nil? then 
      id_city = params[:Village][:id].to_i 
      id_council = params[:council].to_i 
    end

    redirect_to :action => "index", :city => id_city , :council => id_council
  end
end
