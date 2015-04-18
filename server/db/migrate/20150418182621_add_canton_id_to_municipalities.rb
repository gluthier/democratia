class AddCantonIdToMunicipalities < ActiveRecord::Migration
  def change
    add_column :municipalities, :canton_id, :integer
  end
end
