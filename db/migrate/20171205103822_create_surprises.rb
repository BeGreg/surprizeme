class CreateSurprises < ActiveRecord::Migration[5.0]
  def change
    create_table :surprises do |t|
      t.float :total_price
      t.string :del_first_name
      t.string :del_last_name
      t.string :del_address
      t.string :bill_first_name
      t.string :bill_last_name
      t.string :bill_address
      t.integer :nb_persons
      t.datetime :moment_date
      t.float :ticket_price
      t.string :status
      t.string :type
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.references :moment, foreign_key: true

      t.timestamps
    end
  end
end
