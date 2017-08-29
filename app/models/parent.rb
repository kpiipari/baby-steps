class Parent<ActiveRecord::Base
    auto_strip_attributes :username, :email, :password_digest
    has_many :child_parents
    has_many :children, through: :child_parents
    has_secure_password
    validates :email, :username, presence: true
    validates :email, :username, uniqueness: true

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