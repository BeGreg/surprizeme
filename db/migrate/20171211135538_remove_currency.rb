class RemoveCurrency < ActiveRecord::Migration[5.0]
  def change
    change_table :surprises do |t|
      t.monetize :amount, currency: { present: false }
    end
  end
end
