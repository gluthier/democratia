class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.belongs_to :political_party
      t.string :canton
      t.string :district
      t.string :city
      t.timestamps null: false
    end
  end
end
