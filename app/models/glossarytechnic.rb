class Glossarytechnic < ActiveRecord::Base
set_table_name 'glossary_technics'
has_many :proptechnic, :foreign_key => :glossary_technic_id
end
