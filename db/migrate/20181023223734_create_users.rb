class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :password_digest
      t.string :email, unique: true
      t.integer :role, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
