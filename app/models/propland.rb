class Propland < ActiveRecord::Base
set_table_name 'prop_lands'
belongs_to :land
attr_accessible :datezap, :s_all, :s_build, :s_osob_gosp, :s_tov_gosp, :s_arenda, :s_senokos, :s_ogorod, :s_garden, :s_sel_ugod, :s_rill, :s_bagat, :s_sinojat, :otvetstv

validates  :s_all, :s_build, :s_osob_gosp, :s_tov_gosp, :s_arenda, :s_senokos, :s_ogorod, :s_garden, :s_sel_ugod, :s_rill, :s_bagat, :s_sinojat, :numericality => true, :allow_blank => true 
validates :s_all, :datezap,  :presence => true

end
