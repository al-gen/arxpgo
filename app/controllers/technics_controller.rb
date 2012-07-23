# encoding: utf-8

class TechnicsController < ApplicationController
  before_filter :authenticate_user!
  # GET /technics
  # GET /technics.json
  def index
    id_pgo = params[:id]
    @pgo = Pgo.find(id_pgo)
    @technics = @pgo.technics.order('datezap DESC').paginate(:page => params[:page], :per_page => 3)    

  render :layout => false 
  end

  # GET /technics/1
  # GET /technics/1.json
  def show
     
    @technic = Technic.find(params[:id])
    @pgo = Pgo.find(@technic.pgo_id)
  end

  # GET /technics/new
  # GET /technics/new.json
  def new
    id_pgo = params[:id]
    @pgo = Pgo.find(id_pgo)

      if @pgo.technics.order('datezap DESC').first != nil then
          @temp = @pgo.technics.order('datezap DESC').first
          @technic = @pgo.technics.build(@temp.attributes)
          @proparray = Array.new
            Glossarytechnic.order('id').each do |f|
              t = @temp.proptechnics.find(:first, :conditions => ["glossary_technic_id = #{f.id}"])
              if t != nil then @proparray[f.id] = t.value else
                @proparray[f.id] = '' end
            end          
      else    
          @technic = @pgo.technics.build
          @technic.proptechnics.build
          @proptechnics = @technic.proptechnics
          @proparray = Array.new
            Glossarytechnic.order('id').each do |f|
                @proparray[f.id] = ''
            end

      end
  end

  # GET /technics/1/edit
  def edit
     
    @technic = Technic.find(params[:id])
    @pgo = Pgo.find(@technic.pgo_id)
    @proptechnics = @technic.proptechnics 

      @proparray = Array.new
      Glossarytechnic.order('id').each do |f|
         @proptechnic = @technic.proptechnics.find(:first, :conditions => ["glossary_technic_id = #{f.id}"])
         if @proptechnic == nil then
           @proparray[f.id] = ''
         else
           @proparray[f.id] = @proptechnic.value.to_s
         end
      end
  end

  # POST /technics
  # POST /technics.json
  def create
       @pgo = Pgo.find(params[:pgo])
       @technic =  @pgo.technics.build(params[:technic])
       @proptechnics = @technic.proptechnics
       @proparray = Array.new 
        Glossarytechnic.all.each do |f|
          @proparray[f.id] = params[f.id.to_s]  
        end  
        flag = true
    Glossarytechnic.all.each do |f|
       if @proparray[f.id] != '' then
        flag =  @proparray[f.id].kind_of? Integer
        flag =  @proparray[f.id].to_i > 0
        if not flag then
          pprop = {}
          pprop["glossary_technic_id"] = f.id
          pprop["value"] = @proparray[f.id]          
          prop = @proptechnics.build
          prop.update_attributes(pprop)
        end
       end
    end      
    
      if @technic.save then
        
       if flag then
         Glossarytechnic.all.each do |f|
          if @proparray[f.id] != '' then 
          pprop = {}
          pprop["glossary_technic_id"] = f.id
          pprop["value"] = @proparray[f.id]          

            prop = @proptechnics.build
            prop.update_attributes(pprop)  
          end
         end
      
        
        redirect_to pgo_path({:id =>  @pgo.id, :pan => 5}), notice: 'Обход успішно створено.'
      else
         pvalue = @technic.attributes
         @technic.destroy
         @technic = Technic.new(pvalue)          
                
         render action: "new" 
        
      end
     else
      render action: "new" 
     end  
   end

  # PUT /technics/1
  # PUT /technics/1.json
  def update
    
    @technic = Technic.find(params[:id])
    @pgo = Pgo.find(@technic.pgo_id)
    @proptechnics = @technic.proptechnics
    @proparray = Array.new
    Glossarytechnic.all.each do |f|
          @proparray[f.id] = params[f.id.to_s]  
    end   
    flag = true
    Glossarytechnic.all.each do |f|
       if @proparray[f.id] != '' then
        flag =  @proparray[f.id].kind_of? Integer
        flag =  @proparray[f.id].to_i > 0
        if not flag then
          pprop = {}
          pprop["glossary_technic_id"] = f.id
          pprop["value"] = @proparray[f.id]          
          prop = @proptechnics.build
          prop.update_attributes(pprop)
        end
       end
    end      
     if @technic.update_attributes(params[:technic]) then
      
  
       if flag then
         Glossarytechnic.all.each do |f|
          if @proparray[f.id] != '' then 
          pprop = {}
          pprop["glossary_technic_id"] = f.id
          pprop["value"] =  @proparray[f.id]          
          prop = @technic.proptechnics.find(:first, :conditions => ["glossary_technic_id = #{f.id}"])
          if prop != nil then prop.update_attributes(pprop) else
            prop = @proptechnics.build
            prop.update_attributes(pprop)  
          end
          else
           prop = @technic.proptechnics.find(:first, :conditions => ["glossary_technic_id = #{f.id}"])
           if prop != nil then prop.destroy end
            
          end
         end
         redirect_to pgo_path({:id =>  @pgo.id, :pan => 5}), notice: 'Техніка оновлена.' 
       else
         render action: "edit" 
       end  
     else
      render action: "edit" 
     end  

  end

  # DELETE /technics/1
  # DELETE /technics/1.json
  def destroy
    @technic = technic.find(params[:id])
     @pgo = Pgo.find(@technic.pgo_id)
    @technic.proptechnics.each do |f|
      f.destroy
    end
    @technic.destroy
    redirect_to  pgo_path({:id =>  @pgo.id, :pan => 5})
  end
end
