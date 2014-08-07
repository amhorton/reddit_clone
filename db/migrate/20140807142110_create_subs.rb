class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.string :title
      t.string :description
      t.integer :mod_id

      t.timestamps
    end
  end
end
