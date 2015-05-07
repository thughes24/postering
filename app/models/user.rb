class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_secure_password validations: false
  validates :username, presence: true
  validates :password, presence: true, on: :create
  validates :email, presence: true
  validates :username, uniqueness: true, on: :create
  before_create :generate_slug
  def to_param
    self.slug
  end
  def generate_slug
    self.slug = self.username.gsub(' ', '-').downcase
  end
end