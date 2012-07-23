# encoding: utf-8
class Pers < ActiveRecord::Base
  #Возвращает объект по строке адреса
  def self.str_to_pers(pers_str)
    @fio = pers_str.split(' ')
    @per = Pers.find_last_by_surname_and_name_and_midname(@fio[0],@fio[1],@fio[2])
    if @per.blank?||@fio.length == 0
      -1 
    else 
      @per.id 
    end
  end
end
