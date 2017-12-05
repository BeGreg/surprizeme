class CreateSuppliers < ActiveRecord::Migration[5.0]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :url
      t.string :description

      t.timestamps
    end
  end
end
