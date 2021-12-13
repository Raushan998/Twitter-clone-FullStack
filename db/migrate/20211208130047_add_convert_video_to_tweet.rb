class AddConvertVideoToTweet < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :convert_video, :boolean
  end
end
