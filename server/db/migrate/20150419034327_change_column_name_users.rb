class ChangeColumnNameUsers < ActiveRecord::Migration
  def change
    rename_column :users, :commune_id, :municipality_id
  end
end
