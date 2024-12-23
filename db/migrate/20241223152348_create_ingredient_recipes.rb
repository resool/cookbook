class CreateIngredientRecipes < ActiveRecord::Migration[7.2]
  def change
    create_table :ingredient_recipes do |t|
      t.references :ingredient, null: false, foreign_key: true, index: false
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end

    add_index :ingredient_recipes, %i[ingredient_id recipe_id], unique: true
  end
end
