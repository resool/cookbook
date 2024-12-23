class CreateIngredients < ActiveRecord::Migration[7.2]
  def change
    create_table :ingredients do |t|
      t.string :input, null: false, index: { unique: true }
      t.string :name, index: { unique: true }
      t.string :status, null: false

      t.timestamps
    end
  end
end
