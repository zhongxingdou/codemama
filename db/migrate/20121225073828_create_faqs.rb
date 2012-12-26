class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.string :title
      t.text :question
      t.text :answer
      t.integer :user_id

      t.timestamps
    end
  end
end
