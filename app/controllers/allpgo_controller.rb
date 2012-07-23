# encoding: utf-8

class AllpgoController < ApplicationController
  before_filter :authenticate_user!
  
  def index
 
   if get_role < 0 then redirect_to :action => "access_denied" end
  end
  
  def funcadmin
     
  end 
  
    
  def searchadre

    q = params[:query].split(/с\. *|м\. *|село *|місто *|б\. *|буд\. *| , | ,*|, *| /)
    s = ''
    
    q.each { |qq| s = s + ' ' + qq.strip 
      s = s.strip}
    
 #   q = s.split(/  */)

#    @addre = Addre.joins("inner join (select roads.id, roads.city_id from roads
# inner join (select id from villages where (upper(villages.name_ukr) like upper('#{q[0]}%'))) as vl 
#on roads.city_id = vl.id where (upper(roads.value) like upper('#{q[1]}%'))) as
#vr on (addres.city_id = vr.city_id) and (addres.street_id = vr.id) and (addres.house like '#{q[2]}%')")
      
      @addre = Searchpgo.where("fulladdress ILIKE :input",{:input => "#{s}%"}).order('fulladdress')
    
 #     @addre.order()   
      pp = Array.new()
      i = 0
      @addre.each do |p|
#       if (@addre.rada_id == get_role) or (get_role == 0) then           
       if (p.rada_id == get_role) or (get_role == 0) then           
            pp[i] = Hash.new()
  #          @pgo = Pgo.where("address_id = #{p.id}").first
            pp[i].store("id",p.pgo_id)
            pp[i].store("num_1",p.numformat)
            pp[i].store("num_2",p.num_2)
  #          @per = Per.where("pgo_id = #{p.id}").first
  #          if @pers != nil then
  #              pp[i].store("surname",@pers.surname)
  #              pp[i].store("name",@pers.name)
  #              pp[i].store("midname",@pers.midname)
  #          else
   #             pp[i].store("surname","Мешканці")
  #              pp[i].store("name","не")
  #              pp[i].store("midname","визначені")        
  #          end
            pp[i].store("fullname",p.fullname)
            pp[i].store("fulladdres",p.descaddress)
            pp[i].store("adrquest",p.fulladdress)
            i = i + 1
       end
      end
    
    render :json => pp.to_json, :callback => params[:callback]
  end
     
  def searchsur
    
    q = params[:query].strip.split(/ , | ,*|, */, 3)
    s = ''
    
    q.each { |qq| s = s + ' ' + qq.strip 
      s = s.strip}
    
     
    
    
    @pers = Searchpgo.where("fullname ILIKE :input",{:input => "#{s}%"}).order('fullname')
  #  @pers = Per.where("upper(surname) LIKE upper(:input)",{:input => "#{q[0]}%"}).where("upper(name) LIKE upper(:input)",{:input => "#{q[1]}%"}).where("upper(midname) LIKE upper(:input)",{:input => "#{q[2]}%"}).order('surname','name', 'midname')

      pp = Array.new()
      i = 0
      @pers.each do |p|
 #      @pgo = Pgo.find(p.pgo_id)
 #      @addre = Addre.find(@pgo.address_id)
 #      if (@addre.rada_id == get_role) or (get_role == 0) then   
       if (p.rada_id == get_role) or (get_role == 0) then   
            pp[i] = Hash.new()

            pp[i].store("fullname",p.fullname)
  #          pp[i].store("name",p.name)
  #          pp[i].store("midname",p.midname)

            pp[i].store("id",p.pgo_id)
#            pp[i].store("num_1",@pgo.numformat)
#            pp[i].store("num_2",@pgo.num_2)
            pp[i].store("num_1",p.numformat)
            pp[i].store("num_2",p.num_2)
            pp[i].store("fulladdres",p.descaddress)

            i = i + 1

       end
      end

    render :json => pp.to_json, :callback => params[:callback]
  end
   
   
  def searchnum
    num = params[:query].split("-",2)
#    @pgo = Pgo.where("cast(num_1 as varchar(4)) LIKE :input",{:input => "#{num[0].to_i}%"}).where("cast(num_2 as varchar(4)) LIKE :input",{:input => "#{num[1]}%"}).order('num_1','num_2')
    @pgo =  Searchpgo.where("cast(num_1 as varchar(4)) LIKE :input",{:input => "#{num[0].to_i}%"}).where("cast(num_2 as varchar(4)) LIKE :input",{:input => "#{num[1]}%"}).order('num_1','num_2')
      
    
      pp = Array.new()
      i = 0
      @pgo.each do |p|
#            @addre = Addre.find(p.address_id)
            if (p.rada_id == get_role) or (get_role == 0) then   
            pp[i] = Hash.new()
#            @pers = Per.where("(pgo_id = #{p.id})").order('id').first
#            if @pers != nil then
#                pp[i].store("surname",@pers.surname)
#                pp[i].store("name",@pers.name)
#                pp[i].store("midname",@pers.midname)
#            else
#                pp[i].store("surname","Мешканці")
#                pp[i].store("name","не")
#                pp[i].store("midname","визначені")        
#            end
            pp[i].store("id",p.pgo_id)
            pp[i].store("fullname",p.fullname)  
            pp[i].store("num_1",p.numformat)
            pp[i].store("num_2",p.num_2)

            pp[i].store("fulladdres",p.descaddress)

            i = i + 1
       end
      end
    
    render :json => pp.to_json, :callback => params[:callback] 
    
  end
  
  def setpgo
   if  params['pgo-id'].to_i != -1 then 
    id_pgo = params['pgo-id'].to_i
    redirect_to pgo_path({:id => "#{id_pgo}"}) 
   else
      redirect_to :action => "nofound"
   end  
  end
  
  def nofound
    
  end
  
  def access_denied
    
  end
end
