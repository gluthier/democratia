class CreateCantons < ActiveRecord::Migration
  def change
    create_table :cantons do |t|
      t.string :name
      t.string :shortname
      t.timestamps null: false
    end

    add_column :users, :canton_id, :integer

  end
end
