class AddColumnToGroups < ActiveRecord::Migration
  def change
      add_column :groups, :follow_id, :integer
  end
end
