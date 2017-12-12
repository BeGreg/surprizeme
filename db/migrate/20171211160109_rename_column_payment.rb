class RenameColumnPayment < ActiveRecord::Migration[5.0]
  def change
    rename_column :surprises, :payement, :payment
  end
end
