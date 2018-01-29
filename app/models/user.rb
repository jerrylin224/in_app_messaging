class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :image, ImageUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_messageable

  def mailboxer_email(object)
    email
  end
end
