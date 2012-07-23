class Arxiv < ActiveRecord::Base
  validates :numrich,  :presence => true
  validates :numses, :numsoz, :shodo,  :presence => true

  #выгружаем растр на сервер
  def uploaded_picture=(picture_field)
    self.linkfile =picture_field.original_filename
    self.typefile = picture_field.content_type.chomp
    self.mfile = picture_field.read
  end
  
  #обновляем строку поиска архивного документа
  def update_lseach
    self.lseach = Council.find(self.rada_id).name << ' '
    self.lseach << self.numrich << ' ' << self.dateprin.to_s << ' ' << self.numses << ' ' << self.numsoz << ' ' << self.shodo
    self.lseach << ' ' << self.comment if !self.comment.blank?
    self.lseach << ' ' << self.linkfile if self.pgo_id != -1
    self.lseach << ' ' << self.typefile if self.person_id != -1        
  end
  
  #поиск архивного документа по строке
  def self.seach_docs(seach_string,role_id)
    if !seach_string.blank?
        @temp_str = seach_string.strip
        if !@temp_str.blank?
          #Разбиваем на лексисы
          @lecsim = @temp_str.split(' ')
          case role_id
          when -3..-2 #незарегистрированный пользователь или пожарник
            Arxiv.where(["(onadmin = '0')AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)",
                                  "%#{@lecsim[0]}%","%#{@lecsim[1]}%","%#{@lecsim[2]}%","%#{@lecsim[3]}%","%#{@lecsim[4]}%","%#{@lecsim[5]}%"])            
          when -1 #архитекто
            Arxiv.where(["(onadmin = '1')AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)",
                                  "%#{@lecsim[0]}%","%#{@lecsim[1]}%","%#{@lecsim[2]}%","%#{@lecsim[3]}%","%#{@lecsim[4]}%","%#{@lecsim[5]}%"])
          when 0 #голова района
            Arxiv.where(["(onadmin = '0')AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)",
                                  "%#{@lecsim[0]}%","%#{@lecsim[1]}%","%#{@lecsim[2]}%","%#{@lecsim[3]}%","%#{@lecsim[4]}%","%#{@lecsim[5]}%"])
          else #головы рад
            Arxiv.where(["(onadmin = '0')AND(rada_id = ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)",
                                  "#{role_id}","%#{@lecsim[0]}%","%#{@lecsim[1]}%","%#{@lecsim[2]}%","%#{@lecsim[3]}%","%#{@lecsim[4]}%","%#{@lecsim[5]}%"])            
          end
                  
        end 
    else
        nil
    end
  end
  
  #отображение всех архивных документов
  def self.all_docs(role_id)
    case role_id
    when -3..-2 #незарегистрированный пользователь или пожарник
      Arxiv.where(:onadmin => '0')            
    when -1 #архитекто
      Arxiv.where(:onadmin => '1')
    when 0 #голова района
      Arxiv.where(:onadmin => '0')
    else #головы рад
      Arxiv.where(:onadmin => '0',:rada_id => role_id)            
    end
  end
  
  #поиск архивных документов для формирования выпадающего списка
  def self.seach_ajax(seach_string,role_id)
    @temp_str = seach_string
    if !@temp_str.blank?
      #Разбиваем на лексисы
      @lecsim = @temp_str.split(' ')
     
      case role_id
      when -3..-2 #незарегистрированный пользователь или пожарник
        Arxiv.limit(13).where(["(onadmin = '0')AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)",
                              "%#{@lecsim[0]}%","%#{@lecsim[1]}%","%#{@lecsim[2]}%","%#{@lecsim[3]}%","%#{@lecsim[4]}%","%#{@lecsim[5]}%"])            
      when -1 #архитекто
        Arxiv.limit(13).where(["(onadmin = '1')AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)",
                              "%#{@lecsim[0]}%","%#{@lecsim[1]}%","%#{@lecsim[2]}%","%#{@lecsim[3]}%","%#{@lecsim[4]}%","%#{@lecsim[5]}%"])
      when 0 #голова района
        Arxiv.limit(13).where(["(onadmin = '0')AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)",
                              "%#{@lecsim[0]}%","%#{@lecsim[1]}%","%#{@lecsim[2]}%","%#{@lecsim[3]}%","%#{@lecsim[4]}%","%#{@lecsim[5]}%"])
      else #головы рад
        Arxiv.limit(13).where(["(onadmin = '0')AND(rada_id = ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)AND(lseach ILIKE ?)",
                              "#{role_id}","%#{@lecsim[0]}%","%#{@lecsim[1]}%","%#{@lecsim[2]}%","%#{@lecsim[3]}%","%#{@lecsim[4]}%","%#{@lecsim[5]}%"])            
      end      
        
    end
  end
end
