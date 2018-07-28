class RenameYoutubeColumn < ActiveRecord::Migration
  def change
    rename_column(:projects, :youtube, :youtube_url)
  end
end
