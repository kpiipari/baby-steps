class CreateChildParents < ActiveRecord::Migration[5.1]
  def change
    create_table :child_parents do |t|
      t.integer :parent_id
      t.integer :child_id
    end
  end
end
