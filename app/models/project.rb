class Project < ActiveRecord::Base
   belongs_to :user 

   validates_presence_of :title, :category, :description, :github, :external_uri

   def slug
        title.downcase.gsub(" ","-")
    end

    def self.find_by_slug(slug)
        Project.all.find { |project| project.slug == slug }
    end

    def self.find_by_user_id(user_id)
        Project.all.select { |project| project.user_id == user_id }
    end

end