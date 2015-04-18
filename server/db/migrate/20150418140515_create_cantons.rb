class CreateCantons < ActiveRecord::Migration
  def change
    create_table :cantons do |t|
      t.string :name
      t.string :shortname
      t.timestamps null: false
    end
  end
end
