class Parent<ActiveRecord::Base
    has_many :child_parents
    has_many :children, through: :child_parents
    has_secure_password

    def slug
        self.username.downcase.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        Parent.all.find do |parent|
            if parent.slug == slug
                parent
            end
        end
    end

end