class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :position
      t.string :location
      t.text :requirements
      t.text :description
      t.date :expired_date

      t.timestamps
    end
  end
end
