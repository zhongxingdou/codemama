class CreateEdmTemplates < ActiveRecord::Migration
  def change
    create_table :edm_templates do |t|
      t.string :name
      t.string :preview
      t.string :editingfile
      t.boolean :locked, :default => true
      t.text :content

      t.timestamps
    end
  end
end
