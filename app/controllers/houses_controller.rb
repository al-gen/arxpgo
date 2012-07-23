# encoding: utf-8

class HousesController < ApplicationController
  before_filter :authenticate_user!
 
  # GET /houses
  # GET /houses.json
  def index
    id_pgo = params[:id]
    @pgo = Pgo.find(id_pgo)
    @houses =  @pgo.houses.order('id')
    render :layout => false 
  end

  # GET /houses/1
  # GET /houses/1.json
  def show

    @house = House.find(params[:id])
    @pgo = Pgo.find(@house.pgo_id)

# render :layout => false
  end

  # GET /houses/new
  # GET /houses/new.json
  def new
    id_pgo = params[:id]
    @pgo = Pgo.find(id_pgo)
    @house = @pgo.houses.build
    
    @prophouse = @house.prophouses.build

  end

  # GET /houses/1/edit
  def edit

    @house = House.find(params[:id])
    @pgo = Pgo.find(@house.pgo_id)    
    @prophouse = @house.prophouses.order('datezap DESC').first
  end

  # POST /houses
  # POST /houses.json
  def create
    
    @pgo = Pgo.find(params[:pgo])
    if params[:Per] != nil then
    params["house"]["person_id"] = params[:Per][:id] end    

    @house = @pgo.houses.build(params[:house])
    @prophouse = @house.prophouses.build(params[:prophouse])
    
    
      if @house.update_attributes(params[:house])then 
       if  @prophouse.update_attributes(params[:prophouse]) then
        redirect_to pgo_path({:id =>  @pgo.id, :pan => 3}), notice: 'Будинок успішно створений'
       else
         pvalue = @house.attributes
         @house.destroy
         @house = @pgo.houses.build(pvalue)         
        render action: "new"
   
       end
        
      else
      
       render action: "new"
   
      end

  end

  # PUT /houses/1
  # PUT /houses/1.json
  def update
    @house = House.find(params[:id])
    @pgo = Pgo.find(@house.pgo_id)
    @prophouse = @house.prophouses.order("datezap DESC").first
   
    
    
    
    params["house"]["person_id"] = params[:Per][:id]
    
      if @house.update_attributes(params[:house]) then
       if @prophouse.update_attributes(params[:prophouse]) then
        redirect_to pgo_path({:id =>  @pgo.id, :pan => 3}), notice: 'Інформація успішно оновлена'
      else
       render action: "edit"
        
      end        
      else
        @prophouse.attributes = params[:prophouse]
       render action: "edit"
        
      end
  
  end

  # DELETE /houses/1
  # DELETE /houses/1.json
  def destroy
    @house = House.find(params[:id])
    @pgo = Pgo.find(@house.pgo_id)
    @house.prophouses.all.each do |prop|
      prop.destroy
    end
      
    @house.destroy
      redirect_to pgo_path({:id =>  @pgo.id, :pan => 3})
  end
  
  
   def wallsearch
   @houses = House.where("upper(material_wall) LIKE upper(:input)",{:input => "#{params[:query]}%"}).select('material_wall').group('material_wall')
   render :json => @houses.to_json, :callback => params[:callback]
 end 

    def krovlsearch
   @houses = House.where("upper(material_krovl) LIKE upper(:input)",{:input => "#{params[:query]}%"}).select('material_krovl').group('material_krovl')
   render :json => @houses.to_json, :callback => params[:callback]
 end 
 
 end
