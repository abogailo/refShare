class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.string :title
      t.string :content
      t.datetime :created_at
      t.belongs_to :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
