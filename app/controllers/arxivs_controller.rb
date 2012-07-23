class ArxivsController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:index, :showall, :sarxivs, :show, :picture, :printarx, :getarx]
  
  # GET /arxivs
  # GET /arxivs.json
  #  -3 - незарегистрированный пользователь
  #  -2 - пожарник, электрик ...
  #  -1 - архитектор
  #   0 - райголова
  #   1..14 - головы советов
  def index
    if user_signed_in? 
      ArxivsController.del_free_img(current_user)
    end
    $g_rada_id = nil
    $arx_edit_id = nil    
    @doclist = nil
    
    case ArxivsController.role_id(current_user,user_signed_in?)
    when -3
      @doclines = Arxiv.seach_docs(params[:mseach],-3) 
      @user_in = false
    when -2
      @doclines = Arxiv.seach_docs(params[:mseach],-2) 
      @user_in = false
    when -1
      @doclines = Arxiv.seach_docs(params[:mseach],-1) 
      @user_in = true
    when 0
      @doclines = Arxiv.seach_docs(params[:mseach],0) 
      @user_in = true
    else
      @doclines = Arxiv.seach_docs(params[:mseach],current_user.council_id.to_i) 
      @user_in = true      
    end
    
    
    respond_to do |format|
      format.html {render :layout => "application_arx"}
      format.js
    end
    
  end

  
  
  # GET /arxivs/1
  # GET /arxivs/1.json
  def show
    @arxiv = Arxiv.find(params[:id])
    @rada = Council.find(@arxiv.rada_id)
    @s_person = ArxivsController.person_str(@arxiv.person_id)
    @s_address = ArxivsController.address_str(@arxiv.pgo_id) 
    @imgs = Img.find(:all, :conditions =>"arxiv_id = '#{@arxiv.id}'" )
    @userin = false
    respond_to do |format|
      format.html {render :layout => "application_arx"}# show.html.erb
      format.json { render json: @arxiv }
    end
  end

  
  
  # GET /arxivs/new
  # GET /arxivs/new.json
  def new
    @arxiv = Arxiv.new
    @img = Img.new
    @imgs = Img.find(:all, :conditions =>"((arxiv_id = '-1')AND(user_id = '#{current_user.id}'))" )
    if current_user.council_id.to_i > 0
      $g_rada_id = current_user.council_id
    else
      $g_rada_id = 1 if $g_rada_id.nil?
    end
    
    @userin = true
    respond_to do |format|
      format.html {render :layout => "application_arx"}# new.html.erb
      format.json { render json: @arxiv }
    end
  end

  
  
  # GET /arxivs/1/edit
  def edit
    $arx_edit_id = params[:id] if $arx_edit_id.nil?
    @arxiv = Arxiv.find($arx_edit_id)
    if $g_rada_id.nil?
      $g_rada_id = @arxiv.rada_id  
    end 
    @img = Img.new
    @imgs= Img.find(:all, :conditions =>"(((arxiv_id = '#{@arxiv.id}')OR(arxiv_id = '-1'))AND(user_id = '#{current_user.id}'))" )
    @userin = true
    render :layout => "application_arx"
  end

  
  
  # POST /arxivs
  # POST /arxivs.json
  def create    
    @arxiv = Arxiv.new(params[:arxiv])
    @arxiv.rada_id = $g_rada_id
    #Находим ПГО по адресу
    @arxiv.pgo_id = Pgo.adres_to_pgo(@arxiv.linkfile)
    if @arxiv.pgo_id == -1
      @arxiv.linkfile = t(:mynone)
    end
    #Находим человека по ФИО
    @arxiv.person_id = Pers.str_to_pers(@arxiv.typefile)
    if @arxiv.person_id == -1
      @arxiv.typefile = t(:mynone)
    end
    #Определяем принадлежность документа к амин апарату
    if current_user.council_id.to_i == 0 and current_user.id == 15
      @arxiv.onadmin = "1"
    else
      @arxiv.onadmin = "0"      
    end
    #Формируем строку поиска
    @arxiv.update_lseach
    
    respond_to do |format|
      if @arxiv.save
        $g_rada_id = nil
        $arx_edit_id = nil
        
        @addimg = Img.find(:all, :conditions =>"((arxiv_id = '-1')AND(user_id = '#{current_user.id}'))")
        @addimg.each do |a|
          a.arxiv_id = @arxiv.id
          a.save
        end
        
        format.html { redirect_to @arxiv }
        format.json { render json: @arxiv, status: :created, location: @arxiv }
      else
        @img = Img.new
        @imgs = Img.find(:all, :conditions =>"((arxiv_id = '-1')AND(user_id = '#{current_user.id}'))" )
        @userin = true   
        
        format.html { render action: "new", :layout => "application_arx" }
        format.json { render json: @arxiv.errors, status: :unprocessable_entity }
      end
    end
  end
 
  
  
  # PUT /arxivs/1
  # PUT /arxivs/1.json
  def update
    @arxiv = Arxiv.find(params[:id])
    @arxiv.rada_id = $g_rada_id

    respond_to do |format|
      if @arxiv.update_attributes(params[:arxiv])
        #Находим ПГО по адресу
        @arxiv.pgo_id = Pgo.adres_to_pgo(@arxiv.linkfile)
        if @arxiv.pgo_id == -1
          @arxiv.linkfile = t(:mynone)
        end
        #Находим человека по ФИО
        @arxiv.person_id = Pers.str_to_pers(@arxiv.typefile)
        if @arxiv.person_id == -1  
          @arxiv.typefile = t(:mynone)
        end         
        
        #Обновляем строку поиска
        @arxiv.update_lseach
        @arxiv.save
      
        $g_rada_id = nil
        $arx_edit_id = nil 

        @addimg = Img.find(:all, :conditions =>"((arxiv_id = '-1')AND(user_id = '#{current_user.id}'))")
        @addimg.each do |a|
          a.arxiv_id = @arxiv.id
          a.save
        end        
        
        format.html { redirect_to @arxiv }
        format.json { head :ok }
      else
        @img = Img.new
        @imgs = Img.find(:all, :conditions =>"(((arxiv_id = '#{@arxiv.id}')OR(arxiv_id = '-1'))AND(user_id = '#{current_user.id}'))" )
        @userin = true
        
        format.html { render action: "edit", :layout => "application_arx"}
        format.json { render json: @arxiv.errors, status: :unprocessable_entity }
      end
    end
  end

  
  
  # DELETE /arxivs/1
  # DELETE /arxivs/1.json
  def destroy
    @arxiv = Arxiv.find(params[:id])
    @arxid = @arxiv.id
    if @arxiv.destroy
      @remimg = Img.find(:all, :conditions =>"arxiv_id = '#{@arxid}'")
      @remimg.each do |a|
        a.destroy
      end
    end
    redirect_to :action => "showall"
  end
  
  
  
  #Поиск по архиву
  def sarxivs
    $arx_edit_id = nil
    $g_rada_id = nil
    @mf = Arxiv.seach_docs(params[:mseach])
    render :layout => "application_arx"
  end
  
  
  
  def showall
    $arx_edit_id = nil
    $g_rada_id = nil
    @doclines = nil
    
    case ArxivsController.role_id(current_user,user_signed_in?)
    when -3
      @doclines = Arxiv.all_docs(-3) 
      @user_in = false
    when -2
      @doclines = Arxiv.all_docs(-2) 
      @user_in = false
    when -1
      @doclines = Arxiv.all_docs(-1) 
      @user_in = true
    when 0
      @doclines = Arxiv.all_docs(0) 
      @user_in = true
    else
      @doclines = Arxiv.all_docs(current_user.council_id.to_i) 
      @user_in = true      
    end
    
    respond_to do |format|
      format.html {render 'index', :layout => "application_arx"}
      format.js {render 'index'}
    end
  end
  
  
  
  def picture
    @picture = Img.find(params[:id])
    send_data(@picture.mfile,
              :filename => @picture.linkfile,
              :type => @picture.typefile,
              :disposition => "inline")    
  end
  
  
  #Возвращаем список документов, которые относятся к ПГО
  def archpgo
    @pgoid = params[:id]
    @doclist = Arxiv.find(:all, :conditions =>"pgo_id = '#{@pgoid}'")
    render :layout => "application_arx"
  end
    
  
  #Возвращает строку с адресом ПГО, по переданному экземпляру класса ПГО
  def self.address_str(pgo_id)
    if pgo_id == -1
      return "-"
    else
      @pgo = Pgo.find(pgo_id)
      @address = Addres.find(@pgo.address_id)
      return @address.full_address      
    end
  rescue
    return "-"
  end
  
  
  #Возвращает строку ФИО по переданному экземпляру класса Person
  def self.person_str(person_id)
    if person_id == -1
      return "-"
    else
      @per = Pers.find(person_id)
      return "#{@per.surname} #{@per.name} #{@per.midname}"
    end
  rescue
    return "-"
  end
  
  
  #Изменяет совет, которому принадлежит архивный документ(значение переменной $g_rada_id
  def chengerada  
    if not params[:arxiv].nil?
      $g_rada_id = params[:arxiv][:rada_id] 
    end  
    
    if $arx_edit_id.nil?
      redirect_to :action => "new"
    else
      redirect_to :action => "edit"
    end
  end
 
  
  #Удаляем изображение
  def deleteimg
    @img = Img.find(params[:id])
    @img.destroy
    @imgs = Img.find(:all, :conditions =>"((arxiv_id = '-1')AND(user_id = '#{current_user.id}'))" )
    @userin = true    
    respond_to do |format|
      format.html {redirect_to :controller => "arxivs", :action => "chengerada"}
      format.js
    end
    
  end

  
  #Удаляет растры не привязанные к архивам
  def self.del_free_img(cur_user)
    @addimg = Img.find(:all, :conditions =>"((arxiv_id = '-1')AND(user_id = '#{cur_user.id}'))")
    @addimg.each do |a|
      a.destroy
    end        
  end
 
  
  #Версия для печати
  def printarx
    @arxiv = Arxiv.find(params[:id])
    @imgs = Img.find(:all, :conditions =>"arxiv_id = '#{@arxiv.id}'" )
    @userin = false
    render :layout => "application_print"
  end
  
  
  def getarx    
    @arxlist = Arxiv.seach_ajax(params[:term], ArxivsController.role_id(current_user,user_signed_in?))
    #формируем список
    @ls=[]
    if @arxlist.blank?
      @ls = [t(:mynone)]
    else
      @arxlist.each do |a|
        @ls << "#{a.lseach.split(' ')[0]} #{a.numrich} #{a.dateprin}"
      end     
    end
    render json: @ls
  end
  
  
  def getadr
    @temp_str = params[:term].strip
    if not @temp_str.blank?
      #Разбиваем на лексимы
      @lecsim = @temp_str.split(' ')
      case @lecsim.count
        when 1 #Если она одна
        @adrlist = Addres.find(:all, 
                               :limit => 15,
                               :select => 'rada_id, full_address',
                               :conditions => ["(rada_id=?)AND(full_address ILIKE ?)","#{$g_rada_id}","%#{@lecsim[0]}%"])  
        when 2 #Если две
        @adrlist = Addres.find(:all, 
                               :limit => 13,
                               :select => 'rada_id, full_address',
                               :conditions => ["(rada_id=?)AND((full_address ILIKE ?)AND(full_address ILIKE ?))",
                               "#{$g_rada_id}","%#{@lecsim[0]}%","%#{@lecsim[1]}%"])  
        when 3 #Если три
        @adrlist = Addres.find(:all, 
                               :limit => 11,
                               :select => 'rada_id, full_address',
                               :conditions => ["(rada_id=?)AND((full_address ILIKE ?)AND(full_address ILIKE ?)AND(full_address ILIKE ?))",
                               "#{$g_rada_id}","%#{@lecsim[0]}%","%#{@lecsim[1]}%","%#{@lecsim[2]}%"])  
        when 4 #Если четыри
        @adrlist = Addres.find(:all, 
                               :limit => 9,
                               :select => 'rada_id, full_address',
                               :conditions => ["(rada_id=?)AND((full_address ILIKE ?)AND(full_address ILIKE ?)AND(full_address ILIKE ?)AND(full_address ILIKE ?))",
                               "#{$g_rada_id}","%#{@lecsim[0]}%","%#{@lecsim[1]}%","%#{@lecsim[2]}%","%#{@lecsim[3]}%"])  
        else #Пять и больше
        @adrlist = Addres.find(:all, 
                               :limit => 7,
                               :select => 'rada_id, full_address',
                               :conditions => ["(rada_id=?)AND((full_address ILIKE ?)AND(full_address ILIKE ?)AND(full_address ILIKE ?)AND(full_address ILIKE ?)AND(full_address ILIKE ?))",
                               "#{$g_rada_id}","%#{@lecsim[0]}%","%#{@lecsim[1]}%","%#{@lecsim[2]}%","%#{@lecsim[3]}%","%#{@lecsim[4]}%"])  
      end
      
      if @adrlist.blank?
        @ls = [t(:mynone)]
        render json: @ls
      else
        render json: @adrlist.map(&:full_address)     
      end
      
    end
  end
   
  #Формируем список автозаполнения строки адреса
  def getper
    @temp_str = params[:term].strip
    if @temp_str.length != 0  
      #Разбиваем на лексимы запрос
      @lecsim = @temp_str.split(' ')
      if @lecsim.count == 1
        #Если она одна
        @perlist = Pers.find(:all,
                             :limit =>15,
                             :select => 'surname, name, midname',
                             :conditions => ["(surname ILIKE ?)OR(name ILIKE ?)OR(midname ILIKE ?)","#{@lecsim[0]}%","#{@lecsim[0]}%","#{@lecsim[0]}%"])
      else
        if @lecsim.count <= 2
          #Если их две
          @perlist = Pers.find(:all,
                               :limit =>7,
                               :select => 'surname, name, midname',
                               :conditions => ["((surname ILIKE ?)AND((name ILIKE ?)OR(midname ILIKE ?)))OR((name ILIKE ?)AND((surname ILIKE ?)OR(midname ILIKE ?)))OR((midname ILIKE ?)AND((surname ILIKE ?)OR(name ILIKE ?)))",
                               "#{@lecsim[0]}%","#{@lecsim[1]}%","#{@lecsim[1]}%","#{@lecsim[0]}%","#{@lecsim[1]}%","#{@lecsim[1]}%","#{@lecsim[0]}%","#{@lecsim[1]}%","#{@lecsim[1]}%"])        
        else
          #
          @perlist = Pers.find(:all,
                               :limit =>5,
                               :select => 'surname, name, midname',
                               :conditions => ["((surname ILIKE ?)AND(name ILIKE ?)AND(midname ILIKE ?))OR((name ILIKE ?)AND(surname ILIKE ?)AND(midname ILIKE ?))OR((midname ILIKE ?)AND(surname ILIKE ?)AND(name ILIKE ?))",
                               "#{@lecsim[0]}%","#{@lecsim[1]}%","#{@lecsim[2]}%","#{@lecsim[0]}%","#{@lecsim[1]}%","#{@lecsim[2]}%","#{@lecsim[0]}%","#{@lecsim[1]}%","#{@lecsim[2]}%"])                
        end
      end

      if @perlist.blank?
        @ls = [t(:mynone)]
        render json: @ls
      else
        render json: @perlist.map {|p| "#{p.surname} #{p.name} #{p.midname}"}
      end
           
    end
  end
  
  

#возвращает номер роли для входа
#  -3 - незарегистрированный пользователь
#  -2 - пожарник, электрик ...
#  -1 - архитектор
#   0 - райголова
#   1..14 - головы советов
  def self.role_id(user_cur,user_in)
    #Проверяем вход пользователя в систему
    if user_in
      #Если пользователь вошол, проверяем голова он или нет
      if user_cur.role == I18n.t(:my_golova)
        #Если пользователь голова, возвращаем номер совета к которому от принадлежит
        user_cur.council_id.to_i
      else  
        #Если вошедший пользователь не голова, проверяем архитектор он или нет
        if user_cur.role == I18n.t(:my_arxitect)
          #Если вошедший пользователь архитектор
          -1
        else
          #Если пожарник и т.д.
          -2          
        end
      end
    else
      #Если пользователь не в системе
      -3
    end
  end  
  
  
end
