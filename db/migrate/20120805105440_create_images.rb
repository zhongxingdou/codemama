class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string  :data
      t.integer :user_id

      t.timestamps
    end

    add_index :images, :user_id
  end
end
