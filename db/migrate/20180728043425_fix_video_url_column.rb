class FixVideoUrlColumn < ActiveRecord::Migration
  def change
    add_column :projects, :video_url, :string, :default => "https://dianesieg.com/wp-content/uploads/2016/11/video-player-placeholder-very-large.png" 
  end
end
