class AddCommentsCountToAd < ActiveRecord::Migration[5.2]
  def change
    add_column :ads, :comments_count, :integer
  end
end
