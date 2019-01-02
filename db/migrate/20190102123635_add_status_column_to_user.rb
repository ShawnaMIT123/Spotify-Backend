class AddStatusColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :online_now, :boolean
  end
end
