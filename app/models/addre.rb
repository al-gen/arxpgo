# encoding: utf-8

class Addre < ActiveRecord::Base
  attr_accessible :city_id, :house,  :rada_id,  :street_id, :suf_house, :full_address
  validates :city_id, :house,  :rada_id,  :street_id, :presence => true
  validates :house, :numericality => {:only_integer => true }
  validates :suf_house, :uniqueness => {:scope => [:street_id, :house, :city_id,  :rada_id]}

set_table_name 'addres'

belongs_to :council
belongs_to :village
belongs_to :road


  def fulladdres
    if not self.new_record? then
      

  if self.rada_id.to_s != '' then 
   s3 = "#{Council.find(self.rada_id).name.to_s} рада, "
  end
  if self.city_id.to_s != '' then
   s4 = "#{Village.find(self.city_id).typ.to_s} #{Village.find(self.city_id).name_ukr.to_s}, "
  end
  if self.street_id.to_s != '' then 
   s5 = "#{Road.find(self.street_id).typ.to_s} #{Road.find(self.street_id).value.to_s}"
  end 
   
   fulladdres = "#{s3}#{s4}#{s5}, #{self.house} #{self.suf_house}"
    else fulladdres = ''
      end 
  end
  
  
 def addresfull
    if not self.new_record? then
      

      if self.city_id.to_s != '' then
        s4 = "#{Village.find(self.city_id).typ.to_s} #{Village.find(self.city_id).name_ukr.to_s}, "
      end
      if self.street_id.to_s != '' then 
        s5 = "#{Road.find(self.street_id).typ.to_s} #{Road.find(self.street_id).value.to_s}"
      end 
   
    addresfull = "#{s4}#{s5}, #{self.house} #{self.suf_house}"
   else 
     addresfull = ''
   end 
 end
  
  
    def adrquest

  if self.city_id.to_s != '' then
   s4 = "#{Village.find(self.city_id).name_ukr.to_s}, "
  end
  if self.street_id.to_s != '' then 
   s5 = "#{Road.find(self.street_id).value.to_s}"
  end 
   
   adrquest = "#{s4}#{s5}, #{self.house} #{self.suf_house}"
  

  end
  
end
