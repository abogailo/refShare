class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.string :title
      t.string :content
      t.integer :user_id
      t.integer :group_id
      t.timestamps null: false
    end
  end
end
