class Book < ActiveRecord::Base
set_table_name 'books'
attr_accessible :num, :date_begin, :date_end, :comment
validates :num, :date_begin,  :presence => true
validates :num, :numericality => {:only_integer => true}
belongs_to :council 
has_many :pgos, :foreign_key => :book_id

  def numformat
    self.num.to_s.rjust(3,'0')
  end
end
