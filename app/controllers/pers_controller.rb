# encoding: utf-8

class PersController < ApplicationController
  before_filter :authenticate_user!
  # GET /pers
  # GET /pers.json
  def index
    id_pgo = params[:id]
    @pers = Pgo.find(id_pgo).pers.order( 'id', 'surname')  
    @pgo = Pgo.find(id_pgo)
    render :layout => false 
  end

  # GET /pers/1
  # GET /pers/1.json
  def show
   
    @per = Per.find(params[:id])
    @pgo = Pgo.find(@per.pgo_id)

  end

  # GET /pers/new
  # GET /pers/new.json
  def new
    id_pgo = params[:id]
    @pgo = Pgo.find(id_pgo)
    @per = @pgo.pers.build

  end

  # GET /pers/1/edit
  def edit
    
    @per = Per.find(params[:id])

    @pgo = Pgo.find(@per.pgo_id)
  end

  # POST /pers
  # POST /pers.json
  def create
    @pgo = Pgo.find(params[:pgo])
    @per = @pgo.pers.build(params[:per])

 
      if @per.save then
        redirect_to pgo_path({:id =>  @pgo.id, :pan => 1}), notice: 'Особа була успішно створена'

      else
        render action: "new"

      end

  end

  # PUT /pers/1
  # PUT /pers/1.json
  def update
    
    @per = Per.find(params[:id])
    @pgo = Pgo.find(@per.pgo_id)
  
      if @per.update_attributes(params[:per]) then
       redirect_to pgo_path({:id =>  @pgo.id, :pan => 1}), notice: 'Інформацію успішно оновлено.'
       
      else
        render action: "edit"
   
      end
  
  end

  # DELETE /pers/1
  # DELETE /pers/1.json
  def destroy
    @per = Per.find(params[:id])
    @pgo = Pgo.find(@per.pgo_id)
    
    if House.where("person_id = #{@per.id}").first == nil then
    
    @per.destroy
    end 
    redirect_to pgo_path({:id =>  @pgo.id, :pan => 1})
  
  end
 def surnamesearch
   @pers = Per.where("upper(surname) LIKE upper(:input)",{:input => "#{params[:query]}%"}).select('surname').group('surname')
   render :json => @pers.to_json, :callback => params[:callback]
 end
 def namesearch
   @pers = Per.where("upper(name) LIKE upper(:input)",{:input => "#{params[:query]}%"}).select('name').group('name')
   render :json => @pers.to_json, :callback => params[:callback]
 end
 def midnamesearch
   @pers = Per.where("upper(midname) LIKE upper(:input)",{:input => "#{params[:query]}%"}).select('midname').group('midname')
   render :json => @pers.to_json, :callback => params[:callback]
 end
 def familysearch
   @pers = Per.where("upper(family) LIKE upper(:input)",{:input => "#{params[:query]}%"}).select('family').group('family')
   render :json => @pers.to_json, :callback => params[:callback]
 end 


end
