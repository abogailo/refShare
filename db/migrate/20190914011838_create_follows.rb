class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.boolean :following
      t.datetime :followed_at
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :group, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
