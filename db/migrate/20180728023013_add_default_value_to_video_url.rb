class AddDefaultValueToVideoUrl < ActiveRecord::Migration
  def change
    change_column_default :projects, :video_url, "https://dianesieg.com/wp-content/uploads/2016/11/video-player-placeholder-very-large.png"
  end
end
