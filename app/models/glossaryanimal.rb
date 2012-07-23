class Glossaryanimal < ActiveRecord::Base
set_table_name 'glossary_animals'
has_many :propanimals, :foreign_key => :glossary_animal_id
end
