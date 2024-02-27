class AddLastKnownClickCountToUrls < ActiveRecord::Migration[7.1]
  def change
    add_column :urls, :last_known_click_count, :integer
  end
end
