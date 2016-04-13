class AddPictureToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :picture, :string
  end
end

# rails generate uploader Picture
# Used rails generate migration add_picture_to_recipes picture:string to creatr this migrations
# rake db:migrate