class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :url
      t.text :description
      t.text :characteristic
      t.integer :price
      t.float :supplier_review
      t.integer :supplier_review_number
      t.string :supplier_category
      t.float :delivery_price
      t.integer :delivery_time
      t.string :photo_url1
      t.string :photo_url2
      t.string :photo_url3
      t.string :photo_url4
      t.string :status
      t.string :surprise_category
      t.string :gender
      t.references :supplier, foreign_key: true

      t.timestamps
    end
  end
end
