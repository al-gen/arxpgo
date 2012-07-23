class Council < ActiveRecord::Base
set_table_name 'councils'
attr_accessible :name, :typ
 validates :name, :presence => true
has_many :books ,  :foreign_key => :rada_id
has_many :villages ,  :foreign_key => :council_id
belongs_to :region
has_many :addres, :foreign_key => :rada_id

end
