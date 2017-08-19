class Child<ActiveRecord::Base
    has_many :child_parents
    has_many :parents, through: :child_parents
    has_many :milestones
    
    def slug
        self.name.downcase.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        Child.all.find do |child|
            if child.slug == slug
                child
            end
        end
    end
end