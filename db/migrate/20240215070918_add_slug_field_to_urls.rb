class AddSlugFieldToUrls < ActiveRecord::Migration[7.1]
  def change
    add_column :urls, :slug, :string
  end
end
