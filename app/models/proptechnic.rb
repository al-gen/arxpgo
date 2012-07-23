class Proptechnic < ActiveRecord::Base
set_table_name 'prop_technics'
attr_accessible :glossary_technic_id, :value
validates :value, :numericality => {:only_integer => true, :greater_than_or_equal_to => 1}
belongs_to :technic
belongs_to :glossarytechnic
end
