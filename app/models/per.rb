class Per < ActiveRecord::Base
set_table_name 'pers'
attr_accessible :surname, :name, :midname,  :sex, :family, :job, :s_all, :s_build, :s_osob_gosp, :s_tov_gosp, :s_arenda, :s_arenda1, :s_pay,
 :bornday,
 :bornmonth,
 :bornyear,
 :date_begin_hoz, 
 :date_end_hoz,
 :date_vibil,
 :prichina_vibil,
 :date_vosvr,
 :date_vibil1,
 :prichina_vibil1,
 :date_vosvr1,
 :full_vibil, 
 :comment_full_vibil,
 :pensiya,
 :invalidnost,
 :soc_help,
 :comment_lgoti,
 :date_regist, 
 :address_pred_regist,
 :personal_account,
 :datezap,
 :address_reg,
 :count_men,
 :date_prib,
 :meta_prib,
 :date_vib
validates :surname, :name, :midname, :presence => true
validates :s_all, :s_build, :s_osob_gosp, :s_tov_gosp, :s_arenda, :s_arenda1, :numericality => true, :allow_blank => true 
belongs_to :pgo
has_many :houses, :foreign_key => :person_id

validates :count_men, :numericality => {:only_integer => true}, :allow_blank => true  

def fullname
 "#{self.surname} #{self.name} #{self.midname}"
end

  def borndate
    if self.bornday.to_s != "" then d = self.bornday.to_s.rjust(2,'0') else d = "xx"  end
    if self.bornmonth.to_s != "" then m = self.bornmonth.to_s.rjust(2,'0') else m = "xx"  end    
    if self.bornyear.to_s != "" then y = self.bornyear.to_s else y = "xxxx"  end    
      "#{d}.#{m}.#{y}"
  end  
    
 
  
end
