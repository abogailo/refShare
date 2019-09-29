class RemoveColumnFromGroups < ActiveRecord::Migration
  def change
      remove_column :groups, :follow_id, :integer
  end
end
