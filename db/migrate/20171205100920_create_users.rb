class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :genre
      t.string :email
      t.string :address
      t.string :mobile_phone
      t.boolean :rater
      t.boolean :admin

      t.timestamps
    end
  end
end
