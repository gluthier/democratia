class AddJsonIdToDatabase < ActiveRecord::Migration
  def change
    add_column :cantons, :json_id_canton, :integer
    add_column :districts, :json_id_district, :integer
    add_column :municipalities, :json_id_municipality, :integer
  end
end
