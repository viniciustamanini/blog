class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :nullify
  has_many :comments, dependent: :nullify

  def display_name
    email.to_s.split('@').first.presence || 'admin'
  end
end
