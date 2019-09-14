class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.datetime :created_at
      t.belongs_to :user, index: true, foreign_key:true
      t.timestamps null: false
    end
  end
end
