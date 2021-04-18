class ChangeMatchResultToInteger < ActiveRecord::Migration[6.1]
  def change
    remove_column :matches, :result, :string
    add_column :matches, :result, :integer, default: 0
  end
end
