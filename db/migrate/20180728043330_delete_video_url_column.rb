class DeleteVideoUrlColumn < ActiveRecord::Migration
  def change
    remove_column :projects, :video_url
  end
end
