class Prophouse < ActiveRecord::Base
set_table_name 'prop_houses'
attr_accessible :s, :s_summer, :s_jitlova, :n_room, :water, :kanaliz, :otoplen, :hot_water, :bath, :gas, :sgas, :el_plita, :datezap, :otvetstv
validates :s, :datezap,  :presence => true
validates :s, :s_summer, :s_jitlova, :n_room, :numericality => true , :allow_blank => true 
 belongs_to :house
end
