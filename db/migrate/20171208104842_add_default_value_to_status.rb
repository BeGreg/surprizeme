class AddDefaultValueToStatus < ActiveRecord::Migration[5.0]
  def change
    change_column(:moments, :status, :string, default: "scrappé")
    change_column(:products, :status, :string, default: "scrappé")
    change_column(:surprises, :status, :string, default: "initiée")
  end
end
