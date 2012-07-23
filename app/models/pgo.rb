# encoding: utf-8

class Pgo < ActiveRecord::Base

set_table_name 'pgos'
attr_accessible  :num_1, :num_2, :comment, :otvetstv, :address_id, :datezap
validates :num_1, :num_2, :presence => true
validates :num_1, :numericality => true
validates :num_2, :numericality => {:only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5}

belongs_to :book
has_many :pers, :foreign_key => :pgo_id
has_many :houses, :foreign_key => :pgo_id
has_many :lands, :foreign_key => :pgo_id
has_many :animals, :foreign_key => :pgo_id
has_many :technics, :foreign_key => :pgo_id

  def numformat
    self.num_1.to_s.rjust(4,'0')
  end
  
  def fullnum
    "#{numformat}-#{self.num_2}" 
  end

def self.adres_to_pgo(adr_str)
  @adr = Addres.find_last_by_full_address(adr_str) 
  if @adr.blank?||adr_str.length == 0
    -1
  else
    @pgo = Pgo.find_last_by_address_id(@adr.id)
    if @pgo.blank?
      -1
    else
      @pgo.id
    end
  end
end

end
