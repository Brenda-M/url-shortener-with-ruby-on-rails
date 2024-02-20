class AddCustomUrlToUrls < ActiveRecord::Migration[7.1]
  def change
    add_column :urls, :custom_url, :string
  end
end
