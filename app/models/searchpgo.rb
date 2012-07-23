class Searchpgo < ActiveRecord::Base
  def numformat
    self.num_1.to_s.rjust(4,'0')
  end
end
