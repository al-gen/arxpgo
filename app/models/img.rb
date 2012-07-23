class Img < ActiveRecord::Base
  
  def uploaded_picture=(picture_field)
    self.linkfile =picture_field.original_filename
    self.typefile = picture_field.content_type.chomp
    self.mfile = picture_field.read  
  end
end
