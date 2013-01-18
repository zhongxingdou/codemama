class CreateEdms < ActiveRecord::Migration
  def change
    create_table :edms do |t|
      t.string :name
      t.integer :owner_id
      t.integer :template_id
      t.boolean :locked, :default => true
      t.string :editing_file
      t.text :content

      t.timestamps
    end
  end
end
