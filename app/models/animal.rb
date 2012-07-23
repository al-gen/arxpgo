class Animal < ActiveRecord::Base
set_table_name 'animals'
attr_accessible :datezap, :otvetstv, :comment
validates :datezap,  :presence => true
belongs_to :pgo
has_many :propanimals, :foreign_key => :animal_id
accepts_nested_attributes_for :propanimals, :allow_destroy => true
end
