class AddLastKnownUrlCountToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :last_known_url_count, :integer
  end
end
