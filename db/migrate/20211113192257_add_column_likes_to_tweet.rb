class AddColumnLikesToTweet < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :likes, :integer, array: true, default: []
    add_column :tweets, :is_active, :boolean
  end
end
