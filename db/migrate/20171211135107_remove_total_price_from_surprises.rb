class RemoveTotalPriceFromSurprises < ActiveRecord::Migration[5.0]
  def change
    remove_column :surprises, :total_price, :float
  end
end
