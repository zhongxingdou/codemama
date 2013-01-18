class CreateEdmTemplatesPictures < ActiveRecord::Migration
  def change
    create_table :edm_templates_pictures do |t|
      t.references :edm_template
      t.references :picture

      t.timestamps
    end
    add_index :edm_templates_pictures, :edm_template_id
    add_index :edm_templates_pictures, :picture_id
  end
end
