# encoding: utf-8

class House < ActiveRecord::Base

set_table_name 'houses'
attr_accessible :date_build, :material_wall, :material_krovl, :comment, :person_id
validates  :material_wall, :material_krovl, :person_id,  :presence => true

belongs_to :pgo
belongs_to :per
has_many :prophouses, :foreign_key => :house_id
accepts_nested_attributes_for :prophouses , :allow_destroy => true

  def yearbuild
    if (self.date_build == nil) or (self.date_build.year == 1)  then
      yearbuild = "Не визначено"
    else
    self.date_build.year.to_s
    end
  end
  
end
