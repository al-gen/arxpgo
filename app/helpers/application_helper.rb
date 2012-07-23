# encoding: utf-8

module ApplicationHelper

  
  def getnumpage(id, book, perpage)
     numpage = 1
     @pg = Book.find(book).pgos.order('num_1')
     i = 0
     @pg.each do |p|
       if p.id != id then 
         i = i+1
       end
       if p.id == id then
         numpage = (i/perpage).round + 1
       end
     end
    getnumpage = numpage
  end
  
  
  def getbookpage(id, perpage)
     numpage = 1
     id_council = Book.find(id).rada_id
     @bg = Council.find(id_council).books.order('num')
     i = 0
     @bg.each do |b|
       if b.id != id then 
         i = i+1
       end
       if b.id == id then
         numpage = (i/perpage).round + 1
       end
     end
    getbookpage = numpage
  end     

 def access_role
   current_user.council_id.to_i == 0
 end
 
 
end
