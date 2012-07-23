class Village < ActiveRecord::Base
set_table_name 'villages'
attr_accessible :name_ukr, :poshta, :typ
validates :name_ukr, :typ, :presence => true
has_many :roads, :foreign_key => :city_id
belongs_to :council
has_many :addres, :foreign_key => :city_id
validates :poshta, :numericality => {:only_integer => true}
def fullname
  "#{typ} #{name_ukr}"
end  
end
