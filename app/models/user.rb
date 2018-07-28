class User < ActiveRecord::Base
    has_many :projects

    validates_presence_of :username, :email, :password_digest
    has_secure_password

    def slug
        username.downcase.gsub(" ","-")
    end

    def self.find_by_slug(slug)
        User.all.find { |user| user.slug == slug }
    end

end