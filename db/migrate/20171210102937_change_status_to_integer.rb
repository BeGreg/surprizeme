class ChangeStatusToInteger < ActiveRecord::Migration[5.0]
  def change
    change_column_default(:moments, :status, nil)
    change_column_default(:products, :status, nil)
    change_column :moments, :status, 'integer USING CAST(status AS integer)'
    change_column :products, :status, 'integer USING CAST(status AS integer)'
    change_column_default(:moments, :status, 0)
    change_column_default(:products, :status, 0)
  end
end
