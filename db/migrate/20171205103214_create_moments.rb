class CreateMoments < ActiveRecord::Migration[5.0]
  def change
    create_table :moments do |t|
      t.string :name
      t.string :url
      t.text :description
      t.string :photo_url1
      t.string :photo_url2
      t.string :photo_url3
      t.string :photo_url4
      t.string :status
      t.string :surprise_category
      t.references :location, foreign_key: true

      t.timestamps
    end
  end
end
