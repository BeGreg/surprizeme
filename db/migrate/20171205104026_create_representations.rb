class CreateRepresentations < ActiveRecord::Migration[5.0]
  def change
    create_table :representations do |t|
      t.datetime :date
      t.float :price_collection, array:true
      t.float :del_price
      t.references :moment, foreign_key: true

      t.timestamps
    end
  end
end
