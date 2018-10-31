class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.float :price
      t.string :img_url, default: "http://www.colourbox.com/preview/7389458-682747-example-stamp.jpg"
      t.integer :inventory_count
      t.string :description
      t.integer :status, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
