class RemoveStatusFromSurprises < ActiveRecord::Migration[5.0]
  def change
    remove_column :surprises, :status, :string
  end
end
