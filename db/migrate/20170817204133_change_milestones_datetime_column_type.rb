class ChangeMilestonesDatetimeColumnType < ActiveRecord::Migration[5.1]
  def change
    change_column :milestones, :date, :date
  end
end
