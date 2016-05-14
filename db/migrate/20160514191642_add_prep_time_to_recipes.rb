class AddPrepTimeToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :preparation_time, :integer
    add_column :recipes, :servings, :integer
  end
end
