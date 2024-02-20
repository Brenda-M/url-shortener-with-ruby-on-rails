class ChangeUserIdsInUrls < ActiveRecord::Migration[7.1]
  def change
    change_column :urls, :user_id, :bigint, null: true
  end
end
