class ChangeVideoUrlDefault < ActiveRecord::Migration
  def change
    change_column_default :projects, :video_url, "https://i.imgur.com/x3o5Us1.png"
  end
end
