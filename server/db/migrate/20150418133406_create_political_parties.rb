class CreatePoliticalParties < ActiveRecord::Migration
  def change
    create_table :political_parties do |t|
      t.string :name
      t.integer :members
      t.string :description
      t.timestamps null: false
    end
  end
end
