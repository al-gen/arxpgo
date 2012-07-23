class Road < ActiveRecord::Base
set_table_name 'roads'
attr_accessible :value, :typ
validates :value, :typ, :presence => true
belongs_to :village
has_many :addres, :foreign_key => :street_id
   def fullroad
     "#{self.typ} #{self.value}"
   end  
end
