# encoding: utf-8

class PgosController < ApplicationController
  before_filter :authenticate_user!
  # GET /pgos
  # GET /pgos.json
  def index
    
    id_council = getcouncil(params[:council])
 

      id_book = params[:book] 
    if id_book ==  nil then 
       if Council.find(id_council).books.first != nil then
         id_book = Council.find(id_council).books.order('num').first.id
       else 
         id_book = nil 
       end
    end
    
    if id_book != nil then
       @book = Book.find(id_book)
       if (get_role == @book.rada_id) or (get_role == 0)  then 
         id_council = @book.rada_id
       else
            if Council.find(id_council).books.first != nil then
              id_book = Council.find(id_council).books.order('num').first.id
            else 
              id_book = nil 
            end         
       end
      
    end     
    
    if id_book != nil then

       @book = Book.find(id_book)
       @book_id = id_book
       @pgos = @book.pgos.order('num_1').paginate(:page => params[:page], :per_page => 5) 
    else   
        @pgos = nil
        @book = nil
        @book_id = nil
    end           
   @council =  Council.find(id_council)
      
  end
  

  

  # GET /pgos/1
  # GET /pgos/1.json
  def show

    @panel_id = 0
    if params[:pan] != nil then 
      @panel_id = params[:pan]    

    end    
    @pgo = Pgo.find(params[:id])
    
    @book = Book.find(@pgo.book_id)
    @council = Council.find(@book.rada_id)
    if not ((get_role == @council.id) or (get_role == 0)) then
      redirect_to :action => "access_denied", :controller => "allpgo"
    end

  end
  
  def shows
    @pgo = Pgo.find(params[:id])
    if @pgo.num_2 == 1 then
       @per = @pgo.pers.find(:first, :conditions => ["family ilike :input",{:input => "голова"}])
    else
      @per = @pgo.pers.order('id').first
    end  
    @book = Book.find(@pgo.book_id)
    @council = Council.find(@book.rada_id)   
    @addre =  Addre.find(@pgo.address_id) 
   render :layout => false 
  end

  # GET /pgos/new
  # GET /pgos/new.json
  def new
        
    @page = params[:page]
    @book = Book.find(params[:book])
    @council = Council.find(params[:council])   


    @pgo = @book.pgos.new
    @addre = Addre.new
    @pgo.address_id = @addre.id
    @addre.rada_id = @council.id
    

    id_city = @council.villages.order('id').first.id
    if Village.find(id_city).roads.first != nil then
      id_street =  Village.find(id_city).roads.first.id 
    else
      id_street = nil 
    end
        @addre.street_id = id_street
        @addre.city_id = id_city
  end

  # GET /pgos/1/edit
  def edit
    
    
    @pgo = Pgo.find(params[:id])
    @book = Book.find(@pgo.book_id)
    @council = Council.find(@book.rada_id)   
    @addre =  Addre.find(@pgo.address_id)     


  end

  # POST /pgos
  # POST /pgos.json
  def create
    if params[:commit] != nil then    
          @book = Book.find(params[:book])
          @council = Council.find(params[:council])   
          @page = params[:page]

          

            pvalue = {}

            pvalue[:rada_id] = params[:council]
            pvalue[:city_id] = params[:Village][:id]
            pvalue[:street_id] = params[:Road][:id]
            pvalue[:house] = params[:house]
            pvalue[:suf_house] = params[:suf_house]
      


               @addre = Addre.new(pvalue)
              @pgo = @book.pgos.new(params[:pgo])


        if @addre.save then
              @addre.full_address = @addre.addresfull
              @addre.save
              @pgo.address_id = @addre.id 
              
              
              if @pgo.save then

                redirect_to pgo_path({:id =>  @pgo.id, :pan => 0}), notice: 'Об\'єкт ПГО успішно створений'
              else
                unless @addre.new_record? then
                  pvalue = @addre.attributes
                  @addre.destroy
                  @addre = Addre.new(pvalue)
            
                end  
          
                 render action: "new"
              end
        else
                render action: "new"
        end
    else
      @page = params[:page]
      if not params[:Road].nil? then 
        id_street = params[:Road][:id].to_i     
      end  
      if not params[:Village].nil? then 

        id_city = params[:Village][:id].to_i 
        
        if id_street != nil then 
          
          if Village.find(id_city).roads.find(:first, :conditions => ["id = #{id_street}"]) == nil then
            if Village.find(id_city).roads.first != nil then
              id_street = Village.find(id_city).roads.first.id
            else
              id_street = nil
            end
          end  
        else
           if Village.find(id_city).roads.first != nil then
              id_street = Village.find(id_city).roads.first.id
           end
          
        end 
        
        
        
        
        
      end 
      
          @book = Book.find(params[:book])
          @council = Council.find(params[:council])   


           
   
   
            pvalue = {}
            pvalue[:rada_id] = params[:council]
            pvalue[:city_id] = params[:Village][:id]
            pvalue[:street_id] = params[:Road][:id]
            pvalue[:house] = params[:house]
            pvalue[:suf_house] = params[:suf_house]
      
            
            @addre = Addre.new(pvalue)
            params[:pgo][:addres_id] = @addre.id 
            @pgo = @book.pgos.new(params[:pgo])
            
    
      render action: "new"
 
      
   end 
  end

  # PUT /pgos/1
  # PUT /pgos/1.json
  def update
    if params[:commit] != nil then
            @pgo = Pgo.find(params[:id])
            pvalue = {}
            pvalue[:rada_id] = params[:council]
            pvalue[:city_id] = params[:Village][:id]
            pvalue[:street_id] = params[:Road][:id]
            pvalue[:house] = params[:house]
            pvalue[:suf_house] = params[:suf_house]


            @addre = Addre.find(@pgo.address_id)

         
            if @addre.update_attributes(pvalue) then
             
            pvalue[:full_address] = @addre.addresfull 
            @addre.update_attributes(pvalue)
            if @pgo.update_attributes(params[:pgo]) then
              redirect_to pgo_path({:id =>  @pgo.id, :pan => 0}), notice: 'Інформацію успішно оновлено'
            else
              @book = Book.find(@pgo.book_id)
              @council = Council.find(@book.rada_id)                
              render action: "edit"
            end
            else
              @pgo.update_attributes(params[:pgo])
              @book = Book.find(@pgo.book_id)
              @council = Council.find(@book.rada_id)   
                
              render action: "edit"
            end
         
    else
        @pgo = Pgo.find(params[:id])
        @addre = Addre.find(@pgo.address_id)
        pvalue = {}
        if not params[:Road].nil? then 
         id_street = params[:Road][:id].to_i 
         
        end  
        if not params[:Village].nil? then 

        id_city = params[:Village][:id].to_i 
        pvalue[:city_id] = id_city
        if id_street != nil then 
          if Village.find(id_city).roads.where("id = #{id_street}").first == nil then
            if Village.find(id_city).roads.first != nil then
              id_street = Village.find(id_city).roads.first.id
            else
              id_street = nil
            end
          end 
          
        else
           if Village.find(id_city).roads.first != nil then
              id_street = Village.find(id_city).roads.first.id
           end
          
        end 
          pvalue[:street_id] = id_street
        
        end  
            
            
            pvalue[:rada_id] = params[:council]
            
            
            pvalue[:house] = params[:house]
            pvalue[:suf_house] = params[:suf_house]
           

         
            @addre.attributes = pvalue
            @pgo.attributes = params[:pgo]
            
              @book = Book.find(@pgo.book_id)
              @council = Council.find(@book.rada_id)        
            render action: "edit"
     

    end
  end

  # DELETE /pgos/1
  # DELETE /pgos/1.json
  def destroy
    @pgo = Pgo.find(params[:id])
    id_book = @pgo.book_id
    id_council = Book.find(id_book).rada_id
    @pgo.destroy
    redirect_to :action => "index", :council => id_council, :book => id_book
  end
  
  def selbook

    if not params[:Council].nil? then 
      id_council = params[:Council][:id].to_i 
      if Council.find(id_council).books.first != nil then
      id_book = Council.find(id_council).books.order('num').first.id
      else 
        id_book = nil
      end
    end
    if not params[:Book].nil? then 
      id_book = params[:Book][:id].to_i 
      id_council = params[:council].to_i 
    end

    redirect_to :action => "index", :council => id_council, :book => id_book   
  end
  


end
