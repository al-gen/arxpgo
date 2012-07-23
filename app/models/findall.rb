class Findall 
  attr_reader :items
  
  def initialize
    @items = []
  end
  
  def add_doc(arx)
    @fl = 0
    @items.each do |doc|
      if arx.id == doc.id 
        @fl = 1
      end
    end
    if @fl == 0 
      @items <<arx
    end
    
  end
end