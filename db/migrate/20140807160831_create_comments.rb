class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :author_id
      t.integer :post_id
      t.integer :parent_comment_id

      t.timestamps
    end

    add_index :comments, :author_id
    add_index :comments, :parent_comment_id
    add_index :comments, :post_id
  end
end
