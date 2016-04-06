class Chef < ActiveRecord::Base
  before_save {self.email = email.downcase}
  validates :chefname, presence: true, length: {minimum: 3, maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 80},
                                    uniqueness: {case_sensitive: false},
                                    format: { with: VALID_EMAIL_REGEX }
  #checks uniqueness is true and that is not case sensitive
end