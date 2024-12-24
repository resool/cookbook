class CreateRecipes < ActiveRecord::Migration[7.2]
  def change
    create_table :recipes do |t|
      t.text :content
      t.string :status, null: false
      t.string :name

      t.timestamps
    end
  end
end
