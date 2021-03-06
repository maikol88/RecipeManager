class Recipe < ActiveRecord::Base
  belongs_to :chef
  has_many :likes, dependent: :destroy
  has_many :recipe_styles, dependent: :destroy
  has_many :styles, through: :recipe_styles
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  validates :chef_id, presence: true
  validates :name, presence: true, length: {minimum: 5, maximum: 50}
  validates :summary, presence: true, length: {minimum: 10, maximum: 150}
  validates :description, presence: true, length: {minimum: 20, maximum: 1000}
  mount_uploader :picture, PictureUploader
  validate :picture_size
  default_scope -> {order(updated_at: :desc)}
  #specifices what to pick up, specifies sql query, as is it gets recipes that are made the most recently

  def thumbs_up_total
    self.likes.where(like: true).size
  end

  def thumbs_down_total
    self.likes.where(like: false).size
  end

  private
    def picture_size
      if picture.size > 10.megabytes
        errors.add(:picture, "Should be less than 5MB")
      end
    end
end