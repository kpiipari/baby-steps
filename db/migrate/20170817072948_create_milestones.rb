class CreateMilestones < ActiveRecord::Migration[5.1]
  def change
    create_table :milestones do |t|
      t.string :content
      t.string :age
      t.datetime :date
    end
  end
end
