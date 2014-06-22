class CreateWritings < ActiveRecord::Migration
  def change
    create_table :writings do |t|
      t.integer :user_id,     null: false
      t.integer :category_id
      t.string  :title,       null: false
      t.text    :content,     null: false
      t.boolean :private,     null: false
      t.integer :ordered,     null: false

      t.timestamps
    end
  end
end
