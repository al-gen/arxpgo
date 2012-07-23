class Propanimal < ActiveRecord::Base
set_table_name 'prop_animals'
attr_accessible :glossary_animal_id, :value
validates :value, :numericality => {:only_integer => true, :greater_than_or_equal_to => 1}, :allow_blank => true 
belongs_to :animal
belongs_to :glossaryanimal
end
