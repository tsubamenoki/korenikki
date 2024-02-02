class CreateTagRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_relationships do |t|

      t.references :post, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
      t.timestamps
    end

    #同じタグの二重保存防止
    add_index :tag_relationships, [:post_id, :tag_id], unique: true
  end
end
