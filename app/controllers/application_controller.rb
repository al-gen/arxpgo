# encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery
   

#возвращает номер роли для входа
#  -3 - незарегистрированный пользователь
#  -2 - пожарник, электрик ...
#  -1 - архитектор
#   0 - райголова
#   1..14 - головы советов
  def get_role
    
    #Проверяем вход пользователя в систему
    if user_signed_in?
      #Если пользователь вошол, проверяем голова он или нет
      if current_user.role == I18n.t(:my_golova)
        #Если пользователь голова, возвращаем номер совета к которому от принадлежит
        current_user.council_id.to_i
      else  
        #Если вошедший пользователь не голова, проверяем архитектор он или нет
        if current_user.role == I18n.t(:my_arxitect)
          #Если вошедший пользователь архитектор
          -1
        else
          #Если пожарник и т.д.
          -2          
        end
      end
    else
      #Если пользователь не в системе
      -3
    end
  end   
 
 def getcouncil(p)

   id_council = self.get_role
   if id_council == 0 then
     if p != nil then
      id_council = p 
     else
      id_council = Council.order('id').first.id
     end 
   end   
   return id_council
 end
  
  
  
end
