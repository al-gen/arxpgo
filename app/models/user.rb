class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role, :council_id, :famil, :onadmin, :id, :imya, :parent
  
  #Получет строку в формате ФИО (Роль)
  def fio_rol
    temp_s = ''
    temp_s << self.famil<<' '<<self.imya<<' '<<self.parent<<' ('<<self.role<<')'
  end
   
end
