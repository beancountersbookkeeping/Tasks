class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tasks
  has_many :companys

  after_initialize { self.role ||= :standard }

  enum role: [:standard, :admin]

  def self.convert_id_to_email(id)
    @email = "No email found"
    @user = User.find_by_id(id)
    if @user != nil then 
      @email = @user.email
    end
    return @email
  end

  def self.generate_default_users
     ActiveRecord::Base.connection.execute("delete from users")
     @admin_user = User.create!(email: 'admin@gmail.com', password: 'admin100', role: 1)
     @user1 = User.create!(email: 'user@gmail.com', password: 'useruser', role: 0)
     puts "Default users have been generated."
  end

end
