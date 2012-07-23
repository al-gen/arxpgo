class Technic < ActiveRecord::Base
set_table_name 'technics'
attr_accessible :datezap, :otvetstv, :comment
validates :datezap, :presence => true
belongs_to :pgo
has_many :proptechnics, :foreign_key => :technic_id
accepts_nested_attributes_for :proptechnics, :allow_destroy => true
end
