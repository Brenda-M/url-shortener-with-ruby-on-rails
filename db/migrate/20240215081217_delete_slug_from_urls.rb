class DeleteSlugFromUrls < ActiveRecord::Migration[7.1]
  def change
    remove_column :urls, :slug
  end
end
