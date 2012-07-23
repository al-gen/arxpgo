# encoding: utf-8

class AnimalsController < ApplicationController
  before_filter :authenticate_user!
  # GET /animals
  # GET /animals.json
  def index
    
    id_pgo = params[:id]
    @pgo = Pgo.find(id_pgo)
    @animals = @pgo.animals.order('datezap DESC').paginate(:page => params[:page], :per_page => 3)
    render :layout => false     
  end

  # GET /animals/1
  # GET /animals/1.json
  def show
    
    @animal = Animal.find(params[:id])
    @pgo = Pgo.find(@animal.pgo_id)
  end

  # GET /animals/new
  # GET /animals/new.json
  def new
    id_pgo = params[:id]
    @pgo = Pgo.find(id_pgo)

      if @pgo.animals.order('datezap DESC').first != nil then
          @temp = @pgo.animals.order('datezap DESC').first
          @animal = @pgo.animals.build(@temp.attributes)
          @proparray = Array.new
            Glossaryanimal.order('id').each do |f|
              t = @temp.propanimals.find(:first, :conditions => ["glossary_animal_id = #{f.id}"])
              if t != nil then @proparray[f.id] = t.value else
                @proparray[f.id] = '' end
            end          
      else    
          @animal = @pgo.animals.build
          @animal.propanimals.build
          @propanimals = @animal.propanimals
          @proparray = Array.new
            Glossaryanimal.order('id').each do |f|
                @proparray[f.id] = ''
            end

      end
   end
  # GET /animals/1/edit
  def edit
      
    @animal = Animal.find(params[:id])
    @pgo = Pgo.find(@animal.pgo_id)    
    @propanimals = @animal.propanimals 

      @proparray = Array.new
      Glossaryanimal.order('id').each do |f|
         @propanimal = @animal.propanimals.find(:first, :conditions => ["glossary_animal_id = #{f.id}"])
         if @propanimal == nil then
           @proparray[f.id] = ''
         else
           @proparray[f.id] = @propanimal.value.to_s
         end
      end

  end

  # POST /animals
  # POST /animals.json
  def create
          @pgo = Pgo.find(params[:pgo])
          @animal = @pgo.animals.build(params[:animal])
          @propanimals = @animal.propanimals
          @proparray = Array.new
        Glossaryanimal.all.each do |f|
          @proparray[f.id] = params[f.id.to_s]  
        end  
        flag = true
    Glossaryanimal.all.each do |f|
       if @proparray[f.id] != '' then
        flag =  @proparray[f.id].kind_of? Integer
        flag =  @proparray[f.id].to_i > 0
        if not flag then
          pprop = {}
          pprop["glossary_animal_id"] = f.id
          pprop["value"] = @proparray[f.id]          
          prop = @propanimals.build
          prop.update_attributes(pprop)
        end
       end
    end      
    
      if @animal.save then
        
       if flag then
         Glossaryanimal.all.each do |f|
          if @proparray[f.id] != '' then 
          pprop = {}
          pprop["glossary_animal_id"] = f.id
          pprop["value"] = @proparray[f.id]          

            prop = @propanimals.build
            prop.update_attributes(pprop)  
          end
         end
      
        
        redirect_to pgo_path({:id =>  @pgo.id, :pan => 4}), notice: 'Обход успішно створено.'
      else
         pvalue = @animal.attributes
         @animal.destroy
         @animal = Animal.new(pvalue)          
        
         render action: "new" 
        
      end
     else
      render action: "new" 
     end  
  end

  # PUT /animals/1
  # PUT /animals/1.json
  def update
  
    @animal = Animal.find(params[:id])
    @pgo = Pgo.find(@animal.pgo_id)
    @propanimals = @animal.propanimals
    @proparray = Array.new
    Glossaryanimal.all.each do |f|
          @proparray[f.id] = params[f.id.to_s]  
    end   
    flag = true
    Glossaryanimal.all.each do |f|
       if @proparray[f.id] != '' then
        flag =  @proparray[f.id].kind_of? Integer
        flag =  @proparray[f.id].to_i > 0
        if not flag then
          pprop = {}
          pprop["glossary_animal_id"] = f.id
          pprop["value"] = @proparray[f.id]          
          prop = @propanimals.build
          prop.update_attributes(pprop)
        end
       end
    end      
     if @animal.update_attributes(params[:animal]) then
      
  
       if flag then
         Glossaryanimal.all.each do |f|
          if @proparray[f.id] != '' then 
          pprop = {}
          pprop["glossary_animal_id"] = f.id
          pprop["value"] = @proparray[f.id]          
          prop = @animal.propanimals.find(:first, :conditions => ["glossary_animal_id = #{f.id}"])
          if prop != nil then 
            prop.update_attributes(pprop) 
          else
            prop = @propanimals.build
            prop.update_attributes(pprop)  
          end
          else
           prop = @animal.propanimals.find(:first, :conditions => ["glossary_animal_id = #{f.id}"])
           if prop != nil then 
             prop.destroy 
           end
            
          end
         end
         redirect_to pgo_path({:id =>  @pgo.id, :pan => 4}), notice: 'Худоба та птиця оновлені.' 
       else
         render action: "edit" 
       end  
     else
      render action: "edit" 
     end  

  end

  # DELETE /animals/1
  # DELETE /animals/1.json
  def destroy
    @animal = Animal.find(params[:id])
    @pgo = Pgo.find(@animal.pgo_id)
    @animal.propanimals.each do |f|
      f.destroy
    end
    @animal.destroy

     redirect_to pgo_path({:id =>  @pgo.id, :pan => 4})
 
  end
end
