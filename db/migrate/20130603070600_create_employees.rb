class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :department
      t.boolean :gender, :default => true
      t.string :qq
      t.integer :index

      t.timestamps
    end
  end
end
