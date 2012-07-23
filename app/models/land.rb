class Land < ActiveRecord::Base
set_table_name 'lands'
attr_accessible :comment
belongs_to :pgo
has_many :proplands, :foreign_key => :land_id
accepts_nested_attributes_for :proplands, :allow_destroy => true
end
