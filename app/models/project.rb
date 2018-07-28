class Project < ActiveRecord::Base
   belongs_to :user 

   validates_presence_of :title, :category, :description, :github

   def slug
        title.downcase.gsub(" ","-")
    end

    def self.find_by_slug(slug)
        Project.all.find { |project| project.slug == slug }
    end

end