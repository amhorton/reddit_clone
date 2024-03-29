class CreatePostSubs < ActiveRecord::Migration
  def change
    create_table :post_subs do |t|
      t.integer :sub_id
      t.integer :post_id

      t.timestamps
    end

    remove_column :posts, :sub_id

    add_index :post_subs, :sub_id
    add_index :post_subs, :post_id
  end
end