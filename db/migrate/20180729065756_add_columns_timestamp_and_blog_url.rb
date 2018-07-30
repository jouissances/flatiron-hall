class AddColumnsTimestampAndBlogUrl < ActiveRecord::Migration
  def change
    add_column :projects, :blog_url, :string
    add_timestamps :projects, null: true
  end
end
