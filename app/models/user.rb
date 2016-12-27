class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :chat_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy

  has_attached_file :avatar, :styles => {:thumb => "40x40>"}
  validates_attachment :avatar,
                       content_type: { content_type: ["image/jpg","image/jpeg", "image/gif", "image/png","image/pjpeg", "image/x-png"] },
                       :message => 'file type is not allowed (only jpeg/gif/png images)'
  validates_attachment_content_type :avatar, content_type: /\Aimage/
  validates_attachment_file_name :avatar, matches: [/png\z/, /jpe?g\z/]

  def name
    email.split('@')[0]
  end
end
