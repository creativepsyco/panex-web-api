class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :role, :name
  # attr_accessible :title, :body
  
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[A-Z0-9._%+\-]+@(?:[A-Z0-9\-]+\.)+[A-Z]{2,6}\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

  has_many :apps #, :foreign_key => "user_id" #used when wanting to a diff foriegn_key
end
