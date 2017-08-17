class AddChildIdColumnToMilestones < ActiveRecord::Migration[5.1]
  def change
    add_column :milestones, :child_id, :integer
  end
end
