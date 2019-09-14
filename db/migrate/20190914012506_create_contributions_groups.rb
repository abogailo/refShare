class CreateContributionsGroups < ActiveRecord::Migration
  def change
    create_table :contributions_groups do |t|
      t.belongs_to :contribution, index: true, foreign_key: true
      t.belongs_to :group, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
