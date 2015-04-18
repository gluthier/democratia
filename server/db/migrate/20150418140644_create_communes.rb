class CreateCommunes < ActiveRecord::Migration
  def change
    create_table :communes do |t|
      t.string :name
      t.string :shortname
      t.timestamps null: false
    end
  end
end
