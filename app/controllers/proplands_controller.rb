# encoding: utf-8

class ProplandsController < ApplicationController
  before_filter :authenticate_user!
  # GET /prop_lands
  # GET /prop_lands.json
  def index
    @proplands = Propland.all
  end

  # GET /prop_lands/1
  # GET /prop_lands/1.json
  def show
     
    @propland = Propland.find(params[:id])
  end

  # GET /prop_lands/new
  # GET /prop_lands/new.json
  def new

    
    @land = Land.find(params[:id])
    @pgo = Pgo.find(@land.pgo_id)
   if @land.proplands.order('datezap DESC').first !=nil then
     @propland = @land.proplands.new(@land.proplands.order('datezap DESC').first.attributes)
      
   else  
    
    @propland = @land.proplands.new
   end 
  end

  # GET /prop_lands/1/edit
  def edit

    @propland = Propland.find(params[:id])
    @land = Land.find(@propland.land_id)
    @pgo = Pgo.find(@land.pgo_id)
  
  end

  # POST /prop_lands
  # POST /prop_lands.json
  def create
      @pgo = Pgo.find(params[:pgo])
      @land = Land.find(params[:land])
      @propland = @land.proplands.new(params[:propland])

   
      if @propland.save then
       redirect_to pgo_path({:id =>  @pgo.id, :pan => 2}), notice: 'Обход успішно створено'
   
      else
        render action: "new"

      end
 
  end

  # PUT /prop_lands/1
  # PUT /prop_lands/1.json
  def update
  
    @propland = Propland.find(params[:id])
    @land = Land.find(@propland.land_id)
    @pgo = Pgo.find(@land.pgo_id)
      if @propland.update_attributes(params[:propland]) then
         redirect_to pgo_path({:id =>  @pgo.id, :pan => 2}), notice: 'Інформацію обходу оновлено.' 
      else
        render action: "edit"
        
      end

  end

  # DELETE /prop_lands/1
  # DELETE /prop_lands/1.json
  def destroy
    @propland = Propland.find(params[:id])
    id_pgo = Pgo.find(Land.find(@propland.land_id).pgo_id).id
    @propland.destroy
      redirect_to pgo_path({:id =>  id_pgo, :pan => 2})
   
  end
end
