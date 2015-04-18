class AddLinkBetweenAreas < ActiveRecord::Migration
  def change
    rename_table :communes, :municipalities

    add_column :districts, :canton_id, :integer
    add_column :municipalities, :districts_id, :integer

  end
end
