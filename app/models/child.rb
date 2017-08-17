class Child<ActiveRecord::Base
    has_many :child_parents
    has_many :parents, through: :child_parents
    has_many :milestones
    
end