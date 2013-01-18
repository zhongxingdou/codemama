class CreateEdmsPictures < ActiveRecord::Migration
  def change
    create_table :edms_pictures do |t|
      t.references :edm
      t.references :picture

      t.timestamps
    end
    add_index :edms_pictures, :edm_id
    add_index :edms_pictures, :picture_id
  end
end
