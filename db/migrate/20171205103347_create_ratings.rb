class CreateRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.boolean :rating
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.references :moment, foreign_key: true

      t.timestamps
    end
  end
end
