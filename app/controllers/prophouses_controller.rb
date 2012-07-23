# encoding: utf-8

class ProphousesController < ApplicationController
  before_filter :authenticate_user!
  # GET /prop_houses
  # GET /prop_houses.json
  def index
    @prophouses = Prophouse.all

  end

  # GET /prop_houses/1
  # GET /prop_houses/1.json
  def show

    @prophouse = Prophouse.find(params[:id])

  end

  # GET /prop_houses/new
  # GET /prop_houses/new.json
  def new
 
    @house = House.find(params[:id])
    @pgo = Pgo.find(@house.pgo_id)     
 
    
   if @house.prophouses.order('datezap DESC').first !=nil then
     @prophouse = @house.prophouses.new(@house.prophouses.order('datezap DESC').first.attributes)
      
   else  
    
    @prophouse = @house.prophouses.new
   end     

  end

  # GET /prop_houses/1/edit
  def edit
    @prophouse = Prophouse.find(params[:id])
    @house = House.find(@prophouse.house_id)
    @pgo = Pgo.find(@house.pgo_id)    

  end

  # POST /prop_houses
  # POST /prop_houses.json
  def create
      @pgo = Pgo.find(params[:pgo])
      @house = House.find(params[:house])
      @prophouse = @house.prophouses.new(params[:prophouse])

      if @prophouse.save then
        redirect_to pgo_path({:id =>  @pgo.id, :pan => 3}), notice: 'Обход успішно створено.' 
       
      else
        render action: "new" 
       
      end

  end

  # PUT /prop_houses/1
  # PUT /prop_houses/1.json
  def update
  
    @prophouse = Prophouse.find(params[:id])
    @house = House.find(@prophouse.house_id)
    @pgo = Pgo.find(@house.pgo_id)    

      if @prophouse.update_attributes(params[:prophouse])
         redirect_to pgo_path({:id =>  @pgo.id, :pan => 3}), notice: 'Інформацію обходу оновлено.'
      
      else
        render action: "edit"
       
      end
 
  end

  # DELETE /prop_houses/1
  # DELETE /prop_houses/1.json
  def destroy
    
    @prophouse = Prophouse.find(params[:id])
    id_pgo = Pgo.find(House.find(@prophouse.house_id).pgo_id).id
    @prophouse.destroy
     redirect_to pgo_path({:id =>  id_pgo, :pan => 3})    
  end
end
