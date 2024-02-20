class AddDefaultClickCountToUrls < ActiveRecord::Migration[7.1]
  def change
    change_column :urls, :click, :integer, default: 0
  end
end
