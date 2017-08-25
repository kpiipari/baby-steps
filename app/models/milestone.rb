class Milestone<ActiveRecord::Base
    auto_strip_attributes :content, :age
    belongs_to :child
end