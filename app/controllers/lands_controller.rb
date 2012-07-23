# encoding: utf-8

class LandsController < ApplicationController
  before_filter :authenticate_user!
  # GET /lands
  # GET /lands.json
  def index

      id_pgo = params[:id]
      @pgo = Pgo.find(id_pgo)
      @lands = @pgo.lands.order('id')
      
       render :layout => false 
  end

  # GET /lands/1
  # GET /lands/1.json
  def show
     
    @land = Land.find(params[:id])
    @pgo = Pgo.find(@land.pgo_id)
  end

  # GET /lands/new
  # GET /lands/new.json
  def new
    id_pgo = params[:id]
    @pgo = Pgo.find(id_pgo)
    @land = @pgo.lands.new
    @propland = @land.proplands.build

  end

  # GET /lands/1/edit
  def edit
    @land = Land.find(params[:id])
    @pgo = Pgo.find(@land.pgo_id)
    @propland = @land.proplands.order('datezap  DESC').first
  end

  # POST /lands
  # POST /lands.json
  def create
    @pgo = Pgo.find(params[:pgo])
    @land = @pgo.lands.new(params[:land])
    @propland = @land.proplands.build(params[:propland])
    
    
      if @land.save then 
        
       if @propland.update_attributes(params[:propland]) then
       
          redirect_to pgo_path({:id =>  @pgo.id, :pan => 2}), notice: 'Земельний участок успішно створений'
       else
         pvalue = @land.attributes
         @land.destroy
         @land = @pgo.lands.build(pvalue)
         render action: "new"
       end  
      else
        render action: "new"
       
      end
 
  end

  # PUT /lands/1
  # PUT /lands/1.json
  def update
    
    @land = Land.find(params[:id])
    @pgo = Pgo.find(@land.pgo_id)
    @propland = @land.proplands.order('datezap  DESC').first
  
      if @land.update_attributes(params[:land]) then
         if  @propland.update_attributes(params[:propland]) then
            redirect_to pgo_path({:id =>  @pgo.id, :pan => 2}), notice: 'Інформація успішно оновлена'
         else
           render action: "edit" 
         end  
      else
        @propland.attributes = params[:propland]
         render action: "edit" 
   
      end
  
  end

  # DELETE /lands/1
  # DELETE /lands/1.json
  def destroy
    
    @land = Land.find(params[:id])
    @pgo = Pgo.find(@land.pgo_id)
    @land.proplands.all.each do |prop|
      prop.destroy
    end
    @land.destroy
     redirect_to pgo_path({:id =>  @pgo.id, :pan => 2})
    end

end
