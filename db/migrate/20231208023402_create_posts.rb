class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.date :date, null: false
      t.boolean :is_draft, null: false, default: false
      t.timestamps
    end
  end
end
