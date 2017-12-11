class AddStateToSurprises < ActiveRecord::Migration[5.0]
  def change
    add_column :surprises, :state, :string
  end
end
