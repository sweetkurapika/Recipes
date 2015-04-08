class Chef < ActiveRecord::Base
  has_secure_password
  has_many :recipes, dependent: :destroy
  has_many :likes
  validates :chefname, presence: true, length: {minimum:3, maximum:40}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: {case_sensitive: false},
                                    length: {maximum:100},
                                    format: {with: VALID_EMAIL_REGEX}

  before_save {self.email.downcase!}
end
