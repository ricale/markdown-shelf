class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :user_id, null: false
      t.string  :name,    null: false
      t.integer :ordered, null: false

      t.timestamps
    end
  end
end
