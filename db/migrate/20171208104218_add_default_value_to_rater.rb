class AddDefaultValueToRater < ActiveRecord::Migration[5.0]
  def up
    change_column(:users, :rater, :boolean, default: false)
    change_column(:users, :admin, :boolean, default: false)
  end

end
